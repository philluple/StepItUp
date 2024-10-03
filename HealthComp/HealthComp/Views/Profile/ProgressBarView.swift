//
//  ProgressBarView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI
import SwiftUICharts

struct ProgressBarView: View {
    @EnvironmentObject var goalModel: GoalVM
    @EnvironmentObject var healthModel: HealthVM
    @Environment(\.colorScheme) var colorScheme
    
    @State var dailyProgress: Double = 0.0
    @State var weeklyProgress: Double = 0.0
    @State var dailySteps: Int = 0
    @State var weeklySteps: Int = 0
    
    let startColorOut = Color("light-green")
    let endColorOut = Color("medium-green")
    @State var startColorIn: Color = Color("light-blue")
    @State var endColorIn: Color = Color("medium-blue")

    @Binding var editViewPresented: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 2*(UIScreen.main.bounds.width/3)-30, height: 225)
            .foregroundColor(Color("progress-box"))
            .overlay{
                HStack{
                    VStack (alignment: .leading){
                        VStack(alignment: .leading){
                            if let goal = goalModel.userGoal{
                                Text("\(goal.goal) steps")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Your current goal")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color("gray-text"))
                            
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    self.editViewPresented = true
                                }
                        
                            
                            
                        }.padding(.top,20)
                        
                        let gradientOut = ColorGradient(startColorOut, endColorOut)
                        let gradientIn = ColorGradient(startColorIn, endColorIn)
                        
                        
                        ZStack{
                            RingsChart()
                                .data([weeklyProgress * 100])
                                .chartStyle(ChartStyle(backgroundColor: .clear, foregroundColor: gradientIn))
                                .frame(width: UIScreen.main.bounds.width/2-120)
                                .allowsHitTesting(false)
                            RingsChart()
                                .data([dailyProgress * 100])
                                .chartStyle(ChartStyle(backgroundColor: .clear, foregroundColor: gradientOut))
                                .frame(width: UIScreen.main.bounds.width/2-90)
                                .allowsHitTesting(false)
                        }.padding(.bottom)
                            .onAppear{
                                if colorScheme == .dark{
                                    self.endColorIn = Color("light-blue")
                                    self.startColorIn = Color("gray-text")
                                }
                            }
                        
                        
                    }
                    VStack(alignment: .leading){
                        HStack(alignment: .top){
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color("light-green"))
                            VStack(alignment: .leading){
                                Text("Today")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("gray-text"))
//                                Text("15%")
                                let dailyPercentage = Int(dailyProgress*100)
                                Text("\(dailyPercentage)%")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.white)
                                
                                
                            }
                            
                        }
                        HStack(alignment: .top){
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color("light-blue"))
                            VStack(alignment: .leading){
                                Text("Week average")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("gray-text"))
                                let weeklyPercentage = Int(weeklyProgress * 100)
                                Text("\(weeklyPercentage)%")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }
                }.onReceive(healthModel.$healthData) { newData in
                    if let goal = goalModel.userGoal{
                        if let dailyStep = newData.dailyStep {
                            dailySteps = dailyStep
                            dailyProgress = Double(dailySteps) / Double(goal.goal)
                            print(dailyProgress)
                            print(dailySteps)
                        } else {
                            dailyProgress = 0.0
                        }
                        if let weeklyStep = newData.weeklyStep{
                            weeklySteps = weeklyStep/7
                            weeklyProgress = Double(weeklySteps) / Double(goal.goal)
                            print(weeklyProgress)

                        } else {
                            weeklyProgress = 0.0
                        }
                    }
                   
                }

            }

    }


//#Preview {
//    ProgressBarView()
//}

