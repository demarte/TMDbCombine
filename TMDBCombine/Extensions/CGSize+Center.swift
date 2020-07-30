//
//  CGSize+Center.swift
//  TMDbCombine
//
//  Created by Ivan on 29/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

extension CGSize {
  var center: CGPoint {
    CGPoint(x: self.width / 2, y: self.height / 2)
  }
}
