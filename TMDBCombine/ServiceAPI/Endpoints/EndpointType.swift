//
//  EndpointType.swift
//  TMDBCombine
//
//  Created by Ivan on 28/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

protocol EndpointType {
  var request: URLRequest { get }
  var baseURL: URL { get }
  var path: String { get }
  var method: Method { get }
  var headers: [String: String]? { get }
  var parameters: [String: String]? { get }
}

extension EndpointType {
  var headers: [String: String]? {
    return nil
  }

  var baseURL: URL {
    return APIConstants.baseURL
      .appendingPathComponent(APIConstants.apiVersion)
  }

  var request: URLRequest {
     let url: URL = {
       path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
     }()

     var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

     if method == .get {
       let queryItems = parameters?.compactMap { URLQueryItem(name: $0.key, value: $0.value) } ?? []
       urlComponents?.queryItems = queryItems
     }

     var request = URLRequest(url: urlComponents?.url ?? url)

     request.httpMethod = method.rawValue

     if method != .get {
       let dataParam = try? JSONSerialization.data(withJSONObject: parameters ?? [], options: [])
       request.httpBody = dataParam
     }
     return request
   }
}

enum Method: String {
  case get = "GET"
  case post = "POST"
}
