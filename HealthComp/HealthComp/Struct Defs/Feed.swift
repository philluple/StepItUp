//
//  Post.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: String
    var userId: String
    // Store it as a Date() but convert to string
    var date: String?
    var date_swift: Date?
    var likes: Int = 0
    // Link that we will use to load the image
    var attatchment: String?
    var caption: String
    var comments: [Comment]
}

struct Comment: Identifiable, Codable {
    var id: UUID
    var name: String
    var recieverUserID: UUID
    var senderUserId: UUID
    var message: String
    var date: String
}
