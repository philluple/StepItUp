//
//  SubPost.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct PostView: View {
    let post: Post
    var body: some View {
        if let _ = post.attatchment{
            ContentPost(post: post)
                .padding(.vertical, 5)
        } else {
            NoContentPost(post:post)
                .padding(.vertical, 5)
        }

    }
}

