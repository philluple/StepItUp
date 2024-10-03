//
//  Health.swift
//  HealthComp
//
//  Created by Phillip Le on 11/14/23.
//

import Foundation

struct HealthData: Codable {
    var dailyStep: Int?
    var dailyMileage: Double?
    var weeklyStep: Int?
    var weeklyMileage: Double?
}
