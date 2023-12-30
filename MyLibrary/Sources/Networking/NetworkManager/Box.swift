//
//  Box.swift
//
//
//  Created by Илья Шаповалов on 27.12.2023.
//

import Foundation

@usableFromInline
struct Box<Wrapped> {
    
    @usableFromInline
    let value: Wrapped
    
    @inlinable
    init(_ value: Wrapped) {
        self.value = value
    }
    
    @inlinable
    init(_ value: Wrapped) async {
        self.value = value
    }
    
    @inlinable
    @inline(__always)
    func map<T>(_ transform: @escaping (Wrapped) throws -> T) rethrows -> Box<T> {
        Box<T>(try transform(value))
    }

    @inlinable
    @inline(__always)
    func flatMap<T>(_ transform: @escaping (Wrapped) throws -> T) rethrows -> T {
        try transform(value)
    }
    
    @inlinable
    @inline(__always)
    func asyncMap<T>(_ transform: @escaping (Wrapped) async throws -> T) async rethrows -> Box<T> {
        await Box<T>(try transform(value))
    }
    
    @inlinable
    @inline(__always)
    func asyncFlatMap<T>(_ transform: @escaping (Wrapped) async throws -> T) async rethrows -> T {
        try await transform(value)
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
