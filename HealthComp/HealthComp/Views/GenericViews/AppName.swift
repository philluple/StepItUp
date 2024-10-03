//
//  AppName.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct AppName: View {
    var body: some View {
        HStack{
            Text("Step It Up")
                .font(.system(size: 25, weight: .bold))
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    AppName()
}
