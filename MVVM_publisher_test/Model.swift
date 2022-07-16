//
//  Model.swift
//  MVVM_publisher_test
//
//  Created by Dmitry Sankovsky on 9.07.22.
//

import Foundation

struct WeatherDetails: Codable, Identifiable {
    let main: Main?
    let id: Int?
    
    static var placeholder: Self {
        return WeatherDetails(main: nil, id: nil)
    }
}

struct Main: Codable {
    let temp: Double?
}
