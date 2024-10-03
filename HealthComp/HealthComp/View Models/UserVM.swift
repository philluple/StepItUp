//
//  UserModel.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class UserVM: ObservableObject {
    @Published var currentUser: User?
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchCurrUser()
        }
    }

    func checkUserSession() {
        // Add an observer to the Firebase Authentication state
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if let user = user {
                self.userSession = user
                Task {
                    await self.fetchCurrUser()
                    UserDefaults.standard.set(user.uid, forKey: "userId")
                }
            } else {
                // User is signed out, set userSession to nil and reset currentUser data
                self.userSession = nil
                DispatchQueue.main.async{
                    self.currentUser = nil
                }
            }
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws-> Base{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchCurrUser()
            if let userId = self.currentUser?.id{
                UserDefaults.standard.set(userId, forKey: "userId")
            }
            return .success
        } catch {
            if (error.localizedDescription == "There is no user record corresponding to this identifier.The user may have been deleted"){
                return .failure("Hmmm, we couldn't find that account. Try creating one")
            }
            else if (error.localizedDescription == "The password is invalid or the user does not have a password."){
                return .failure("Incorrect password, try again!")
            }
            else{
                return .failure(error.localizedDescription)
            }
        }
    }
    
    func createUser(email: String, password: String, username: String, name: String, pfp_uri: String) async throws -> CreateUser{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            DispatchQueue.main.async{
                self.userSession = result.user
            }
            UserDefaults.standard.set(result.user.uid, forKey: "userId")
            UserDefaults.standard.set(name, forKey: "name")
            let new_user = User(id: result.user.uid, name: name, email: email, username: username, pfp: pfp_uri)
            let encoded_user = try Firestore.Encoder().encode(new_user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encoded_user)
            return .success(new_user.id)
        } catch {
            print(error.localizedDescription)
            return .failure(error.localizedDescription)
        }
    }

    func isUsernameAvailable(_ username: String, completion: @escaping (Bool, Error?) -> Void) {
        Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error)
            } else {
                let isAvailable = querySnapshot?.isEmpty ?? true
                completion(isAvailable, nil)
            }
        }
    }
    
    
    func isPasswordValid(password: String) -> Bool {
        if password.count < 6{
            return false
        }
        return true
    }
    
    func addPost(postId: String) {
        if self.currentUser?.posts == nil {
            self.currentUser?.posts = [postId]
        } else {
            // Safely unwrap the posts array, append postId, and update 'currentUser' posts
            if var posts = self.currentUser?.posts {
                posts.append(postId)
                self.currentUser?.posts = posts
            }
        }
    }

    func addGroup(groupId: String) {
        if self.currentUser?.groups == nil {
            self.currentUser?.groups = [groupId]
        } else {
            // Safely unwrap the posts array, append postId, and update 'currentUser' posts
            if var groups = self.currentUser?.posts {
                groups.append(groupId)
                self.currentUser?.groups = groups
            }
        }
    }
    
    func addFriend(userId: String) {
        if self.currentUser?.friends == nil {
            self.currentUser?.friends = [userId]
        } else {
            // Safely unwrap the posts array, append postId, and update 'currentUser' posts
            if var friends = self.currentUser?.posts {
                friends.append(userId)
                self.currentUser?.friends = friends
            }
        }
    }
    
    func checkPassword(confirm: String, password: String) -> Bool{
        if confirm == password{
            return true
        } else {
            return false
        }
    }
    
    func fetchUser(id: String) async throws -> FetchUser {
        guard let snapshot = try? await Firestore.firestore().collection("users").document(id).getDocument() else {return .failure("Could not fetch user")}
        if let user = try? snapshot.data(as: User.self) {
            return .success(user)
        } else {
            return .failure("Could not decode a user")
        }
        
    }
    
    func fetchCurrUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        DispatchQueue.main.async{
            self.currentUser = try? snapshot.data(as: User.self)            
        }
    }
        
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }catch{
            print("Could not signout")
        }
    }
    
}
