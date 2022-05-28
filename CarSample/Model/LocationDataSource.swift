//
//  LocationDataSource.swift
//  CarSample
//
//  Created by LeoAndo on 2022/05/28.
//

import CoreLocation
import Combine

final class LocationDataSource: NSObject {

    private let locationManager: CLLocationManager = .init()
    private let authorizationSubject: PassthroughSubject<CLAuthorizationStatus, Never> = .init()
    private let locationSubject: PassthroughSubject<[CLLocation], Never> = .init()

    override init() {
        super.init()
        locationManager.delegate = self
        // locationManager.distanceFilter = 100.0 // 位置情報取得間隔を指定(100m移動したら、位置情報を通知)
    }

    func authorizationPublisher() -> AnyPublisher<CLAuthorizationStatus, Never> {
        return Just(locationManager.authorizationStatus).merge(with: authorizationSubject).eraseToAnyPublisher()
    }

    func locationPublisher() -> AnyPublisher<[CLLocation], Never> {
        return locationSubject.eraseToAnyPublisher()
    }

    func requestAuthorization() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationDataSource: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("\(manager.authorizationStatus.description)")
        authorizationSubject.send(manager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(locations)")
        locationSubject.send(locations)
    }
}
