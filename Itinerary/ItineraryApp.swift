//
//  ItineraryApp.swift
//  Itinerary
//
//  Created by Alex on 7/27/23.
//

import SwiftUI

@main
struct ItineraryApp: App {
    
    @StateObject private var store = TripsStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            TripsView(trips: $store.trips) {
                
                // Try to retrieve the stored date on the iPhone
                Task {
                    do {
                        try await store.save(trips: store.trips)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Itinerary will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.trips = TripDetails.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
                
        }
    }
}
