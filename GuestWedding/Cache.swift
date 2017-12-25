//
//  Protocol.swift
//  Golf
//
//  Created by le kien on 12/1/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation

protocol Encoded {
    associatedtype Encoder: NSCoding
    var encoder: Encoder { get }
}

protocol Encodable {
    associatedtype Value
    var value: Value? { get }
}

class Cache<T: Encoded> where T.Encoder: Encodable, T.Encoder.Value == T {
    let file = String(describing: T.self)
    func save(object: T) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object.encoder)
        UserDefaults.standard.set(encodedData, forKey: file)
    }
    
    func fetchObject() -> T? {
        if let data = UserDefaults.standard.data(forKey: file) {
            let fetchedEncoder = NSKeyedUnarchiver.unarchiveObject(with: data)
            let typedEncoder = fetchedEncoder as? T.Encoder
            return typedEncoder?.value as T?
        }
        return nil
    }
    
    func remove() {
        UserDefaults.standard.set(nil, forKey: file)
    }
}
