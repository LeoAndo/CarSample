//
//  CarPlaySceneDelegate.swift
//  CarPlay
//
//  Created by LeoAndo on 2022/05/28.
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
    
    
    
    private var systemImageNames = ["pencil.tip", "folder", "doc", "location", "person.3", "airplane", "bolt.car", "bus.doubledecker", "bicycle"]
    
    private func setRootTemplate(longitude: String, latitude: String) {
        
        let imaegname = systemImageNames.randomElement() ?? "location"
        // UIの設定
        let requestPermissionButton:CPGridButton = .init(titleVariants: ["request Permissin"], image: UIImage(systemName: imaegname)!, handler: { _ in
            self.model.requestAuthorization()
        })
        let startLocationButton:CPGridButton = .init(titleVariants: ["start Location"], image: UIImage(systemName: imaegname)!, handler: { _ in
            self.model.startTracking()
        })
        let stopLocationButton:CPGridButton = .init(titleVariants: ["stop Location"], image: UIImage(systemName: imaegname)!, handler: { _ in
            self.model.stopTracking()
        })
        
        let longitudeItem:CPGridButton = .init(titleVariants: [String(longitude)], image: UIImage(systemName: imaegname)!, handler: { _ in
            print("clicked longitudeItem")
        })
        let latitudeItem:CPGridButton = .init(titleVariants: [String(latitude)], image: UIImage(systemName: imaegname)!, handler: { _ in
            print("clicked latitudeItem")
        })
        
        let gridTemplate:CPGridTemplate = .init(title: "Location", gridButtons: [requestPermissionButton, startLocationButton, stopLocationButton, longitudeItem, latitudeItem])
        // 位置情報の許可ステータスの表示
        self.interfaceController!.setRootTemplate(gridTemplate, animated: false)
    }
}
