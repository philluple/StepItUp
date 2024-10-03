//
//  TextField.swift
//  HealthComp
//
//  Created by Phillip Le on 11/11/23.
//

import SwiftUI

struct CustomTextField: View{
    let title: String
    let placeholder: String
    let secure: Bool
    let autocap: Bool
    
    @Binding var text: String
    var body: some View{
        VStack (spacing: 5){
            HStack{
                Text(title)
                    .font(.system(size: 15, weight: .thin))
                Spacer()
            }.padding(.horizontal, 30)
            if secure == true{
                SecureField(placeholder, text: $text)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width-40, height: 40)
                    .overlay( RoundedRectangle(cornerRadius: 15) .stroke(Color("medium-green")) )
            }else{
                TextField(placeholder, text: $text)
                    .autocapitalization(autocap ? .words : .none)
                    .autocorrectionDisabled()
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width-40, height: 40)
                    .overlay( RoundedRectangle(cornerRadius: 15) .stroke(Color("medium-green")) )
            }
            
        }.padding(.top)
    }
}


