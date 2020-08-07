//
//  SearchEndpoint.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

enum SearchEndpoint {
  case movie(query: String)
}

extension SearchEndpoint: EndpointType {
  var path: String {
    return "search/movie"
  }

  var method: Method {
    return .get
  }

  var parameters: [String: String]? {
    var parameters = ["api_key": APIConstants.apiKey]
    switch self {
    case .movie(let query):
      parameters["query"] = query
      return parameters
    }
  }
}
