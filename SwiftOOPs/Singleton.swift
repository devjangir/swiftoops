//
//  Singleton.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 03/06/23.
//

import Foundation

final public class EventLogger {
    private let serialQueue = DispatchQueue(label: "SerialQueue")
    public static let shared = EventLogger()
    private init() {}
    private var data: [String : String] = [:]
    
    func readLog(key: String) -> String? {
        var result : String?
        serialQueue.sync {
            result = data[key]
        }
        return result
    }
    
    func writeLog(key: String, content: String) {
        serialQueue.sync {
            data[key] = content
        }
    }
    
    func reset() {
        data.removeAll()
    }
}

func testSingleton() {
    let count = 100
    
    for index in 0..<count{
        EventLogger.shared.writeLog(key: String(index), content: String(index))
    }
    DispatchQueue.concurrentPerform(iterations:count) { (index) in
        if let n = EventLogger.shared.readLog(key: "\(index)") {
            print(n)
        }
    }
    EventLogger.shared.reset()
    DispatchQueue.concurrentPerform(iterations:count) { (index) in
        EventLogger.shared.writeLog(key: "\(index)", content: String(index))
    }
}
