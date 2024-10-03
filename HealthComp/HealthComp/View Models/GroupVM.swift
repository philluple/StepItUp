//
//  GroupVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class GroupVM: ObservableObject {
    var userModel: UserVM
    var healthModel: HealthVM
    var friendModel: FriendVM
    var groups_by_id: [Group_id] = []
    let imageUtil = ImageUtils()

    @Published var user_groups: [String: Group_user] = [:]
    @Published var user_cache: [String: UserHealth] = [:]
    
    init(userModel: UserVM, healthModel: HealthVM, friendModel: FriendVM){
        self.userModel = userModel
        self.healthModel = healthModel
        self.friendModel = friendModel
        Task{
            if let groups = userModel.currentUser?.groups{
                await fetchGroups(groups: groups)
//                print(" here is groups by id: \(groups_by_id)")
                await fillGroupStruct(groups: groups_by_id)
            }
        }
        
    }

    // Make sure that the current user is in the list
    func fillGroupStruct(groups: [Group_id]) async {
        for group in groups{
            var new_group = Group_user(id: group.id, name: group.name, pfp: "", members: [])
            do {
                for id in group.members{
                    if id == userModel.currentUser?.id{
                        if let user = userModel.currentUser{
                            var hd = HealthData(dailyStep: 0, dailyMileage: 0.0, weeklyStep: 0, weeklyMileage: 0.0)
                            if healthModel.isValid(healthModel.healthData){
                                hd = healthModel.healthData
                            }
                            let loadedUserHealth = UserHealth(id: id, user: user, data: hd)
                            new_group.members.append(loadedUserHealth)
                        }
                    } else if let user = self.friendModel.user_friends[id]{
                        new_group.members.append(user)
                        continue
                    } else if let user = self.user_cache[id]{
                        new_group.members.append(user)
                        continue
                    } else {
                        do{
                            let result = try await self.userModel.fetchUser(id: id)
                            switch result {
                            case .success (let user):
                                do {
                                    let healthResult = try await friendModel.fetchHealthData(id: id)
                                    switch healthResult {
                                    case .success(let healthData):
                                        let loadedUserHealth = UserHealth(id: user.id, user: user, data: healthData)
                                        self.user_cache[user.id] = loadedUserHealth
                                        new_group.members.append(loadedUserHealth)
                                    case .failure(_):
                                        print("Error fetching data in fillGroupStruct for \(id)")
                                    }
                                }
                            case .failure (_):
                                print("Error fetching \(id) in fillGroupStruct")
                            }
                        } catch {
                            print("An error occured in fillGroupStruct")
                        }
                    }
                }
                new_group.members.sort { $0.data.dailyStep ?? 0 > $1.data.dailyStep ?? 0 }
            }
            self.user_groups[group.id] = new_group
        }
    }
    
    func fetchGroups(groups: [String]) async {
        print("Fetching groups... \(groups.count) group to fetch")
        for group_id in groups{
            
            do {
                let document = try await Firestore.firestore().collection("groups").document(group_id).getDocument()
                if document.exists {
                    let group = try document.data(as: Group_id.self)
                    self.groups_by_id.append(group)
                } else {
                    print("Group not found for ID: \(group_id)")
                }
            } catch {
                print("Error fetching group data for ID: \(group_id), Error: \(error)")
            }
        }
    }
    
    func createGroup (name: String, users: [User], image: UIImage?) async -> Base{
        // Store the group in database
        do {
            let newGroupRef = Firestore.firestore().collection("groups").document()
            let groupID = newGroupRef.documentID
            let memberIDs = users.map {$0.id}
            var newGroup = Group_id(id: groupID, name: name, pfp: "", members: memberIDs)
            if let image = image {
                imageUtil.uploadGroupPhoto(groupId: groupID, selectedImage: image) { result in
                    switch result{
                    case .success(let urlString):
                        newGroup.pfp = urlString
                        let encodedGroup = try? Firestore.Encoder().encode(newGroup)
                        Firestore.firestore().collection("groups").document(groupID).setData(encodedGroup ?? [:])
                        self.groups_by_id.append(newGroup)
                        self.userModel.addGroup(groupId: groupID)
                    case .failure(let error):
                        print("Error uploading photo: \(error)")
                    }
                }
            } else {
                let encodedGroup = try? Firestore.Encoder().encode(newGroup)
                try await Firestore.firestore().collection("groups").document(groupID).setData(encodedGroup ?? [:])
                self.groups_by_id.append(newGroup)
                self.userModel.addGroup(groupId: groupID)
            }
            
            await populateOtherUsers(users: users, groupID: groupID)
            await fillGroupStruct(groups: [newGroup])
            return .success
            
        } catch {
            return .failure(error.localizedDescription)
        }
    }
    
    func populateOtherUsers(users: [User], groupID: String) async{
        do{
            for (index, _) in users.enumerated() {
                var user = users[index]
                if user.groups == nil{
                    user.groups = [groupID]
                } else {
                    user.groups?.append(groupID)
                }
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func addMembertoGroup(name: String, groupid: String)-> Base{
        // add a new member to an existing group
        return .success
    }
    func refreshGroups()->Base{
        // refresh groups after adding a new member
        return .success
    }
    
    func signOut() {
        self.user_groups = [:]
        self.user_cache = [:]
        self.groups_by_id = []
    }
}
