//
//  ResHandler.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/04.
//

import Foundation

class ResHandler {
  
  enum ResultTypes {
    case created(RestProcessor.RestEntity, Data?)
    case ok(RestProcessor.RestEntity, Data?)
  }
  
  private let result: RestProcessor.Results
  
  init(result: RestProcessor.Results) {
    self.result = result
  }
  
  func getResult(_ result: RestProcessor.Results? = nil) -> ResultTypes? {
    
    var res: RestProcessor.Results!
    
    if let result = result {
      res = result
    } else {
      res = self.result
    }
    
    guard let statusCode = res.response?.httpStatusCode else { return nil }
    if let data = res.data {
      let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
      print("json! :: \(json!)")
    }
    // 1. Process status codes first
    if statusCode == 200 {
      guard let headers = res.response?.headers else { return nil}
      if let data = res.data {
        let count = data.count
        if count > 0 {
          return .ok(headers, data)
        }
      }
    }
    return nil
  }
  
  
  private func getMsgFromBody(data: Data?) -> String? {
    guard let data = data,
          let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]),
          let unwrappedJson = json as? [String: Any],
          let msg = unwrappedJson["msg"] as? String else { return nil }
    return msg
  }
}
