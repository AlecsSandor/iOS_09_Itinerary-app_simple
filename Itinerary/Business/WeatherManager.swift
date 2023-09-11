//
//  WeatherManager.swift
//  Itinerary
//
//  Created by Alex on 8/4/23.
//

import Foundation

struct WeatherManager {
    
    func getWeather(latitude: String, longitude: String) async throws -> WeatherModel {
        
        let endpoint = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=weathercode,temperature_2m_max,rain_sum&timezone=GMT&forecast_days=1"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(WeatherModel.self, from: data)
            
        } catch {
            
            throw GHError.invalidData
            
        }
        
    }
    
    func decodeWeatherCodes(code: Int) -> String {
        
        switch code {
            
        case 0:
            return "sunny"
        case 1, 2, 3:
            return "partially clouded"
        case 61, 63, 65, 66, 67, 80, 81, 82, 95, 96, 99:
            return "rainy"
        case 45, 48, 51, 53, 55, 56, 57:
            return "cloudy"
        default:
            return "rainy"
            
        }
        
    }
    
}


enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
