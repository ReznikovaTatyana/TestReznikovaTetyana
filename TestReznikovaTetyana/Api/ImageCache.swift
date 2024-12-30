//
//  ImageCache.swift
//  TestReznikovaTetyana
//
//  Created by mac on 05.07.2024.
//

import UIKit

// MARK: Клас для кешування зображення
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
//    func image(forKey key: String) -> UIImage? {
//        return cache.object(forKey: NSString(string: key))
//    }
//    
//    func setImage(_ image: UIImage, forKey key: String) {
//        cache.setObject(image, forKey: NSString(string: key))
//    }
}
