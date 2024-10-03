//
//  RegistrationView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    @State private var next: Bool = false
    @State private var fieldError: Bool = false
    @State private var pwMatchError: Bool = false
    @State private var pwLengthError: Bool = false
    @State private var viewPw: Bool = false
    
    @EnvironmentObject var userModel: UserVM
    
    var body: some View {
        NavigationStack{
            VStack{
                Logo(size: 50)
                    .padding(.bottom, UIScreen.main.bounds.height/50)
                RegistationHeader()
                    .padding(.top, UIScreen.main.bounds.height/8)
                
                CustomTextField(title: "Full name", placeholder: "Roaree the Lion", secure: false, autocap: true, text: $name)
                
                CustomTextField(title: "Email", placeholder: "your_email@columbia.edu", secure: false, autocap: false, text: $email)
                
                CustomTextField(title: "Password", placeholder: "Please not your birthday or dog's name", secure: true, autocap: false, text: $password)
                
                CustomTextField(title: "Confirm Password", placeholder: "", secure: true, autocap: false, text: $confirm)
                
                if fieldError == true{
                    Text("Please enter all fields")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .opacity(1.0)
                }
                
                if pwMatchError == true{
                    Text("Passwords don't match")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .opacity(1.0)
                }
                if pwLengthError == true{
                    Text("Your password must be 6 or more characters long")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .opacity(1.0)
                }
                
                
                NavigationLink {
                    LoginView()
                } label: {
                    SmallSigninButton()
                }

                Spacer()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.fieldError = name.trimmingCharacters(in: .whitespaces).isEmpty || email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || confirm.trimmingCharacters(in: .whitespaces).isEmpty
                        self.pwMatchError = !userModel.checkPassword(confirm: confirm, password: password)
                        self.pwLengthError = !userModel.isPasswordValid(password: password)
                        
                        if !fieldError && !pwMatchError && !pwLengthError {
                            self.next = true
                        } else if fieldError {
                            self.pwMatchError = false
                            self.pwLengthError = false
                        }
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 80, height: 40)
                                .foregroundColor(Color("medium-green-to-blue"))
                            Text("Next")
                                .font(.system(size: 15, weight: .bold))
                        }
                        
                    }).accentColor(.white)
                }.padding()
                
            }
            
        }.navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $next) {
            RegistrationDetailView(name: name, email: email, password: password)
        }
    }
}

