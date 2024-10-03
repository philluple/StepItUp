//
//  GroupsMemberView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/19/23.
//

import SwiftUI

struct GroupMember: View {
    var curr_user: User
    var body: some View {
        VStack {
            ProfileIcon(userId: curr_user.id, size: 100)
            Text(curr_user.name)
                .foregroundColor(Color("dark-blue"))
                .bold()
                .lineLimit(nil)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
