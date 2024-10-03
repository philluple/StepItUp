//
//  LoginButton.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct LoginButton: View{
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                .foregroundColor(Color("startup-button-color"))
            Text("Log In")
                .font(.system(size: 16, weight: .semibold))
        }
    }
}

