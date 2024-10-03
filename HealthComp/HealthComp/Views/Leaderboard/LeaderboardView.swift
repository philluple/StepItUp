//
//  LeaderboardView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI


struct LeaderboardView: View {

    @EnvironmentObject var leaderboardModel: LeaderBoardVM
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var groupModel: GroupVM
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.greyToBlack)
                    .ignoresSafeArea(.all)
                VStack{
                    TabView{
                    
                        //showing friends
                        LeaderboardTab()
                        
                        //showing groups
                        ForEach(groupModel.user_groups.keys.sorted(), id: \.self) { groupId in
                            LeaderboardTab(groupId: groupId)
                        }
                    }
                    .tabViewStyle(.page)
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

