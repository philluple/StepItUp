//
//  GoalVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class GoalVM: ObservableObject {
    @Published var userGoal: Goal?
    var fetchTime: Int = 0
    
    init(){
        Task{
            if fetchTime == 0{
                self.fetchGoal()
            }
        }
    }
    
    func fetchGoal() {
        guard let user_id = UserDefaults.standard.string(forKey: "userId") else {
            print("User ID not found in UserDefaults")
            return
        }
        
        Task {
            do {
                let snapshot = try await Firestore.firestore().collection("goals").document(user_id).getDocument()
                DispatchQueue.main.async { [weak self] in
                    if let goal = try? snapshot.data(as: Goal.self) {
                        self?.userGoal = goal
                        self?.fetchTime += 1
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func writeGoal(userId: String, goal: Goal) async{
        do{
            let encoded_goal = try Firestore.Encoder().encode(goal)
            try await Firestore.firestore().collection("goals").document(userId).setData(encoded_goal)
            self.userGoal = goal
            return
        }catch{
            print(error.localizedDescription)
        }
    }
}
