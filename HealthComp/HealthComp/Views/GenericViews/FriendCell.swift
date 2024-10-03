//
//  FriendCell.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct FriendCell: View {
    let friend: UserHealth

    var body: some View {
        VStack(){
            ProfileIcon(userId: friend.id, size: 75)
                .padding(.bottom, 2)

            Text("@\(friend.user.username)")
                .foregroundColor(.black)
                .font(.system(size: 14, weight: .semibold))
                .multilineTextAlignment(.center)
                
                 
            Text(friend.user.name)
                .foregroundColor(Color("dark-blue"))
                .font(.system(size: 12))
                .multilineTextAlignment(.center)

        }
        .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color("light-green"))
                       .frame(width: 120, height: 180))
        .padding(12)
    }
}
