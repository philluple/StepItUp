//
//  EmbeddedFriendsView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/15/23.
//

import SwiftUI

struct EmbeddedFriendsView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var friendModel: FriendVM
    // let friends: [UserHealth]
    var body: some View {
        VStack{
            HStack{
                Text("\(friendModel.user_friends.count) FRIENDS")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("View all")
                    .font(.system(size: 14, weight: .semibold))
            }
            ScrollView(.horizontal){
                HStack(spacing: 20){
                    ForEach(Array(friendModel.user_friends.values)) { friend in
                        // Assuming Icon is a View that displays user information
                        Icon(friend: friend)
                    }
                }
                
            }
            
        }.frame(width: UIScreen.main.bounds.width - 25)
    }
}


