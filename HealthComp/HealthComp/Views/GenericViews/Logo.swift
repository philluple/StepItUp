//
//  Logo.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct Logo: View {
    let size: CGFloat?
    
    init(size: CGFloat? = nil) {
        self.size = size
    }
    
    var body: some View {
        Image(systemName: "heart.circle.fill")
            .resizable()
            .foregroundColor(Color("medium-green"))
            .frame(width: size ?? 100, height: size ?? 100)
    }
}



