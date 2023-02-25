//
//  EndPoint.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/04.
//

import Foundation

let baseURL: String = "https://zeroganseoul-server.onrender.com/api/v1"

enum EndPoint {
  case seoulCitiesData
  case search
  
  var url: URL {
    switch self {
    case .seoulCitiesData:
      return URL(string: "\(baseURL)/seoulCitiesData")!
    case .search:
      return URL(string: "\(baseURL)/citiesRouter")!
    }
  }
}
