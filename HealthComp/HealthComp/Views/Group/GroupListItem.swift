//
//  GroupList.swift
//  HealthComp
//
//  Created by Phillip Le on 11/30/23.
//

import SwiftUI

struct GroupListItem: View {
    var group: Group_user
    @EnvironmentObject var groupModel: GroupVM
    var body: some View {
        HStack{
                GroupImageIcon(groupId: group.id, size: 50)
                    .padding(.horizontal, 20)
            
                VStack(alignment: .leading, spacing: 2){
                Text(group.name)
                    .font(.system(size: 16, weight: .semibold))
                HStack(spacing: 2){
                    ForEach(Array(group.members.prefix(4))) { friend in
                        ProfileIcon(userId: friend.user.id, size: 25)
                    }
                    if group.members.count > 4{
                        Circle()
                            .foregroundColor(Color("medium-green"))
                            .frame(width: 30, height: 30)
                            .overlay{
                                Text("+\(group.members.count - 4)")
                                    .foregroundColor(Color("const-navy"))
                                    .font(.system(size: 10, weight: .bold))
                            }
                    }
                }
                
            }
            Spacer()
            Image(systemName: "arrow.right.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.darkBlue)
        }.padding(.horizontal, 20)
            .frame(width: UIScreen.main.bounds.width - 40, height: 90)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 2)
                .frame(width: UIScreen.main.bounds.width - 30, height: 90)
                .foregroundColor(Color("gray-text")) // Set your desired outline color here
                .opacity(0.5)
        )

        
    }
}

#Preview {
    VStack{
        GroupListItem(group: Group_user(id: UUID().uuidString, name: "Team Denmark", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68", members: [UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0))]))
        GroupListItem(group: Group_user(id: UUID().uuidString, name: "Team Denmark", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68", members: [UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0)), UserHealth(id: UUID().uuidString, user: User(id: UUID().uuidString, name: "Tuna Cakes", email: "tuna@columbia.edu", username: "tuna_queen", pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68"), data: HealthData(dailyStep: 0, dailyMileage: 0, weeklyStep: 0, weeklyMileage: 0))]))
    }

}
