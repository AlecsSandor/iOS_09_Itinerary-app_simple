//
//  WeatherModel.swift
//  Itinerary
//
//  Created by Alex on 8/4/23.
//

import Foundation

struct WeatherModel: Codable {
    let daily: Daily
}

struct Daily: Codable {
    let time: [String]
    let weathercode: [Int]
    let temperature2MMax: [Double]
    let rainSum: [Double]
}
