//
//  MovieResponse.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

let movieData: [Movie] = load("movieData.json")

func load<T: Decodable>(_ filename: String) -> T {
  let data: Data

  guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
    fatalError("Couldn't find \(filename) in main bundle.")
  }
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
  }
  do {
    return try JSONDecoder().decode(T.self, from: data)
  } catch {
    fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
  }
}

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
