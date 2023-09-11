//
//  TripDetailView.swift
//  Itinerary
//
//  Created by Alex on 8/2/23.
//

import SwiftUI

struct TripDetailView: View {
    
    let weatherManager = WeatherManager()
    @Binding var trip: TripDetails
    @State private var weather: WeatherModel?
    @StateObject var locationManager = LocationManager()
    
    @State private var editingTrip = TripDetails.emptyTripDetails
    @State private var isPresentingEditView = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.gray)
            //                    Text("Go back")
        }
    }
    }
    
    var body: some View {
        NavigationStack {
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
                            .blur(radius: 0).opacity(0.94))
                
                VStack(alignment: .leading) {
                    Text(trip.category.name)
                        .font(.title)
                        .frame(alignment: .leading)
                        .foregroundColor(Color(red: 254 / 255, green: 241 / 255, blue: 12 / 255))
                        .padding(20)
                    ScrollView {
                        HStack(spacing: 10) {
                            VStack {
                                VStack(alignment: .leading) {
                                    Text("from")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    Text(formatDayMonth(date: trip.startDate))
                                        .foregroundColor(Color(red: 254 / 255, green: 241 / 255, blue: 12 / 255))
                                    
                                    Text("to")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    Text(formatDayMonth(date: trip.endDate))
                                        .foregroundColor(.white)
                                    
                                    Text("duration")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.top, 20)
                                    Text("\(computeTime(trip.startDate, trip.endDate)) days")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                }
                                .padding(30)
                                .frame(height: 200)
                            }
                            .listRowInsets(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                            .background(Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255).opacity(0.7))
                            .cornerRadius(40)
                            
                            VStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(weatherManager.decodeWeatherCodes(code: weather?.daily.weathercode[0] ?? 0))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 90)
                                            .clipped()
                                        
                                        VStack {
                                            Text("\(String(format: "%.1f", weather?.daily.temperature2MMax[0] ?? 342))°C")
                                                .foregroundColor(.white)
                                                .font(.subheadline)
                                                .bold()
                                            
                                            Text(weatherManager.decodeWeatherCodes(code: weather?.daily.weathercode[0] ?? 0))
                                                .foregroundColor(.white)
                                                .font(.caption)
                                        }
                                        .padding(.leading, 10)
                                    }
                                    
                                    Text(locationManager.city + locationManager.address)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 10)
                                        .bold()
                                        .font(.subheadline)
                                }
                                .padding(30)
                                .frame(height: 200)
                            }
                            .listRowInsets(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                            .background(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255).opacity(0.3))
                            .cornerRadius(40)
                            
                        }
                        .listRowBackground(Color.clear)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                        
                        MapView(trip: $trip)
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(40)
                            .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                            .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
                        
                        ZStack {
                            Group() {
                                if trip.notes == "" {
                                    Text("No Notes")
                                        .frame(height: 100, alignment: .leading)
                                        .lineLimit(4, reservesSpace: true)
                                        .padding(30)
                                } else {
                                    Text(trip.notes)
                                        .frame(height: 100)
                                        .lineLimit(4, reservesSpace: true)
                                        .padding(30)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .background(Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255).opacity(0.7))
                            .cornerRadius(40)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .foregroundColor(Color.gray)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    }
                }
                .background(Color.clear)
                
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Edit") {
                        isPresentingEditView = true
                        editingTrip = trip
                    }
                    .foregroundColor(Color(red: 254 / 255, green: 241 / 255, blue: 12 / 255))
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationStack {
                    TripDetailEditView(trip: $editingTrip)
//                        .navigationTitle("My Title")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    trip = editingTrip
                                }
                            }
                        }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
        }
        
        .onAppear {
            locationManager.getAddressFromCoordinates(latitude: trip.latitude, longitude: trip.longitude)
        }
        .task {
            do {
                weather = try await weatherManager.getWeather(latitude: String(trip.latitude), longitude: String(trip.longitude))
            } catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid response")
            } catch GHError.invalidData {
                print("invalid data")
            } catch {
                print("Unexpected error")
            }
        }
        
    }
    
    func computeTime(_ firstDate: Date, _ secondDate: Date) -> Int {
        let timeInterval = secondDate.timeIntervalSince(firstDate)
        let numberOfDays = Int(timeInterval / (60 * 60 * 24))
        return numberOfDays
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(trip:
                .constant(TripDetails.sampleData[0]))
    }
}
