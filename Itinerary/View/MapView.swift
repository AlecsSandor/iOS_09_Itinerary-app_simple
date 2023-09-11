import SwiftUI
import MapKit

struct DraggableMap: View {
    @Binding var trip: TripDetails
    @Binding var region: MKCoordinateRegion
    @State private var isDragging = false
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .gesture(DragGesture()
                .onChanged { gesture in
                    if !isDragging {
                        isDragging = true
                    }
                    dragOffset = gesture.translation
                }
                .onEnded { gesture in
                    isDragging = false
                    let location = region.center
                    _ = region.span
                    let newLatitude = location.latitude - Double(dragOffset.height) / 100000
                    let newLongitude = location.longitude - Double(dragOffset.width) / 100000
                    region.center = CLLocationCoordinate2D(latitude: newLatitude, longitude: newLongitude)
                    dragOffset = .zero
                    
                    trip.latitude = location.latitude - Double(dragOffset.height) / 100000
                    trip.longitude = location.longitude - Double(dragOffset.width) / 100000
                    print("stoped")
                }
            )
            .onDisappear {
                
            }
    }
}

struct MapView: View {
    @Binding var trip: TripDetails
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State private var pinnedLocation: PinAnnotation?
    
    var body: some View {
        VStack {
            DraggableMap(trip: $trip, region: $region)
                .overlay(
                    // Show the pin all the time using ZStack
                    ZStack {
                        Image("Location")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
//                            .font(.title)
//                            .foregroundColor(.red)
                            .shadow(color: Color.black.opacity(0.9), radius: 4)
                    }
                        .offset(x: 0, y: -15) // Adjust the pin position
                        .animation(.none) // Disable animation for pin movement
                )
                .onAppear {
                    // Set the initial region using trip.latitude and trip.longitude
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip.latitude, longitude: trip.longitude), span: region.span)
                }
                .onChange(of: pinnedLocation, perform: { newValue in
                    guard let pinnedLocation = pinnedLocation else { return }
                    // Add pinnedLocation to the annotationItems
                    region = MKCoordinateRegion(center: pinnedLocation.coordinate, span: region.span)
                })
        }
    }
}

struct PinAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

extension PinAnnotation: Equatable {
    static func == (lhs: PinAnnotation, rhs: PinAnnotation) -> Bool {
        lhs.id == rhs.id
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(trip:
                .constant(TripDetails.sampleData[0]))
    }
}
