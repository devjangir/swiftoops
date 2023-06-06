//
//  Decorator.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 06/06/23.
//

import Foundation

protocol Order {
    func calculateTotalPrice() -> Double
}

class BaseOrder: Order {
    func calculateTotalPrice() -> Double {
        print("calculating base price")
        let basePrice = 100.0
        return basePrice
    }
}

protocol OrderDecorator: Order {
    var wrappedOrder: Order { get }
    init(order: Order)
}

class DiscountDecorator: OrderDecorator {
    let wrappedOrder: Order
    required init(order: Order) {
        self.wrappedOrder = order
    }
    func calculateTotalPrice() -> Double {
        print("discount calculation")
        var basePrice = wrappedOrder.calculateTotalPrice()
        let discount = 20.0
        let finalPrice = basePrice - discount
        return finalPrice
    }
}

class ShippingDecorator: OrderDecorator {
    let wrappedOrder: Order
    required init(order: Order) {
        self.wrappedOrder = order
    }
    func calculateTotalPrice() -> Double {
        print("shipping calculation")
        var basePrice = wrappedOrder.calculateTotalPrice()
        let shippingCost = 45.0
        let finalPrice = basePrice + shippingCost
        return finalPrice
    }
}

func testDecorator() {
    let order = BaseOrder()
    let shippingOrder = ShippingDecorator(order: DiscountDecorator(order: order))
    let finalPrice = shippingOrder.calculateTotalPrice()
    
    print("final price after discount and shipping \(finalPrice)")
}
