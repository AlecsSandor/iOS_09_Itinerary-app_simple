//
//  TripCategories.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI

enum TripCategories: String, CaseIterable, Identifiable, Decodable {
    case Hikking
    case Camping
    case Swimming
    case Citybreak
    
    var name: String {
        switch rawValue{
        case "Hikking":
            return rawValue.capitalized+" ⛰️"
        case "Camping":
            return rawValue.capitalized+" 🏕️"
        case "Swimming":
            return rawValue.capitalized+" 🏖️"
        case "Citybreak":
            return rawValue.capitalized+" 🏘️"
        default:
            return rawValue.capitalized+" 🏘️"
        }
//        rawValue.capitalized
    }
    
    var id: String {
        name
    }
    
    var raw: String {
        rawValue.capitalized
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)

            switch rawValue {
            case "Hikking":
                self = .Hikking
            case "Camping":
                self = .Camping
            case "Swimming":
                self = .Swimming
            case "Citybreak":
                self = .Citybreak
            default:
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unknown raw value: \(rawValue)"
                )
            }
        }
}
