//
//  SearchBar.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var searchResults: [User]
    @EnvironmentObject var friendModel: FriendVM
    
    var body: some View {
        HStack {
            TextField(" Search", text: $text)
                .padding(6)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .onSubmit {
                    friendModel.searchFriend(search: text) { result in
                        switch result {
                        case .success(let matchingUsers):
                            self.searchResults = matchingUsers
                            // Update your UI or perform other operations with the matchingUsers array
                        case .failure(let error):
                            // Handle error
                            print("Error during search: \(error.localizedDescription)")
                            // Show an alert or update UI to indicate an error
                        }
                    }
                }
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: text.isEmpty ? 0: 15, height: text.isEmpty ? 0:15)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
            .opacity(text.isEmpty ? 0 : 1)
        }
        
        
        
    }
}
