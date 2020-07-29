//
//  Result.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {

  let totalOfResults: Int
  let totalOfPages: Int
  let movies: [Movie]

  enum CodingKeys: String, CodingKey {
    case totalOfResults = "total_results"
    case totalOfPages = "total_pages"
    case movies = "results"
  }
}
