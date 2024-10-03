//
//  NoContentPost.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct NoContentPost: View{
    @EnvironmentObject var friendModel: FriendVM
    let post: Post
    var body: some View{
        VStack(alignment: .leading, spacing: 10) { // Adjust the spacing as needed
            VStack (alignment: .leading){
                HStack{
                    ProfileIcon(userId: post.userId, size: 40)
                    VStack(alignment:.leading){
                        if let username = friendModel.usernames[post.userId]{
                            Text("@\(username)")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        if let name = friendModel.names[post.userId]{
                            Text("\(name)")
                                .font(.system(size: 12))
                        }
                    }
                    Spacer()
                }
                Text(post.caption)
                    .font(.system(size: 20))
                
                    if post.comments.count > 2 {
                        Text("View all \(post.comments.count) comments")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.leading, 1)
                    }
                    
                    VStack{
                        ForEach(post.comments.suffix(2), id: \.id) { comment in
                            PostComment(comment: comment)
                        }
                    }
                    .padding(.leading, 1)
                    .padding(.top, 1)
//                    Divider()
                
                LikeCommentButton(likes: post.likes, comments: post.comments.count)
                
            }
            
            
        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("gray-text"))
        )
    }
}
