//
//  IconView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct Icon: View{
    let friend: UserHealth
    var body: some View {
        VStack{
            ProfileIcon(userId: friend.id, size: 60)
            Text("@\(friend.user.username)")
                .font(.system(size: 12, weight: .semibold))
        }
    }
}
