//
//  PosterImageView.swift
//  TMDbCombine
//
//  Created by Ivan on 29/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct PosterImageView: View {
  
  @ObservedObject var imageRequester: ImageRequester
  @State var isLoading = true
  private let requesterSize: ImageRequester.Size
  
  init(path: String?, size: ImageRequester.Size) {
    _imageRequester = ObservedObject(wrappedValue: ImageCache.shared.loadImage(for: path, with: size))
    self.requesterSize = size
  }
  
  var body: some View {
    ZStack {
      if self.imageRequester.image != nil {
        Image(uiImage: imageRequester.image!)
          .resizable()
          .scaleEffect(self.isLoading ? 0.6 : 1)
          .animation(.spring())
          .onAppear {
            self.isLoading = false
        }
      } else {
        Rectangle()
          .foregroundColor(.gray)
      }
    }
    .frame(width: posterSize.width, height: posterSize.height)
    .cornerRadius(10.0)
  }
  
  private var posterSize: CGSize {
    switch requesterSize {
    case .small:
      return CGSize(width: 53, height: 80)
    case .medium:
      return CGSize(width: 100, height: 150)
    case .cast:
      return CGSize(width: 250, height: 375)
    case .original:
      return CGSize(width: 333, height: 500)
    }
  }
}
