//
//  ContentView.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
  
  @ObservedObject private var requester = QueryRequest()
  
  var body: some View {
    VStack {
      TextField("Search", text: $requester.movieQuery)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      List(requester.movies) { movie in
        MovieRow(movie: movie)
      }
    }
  }
}

struct MovieRow: View {
  
  var movie: Movie
  
  var body: some View {
    HStack {
      PosterImageView(path: movie.posterPath, size: .medium)
      VStack(alignment: .leading) {
        Text(movie.title ?? "untitled")
          .font(.subheadline)
        HStack {
          Text("\(movie.voteAverage ?? 0)")
          Text("\(movie.releaseDate ?? "")")
            .font(.callout)
        }
        Text(movie.overview)
        .font(.callout)
      }
    }
    .frame(height: 200)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MoviesListView()
  }
}
