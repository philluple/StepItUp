//
//  StartupView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct StartupView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Logo()
                    .padding(.vertical, 50)
                NavigationLink {
                    LoginView()
                } label: {
                    LoginButton()
                }.accentColor(.white)
                    .padding()
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    SignupButton()
                }.accentColor(.white)
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    StartupView()
}

