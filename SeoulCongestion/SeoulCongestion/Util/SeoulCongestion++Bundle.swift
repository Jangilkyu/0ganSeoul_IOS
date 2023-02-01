//
//  SeoulCongestion++Bundle.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import Foundation

extension Bundle {
  var apiKey: String {
    guard let file = self.path(forResource: "SeoulCongesionInfo", ofType: "plist") else { return ""}
    
    guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
    guard let key = resource["API_KEY"] as? String else { fatalError("SeoulCongestion.plist에 API_KEY를 설정해주세요.")}
    return key
  }
}
