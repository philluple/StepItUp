//
//  RegistrationView2.swift
//  HealthComp
//
//  Created by Phillip Le on 11/11/23.
//

import SwiftUI
import PhotosUI

struct RegistrationDetailView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var ui_selectedImage: UIImage?
    @State var username: String = ""
    @State var name: String
    @State var email: String
    @State var password: String
    @State var error: String = "Hello"
    @State var opacity: CGFloat = 0
    @State var display: Bool = false
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var imageUtil: ImageUtilObservable
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("You are almost there!")
                    .font(.system(size: 25, weight: .bold))
                    .padding(.top, 40)
                    .padding(.bottom, 20)
    
                PhotosPicker(selection: $selectedItem, matching: .images){
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
                            .clipShape(Circle())
                        
                    } else{
                        ZStack{
                            Circle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color("light-green"))
                            Image(systemName: "camera.fill")
                                .foregroundColor(Color("medium-green"))
                        }
                    }
                    
                }.onChange(of: selectedItem) {
                    Task {
                        if selectedItem != nil{
                            if let data = try? await selectedItem!.loadTransferable(type: Data.self) {
                                ui_selectedImage = UIImage(data: data)
                                selectedImage = Image(uiImage: ui_selectedImage!)
                            }
                        }
                    }
                }
                CustomTextField(title: "Username", placeholder: "swaggy_roaree123", secure: false, autocap: false, text: $username)
                Text(error)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .opacity(opacity)
                    .onChange(of: username) {
                        Task {
                            userModel.isUsernameAvailable(username){ isAvailable, error in
                                if let error = error{
                                    self.error = error.localizedDescription
                                } else {
                                    if isAvailable {
                                        self.display = true
                                    } else {
                                        self.display = false
                                        self.error = "Sorry, that name is taken"
                                        self.opacity = 1.0
                                    }
                                }
                            }
                        }
                    }
                    
                if display == true {
                    Button{
                        Task{
                            if let result = try? await userModel.createUser(email: email, password: password, username: username, name: name, pfp_uri: ""){ switch result {
                            case .success(let id):
                                if let image = ui_selectedImage {
                                    await imageUtil.imageUtils.uploadPhoto(userId: id, selectedImage: image)
                                }
                            case .failure(let error):
                                print(error)
                            }
                            }
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color("medium-green-to-blue"))
                                .frame(width: 100, height: 40)
                            Text("Let's go!")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }.accentColor(.white)
                }
                    
                Spacer()
            }.navigationBarBackButtonHidden()
        }
    }
}
