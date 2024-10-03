//
//  TodayStats.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct TodayStats: View {
    @EnvironmentObject var healthModel: HealthVM
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("Today")
                    .font(.custom("DIN Alternate",fixedSize: 16))
                Spacer()
            }.padding(.bottom, 3)
            Text("Steps")
                .font(.custom("DIN Alternate",fixedSize: 18))
            if healthModel.healthData.dailyStep != nil{
                HStack{
                    Text("\(healthModel.healthData.dailyStep!)")
                        .font(.custom("DIN Alternate",fixedSize: 35))
                }
                
            } else {
                HStack{
                    Text("0")
                        .font(.custom("DIN Alternate",fixedSize: 35))
                }
            }
            Text("Distance")
                .font(.custom("DIN Alternate",fixedSize: 18))
            if healthModel.healthData.dailyMileage != nil{
                HStack{
                    Text(String(format: "%.1f", healthModel.healthData.dailyMileage!))
                        .font(.custom("DIN Alternate", fixedSize: 35))
                    Text("miles")
                        .font(.custom("DIN Alternate",fixedSize: 14))
                }
                
            } else {
                //TODO: remove
                HStack{
                    Text("0.0")
                        .font(.custom("DIN Alternate",fixedSize: 35))
                    Text("miles")
                        .font(.custom("DIN Alternate",fixedSize: 14))
                }
            }
            
        }.padding(.horizontal)
    }
}

