//
//  LocationManager.swift
//  Seedlinks
//
//  Created by Ivan Voloshchuk on 17/02/22.
//

import CoreLocation
import Foundation
import MapKit

let currLocation: String = "Searching for current location"
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var didTapOnPin = false
    
    
    //Default position = San Giovanni a Teduccio
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.836501, longitude: 14.306021),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.001))
    
    // Reverse geolocation
    @Published var streetName : String = ""
    @Published var cityName : String = NSLocalizedString(currLocation, comment: "")
    let geoCoder = CLGeocoder()
    
    //Reverse geolocation for every message
    @Published var streetNameMessage : String = ""
    @Published var cityNameMessage : String = ""
    
    func reverseGeoMessage(latitude : Double, longitude : Double ) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
            placemarks, error -> Void in
            
            // Place details
            guard let placeMark = placemarks?.first else { return }
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
            }
            // Street address
            if let street = placeMark.thoroughfare {
                self.streetNameMessage = street
                print(street)
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                self.cityNameMessage = city
                print(city)
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                print(zip)
            }
            // Country
            if let country = placeMark.country {
                print(country)
            }
        })
    }
    
    func reverseGeo(latitude : Double, longitude : Double ) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
            placemarks, error -> Void in
            
            // Place details
            guard let placeMark = placemarks?.first else { return }
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
            }
            // Street address
            if let street = placeMark.thoroughfare {
                self.streetName = street
                print(street)
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                self.cityName = city
                print(city)
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                print(zip)
            }
            // Country
            if let country = placeMark.country {
                print(country)
            }
        })
    }
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var statusString : String {
        
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authInUse"
        case .authorizedAlways: return "authAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func getRegion() {
        if let location = self.lastLocation {
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        }
        print(#function,region)
    }
    
    func setRegion(latitude : Double, longitude : Double){
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        print(#function)
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        self.getRegion()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
//        print(#function, location)
    }
    func getRadius(bLat : Double, bLong: Double) -> Double {
        let myCoord = CLLocation(latitude: self.lastLocation?.coordinate.latitude ?? 0.0,longitude: self.lastLocation?.coordinate.longitude ?? 0.0)
        print(myCoord)
        let genericCoord = CLLocation(latitude: bLat, longitude: bLong)
        print(genericCoord)
        let distanceInMeters = myCoord.distance(from: genericCoord)
//         print("DISTANZA IN METRI MAPPA" ,distanceInMeters)
        print(distanceInMeters)
        return distanceInMeters
        
    }
    
}

