//
//  Extension+UITextField.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/13.
//

import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
