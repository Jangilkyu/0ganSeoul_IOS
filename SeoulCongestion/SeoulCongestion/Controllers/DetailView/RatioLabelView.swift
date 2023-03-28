//
//  RatioLabelView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/22.
//

import UIKit

class RatioLabelView: UIView {
  
  let lb: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 0
    lb.textAlignment = .right
    lb.font = SCFont.bold(size: 12)
    return lb
  }()
  
  required init(bgColor: SCColor) {
    super.init(frame: .zero)
    self.clipsToBounds = true
    self.layer.cornerRadius = 2.0
    lb.textColor = SCColor.white.color
    backgroundColor = bgColor.color

    setup()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func setup() {
    addViews()
    setConstraints()
  }
  
  private func addViews() {
    addSubview(lb)
  }
  
  private func setConstraints() {
    lbConstraints()
  }
  
  private func lbConstraints() {
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
    lb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
    lb.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    lb.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
  }

}
