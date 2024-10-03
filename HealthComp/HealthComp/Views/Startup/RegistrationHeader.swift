//
//  RegistrationHeader.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct RegistationHeader: View {
    var body: some View {
        VStack {
            HStack{
                Text("Create your account")
                    .font(.system(size: 25, weight: .bold))
                Spacer()
            }.padding(.horizontal)
            
        }.frame(width: UIScreen.main.bounds.width)
        
    }
}
