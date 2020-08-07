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
  @Published var selectedItem: Int = 0
  @Published var movieQuery = ""
  @Published var movies: [Movie] = []
  private var subscriptions: Set<AnyCancellable> = []
  
  init() {
    $movieQuery
      .filter { !$0.isEmpty }
      .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
      .removeDuplicates()
      .compactMap(urlRequest)
      .flatMap(fetchResults)
      .assign(to: \.movies, on: self)
      .store(in: &subscriptions)
    
    $selectedItem
      .map(urlRequest)
      .flatMap(fetchResults)
      .assign(to: \.movies, on: self)
      .store(in: &subscriptions)
  }
  
  private func urlRequest(for itemIndex: Int) -> URLRequest {
    switch itemIndex {
    case 1:
      return MovieEndpoint.topRated.request
    case 2:
      return MovieEndpoint.upcoming.request
    case 3:
      return MovieEndpoint.nowPlaying.request
    default:
      return MovieEndpoint.popular.request
    }
  }
  
  private func urlRequest(for query: String) -> URLRequest {
//    if query.isEmpty {
//      return urlRequest(for: selectedItem)
//    } else {
      return SearchEndpoint.movie(query: query).request
//    }
  }
  
  private func fetchResults(for urlRequest: URLRequest) -> AnyPublisher<[Movie], Never> {
    URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map(\.data)
      .decode(type: MovieResponse.self, decoder: JSONDecoder())
      .map(\.movies)
      .replaceError(with: [])
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
