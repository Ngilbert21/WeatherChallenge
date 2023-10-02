//
//  WeatherModel.swift
//  WeatherChallenge
//
//  Created by Nicholas Gilbert on 10/2/23.
//

import Foundation

struct WeatherModel: Codable {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let icon: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}
