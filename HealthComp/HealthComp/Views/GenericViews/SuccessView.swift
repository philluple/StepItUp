//
//  SuccesGroupView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct SuccessView: View {
    var message: String
    @Environment(\.presentationMode) var presentationMode
    
    
    let characterLimit = 250 // Define your character limit here
    
    var body: some View {
        VStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                VStack{
                    Spacer()
                    VStack{
                        Text(message)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("button-accent"))
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Spacer()
                }
            }).accentColor(Color("medium-green"))
            Spacer()
        }
    }
}
