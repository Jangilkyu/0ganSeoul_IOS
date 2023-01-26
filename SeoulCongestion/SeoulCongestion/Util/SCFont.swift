//
//  SCFont.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit

enum SCFont: String {
  case Black = "Pretendard-Black"
  case Bold = "Pretendard-Bold"
  case ExtraBold = "Pretendard-ExtraBold"
  case Light = "Pretendard-Light"
  case ExtraLight = "Pretendard-ExtraLight"
  case Medium = "Pretendard-Medium"
  case Regular = "Pretendard-Regular"
  case Thin = "Pretendard-Thin"
  case SemiBold = "Pretendard-SemiBold"
  
  func of(size: CGFloat) -> UIFont {
    return UIFont(name: self.rawValue, size: size)!
  }
  
  static func black(size: CGFloat) -> UIFont {
    return SCFont.Black.of(size: size)
  }
  
  static func bold(size: CGFloat) -> UIFont {
    return SCFont.Bold.of(size: size)
  }
  
  static func extraBold(size: CGFloat) -> UIFont {
    return SCFont.ExtraBold.of(size: size)
  }
  
  static func light(size: CGFloat) -> UIFont {
    return SCFont.Light.of(size: size)
  }
  
  static func extraLight(size: CGFloat) -> UIFont {
    return SCFont.ExtraLight.of(size: size)
  }
  
  static func medium(size: CGFloat) -> UIFont {
    return SCFont.Medium.of(size: size)
  }
  
  static func regular(size: CGFloat) -> UIFont {
    return SCFont.Regular.of(size: size)
  }
  
  static func thin(size: CGFloat) -> UIFont {
    return SCFont.Thin.of(size: size)
  }
  
  static func semiBold(size: CGFloat) -> UIFont {
    return SCFont.SemiBold.of(size: size)
  }
}
