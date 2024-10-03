//
//  SearchCell.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct SearchCell: View {
    let friend: User
    @EnvironmentObject var friendModel: FriendVM
    @State private var isFriendAdded = false
    @State private var sheetPresented = false
    
    
    var body: some View {
        HStack {
            ProfileIcon(userId: friend.id, size: 40)
            
            VStack(alignment: .leading) {
                Text(friend.name)
                    .font(.system(size: 14))
                Text(friend.username)
            }
            
            Spacer()
            if !friendModel.user_friends.keys.contains(friend.id) {
                if isFriendAdded == false{
                    Button(action: {
                        // Call a function from
                        Task{
                            await friendModel.addFriend(friendId: friend.id)
                        }
                        isFriendAdded.toggle()
                        sheetPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .foregroundColor(Color("medium-green"))
                            .frame(width: 20, height: 20)
                    }
                }else{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color("dark-blue"))
                        .frame(width: 20, height: 20)
                }
            }
        }.sheet(isPresented: $sheetPresented) {

        } content: {
            SuccessView(message: "Added \(friend.name) as a friend!")
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}
