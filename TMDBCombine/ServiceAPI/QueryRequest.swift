//
//  QueryRequest.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class QueryRequest: ObservableObject {
  @Published var movieQuery = ""
  @Published var movies: [Movie] = []
  private var subscriptions: Set<AnyCancellable> = []
  
  init() {
    $movieQuery
      .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
      .removeDuplicates()
      .compactMap { SearchEndpoint.movie(query: $0).request }
      .flatMap(fetchResults)
      .receive(on: DispatchQueue.main)
      .assign(to: \.movies, on: self)
      .store(in: &subscriptions)
  }
  
  private func fetchResults(for urlRequest: URLRequest) -> AnyPublisher<[Movie], Never> {
    URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map(\.data)
      .decode(type: MovieResponse.self, decoder: JSONDecoder())
      .map(\.movies)
      .replaceError(with: [])
      .eraseToAnyPublisher()
  }
}
