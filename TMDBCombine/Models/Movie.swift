//
//  Movie.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import SwiftUI

struct Movie: Codable, Identifiable {
  let id = UUID()
  let title: String?
  let voteAverage: Double?
  let overview: String
  let releaseDate: String?
  let voteCount: Int?
  let popularity: Double?
  let originalLanguage: String?
  let originalTitle: String?
  let genreIds: [Int]?
  let posterPath: String?

  enum CodingKeys: String, CodingKey {
    case title, overview, popularity
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
    case releaseDate = "release_date"
    case originalTitle = "original_title"
    case originalLanguage = "original_language"
    case voteCount = "vote_count"
    case genreIds = "genre_ids"
  }
}
