//
//  GroupIcon.swift
//  HealthComp
//
//  Created by Phillip Le on 12/3/23.
//

import SwiftUI

struct GroupIcon: View {
    @EnvironmentObject var imageUtil: ImageUtilObservable
    let groupId: String
    var size: CGFloat
    @State private var groupPhoto: Image?
    
    var body: some View {
        VStack {
            if let groupPhoto = groupPhoto {
                groupPhoto
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
            imageUtil.imageUtils.fetchGroupPhoto(groupId: groupId){ result in
                switch result{
                case .success(let uiImage):
                    self.groupPhoto = Image(uiImage: uiImage)
                case .notFound:
                    self.groupPhoto = Image(systemName: "person.circle.fill")
                }
            }
        }
    }
}
