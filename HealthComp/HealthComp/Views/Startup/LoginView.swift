//
//  LoginView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var pw = ""
    @State private var success: Bool = false
    @EnvironmentObject var userModel: UserVM
    
    var body: some View {
        NavigationStack{
            VStack(){
                Logo()
                CustomTextField(title: "email", placeholder: "", secure: false, autocap: false, text: $email)
                CustomTextField(title: "Password", placeholder: "", secure: true, autocap: false, text: $pw)
                
                Button {
                    Task{
                        if let result = try? await userModel.signIn(withEmail: email, password: pw){
                            switch result{
                            case .success:
                                print("Success: Logged in")
                            case .failure(let message):
                                print(message)
                            }
                        }
                    }
                } label : {
                    LoginButton()
                }.accentColor(.white)
                    .padding(.top, 20)
                NavigationLink {
                    RegistrationView()
                } label: {
                    SmallSignupButton()
                }.accentColor(.white)
            }.navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    LoginView()
}

