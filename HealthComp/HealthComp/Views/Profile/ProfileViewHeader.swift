//
//  ProfileViewHeader.swift
//  HealthComp
//
//  Created by Phillip Le on 11/18/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    @EnvironmentObject var imageUtil: ImageUtilObservable // Inject your observable object here
    let user: User
    var body: some View {
        VStack{
            ProfileIcon(userId: user.id, size: 120)
            Text("\(user.name)")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 15)
            Text("@\(user.username)")
                .font(.system(size: 16, weight: .semibold))
        }
    }
    
}


//#Preview {
//    ProfileHeaderView(user: currentUser)
//}
