import SwiftUI

struct GroupsDetailView: View {
    let group: Group_user
    @EnvironmentObject var groupModel: GroupVM
    
    var body: some View {
        ScrollView {
            VStack {
                // Group Picture
                GroupImageIcon(groupId: group.id, size: 150)
                
                // Group Name
                Text(group.name)
                    .font(.custom("DIN Alternate",fixedSize: 30))
                    .bold()
                    .padding()
                
                let totalSteps = group.members.reduce(0) { $0 + ($1.data.dailyStep ?? 0) }
            
                HStack {
                                    // Members count
                    RoundedRectangle(cornerRadius: 20.0)
                        .foregroundColor(Color("dark-blue"))
                        .frame(width:UIScreen.main.bounds.width * 0.4 , height: UIScreen.main.bounds.height * 0.1)
                        .overlay(
                            Text("MEMBERS: \(group.members.count)")
                                .foregroundColor(Color("grey-to-black"))
                                .font(.custom("DIN Alternate",fixedSize: 18))                                                .bold()
                        )
                                        .padding()

                                    // Total Steps
                    RoundedRectangle(cornerRadius: 20.0)
                            .foregroundColor(Color("dark-blue"))
                            .frame(width:UIScreen.main.bounds.width * 0.4 , height: UIScreen.main.bounds.height * 0.1)
                            .overlay(
                                Text("TOTAL STEPS: \(totalSteps)")
                                    .foregroundColor(Color("grey-to-black"))
                                    .font(.custom("DIN Alternate",fixedSize: 18))
                                    .bold()
                            )
                            .padding()
                }
                                // User with the most steps
                if let topUser = group.members.max(by: { $0.data.dailyStep ?? 0 < $1.data.dailyStep ?? 0 }) {
                    Text(" \(Text(topUser.user.name).bold()) currently has the most steps with \(topUser.data.dailyStep ?? 0) steps! Step it up!")
                        .font(.custom("DIN Alternate",fixedSize: 18))
//                        .foregroundColor(Color("grey-to-black"))
                        .padding()
                } else {
                    Text("No user data available.")
                        .font(.custom("DIN Alternate",fixedSize: 18))
//                        .foregroundColor(Color("grey-to-black"))
                        .padding()
                }
                
                // Group Members
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.01) {
                    ForEach(group.members) { friend in
                        FriendCell(friend: friend)
                            .padding(.vertical, 20)
                    }
                }
            }
            .padding()
            
        }
        
    }
    
}
