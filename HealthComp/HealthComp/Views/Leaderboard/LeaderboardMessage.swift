//
//  LeaderboardMessage.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct LeaderboardMessage: View {
    let currentUser: UserHealth
    let sortedUsers: [UserHealth]

    init(currentUser: UserHealth, sortedUsers: [UserHealth]) {
        self.currentUser = currentUser
        self.sortedUsers = sortedUsers
    }

    var body: some View {
        Text(messageText()).font(.system(size: 16, weight: .semibold)).foregroundColor(Color("dark-blue")).padding(.bottom, 10).multilineTextAlignment(.center)
            .lineLimit(nil).frame(width: UIScreen.main.bounds.width - 100, height: 80)
    }
    
    func messageText() -> String {
            let leaderboardPosition = leaderboardPositionOfCurrentUser()
            if leaderboardPosition == 1 {
                return "Keep it up! You're on top!"
            } else {
                if let userToBeat = userToBeat(leaderboardPosition) {
                    let numStepsToBeat = userToBeat.data.dailyStep! - currentUser.data.dailyStep!
                    return "\(numStepsToBeat) more steps to beat \(userToBeat.user.name)! Step it up!"
                } else {
                    return "Get moving! Step it up!"
                }
            }
        }
    func leaderboardPositionOfCurrentUser() -> Int {
        if let index = sortedUsers.firstIndex(where: { $0.id == currentUser.id }) {
            return index + 1
        }
        return 0
    }

    func userToBeat(_ leaderboardPosition: Int) -> UserHealth? {
        guard leaderboardPosition > 0 && leaderboardPosition <= sortedUsers.count+1 else {
            return nil
        }
        return sortedUsers[leaderboardPosition-2]
    }
}
