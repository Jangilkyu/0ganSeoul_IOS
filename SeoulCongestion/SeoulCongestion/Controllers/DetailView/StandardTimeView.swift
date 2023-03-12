//
//  StandardTimeView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/25.
//

import UIKit

class StandardTimeView: UIView {
  
  let timeLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.regular(size: 15)
    lb.textColor = SCColor.white.color
    return lb
  }()
  
  required init() {
    super.init(frame: .zero)
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
    addSubview(timeLabel)
  }
  
  private func setConstraints() {
    timeLabelConstraints()
  }
  
  private func timeLabelConstraints() {
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
  }
}
