//
//  ProfileIcon.swift
//  HealthComp
//
//  Created by Claudia Cortell on 11/28/23.
//

import SwiftUI

struct ProfileIcon: View {
    @EnvironmentObject var imageUtil: ImageUtilObservable
    let userId: String
    var size: CGFloat
    @State private var profileImage: Image?
    
    var body: some View {
        VStack {
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            }
        }
        .onAppear {
            imageUtil.imageUtils.fetchProfilePhoto(userId: userId){ result in
                switch result{
                case .success(let uiImage):
                    self.profileImage = Image(uiImage: uiImage)
                case .notFound:
                    self.profileImage = Image(systemName: "person.circle.fill")
                }
            }
        }
    }
}

