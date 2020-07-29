//
//  APIRequester.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import Combine

final class MovieRequest: ObservableObject {
  
  private var endpoint: EndpointType
  var cancellables: Set<AnyCancellable> = []
  @Published var movies: [Movie] = []
  
  init(endpoint: EndpointType) {
    self.endpoint = endpoint
    createDataTaskPublisher()
  }
  
  private func createDataTaskPublisher() {
    URLSession.shared.dataTaskPublisher(for: endpoint.request)
      .map(\.data)
      .decode(type: MovieResponse.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { (completion) in
        print(completion)
      }) { result in
        self.movies = result.movies
        print(self.movies)
    }
    .store(in: &cancellables)
  }
}
