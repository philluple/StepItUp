//
//  CreatePostView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI
import PhotosUI
            
struct CreatePostView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var feedModel: FeedVM
    
    @Environment(\.presentationMode) var presentationMode
    @State private var caption: String = "What's on your mind?"
    @State private var placeholder = "What's on your mind?"
    @FocusState private var isFocused: Bool // New state to control focus
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var ui_selectedImage: UIImage?
    
    let characterLimit = 250 // Define your character limit here

    var body: some View {
        VStack{
            if let user = userModel.currentUser{
                ZStack{
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("button-accent"))
                        })
                        Spacer()
                    }
                    
                    Text("Create post")
                        .font(.system(size: 18, weight: .semibold))
                    HStack{
                        Spacer()
                        Button(action: {
                            feedModel.makePost(id: user.id, caption: caption, image: ui_selectedImage)
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Share")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("const-navy"))
                                .padding()
                                .frame(height: 30)
                                .background(Color("medium-green"))
                                .cornerRadius(25.0)
                            
                        }).accentColor(.white)
                        
                    }
                }.padding(.horizontal, 10)
                    .padding(.top, 20)
                Divider()
                    .padding(.bottom, 10)
                HStack{
                    ProfileIcon(userId: user.id, size: 60)
                    VStack(alignment: .leading){
                        Text(user.name)
                            .font(.system(size: 16, weight: .semibold))
                        Text(feedModel.formatDate(date: Date()))
                            .font(.system(size: 14))
                            .foregroundColor(Color("dark-blue"))
                        
                    }
                    Spacer()
                    
                }.padding(.bottom, 5)
                if (selectedImage != nil){
                    ZStack(alignment: .topTrailing){
                        selectedImage!
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width-50)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        Button(action: {
                            selectedImage = nil
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        })
                    }
                    
                }
                VStack(alignment: .leading){
                    TextEditor(text: self.$caption)
                        .foregroundColor(self.caption == placeholder ? .gray : .primary)
                        .onTapGesture {
                            if self.caption == placeholder {
                                self.caption = ""
                            }
                        }
                        .font(.system(size: 16))
                        .frame(width: UIScreen.main.bounds.width - 50, height: 150) // Set the desired height
                    
                    HStack{
                        PhotosPicker(selection: $selectedItem, matching: .images){
                            Image(systemName: "paperclip.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundColor(Color("dark-blue"))
                            
                        }.onChange(of: selectedItem) {
                            Task {
                                if selectedItem != nil {
                                    if let data = try? await selectedItem!.loadTransferable(type: Data.self) {
                                        ui_selectedImage = UIImage(data: data)
                                        selectedImage = Image(uiImage: ui_selectedImage!)
                                    }
                                }
                            }
                        }
                        Spacer()
                        Text("\(caption.count) / \(characterLimit)")
                            .font(.caption)
                            .foregroundColor(caption.count > characterLimit ? .red : .secondary)
                        
                    }.padding(.top)
                    
                    
                }
                .onAppear{
                    isFocused = true
                }
                //            }
                Spacer()
                
            }
        }.padding(.horizontal, 10)
    }

}

