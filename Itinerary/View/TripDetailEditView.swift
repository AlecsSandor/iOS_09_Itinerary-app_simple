//
//  TripDetailEditView.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI

// View for editing a trip card's details
struct TripDetailEditView: View {
    
    @Binding var trip: TripDetails
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity)
                .background(
                    Image("BluredBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 1097)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .blur(radius: 30).opacity(0.99))
            
            VStack {
                if #available(iOS 16.0, *) {
                    List {
                        VStack(alignment: .leading) {
                            Text("Info")
                                .font(.headline)
                                .foregroundColor(Color.gray)
                            CategoryPicker(selection: $trip.category)
                            DatePicker("Start date", selection: $trip.startDate, displayedComponents: .date)
                                .tint(.black)
                            DatePicker("End date", selection: $trip.endDate, displayedComponents: .date)
                                .tint(.black)
                            Text("Notes")
                                .font(.headline)
                                .foregroundColor(Color.gray)
        
                            TextField("Write your notes...", text: $trip.notes, axis: .vertical)
                                .lineLimit(4, reservesSpace: true)
                        }
                        .padding(30)
                        .background(Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255).opacity(0.4))
                        .cornerRadius(40)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .listRowBackground(Color.clear)
                        
                        VStack {
                            MapView(trip: $trip)
                                .frame(height: 350)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(40)
                                .ignoresSafeArea(.all)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                    }
                    .scrollContentBackground(.hidden)
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .listStyle(PlainListStyle())
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
            .background(Color.clear)
        }
    }
}

struct TripDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailEditView(trip:
                .constant(TripDetails.sampleData[0]))
    }
}

