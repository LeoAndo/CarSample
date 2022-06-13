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
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
            didConnect interfaceController: CPInterfaceController) {

        self.interfaceController = interfaceController
        let soundPlayer = SoundPlayer()
        let item: CPInformationItem = .init(title: "information Title!", detail: "detail!")
        let playButton: CPTextButton = .init(title: "Play", textStyle: .normal, handler:  { _ in
            soundPlayer.play(fileName: "cymbalSound")
        })
        
        let informationTemplate: CPInformationTemplate = .init(title: "Sound Test", layout: .leading, items: [item], actions: [playButton])
        interfaceController.setRootTemplate(informationTemplate, animated: false)
    }

    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
}
