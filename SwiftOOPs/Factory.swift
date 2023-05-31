//
//  main.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 31/05/23.
//

import Foundation

protocol ProjectFactory {
    func createProjector() -> Projector
    func syncedProjector(with projector: Projector) -> Projector
}

extension ProjectFactory {
    func syncedProjector(with projector: Projector) -> Projector {
        let newProjector = createProjector()
        newProjector.sync(with: projector)
        return newProjector
    }
}

class WifiFactory: ProjectFactory {
    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: ProjectFactory {
    func createProjector() -> Projector {
        return BluetoothProjector()
    }
}

protocol Projector {
    var currentPage: Int { get }
    func present(info: String)
    func sync(with projector: Projector)
    func update(with page: Int)
}

extension Projector {
    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

class WifiProjector: Projector {
    var currentPage = 0
    func present(info: String) {
        print("Info is presented over WiFi: \(info)")
    }
    
    func update(with page: Int) {
        currentPage = page
    }
}

class BluetoothProjector: Projector {
    var currentPage = 0
    func present(info: String) {
        print("Info is presented over Bluetooth: \(info)")
    }
    func update(with page: Int) {
        currentPage = page
    }
}

class ClientCode {
    private var currentProjector: Projector?
    
    func present(info: String, with factory: ProjectFactory) {
        guard let projector = currentProjector else {
            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }
        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}

func testFactory() {
    let info = "Very important info of the presentation"

    let clientCode = ClientCode()
    
    /// Present info over WiFi
    clientCode.present(info: info, with: WifiFactory())
    
    /// Present info over Bluetooth
    clientCode.present(info: info, with: BluetoothFactory())

}
