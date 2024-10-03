//
//  Group.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

struct Group_id: Identifiable, Codable{
    var id: String
    var name: String
    var pfp: String
    var members: [String]
}

struct Group_user: Identifiable, Codable{
    var id: String
    var name: String
    var pfp: String
    var members: [UserHealth] = []
}

