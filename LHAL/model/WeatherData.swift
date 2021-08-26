//
//  WeatherData.swift
//  LHAL
//
//  Created by Home on 8/26/21.
//

import Foundation

struct Weatherdata: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}
struct Weather: Codable{
    let description: String
    let id: Int
}
