//
//  MainCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit

class MainCell: UICollectionViewCell {
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 5
    return iv
  }()
  
  let areaNmLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.semiBold(size: 18)
    return lb
  }()
  
  let areaCongestMsgLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.thin(size: 10)
    lb.numberOfLines = 2
    return lb
  }()
  
  let areaCongestLvlLabel: UILabel = {
    let lb = UILabel()
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
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
    addSubview(imageView)
    addSubview(areaNmLabel)
    addSubview(areaCongestMsgLabel)
    addSubview(areaCongestLvlLabel)
  }
  
  private func setConstraints() {
    imageViewConstraints()
    areaNmLabelConstraints()
    areaCongestMsgLabelConstraints()
    areaCongestLvlLabelConstraints()
  }
  
  private func imageViewConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0).isActive = true
    imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
    imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  private func areaNmLabelConstraints() {
    areaNmLabel.translatesAutoresizingMaskIntoConstraints = false
    areaNmLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    areaNmLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
  }
  
  private func areaCongestMsgLabelConstraints() {
    areaCongestMsgLabel.translatesAutoresizingMaskIntoConstraints = false
    areaCongestMsgLabel.topAnchor.constraint(equalTo: areaNmLabel.bottomAnchor, constant: 3).isActive = true
    areaCongestMsgLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
    areaCongestMsgLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
  }
  
  private func areaCongestLvlLabelConstraints() {
    areaCongestLvlLabel.translatesAutoresizingMaskIntoConstraints = false
    areaCongestLvlLabel.topAnchor.constraint(equalTo: areaCongestMsgLabel.bottomAnchor, constant: 3).isActive = true
    areaCongestMsgLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
    areaCongestMsgLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
  }
}
