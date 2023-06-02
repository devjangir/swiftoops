//
//  Builder.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 02/06/23.
//

import Foundation

protocol Builder {
    func buildPartA()
    func buildPartB()
    func buildPartC()
}

class Product {
    var list: [String] = []
    func add(_ step: String) {
        list.append(step)
    }
    
    func listStep() {
        print(list.joined(separator: ", "))
    }
}

class ProductFamily1: Builder {
    private var product = Product()
    
    func reset() {
        product = Product()
    }
    
    func buildPartA() {
        product.add("Building Part 1")
    }
    
    func buildPartB() {
        product.add("Building Part 2")
    }
    
    func buildPartC() {
        product.add("Building Part 3")
    }
    
    func getProduct() -> Product {
        let result = product
        reset()
        return result
    }
}

class Director {
    private var builder: Builder?
    func update(builder: Builder) {
        self.builder = builder
    }
    func makeMVP() {
        builder?.buildPartA()
    }
    
    func makeFullProduct() {
        builder?.buildPartA()
        builder?.buildPartB()
        builder?.buildPartC()
    }
}

class ClientBuilder {
    static func testBuilder() {
        let builder = ProductFamily1()
        let director = Director()
        director.update(builder: builder)
        director.makeMVP()
        builder.getProduct().listStep()
        
        director.makeFullProduct()
        builder.getProduct().listStep()
    }
}

func testBuilderDesignPattern() {
    ClientBuilder.testBuilder()
}
