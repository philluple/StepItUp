//
//  ProfileHealthStats.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI
import SwiftUICharts

struct ProfileHealthStats: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: UIScreen.main.bounds.width/3, height: 225)
            .foregroundColor(Color("gray-text"))
            .overlay{
                TabView{
                    TodayStats()
                    WeeklyStat()
                }.tabViewStyle(.page)
            }
    }
}

#Preview {
    ProfileHealthStats()
}

