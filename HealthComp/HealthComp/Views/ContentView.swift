//
//  ContentView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    var body: some View {
        VStack {
            if let user = userModel.currentUser{
                BaseView()

            }
        }.onAppear{
            Task{
                if var user = userModel.currentUser{
                    user.data = healthModel.healthData
                }
            }
        }
//        Group {
//            if userModel.userSession != nil {
//                
//                BaseView()
//            } else {
//                StartupView()
//            }
//        }.onAppear {
//            userModel.checkUserSession()
//        }
    }
}

