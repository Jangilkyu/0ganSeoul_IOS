//
//  Extension+String.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/11.
//

import UIKit

extension String {
  func numberFormatter(number: Int) -> String {
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
      
      return numberFormatter.string(from: NSNumber(value: number))!
  }
}
