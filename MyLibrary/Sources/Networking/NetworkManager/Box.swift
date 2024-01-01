//
//  Box.swift
//
//
//  Created by Илья Шаповалов on 27.12.2023.
//

import Foundation

struct Box<Wrapped> {
    let value: Wrapped
    
    init(_ value: Wrapped) {
        self.value = value
    }
    
    func map<T>(_ transform: @escaping (Wrapped) throws -> T) rethrows -> Box<T> {
        Box<T>(try transform(value))
    }
    
    func flatMap<T>(_ transform: @escaping (Wrapped) throws -> T) rethrows -> T {
        try transform(value)
    }
    
}

//extension Box where Wrapped: T? {
//    func replaceNill<T>(
//        _ alternative: () throws -> T
//    ) rethrows -> Box<T> {
//        switch value {
//        case .some(let wrapped): return Box(wrapped)
//        case .none: return try Box(alternative())
//        }
//    }
//}
