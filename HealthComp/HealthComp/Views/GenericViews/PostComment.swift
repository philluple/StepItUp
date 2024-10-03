//
//  PostComment.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct PostComment: View {
    let comment: Comment
    var body: some View{
        HStack{
            HStack {
                Text("__\(comment.name)__ \(comment.message)")
                    .font(.system(size: 14))
                Spacer()
            }
        }.padding(.bottom, 0.5)
    }
}
