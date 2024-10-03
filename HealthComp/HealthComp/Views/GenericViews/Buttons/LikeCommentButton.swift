//
//  LikeCommentButton.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI


struct LikeCommentButton: View {
    let likes: Int
    let comments: Int
    let size: CGFloat = 20

    var body: some View {
        HStack{
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
            if likes > 0{
                Text("\(String(likes)) likes")
                    .font(.system(size: 12))
                
            }
            Image(systemName: "text.bubble")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
            if comments > 0{
                if comments == 1{
                    Text("\(String(comments)) comment")
                        .font(.system(size: 12))

                }else{
                    Text("\(String(comments)) comments")
                        .font(.system(size: 12))

                }
            }
            Spacer()
        }
    }
}
