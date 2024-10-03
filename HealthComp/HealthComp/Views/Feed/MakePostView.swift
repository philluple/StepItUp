//
//  MakePostView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct MakePostView: View {
    @EnvironmentObject var userModel: UserVM
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(Color("progress-box"))
            .frame(width: UIScreen.main.bounds.width - 25, height: 80)
            .overlay{
                HStack{
                    if let user = userModel.currentUser{
                        ProfileIcon(userId: user.id, size: 50)
                    }
                    
                    Text("What's on your mind?")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("gray-text"))
                    Spacer()
                }.padding()
            }
    }
}

