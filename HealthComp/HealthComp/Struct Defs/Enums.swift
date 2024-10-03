//
//  Enums.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//


import Foundation
import SwiftUI

enum HealthKitRetrievalInt{
    case success(Int)
    case failure
}

enum HealthKitRetrievalDouble{
    case success(Double)
    case failure
}

enum HealthKitRetrievalHealthData{
    case success(HealthData)
    case failure
}

enum Upload{
    case success(String)
    case failure
}

enum CreatedGroup{
    case success(String)
    case failure(String)
}

enum FetchImage{
    case success(UIImage)
    case notFound
}

enum FetchUser{
    case success(User)
    case failure(String)
}

enum FetchHealthData{
    case success(HealthData)
    case failure(String)
}

enum Search{
    case success([User])
    case failure(String)
    case no_results
}

enum CreateUser{
    case success(String)
    case failure(String)
}

enum Base{
    case success
    case failure(String)
}

enum Status{
    case accepted
    case rejected
}
