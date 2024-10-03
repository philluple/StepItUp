//
//  FeedViewHeader.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct FeedViewHeader: View {
    var body: some View {
        HStack{
            Text("Hey, Roaree! See what everyone is up to")
                .font(.system(size: 16, weight: .semibold))
                .padding()
            
            AsyncImage(
                url: URL(string:"https://gocolumbialions.com/images/2019/10/11/20170916ColumbiaFootball_0700.JPG"),
                content: { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .overlay(Circle().stroke(Color("light-blue"), lineWidth: 4))
                        .clipShape(Circle())
                    
                },
                placeholder: {
                    ProgressView()
                }
            ).padding()
        }.background{
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("medium-green"))
                .frame(width:UIScreen.main.bounds.width-20)
        }
    }
}
