//
//  GroupCellView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/19/23.
//

import SwiftUI

struct GroupCell: View {
    let group: Group_user
    let rowIndex: Int
    let columnIndex: Int

    var body: some View {
        VStack(alignment: .center) {
            // Group Image
            Image(systemName:"person.3.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)

            // Group Name
            Text(group.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // Members' Images
            ScrollView{
                HStack(spacing: 5){
                    ForEach(Array(group.members.prefix(2))) { friend in
                        ProfileIcon(userId: friend.user.id, size: 20)
                    }
                    
                    if group.members.count > 2 {
                        Text("+\(group.members.count - 2)")
                            .font(.footnote)
                            .foregroundColor(Color("const-navy"))
                            .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.width * 0.1)
                            .background(Color("light-green"))
                            .clipShape(Circle())
                    }
                    
                    
                    
                }
                       
            } .frame(width: UIScreen.main.bounds.width * 0.15)
                .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.22)
        .padding(UIScreen.main.bounds.width * 0.1)
        .background(Color("dark-blue"))
        .cornerRadius(15)
    }

    
}
