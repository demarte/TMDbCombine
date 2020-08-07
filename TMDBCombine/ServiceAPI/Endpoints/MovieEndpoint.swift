//
//  MovieEndpoint.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

enum MovieEndpoint {
  case popular, upcoming, topRated, nowPlaying
}

extension MovieEndpoint: EndpointType {
  var path: String {
    switch self {
    case .popular:
      return "movie/popular"
    case .upcoming:
      return "movie/upcoming"
    case .topRated:
      return "movie/top_rated"
    case .nowPlaying:
      return "movie/now_playing"
    }
  }
  
  var method: Method {
    return .get
  }
  
  var parameters: [String : String]? {
    let parameters = ["api_key": APIConstants.apiKey]
    return parameters
  }
}
