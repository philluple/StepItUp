//
//  HealthVM.swift
//  HealthComp
//
//  Created by Claudia Cortell on 11/11/23.
//

import Foundation
import HealthKit
import FirebaseStorage
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class HealthVM: ObservableObject {
    var healthStore = HKHealthStore()
    @Published var validData: Bool = false
    
    @Published var healthData: HealthData = HealthData(){
        didSet {
            if isValid(healthData){
                validData = true
                writeHealthData()
            }
        }
    }
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let healthTypes: Set = [steps, distance]
        Task{
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("Error getting permissions from user")
            }
        }
    }
    
     func isValid(_ data: HealthData) -> Bool {
         return data.dailyStep != nil && data.dailyMileage != nil && data.weeklyStep != nil
    }
    
    func fetchAllHealthData() {
        readTodaysSteps()
        readWeeklySteps()
        readTodaysMileage()
        readWeeklyMileage()
    }
    
    
    func readTodaysSteps(){
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) {
            _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
                return
            }
            
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            DispatchQueue.main.async{
                self.healthData.dailyStep = steps
            }
        }
        healthStore.execute(query)
    }
    
    
    func readWeeklySteps(){
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        //Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("ERROR readWeeklySteps(): could not get date")
            return
        }
        //Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("ERROR readWeeklySteps(): could not get date")
            return
        }

        let predicate = HKQuery.predicateForSamples(
          withStart: startOfWeek,
          end: endOfWeek,
          options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
          quantityType: stepCountType,
          quantitySamplePredicate: predicate,
          options: .cumulativeSum
        ) { _, result, error in
          guard let result = result, let sum = result.sumQuantity() else {
            if let error = error {
                print("ERROR readWeeklySteps(): could not read weekly data, \(error.localizedDescription)")
            }
              return
          }
    
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            DispatchQueue.main.async{
                self.healthData.weeklyStep = steps
            }
        }
        healthStore.execute(query)
    }
    
    
    func readTodaysMileage(){
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return
        }
        
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: distanceType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to read walking/running distance: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
                DispatchQueue.main.async{
                    self.healthData.dailyMileage = 0
                }
                return
            }

            let distanceInMeters = sum.doubleValue(for: HKUnit.meter())
            let distanceInMiles = distanceInMeters * 0.000621371 // Convert meters to miles
            
            DispatchQueue.main.async{
                self.healthData.dailyMileage = distanceInMiles
            }
        }
        healthStore.execute(query)
    }
    
    
    func readWeeklyMileage(){
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        // Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return
        }
        // Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return
        }

        let predicate = HKQuery.predicateForSamples(
          withStart: startOfWeek,
          end: endOfWeek,
          options: .strictStartDate
        )

        let query = HKStatisticsQuery(
          quantityType: distanceType,
          quantitySamplePredicate: predicate,
          options: .cumulativeSum
        ) { _, result, error in
          guard let result = result, let sum = result.sumQuantity() else {
            if let error = error {
              print("An error occurred while retrieving mileage: \(error.localizedDescription)")
                DispatchQueue.main.async{
                    self.healthData.weeklyMileage = 0.0
                }

            }
              return
          }
    
            let weeklyDistanceInMeters = sum.doubleValue(for: HKUnit.meter())
            let weeklyDistanceInMiles = weeklyDistanceInMeters * 0.000621371 // Convert meters to miles
            DispatchQueue.main.async{
                self.healthData.weeklyMileage = weeklyDistanceInMiles
            }
        }
        healthStore.execute(query)
    }
    

    func writeHealthData() {
        do {
            guard let user_id = UserDefaults.standard.string(forKey: "userId") else {
                print("User ID not found in UserDefaults")
                return
            }
            let encoded_healthdata = try Firestore.Encoder().encode(healthData)
                Firestore.firestore().collection("healthdata").document(user_id).setData(encoded_healthdata) { error in
                if let error = error {
                    print("Error writing health data to Firestore: \(error.localizedDescription)")
                } else {
                }
            }
        } catch {
            print(error.localizedDescription)
            return
        }
        
    }
    
    func signOut() {
        self.healthData = HealthData()
    }
        

}


