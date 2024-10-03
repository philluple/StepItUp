//
//  LeaderboardHeader.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct LeaderboardHeader: View {
    var friendGroupName: String
    
    var body: some View {
        Text(friendGroupName).font(.system(size: 22, weight: .semibold)).foregroundColor(Color("dark-blue"))
    }
}
