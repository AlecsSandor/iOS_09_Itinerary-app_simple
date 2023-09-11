import SwiftUI

@MainActor
class TripsStore: ObservableObject {
    @Published var trips: [TripDetails] = []


    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("trips.data")
    }


    func load() async throws {
        let task = Task<[TripDetails], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let tripDetails = try JSONDecoder().decode([TripDetails].self, from: data)
            return tripDetails
        }
        let trips = try await task.value
        self.trips = trips
    }
    
    func save(trips: [TripDetails]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(trips)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
