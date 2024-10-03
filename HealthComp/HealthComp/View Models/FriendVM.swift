//
//  FriendVM.swift
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


class FriendVM: ObservableObject {
    var userModel: UserVM
    var imageUtil: ImageUtilObservable
    
    @Published var user_friends: [String: UserHealth] = [:]
    @Published var pfpUrl: [String: String] = [:]
    @Published var names: [String: String] = [:]
    @Published var usernames: [String: String] = [:]
   
    init(userModel: UserVM, imageUtil: ImageUtilObservable) {
        self.userModel = userModel
        self.imageUtil = imageUtil
        
        Task {
            if let friends_id = self.userModel.currentUser?.friends {
                if friends_id.count > 0 {
                    await self.fetchFriends(friend_ids: friends_id)
                    
                    if let user = self.userModel.currentUser {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            
                            self.pfpUrl[user.id] = user.pfp
                            self.names[user.id] = user.name
                            self.usernames[user.id] = user.username
                        }
                    }
                }
            }
        }
    }

    
    func searchFriend(search: String, completion: @escaping (Result<[User], Error>) -> Void) {
        var matchingUsers: [User] = []
        let searchValue = search.trimmingCharacters(in: .whitespaces)
        let searchEndValue = searchValue + "\u{f8ff}" // Unicode character that is higher than any other character

        Firestore.firestore().collection("users")
            .whereField("username", isGreaterThanOrEqualTo: searchValue)
            .whereField("username", isLessThan: searchEndValue)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("ERROR searchFriend(): \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                for document in querySnapshot!.documents {
                    if let user = try? document.data(as: User.self) {
                        matchingUsers.append(user)
                    } else {
                        print("Error decoding user data")
                    }
                }

                // If no matches found by username, search by name
                if matchingUsers.isEmpty {
                    Firestore.firestore().collection("users")
                        .whereField("name", isGreaterThanOrEqualTo: searchValue)
                        .whereField("name", isLessThan: searchEndValue)
                        .getDocuments { (querySnapshot, error) in
                            if let error = error {
                                print("ERROR searchFriend(): \(error.localizedDescription)")
                                completion(.failure(error))
                                return
                            }
                            for document in querySnapshot!.documents {
                                if let user = try? document.data(as: User.self) {
                                    matchingUsers.append(user)
                                } else {
                                    print("Error decoding user data")
                                }
                            }
                            completion(.success(matchingUsers))
                        }
                } else {
                    completion(.success(matchingUsers))
                }
            }
    }

    

    func fetchFriends(friend_ids: [String]) async {
        for user_id in friend_ids {
            do {
                let resultUser = try await self.userModel.fetchUser(id: user_id)
                let resultHealth = try await fetchHealthData(id: user_id)
                
                let localFetchedFriendUser: User?
                let localFetchedFriendHealth: HealthData?
                
                switch resultUser {
                    case .success(let user):
                        localFetchedFriendUser = user
                    case .failure(let error):
                        print(error)
                        localFetchedFriendUser = nil
                }
                
                switch resultHealth {
                    case .success(let healthdata):
                        localFetchedFriendHealth = healthdata
                    case .failure(let error):
                        print(error)
                        localFetchedFriendHealth = nil
                }
                
                // Now, perform UI updates on the main thread
                DispatchQueue.main.async { [weak self] in
                    if let user = localFetchedFriendUser, let health = localFetchedFriendHealth {
                        self?.user_friends[user_id] = UserHealth(id: user_id, user: user, data: health)
                        self?.pfpUrl[user_id] = user.pfp
                        self?.names[user_id] = user.name
                        self?.usernames[user_id] = user.username
                    } else {
                        print("Error fetching friend for Id: \(user_id)")
                    }
                }
                
            } catch {
                print("Error fetching data for ID: \(user_id), Error: \(error)")
            }
        }
    }
    
    func addFriend(friendId: String) async{
        do{
            if var user = userModel.currentUser{
                var _ = user.friends
                if user.friends == nil{
                    user.friends = [friendId]
                } else {
                    user.friends?.append(friendId)
                }
                // curr user
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
                // friend
                let result = try await self.userModel.fetchUser(id: friendId)
                switch result {
                case .success (var friend):
                    if friend.friends == nil{
                        friend.friends = [user.id]
                    } else {
                        friend.friends?.append(user.id)
                    }
                    let encodedFriend = try Firestore.Encoder().encode(friend)
                    try await Firestore.firestore().collection("users").document(friend.id).setData(encodedFriend)
                case .failure (_):
                    print("Could not add friend")
                }
//                try await Firestore.firestore().collection("users").document(friendId).setData(["friends": [user.id]], merge: true)
                await fetchFriends(friend_ids: [friendId])
                userModel.addFriend(userId: friendId)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    func fetchHealthData(id: String) async throws -> FetchHealthData {
        guard let snapshot = try? await Firestore.firestore().collection("healthdata").document(id).getDocument() else {return .failure("Could not fetch a user's health data")}
        if let userHealthData = try? snapshot.data(as: HealthData.self){
            return .success(userHealthData)
        } else{
            return .failure("Could not decode a user's health data")
        }
    }
    func signOut() {
        self.user_friends = [:]
        self.pfpUrl = [:]
    }
    
}


