import SwiftUI
import SwiftUICharts

struct ProfileView: View {
    
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var feedModel: FeedVM
    @EnvironmentObject var leaderboardModel: LeaderBoardVM
    @EnvironmentObject var groupModel: GroupVM
    @EnvironmentObject var goalModel: GoalVM
    @EnvironmentObject var imageUtil: ImageUtilObservable
    @State private var didFetchProfilePhoto = false // Track if profile photo was fetched    
    @State var editGoalPresented = false
    @State var signoutConfirmPresented = false

    private var fetchCount: Int  = 0
    private func signOutAction() {
        healthModel.signOut()
        friendModel.signOut()
        feedModel.signOut()
        groupModel.signOut()
        userModel.signOut()
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    AppName()
                    HStack{
                        Spacer()
                        Button {
                            signoutConfirmPresented = true
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }.accentColor(Color("button-accent"))
                            .alert(isPresented: $signoutConfirmPresented, content: {
                                Alert(
                                    title: Text("Confirm"),
                                    message: Text("Are you sure you want to sign out?"),
                                    primaryButton: .default(
                                        Text("Sign Out"),
                                        action: signOutAction
                                    ),
                                    secondaryButton: .default(
                                        Text("Cancel"),
                                        action: {}
                                    )
                                    )
                            })
                    }.padding(.trailing)
                }
                if let user = userModel.currentUser{
                    ProfileHeaderView(user: user)
                        .padding(.bottom, 20)
                    HStack(){
                        ProfileHealthStats()
                        if let _ = goalModel.userGoal, !self.editGoalPresented {
                            ProgressBarView(editViewPresented: $editGoalPresented)
                        } else {
                            SetGoalView(clicked: editGoalPresented, isPresented: $editGoalPresented)
                        }                        
                    }.padding(.horizontal)
                    
                    NavigationLink {
                        // use the view model
                        FriendsView(friends: Array(friendModel.user_friends.values))
                    } label: {
                        EmbeddedFriendsView()
                    }.accentColor(Color("button-accent"))
                        .padding(.vertical, 15)
                    HStack{
                        Text("\(groupModel.user_groups.values.count) GROUPS")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width - 25)
                    
                    VStack(){
                        ForEach(Array(groupModel.user_groups.values)){ group in
                            NavigationLink {
                                GroupsDetailView(group: group)
                            } label: {
                                GroupListItem(group: group)
                            }.accentColor(Color("button-accent"))

                        }
                    }
                }
            }
            .refreshable {
                Task{
                    await userModel.fetchCurrUser()
                    goalModel.fetchGoal()
                    healthModel.fetchAllHealthData()
                    if let friends_id = self.userModel.currentUser?.friends {
                        if friends_id.count > 0 {
                            await friendModel.fetchFriends(friend_ids: friends_id)
                        }
                    }
                    if let groups_id = self.userModel.currentUser?.groups {
                        if groups_id.count > 0 {
                            await groupModel.fetchGroups(groups: groups_id)
                        }
                    }
                }
            }
        }
    }
}
