//
//  LocationManager.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/23.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    typealias LocationCompletion = ([String: String]?) -> Void
    
    private let locationManager = CLLocationManager()
    private var completion: LocationCompletion?
    private var currentLocation: CLLocation?
    private var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func fetchLocationInfo(completion: @escaping LocationCompletion) {
        
        self.completion = completion
        
        let status = CLLocationManager().authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdate()
            
        default:
            completion(nil)
        }
    }
    
    private func startLocationUpdate() {
        locationManager.startUpdatingLocation()
    }
    
    private func stopLocationUpdate() {
        locationManager.stopUpdatingLocation()
    }
    
    private func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            guard let placemark = placemarks?.first else {
                self.completion?(nil)
                return
            }
            
            let locationInfo = self.parsePlacemark(placemark, location: location)
            self.completion?(locationInfo)
            
            self.stopLocationUpdate()
        }
    }
    
    private func parsePlacemark(_ placemark: CLPlacemark, location: CLLocation) -> [String: String] {
        var locationDict: [String: String] = [:]
        
        locationDict["plausible"] = placemark.administrativeArea ?? ""
        locationDict["circumstances"] = placemark.isoCountryCode ?? ""
        locationDict["accustomed"] = placemark.country ?? ""
        locationDict["ants"] = placemark.thoroughfare ?? ""
        locationDict["donkey"] = "\(location.coordinate.latitude)"
        locationDict["skittish"] = "\(location.coordinate.longitude)"
        locationDict["pants"] = placemark.locality ?? ""
        locationDict["shitting"] = placemark.subLocality ?? ""
        locationDict["rat"] = placemark.subLocality ?? ""
        
        return locationDict
    }
    
    deinit {
        stopLocationUpdate()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentLocation = location
        reverseGeocode(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil)
        stopLocationUpdate()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdate()
            
        default:
            completion?(nil)
        }
    }
}
