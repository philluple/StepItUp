//
//  TestVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/13/23.
//

import Foundation

class TestVM: ObservableObject{
    var userModel: UserVM
    var friendModel: FriendVM
    var groupModel: GroupVM
    var feedModel: FeedVM
    
    let username = "tester_name"
    let name = "Test User"
    let email = "test@columbia.edu"
    let password = "March1502!"
    let pfp_uri = "https://img.texasmonthly.com/2021/11/walker-county-jane-doe-sherri-jarvis.jpg?auto=compress&crop=faces&fit=crop&fm=jpg&h=1400&ixlib=php-3.3.1&q=45&w=1400"
    let test_friends = ["IW4JP7gAniayXu7yVIWM7yMO62p2", "OdVxAcmRGXhbNfCfN7EMXSFm02z2", "nsGWH2pLj8hXsYyVsZ0SrjfPxBA2"]
    init(userModel: UserVM, friendModel: FriendVM, groupModel: GroupVM, feedModel: FeedVM){
        self.userModel = userModel
        self.friendModel = friendModel
        self.groupModel = groupModel
        self.feedModel = feedModel
    }
}
