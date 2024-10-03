//
//  LeaderboardCell.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct LeaderboardCell: View{
    let user: UserHealth
    let leaderboardPosition: Int
    let isCurrentUser: Bool
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width:UIScreen.main.bounds.width-40, height: 60)
                .foregroundColor(isCurrentUser ? Color("const-blue") : Color("light-green"))

            HStack {
                Text("\(leaderboardPosition).").fontWeight(.bold).foregroundColor(Color("const-navy"))
                                    .padding(.trailing, 8)
                ProfileIcon(userId: user.user.id, size: 40)
                Spacer()
                Text(user.user.name)
                    .foregroundColor(Color("const-navy"))
                    .fontWeight(.semibold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .padding(.leading, 8)
                Spacer()
                Text("\(user.data.dailyStep!)")
//                    .fontWeight(.bold)
                    .font(.custom("DIN Alternate",fixedSize: 16))
                    .foregroundColor(Color("const-navy"))
            }.frame(width: UIScreen.main.bounds.width - 80)
        }
    }
}

