//
//  WeatherData.swift
//  WeatherChallenge
//
//  Created by Nicholas Gilbert on 10/2/23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
    let icon: String
}

struct Sys: Codable {
    let country: String
}
