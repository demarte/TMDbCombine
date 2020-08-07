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
      TextField("Search for a movie, tv show, person...", text: $requester.movieQuery)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Picker(selection: $requester.selectedItem, label: EmptyView()) {
        Text("Popular").tag(0)
        Text("Top Rated").tag(1)
        Text("Upcoming").tag(2)
        Text("At the Movies").tag(3)
      }
      .pickerStyle(SegmentedPickerStyle())
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
          .font(.title)
        HStack {
          RatingView(score: movie.voteAverage ?? 0)
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
