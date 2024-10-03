//
//  ContentView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var imageUtil: ImageUtilObservable
    
    var body: some View {
        let friendModel = FriendVM(userModel: userModel, imageUtil: imageUtil)
        let groupModel = GroupVM(userModel: userModel, healthModel: healthModel, friendModel: friendModel)
        let feedModel = FeedVM(userModel: userModel, friendModel: friendModel)
        let goalModel = GoalVM()
//        let leaderboardModel = LeaderBoardVM(userModel: userModel, friendModel: friendModel, healthModel: healthModel)

        Group {
            if userModel.userSession != nil {
                BaseView()
                    .environmentObject(friendModel)
                    .environmentObject(groupModel)
                    .environmentObject(feedModel)
                    .environmentObject(goalModel)
                    .onAppear {
                        userModel.checkUserSession()
                        healthModel.fetchAllHealthData()
                    }
            } else {
                StartupView()
                    .environmentObject(userModel)
                    .environmentObject(friendModel)
                    .environmentObject(groupModel)
                
            }
        }
                
        }
    }

