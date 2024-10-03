//
//  Buttons.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import SwiftUI



struct SmallSignupButton: View {
    var body: some View {
        HStack{
            Text ("Don't have an account?")
                .foregroundColor(Color("button-accent"))
            Text ("Sign up")
                .foregroundColor(Color.gray)

        }
    }
}

