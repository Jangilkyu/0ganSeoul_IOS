//
//  Extension+UIview.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/05.
//

import UIKit

extension UIView {

    func addGradient(frame: CGRect) {
        let gradientView = UIView(frame: self.frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
      let colors: [CGColor] = [
        .init(red: 0.212, green: 0.212, blue: 0.212, alpha: 0.55),
        .init(red: 0.106, green: 0.106, blue: 0.106, alpha: 0.6),
        .init(red: 0, green: 0, blue: 0, alpha: 0.8),
        .init(red: 0, green: 0, blue: 0, alpha: 1)
      ]
      
        gradientLayer.colors = colors
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        addSubview(gradientView)
    }
}
