//
//  ContentView.swift
//  Itinerary
//
//  Created by Alex on 7/27/23.
//

import SwiftUI

// This view dipslays all of the card trips
struct TripsView: View {
    
    @Binding var trips: [TripDetails]
    @State private var isPresentingNewTripView = false
    
    // This is called when an item is deleted or before the app is exited
    let saveAction: () -> Void
    
    // Based where the current scene is, this will return a response, which in this paticular case is used to trigger the saving action
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // This is just static styling
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity)
                    .background(
                        Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 1897)
                            .frame(maxWidth: .infinity)
                            .clipped())
                    .padding(.bottom, 30)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.95))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 445)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.08, green: 0.54, blue: 0.6).opacity(0.4))
                    .cornerRadius(456)
                    .blur(radius: 96.5)
                    .offset(x: -200,y: -500)
                
                VStack(alignment: .leading) {
                    Group {
                        
                        Text("Your upcoming")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .bold()
                        
                        
                        Text("Trips")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                        
                        Text(String($trips.count))
                            .foregroundColor(Color(red: 254 / 255, green: 241 / 255, blue: 12 / 255))
                            .font(.system(size: 54, weight: .semibold))
                            .bold()
                        
                    }
                    .padding(.leading, 10)
                    
                    // Based on the existance of cards in $trips, choose what to display
                    if $trips.count == 0 {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.14, green: 0.13, blue: 0.13).opacity(0.7))
                                .cornerRadius(43)
                            
                            Text("You have not entered any Trip Cards yet.")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(20)
                        }
                    } else {
                        List {
                            
                            // Looping through all the cards in $trips and rendering each CardView
                            ForEach($trips) { $trip in
                                NavigationLink(destination: TripDetailView(trip: $trip)) {
                                    CardView(trip: trip)
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowBackground(Color.clear)
                            }
                            .onDelete { indexSet in
                                trips.remove(atOffsets: indexSet)
                                saveAction()
                            }
                        }
                        .listStyle(PlainListStyle())
                        .padding(.top, 10)
                        .onChange(of: scenePhase) { phase in
                            if phase == .inactive { saveAction() }
                        }
                    }
                }
                
                // Styling of the entire VStack
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                
                // More static styling
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 445)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 250 / 255, green: 201 / 255, blue: 28 / 255))
                    .cornerRadius(456)
                    .blur(radius: 96.5)
                    .offset(x: 300,y: 600)
                
            }
            .frame(maxWidth: .infinity)
            .toolbar {
                Button(action: {
                    isPresentingNewTripView = true
                }) {
                    ZStack {
                        Image(systemName: "plus")
                            .padding(11)
                            .foregroundColor(Color("CustomGreen"))
                            .background(Color(red: 34 / 255, green: 34 / 255, blue: 33 / 255, opacity: 1))
                            .cornerRadius(100)
                            .padding(.trailing, 10)
                    }
                }
                .fullScreenCover(isPresented: $isPresentingNewTripView) {
                    NewTripSheet(trips: $trips,
                                 isPresentingNewTripView: $isPresentingNewTripView)
                    .background(BackgroundClearView())
                }
            }
        }
        
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView(trips: .constant(TripDetails.sampleData), saveAction: {})
    }
}

// Custom struct for background transparency of a view (idk why swift makes it so complicated to obtain such a common result)
struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
