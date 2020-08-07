//
//  RatingView.swift
//  TMDbCombine
//
//  Created by Ivan on 29/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct RatingView: View {

  let score: Double
  @State private var isDisplayed = false

  var body: some View {
    ZStack {
      GeometryReader { proxy in
        Circle()
          .foregroundColor(.black)
          .shadow(color: self.color, radius: 5)
        Circle()
          .trim(from: 0, to: self.isDisplayed ? CGFloat(self.score) / 10 : 0)
          .stroke(lineWidth: proxy.size.width * 0.07)
          .foregroundColor(self.color)
          .animation(Animation.interpolatingSpring(stiffness: 60, damping: 10).delay(0.1))
          .frame(width: proxy.size.width * 0.9)
          .position(proxy.size.center)
          .rotationEffect(.degrees(self.rotationAngle))
        HStack(spacing: 0.0) {
          if self.score == 0 {
            Text("NR")
              .font(Font.system(size: proxy.size.width * 0.35))
          } else {
            Text("\(Int(self.score * 10))")
              .font(Font.system(size: proxy.size.width * 0.35))
            Text("%")
              .font(Font.system(size: proxy.size.width * 0.12))
          }
        }
        .foregroundColor(.white)
        .position(proxy.size.center)
      }
    }
    .frame(width: 70, height: 70)
    .onAppear {
      self.isDisplayed = true
    }
  }

  private var color: Color {
    switch score {
    case 0:
      return .black
    case 0.1...3.9:
      return .red
    case 4...5.9:
      return .orange
    case 6...7.4:
      return .yellow
    default:
      return .green
    }
  }

// MARK: - Drawing Constants -
  private let rotationAngle: Double = -90
}

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    RatingView(score: 7.4)
  }
}
