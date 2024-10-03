//
//  LeaderboardTab.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI


struct LeaderboardTab: View {
    @EnvironmentObject var leaderboardModel: LeaderBoardVM
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var groupModel: GroupVM
    
    var groupId: String?
    
    var body: some View {
        ScrollView{
            
            if let groupId = groupId{
                if groupModel.user_groups.keys.contains(groupId) {
                    LeaderboardHeader(friendGroupName: groupModel.user_groups[groupId]!.name).padding(.bottom, 5)
                    
                    if leaderboardModel.currentUserHealth != nil{
                        LeaderboardMessage(currentUser: leaderboardModel.currentUserHealth!, sortedUsers: groupModel.user_groups[groupId]!.members)
                        
                        ForEach(Array(groupModel.user_groups[groupId]!.members.enumerated()), id: \.element.id) { index, user in
                            let isCurrentUser = user.id == userModel.currentUser?.id
                            LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: isCurrentUser)
                        }
                        
                    } else {
                        let filler_data = HealthData(dailyStep: 0, dailyMileage: 0.0, weeklyStep: 0, weeklyMileage: 0.0)
                        if let user = userModel.currentUser{
                            let filler_user = UserHealth(id: user.id, user: user, data: filler_data)
                            
                            LeaderboardMessage(currentUser: filler_user, sortedUsers: groupModel.user_groups[groupId]!.members)
                            
                            ForEach(Array(groupModel.user_groups[groupId]!.members.enumerated()), id: \.element.id) { index, user in
                                let isCurrentUser = user.id == userModel.currentUser?.id
                                LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: isCurrentUser)
                            }
                        }
                    }
                }
            } else {
                LeaderboardHeader(friendGroupName: "Friends").padding(.bottom, 5)
                
                if leaderboardModel.currentUserHealth != nil{
                    LeaderboardMessage(currentUser: leaderboardModel.currentUserHealth!, sortedUsers: leaderboardModel.sortedUsers)
                    
                    ForEach(Array(leaderboardModel.sortedUsers.enumerated()), id: \.element.id) { index, user in
                        let isCurrentUser = user.id == userModel.currentUser?.id
                        LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: isCurrentUser)
                    }
                } else {
                    let filler_data = HealthData(dailyStep: 0, dailyMileage: 0.0, weeklyStep: 0, weeklyMileage: 0.0)
                    if let user = userModel.currentUser{
                        let filler_user = UserHealth(id: user.id, user: user, data: filler_data)
                        
                        LeaderboardMessage(currentUser: filler_user, sortedUsers: leaderboardModel.sortedUsers)
                        
                        ForEach(Array(leaderboardModel.sortedUsers.enumerated()), id: \.element.id) { index, user in
                            LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: false)
                        }
                        LeaderboardCell(user: filler_user, leaderboardPosition: Array(leaderboardModel.sortedUsers).count+1, isCurrentUser: true)
                    }
                }
            }
        
            
        }.onAppear{
            Task{
                leaderboardModel.makeUserHealth()
                leaderboardModel.sortUsers()
            }
        }.padding(.top)
    }
    
}
