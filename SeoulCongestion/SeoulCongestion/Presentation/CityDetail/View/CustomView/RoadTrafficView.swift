//
//  RoadTrafficView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/02.
//

import UIKit
import SkeletonView

class RoadTrafficView: UIView {
  
  let carIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.isSkeletonable = true
    return iv
  }()
  
  let roadTrafficLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.white.color
    lb.isSkeletonable = true
    return lb
  }()
  
  required init() {
    super.init(frame: .zero)
    layer.masksToBounds = true
    layer.cornerRadius = 6
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
    addSubview(carIconImageView)
    addSubview(roadTrafficLabel)
  }
  
  private func setConstraints() {
    carIconImageViewConstraints()
    roadTrafficLabelConstraints()
  }
  
  private func carIconImageViewConstraints() {
    carIconImageView.translatesAutoresizingMaskIntoConstraints = false
    carIconImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
    carIconImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
    carIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
    carIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    carIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    carIconImageView.trailingAnchor.constraint(equalTo: roadTrafficLabel.leadingAnchor, constant: -4.5).isActive = true
  }
  
  private func roadTrafficLabelConstraints() {
    roadTrafficLabel.translatesAutoresizingMaskIntoConstraints = false
    roadTrafficLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    roadTrafficLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    roadTrafficLabel.leadingAnchor.constraint(equalTo: carIconImageView.trailingAnchor, constant: 4.5).isActive = true
    roadTrafficLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
}
