//
//  CarPlaySceneDelegate.swift
//  CarPlay
//
//  Created by Alexander v. Below on 24.06.20.
//

import UIKit
// CarPlay App Lifecycle

import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfaceController: CPInterfaceController?

    // UI
    // private let authorizationStatusItem: CPInformationItem = .init(title: "Authorization Status", detail: CLAuthorizationStatus.notDetermined.description)
    
    // Model
    private let model: LocationDataSource = LocationDataSource()
    private var authorizationStatus: CLAuthorizationStatus = .notDetermined
    private var location: CLLocation = .init()
    private var longitude: CLLocationDegrees { location.coordinate.longitude }
    private var latitude: CLLocationDegrees { location.coordinate.latitude }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
            didConnect interfaceController: CPInterfaceController) {
        print("templateApplicationScene1")
        self.interfaceController = interfaceController
        
        // UIの設定
        setRootTemplate(longitude: "0.000", latitude: "0.000")
        
        //
        activate()
    }

    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
        print("templateApplicationScene2")
        self.interfaceController = nil
    }
    
    private func activate() {
       model.authorizationPublisher()
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main) // receiveValueのコードブロックの処理をUIスレッドに変更
            .sink(receiveCompletion: {
            print ("authorizationPublisher completion: \($0)")
        }, receiveValue: { status in
            self.authorizationStatus = status
            // self.authorizationStatusItem.detail = status.description
        })
        
        model.locationPublisher().compactMap { $0.last }
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
            print ("locationPublisher completion: \($0)")
        }, receiveValue: { location in
            self.location = location
            
            // UIの設定
            self.setRootTemplate(longitude: String(self.longitude), latitude: String(self.latitude))
        })
    }
    
    private func setRootTemplate(longitude: String, latitude: String) {
        // UIの設定
        let requestPermissionButton:CPTextButton = .init(title: "request Permissin", textStyle: .normal, handler: {_ in
            self.model.requestAuthorization()
        })
        let startLocationButton:CPTextButton = .init(title: "start Location", textStyle: .normal, handler: { _ in
            self.model.startTracking()
        })
        let stopLocationButton:CPTextButton = .init(title: "stop Location", textStyle: .normal, handler: { _ in
            self.model.stopTracking()
        })
        let longitudeItem: CPInformationItem = .init(title: "Location longitude: ", detail: String(longitude))
        let latitudeItem: CPInformationItem = .init(title: "Location Latitude: ", detail: String(latitude))
        // 位置情報の許可ステータスの表示
        let informationTemplate:CPInformationTemplate = .init(title: "Location", layout: .leading, items: [longitudeItem, latitudeItem], actions: [requestPermissionButton, startLocationButton, stopLocationButton])
        self.interfaceController!.setRootTemplate(informationTemplate, animated: false)
    }
}
