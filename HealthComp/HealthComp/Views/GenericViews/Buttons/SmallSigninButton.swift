//
//  SmallSigninButton.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct SmallSigninButton: View {
    var body: some View {
            HStack{
                Text ("Already have an account?")
                    .foregroundColor(Color("button-accent"))
                Text ("Sign in")
                    .foregroundColor(Color.gray)
            }
        }
}
