//
//  ImageRequester.swift
//  TMDbCombine
//
//  Created by Ivan on 29/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ImageRequester: ObservableObject {

  let posterPath: String?
  let size: ImageRequester.Size

  @Published var image: UIImage?
  var cancellable: AnyCancellable?
  var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers
    .Sequence<[UIImage?], Never>(sequence: [])
    .eraseToAnyPublisher()

  init(posterPath: String?, size: Size) {
    self.posterPath = posterPath
    self.size = size

    self.objectWillChange = $image
      .handleEvents(receiveSubscription: { [weak self] _ in
        self?.fetchImage()
        }, receiveCancel: { [weak self] in
          self?.cancellable?.cancel()
      })
      .eraseToAnyPublisher()
  }

  private func fetchImage() {
    guard let path = self.posterPath else { return }

    cancellable = URLSession.shared.dataTaskPublisher(for: size.path(poster: path))
      .tryMap { (data, _) in
        return UIImage(data: data)
    }
    .catch { _ in
      return Just(nil)
    }
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .assign(to: \.image, on: self)
  }
}

extension ImageRequester {
  // MARK: - Image Size -
  enum Size: String {
    case small = "https://image.tmdb.org/t/p/w154/"
    case medium = "https://image.tmdb.org/t/p/w500/"
    case cast = "https://image.tmdb.org/t/p/w185/"
    case original = "https://image.tmdb.org/t/p/original/"

    func path(poster: String) -> URL {
        return URL(string: rawValue)!.appendingPathComponent(poster)
    }
  }
}
