//
//  ImageCache.swift
//  TMDbCombine
//
//  Created by Ivan on 29/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

final class ImageCache {
  
  static let shared: ImageCache = ImageCache()
  
  private init() { }
  
  private let cache: NSCache<NSString, ImageRequester> = NSCache()
  
  func loadImage(for path: String?, with size: ImageRequester.Size) -> ImageRequester {
    
    let key = NSString(string: "\(path ?? "not found")")
    if let image = cache.object(forKey: key) {
      return image
    } else {
      let imageRequester = ImageRequester(posterPath: path, size: size)
        cache.setObject(imageRequester, forKey: key)
        return imageRequester      
    }
  }
}
