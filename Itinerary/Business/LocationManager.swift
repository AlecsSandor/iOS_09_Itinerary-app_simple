
import Foundation
import CoreLocation

class LocationManager: ObservableObject {
    
    @Published var address: String = ""
    @Published var city: String = ""
    @Published var country: String = ""
    
    func getAddressFromCoordinates(latitude: Double, longitude: Double) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }

            var address: String = ""

            if let placemark = placemarks?.first {
                // Construct the address using individual address components
                var addressComponents = [String]()
                
                if let locality = placemark.locality {
                    self.city = locality + ","
                }
                if let country = placemark.country {
                    self.country = country
                }
                if let name = placemark.name {
                    addressComponents.append(name)
                    if self.city == "" {
                        self.city = name
                    }
                }
                if let street = placemark.thoroughfare {
                    addressComponents.append(street)
                }
                if let administrativeArea = placemark.administrativeArea {
                    addressComponents.append(administrativeArea)
                }

                address = addressComponents.joined(separator: ", ")
                self.address = address
            }
        }
    }
}
