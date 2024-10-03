//
//  SetGoalView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/30/23.
//

import SwiftUI

struct SetGoalView: View {
    @State var clicked: Bool = false
    @State private var newGoal: String = ""
    @EnvironmentObject var goalModel: GoalVM
    @EnvironmentObject var userModel: UserVM
    @Binding var isPresented: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 2*(UIScreen.main.bounds.width/3)-30, height: 225)
            .foregroundColor(Color("progress-box"))
            .overlay{
                if clicked == false{
                    Button(action: {
                        clicked.toggle()
                    }, label: {
                        VStack{
                            Text("SET STEP GOAL")
                                .font(.system(size: 16, weight: .semibold))
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }).accentColor(Color("gray-text"))
                } else {
                    VStack{
                        Text("Think big!")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("gray-text"))
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:2*(UIScreen.main.bounds.width/3)-50, height: 50)
                                .foregroundColor(Color("gray-text")) // Set your desired outline color here
                                .opacity(0.5)
                            TextField("10,000", text: $newGoal)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width:  2*(UIScreen.main.bounds.width/3)-60, height: 30)
                                .keyboardType(.numberPad)
                        }.padding(.bottom)
                        HStack{
                            Spacer()
                            Button(action: {
                                Task{
                                    if let user = userModel.currentUser{
                                        await goalModel.writeGoal(userId: user.id, goal: Goal(goal: Int(newGoal)!))
                                    }
                                    isPresented = false
                                }
                            }, label: {
                                Image(systemName: "arrow.right.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }).accentColor(.white)
                            
                        }
                        .padding(.trailing, 10)
                    }
                    
                }
            }
    }
}

//#Preview {
//    SetGoalView()
//}

