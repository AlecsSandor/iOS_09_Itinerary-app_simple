//
//  TripDetails.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI
import CoreLocation

struct TripDetails: Identifiable, Codable {
    
    var id: UUID
    var category: TripCategories
    var startDate: Date
    var endDate: Date
    var latitude: Double
    var longitude: Double
    var notes: String

    init(id: UUID = UUID(), category: TripCategories, startDate: Date, endDate: Date, latitude: Double, longitude: Double, notes: String) {
        self.id = id
        self.category = category
        self.startDate = startDate
        self.endDate = endDate
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
    }
    
    static var emptyTripDetails: TripDetails {
        TripDetails(category: TripCategories.Camping, startDate: Date(), endDate: Date(), latitude: 38.8977, longitude: -77.0365, notes: "")
    }
    
    enum CodingKeys: String, CodingKey {
            case id
            case category
            case startDate
            case endDate
            case latitude
            case longitude
            case notes
        }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(category.rawValue, forKey: .category)

            // Encode startDate and endDate as ISO 8601 formatted strings
            let dateFormatter = ISO8601DateFormatter()
            try container.encode(dateFormatter.string(from: startDate), forKey: .startDate)
            try container.encode(dateFormatter.string(from: endDate), forKey: .endDate)

            try container.encode(latitude, forKey: .latitude)
            try container.encode(longitude, forKey: .longitude)
            try container.encode(notes, forKey: .notes)
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            category = try container.decode(TripCategories.self, forKey: .category)

            // Decode startDate and endDate from ISO 8601 formatted strings
            let dateFormatter = ISO8601DateFormatter()
            startDate = try dateFormatter.date(from: container.decode(String.self, forKey: .startDate)) ?? Date()
            endDate = try dateFormatter.date(from: container.decode(String.self, forKey: .endDate)) ?? Date()

            latitude = try container.decode(Double.self, forKey: .latitude)
            longitude = try container.decode(Double.self, forKey: .longitude)
            notes = try container.decode(String.self, forKey: .notes)
        }

}

extension TripDetails {
    static let sampleData: [TripDetails] =
    [
        TripDetails(
            category: TripCategories.Swimming,
            startDate: Date(),
            endDate: Date(),
            latitude: 38.8977,
            longitude: -77.0365,
            notes: ""
        ),
    ]
}
