//
//  TestView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/13/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var testModel: TestVM
    var body: some View {
        Button {
            Task{
                if let result = try? await testModel.userModel.createUser(email: testModel.email, password: testModel.password, username: testModel.username, name: testModel.name, pfp_uri: ""){ switch result {
                case .success(let id):
                    print(id)
                case .failure(let error):
                    print(error)
                }
                }
            }
        } label: {
            Text("Create User")
        }
        
        
    }
}

#Preview {
    TestView()
}
