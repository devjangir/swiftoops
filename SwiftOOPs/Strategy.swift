//
//  Strategy.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 08/06/23.
//

import Foundation
protocol RouteStrategy {
    func calculateRouter(from: String, to: String) -> String
}

class CarRouteStrategy: RouteStrategy {
    func calculateRouter(from: String, to: String) -> String {
        "Calculating the route from \(from) to \(to) using Car mode"
    }
}

class BikeRouteStrategy: RouteStrategy {
    func calculateRouter(from: String, to: String) -> String {
        "Calculating the route from \(from) to \(to) using Bike mode"
    }
}

class PublicTransportStrategy: RouteStrategy {
    func calculateRouter(from: String, to: String) -> String {
        "Calculating the route from \(from) to \(to) using Public Transport mode"
    }
}

class NavigationFinder {
    var strategy: RouteStrategy
    init(strategy: RouteStrategy) {
        self.strategy = strategy
    }
    
    func update(strategy: RouteStrategy) {
        self.strategy = strategy
    }
    
    func calculateRoute(from: String, to: String) -> String {
        strategy.calculateRouter(from: from, to: to)
    }
}

func testStrategy() {
    let carRouteStrategy = CarRouteStrategy()
    let bikeRouteStrategy = BikeRouteStrategy()
    let transportStrategy = PublicTransportStrategy()
    
    let navigation = NavigationFinder(strategy: carRouteStrategy)
    print(navigation.calculateRoute(from: "newyork", to: "atlanta"))
    
    navigation.update(strategy: bikeRouteStrategy)
    print(navigation.calculateRoute(from: "newyork", to: "washington"))
    
    navigation.update(strategy: transportStrategy)
    print(navigation.calculateRoute(from: "newyork", to: "newyork airport"))
}
