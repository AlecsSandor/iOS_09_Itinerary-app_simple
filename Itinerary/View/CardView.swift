//
//  CardView.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI

// This view represents a single card trip
struct CardView: View {
    
    let trip: TripDetails
    
    // Used to save and display location on the minimap
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            
            // Static styling and display of data
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.14, green: 0.13, blue: 0.13).opacity(0.7))
                .cornerRadius(43)
 
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.category.name)
                            .font(.title2)
                            .bold()
                        if #available(iOS 16.0, *) {
                            Text(locationManager.city + "\n" + locationManager.country)
                                .lineLimit(2, reservesSpace: true)
                        } else {
                            Text(locationManager.city + "\n" + locationManager.country)
                        }
                    }
                        .frame(minWidth: 30)
                        .padding()
                        .foregroundColor(Color.white)
                        .padding(.leading)
                        .padding(.top)
                        
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        
                        Text(formatDay(date: trip.startDate))
                            .font(.title3)
                            .bold()
                        Text(formatMonth(date: trip.startDate))
                            
                    }
                        .frame(minWidth: 30)
                        .padding()
                        .foregroundColor(Color(red: 157 / 255, green: 157 / 255, blue: 157 / 255))
                        .padding(.trailing)
                        .padding(.top)
                }
                
                HStack {
                    Image("Location")
                        .resizable()
                        .frame(width: 20, height: 30)
                        
                    Text(locationManager.address)
                        .foregroundColor(Color(red: 157 / 255, green: 157 / 255, blue: 157 / 255))
                        .lineLimit(2)
                        .padding(.bottom)
                        .frame(maxWidth: 100)
                }
                    
                Image(trip.category.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250)
                    .clipped()
                    .padding(.top, -10)
            }
            
        }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .padding(.bottom, 10)
        
            .onAppear {
                // loading the location of the current trip card - the default location is the White House in DC
                locationManager.getAddressFromCoordinates(latitude: trip.latitude, longitude: trip.longitude)

            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var trip = TripDetails.sampleData[0]
    static var previews: some View {
        CardView(trip: trip)
    }
}
