//
//  Extension+Int.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/12.
//

import UIKit

extension Int {
    var formattedComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
