//
//  ImageCache.swift
//
//
//  Created by Илья Шаповалов on 29.12.2023.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private let lock = NSRecursiveLock()
    private var images: [URL: UIImage] = .init()
    
    var library: [URL: UIImage] {
        get { images }
        set {
            lock.withLock {
                images = newValue
            }
        }
    }
}
