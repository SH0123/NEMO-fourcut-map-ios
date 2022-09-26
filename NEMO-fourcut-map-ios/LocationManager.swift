//
//  LocationManager.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/26.
//

import CoreLocation

final class LocationManager: NSObject {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private var currentLocation: CLLocation?
    var locationAuthorizationStatus: CLAuthorizationStatus {
        get {
            if #available(iOS 14.0, *) {
                return manager.authorizationStatus
            }  else {
                CLLocationManager.authorizationStatus()
            }
        }
    }
    var locateCurrentLocation: (CLLocation) -> Void = { _ in }
    var handleToAuthorizedState: () -> Void = { }
    
    override init() {
        super.init()
        manager.delegate = self
        settingLocationManager()
    }
    
    func getCurrentLocation() -> CLLocation? { return currentLocation }
    
    private func settingLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            if locationAuthorizationStatus == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else if locationAuthorizationStatus == .authorizedAlways || locationAuthorizationStatus == .authorizedWhenInUse {
                manager.startUpdatingLocation()
            }
        }
    }
    
    private func checkUserLocationServiceAuthorization() {
        switch locationAuthorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            handleToAuthorizedState()
            print("restricted")
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            print("default")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let lastLocation = locations.last else { return }
        locateCurrentLocation(lastLocation)
        currentLocation = lastLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("fail")
        // TODO: fail에 대한 처리 필요
    }
}
