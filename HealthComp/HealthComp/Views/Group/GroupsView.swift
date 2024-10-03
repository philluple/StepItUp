import SwiftUI

import SwiftUI

struct GroupsView: View {
    @State private var isMemberAdded: Bool = false
    let group: Group_user

    var body: some View {
        VStack {
            Text(group.name)
                .font(.title)
                .padding()
                .lineLimit(nil)

            Text("Total Members: \(group.members.count)")
                .font(.title3)
            ScrollView{
                LazyHGrid(rows: [GridItem(), GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.01) {
                    ForEach(group.members) { friend in
                        FriendCell(friend: friend)
                    }
                }
            }
            .padding()
        }
    }
}
