//
//  FriendSearchView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//


import SwiftUI

struct FriendSearchView: View {

    @State private var searchText = ""
    @State private var results: [User] = []
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var userModel: UserVM
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    SearchBar(text: $searchText, searchResults: $results)
                        .padding()
                    ForEach(results){ friend in
                        if friend.id != userModel.currentUser?.id{
                            SearchCell(friend: friend)
                            Divider()
                                .padding(.horizontal, 20)
                        }
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height - 30)
                    
                    Spacer()
                }
            }
        }
    }
}

