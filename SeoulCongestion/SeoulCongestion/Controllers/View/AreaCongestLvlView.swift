//
//  AreaCongestLvlView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/02.
//

import UIKit
import SkeletonView

class AreaCongestLvlView: UIView {
  
  let popIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.isSkeletonable = true
    return iv
  }()
  
  let areaCongestLvlLabel: UILabel = {
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
    addSubview(popIconImageView)
    addSubview(areaCongestLvlLabel)
  }
  
  private func setConstraints() {
    popIconImageViewConstraints()
    areaCongestLvlLabelConstraints()
  }
  
  private func popIconImageViewConstraints() {
    popIconImageView.translatesAutoresizingMaskIntoConstraints = false
    popIconImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
    popIconImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
    popIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
    popIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    popIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    popIconImageView.trailingAnchor.constraint(equalTo: areaCongestLvlLabel.leadingAnchor, constant: -4.5).isActive = true
  }
  
  private func areaCongestLvlLabelConstraints() {
    areaCongestLvlLabel.translatesAutoresizingMaskIntoConstraints = false
    areaCongestLvlLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    areaCongestLvlLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    areaCongestLvlLabel.leadingAnchor.constraint(equalTo: popIconImageView.trailingAnchor, constant: 4.5).isActive = true
    areaCongestLvlLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
  }


}
