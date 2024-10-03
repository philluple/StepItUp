//
//  FriendRequest .swift
//  HealthComp
//
//  Created by Phillip Le on 11/21/23.
//

import Foundation

struct FriendRequest: Identifiable {
    var id: String
    var sender_id: String
    var dest_id: String
    var status: Status
}
