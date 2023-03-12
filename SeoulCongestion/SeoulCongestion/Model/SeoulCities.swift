//
//  SeoulCities.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/07.
//

import Foundation

class SeoulCities {
  var cities: [Cities]
  
  init(_ cities: [Cities]) {
    self.cities = cities
  }
  
  func getCity() -> [City]? {
    return cities[0].cities
  }
  
  func setCity(city: [City]?) {
    self.cities[0].cities = city
  }
  
  func getNumberOfCities() -> Int {
    if cities.count > 0 {
      let numberOfCities = cities[0].cities!.count
      return numberOfCities
    }
    return 0
  }
  
  func getOneCenter(at indexPath: IndexPath) -> City? {
      guard let cities = self.getCity(), indexPath.row < cities.count else {
          print("Error: Invalid index path or empty city list")
          return nil
      }
      let city = cities[indexPath.row]
      return city
  }
  
}
