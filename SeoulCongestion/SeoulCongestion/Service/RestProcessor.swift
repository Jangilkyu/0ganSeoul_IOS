//
//  RestProcessor.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/26.
//

import Foundation
import UIKit

enum NetworkError: Error {
  case badUrl
  case noData
  case decodingError
  case iconLoadingError
}

enum XMLKey: String {
  case areaNm = "AREA_NM"
  case areaCongestLvl = "AREA_CONGEST_LVL"
  case areaCongestMsg = "AREA_CONGEST_MSG"
  case areaPpltnMin = "AREA_PPLTN_MIN"
  case areaPpltnMax = "AREA_PPLTN_MAX"
  case malePpltnRate = "MALE_PPLTN_RATE"
  case femalePpltnRate = "FEMALE_PPLTN_RATE"
  case roadTrafficIdx = "ROAD_TRAFFIC_IDX"
  case roadMSG = "ROAD_MSG"
  case roadTrafficSPD = "ROAD_TRAFFIC_SPD"
}

class RestProcessor: NSObject {
  static var shared: RestProcessor = RestProcessor()
  var xmlParser = XMLParser()
  var xmlDictionary: [String: String]?
  var crtElementType: XMLKey?
  var city: City?
}

extension RestProcessor: XMLParserDelegate {
  func requestSeoulCityInfo(
    cityID: String,
    completion: @escaping (Result<City, NetworkError>) -> Void
  ) {
    
    let encodedStr = cityID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    let urlString = "http://openapi.seoul.go.kr:8088/\(Bundle.main.apiKey)/xml/citydata/1/16/\(encodedStr)"
    guard let url = URL(string: urlString) else { return }
    print(url)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: url) {
      data, response, error in
      
      guard error == nil,
            let httpResponse = (response as? HTTPURLResponse),
            httpResponse.statusCode == 200,
            let data = data else {
        return
      }
      
      self.configurePaser(data) { result in
        switch result {
        case .success(let city):
          return completion(.success(city))
        case .failure(_):
          ()
        }
      }
    }
    dataTask.resume()
  }
  
  func configurePaser(
    _ data: Data,
    completion: @escaping (Result <City, NetworkError>) -> Void
  ) {
    let parser = XMLParser(data: data)
    parser.delegate = self
    parser.parse()
    
    guard let city = self.city else { return }
    return completion(.success(city))
  }
  
  func parser(
    _ parser: XMLParser,
    didStartElement elementName:
    String, namespaceURI: String?,
    qualifiedName qName: String?,
    attributes attributeDict: [String : String] = [:]
  ) {
    switch elementName {
    case "CITYDATA":
      xmlDictionary = [:]
    case "AREA_NM":
      crtElementType = .areaNm
    case "LIVE_PPLTN_STTS":
      xmlDictionary = [:]
    case "AREA_CONGEST_LVL":
      crtElementType = .areaCongestLvl
    case "AREA_CONGEST_MSG":
      crtElementType = .areaCongestMsg
    case "AREA_PPLTN_MIN":
      crtElementType = .areaPpltnMin
    case "AREA_PPLTN_MAX":
      crtElementType = .areaPpltnMax
    case "MALE_PPLTN_RATE":
      crtElementType = .malePpltnRate
    case "FEMALE_PPLTN_RATE":
      crtElementType = .femalePpltnRate
    case "AVG_ROAD_DATA":
      xmlDictionary = [:]
    case "ROAD_MSG":
      crtElementType = .roadMSG
    case "ROAD_TRAFFIC_IDX":
      crtElementType = .roadTrafficIdx
    case "ROAD_TRAFFIC_SPD":
      crtElementType = .roadTrafficSPD
      
    default:
      break
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    guard xmlDictionary != nil,
          let crtElementType = self.crtElementType else { return }
    xmlDictionary?.updateValue(string, forKey: crtElementType.rawValue)
  }
  
  func parser(
    _ parser: XMLParser,
    didEndElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?
  ) {
    guard let xmlDictionary = self.xmlDictionary else { return }
    switch elementName {
    case "AREA_NM":
      self.city = City()
      guard let areaNM = xmlDictionary[XMLKey.areaNm.rawValue] else { return }
      self.city?.areaNm = areaNM
      
    case "AREA_CONGEST_LVL":
      guard let areaCongestLvl = xmlDictionary[XMLKey.areaCongestLvl.rawValue] else { return }
      self.city?.areaCongestLvl = areaCongestLvl
      
    case "AREA_CONGEST_MSG":
      guard let areaCongestMsg = xmlDictionary[XMLKey.areaCongestMsg.rawValue] else { return }
      self.city?.areaCongestMsg = areaCongestMsg
      
    case "ROAD_TRAFFIC_IDX":
      guard let roadTrafficIdx = xmlDictionary[XMLKey.roadTrafficIdx.rawValue] else { return }
      self.city?.roadTrafficIdx = roadTrafficIdx
      
    case "ROAD_MSG":
      guard let roadMSG = xmlDictionary[XMLKey.roadMSG.rawValue] else { return }
      self.city?.roadMSG = roadMSG
      
    case "ROAD_TRAFFIC_SPD":
      guard let roadTrafficSPD = xmlDictionary[XMLKey.roadTrafficSPD.rawValue] else { return }
      self.city?.roadTrafficSPD = roadTrafficSPD
      
    default:
      break
    }
    
    crtElementType = nil
  }
}
