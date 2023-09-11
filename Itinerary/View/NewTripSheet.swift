//
//  NewTripSheet.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI
import MapKit

// View for creating a new trip card
struct NewTripSheet: View {
    
    @State private var newTrip = TripDetails.emptyTripDetails
    @Binding var trips: [TripDetails]
    @Binding var isPresentingNewTripView: Bool
    
    var body: some View {
        NavigationStack {
            TripDetailEditView(trip: $newTrip)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            isPresentingNewTripView = false
                        }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color.gray)
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            trips.append(newTrip)
                            isPresentingNewTripView = false
                        }
                        .foregroundColor(Color(red: 254 / 255, green: 241 / 255, blue: 12 / 255))
                    }
                }
        }
    }
    
}

struct NewTripSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTripSheet(trips: .constant(TripDetails.sampleData),
                     isPresentingNewTripView: .constant(true))
    }
}
