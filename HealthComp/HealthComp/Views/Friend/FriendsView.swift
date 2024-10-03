//
//  FriendsView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//

import SwiftUI

struct FriendsView: View {
    var friends: [UserHealth]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 40){
                        ForEach(friends){ friend in
                            FriendCell(friend: friend)
                                .padding(.vertical, 2)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 25)
                }
            }
        }
    }
}


