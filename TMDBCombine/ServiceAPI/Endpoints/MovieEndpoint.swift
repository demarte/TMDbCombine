//
//  MovieEndpoint.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

enum MovieEndpoint {
  case popular
}

extension MovieEndpoint: EndpointType {
  var path: String {
    return "movie/popular"
  }
  
  var method: Method {
    return .get
  }
  
  var parameters: [String : String]? {
    let parameters = ["api_key": APIConstants.apiKey]
    switch self {
    case .popular:
      return parameters
    }
  }
}
