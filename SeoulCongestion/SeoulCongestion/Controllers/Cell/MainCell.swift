//
//  MainCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit
import SkeletonView

class MainCell: UICollectionViewCell {
  
  var city: City? {
    didSet {
      guard let city = self.city else { return }
      self.areaNmLabel.text = city.areaNm
      guard let areaCongestLvl = city.areaCongestLvl else { return }
      
      switch areaCongestLvl {
        case "여유":
          self.areaCongestLvlLabel.textColor = .gray
        case "보통":
          self.areaCongestLvlLabel.textColor = .green
        case "약간 붐빔":
          self.areaCongestLvlLabel.textColor = .orange
        case "매우 붐빔":
          self.areaCongestLvlLabel.textColor = .red
        default:
          break
      }

      self.areaCongestLvlLabel.text = areaCongestLvl
      self.areaCongestMsgLabel.text = city.areaCongestMsg
      self.roadTrafficIdxLabel.text = city.roadTrafficIdx
      self.roadMSGLabel.text = city.roadMSG
    }
  }
  
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
    lb.font = SCFont.thin(size: 11)
    lb.numberOfLines = 3
    return lb
  }()
  
  let populationCongestionLabel: UILabel = {
    let lb = UILabel()
    lb.text = "인구 혼잡도"
    lb.font = SCFont.semiBold(size: 13)
    return lb
  }()
  
  let areaCongestLvlLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.semiBold(size: 13)
    return lb
  }()
  
  let trafficCongestionLabel: UILabel = {
    let lb = UILabel()
    lb.text = "차량 혼잡도"
    lb.font = SCFont.semiBold(size: 13)
    return lb
  }()
  
  let roadTrafficIdxLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.semiBold(size: 13)
    return lb
  }()
  
  let roadMSGLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.thin(size: 11)
    lb.numberOfLines = 3
    return lb
  }()
  
  let mainHoriLine: UIView = {
    let line = UIView()
    line.backgroundColor = SCColor.lightGray.color
    return line
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func setup() {
    setSkeletonView()
    addViews()
    setConstraints()
  }
  
  private func addViews() {
    addSubview(imageView)
    addSubview(areaNmLabel)
    addSubview(populationCongestionLabel)
    addSubview(areaCongestLvlLabel)
    addSubview(areaCongestMsgLabel)
    addSubview(trafficCongestionLabel)
    addSubview(roadTrafficIdxLabel)
    addSubview(roadMSGLabel)
    addSubview(mainHoriLine)
  }
  
  private func setConstraints() {
    imageViewConstraints()
    areaNmLabelConstraints()
    populationCongestionLabelConstraints()
    areaCongestLvlLabelConstraints()
    areaCongestMsgLabelConstraints()
    trafficCongestionLabelConstraints()
    roadTrafficIdxLabelConstraints()
    roadMSGLabelConstraints()
    mainHoriLineConstraints()
  }
  
  private func setSkeletonView() {
    self.isSkeletonable = true
    self.contentView.isSkeletonable = true
    self.imageView.isSkeletonable = true
    self.areaNmLabel.isSkeletonable = true
    self.areaCongestLvlLabel.isSkeletonable = true
    self.areaCongestMsgLabel.isSkeletonable = true
  }
  
  private func imageViewConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
    imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
    imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  private func areaNmLabelConstraints() {
    areaNmLabel.translatesAutoresizingMaskIntoConstraints = false
    areaNmLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    areaNmLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
  }
  
  private func populationCongestionLabelConstraints() {
    populationCongestionLabel.translatesAutoresizingMaskIntoConstraints = false
    populationCongestionLabel.topAnchor.constraint(equalTo: areaNmLabel.bottomAnchor, constant: 5).isActive = true
    populationCongestionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
  }
  
  private func areaCongestLvlLabelConstraints() {
    areaCongestLvlLabel.translatesAutoresizingMaskIntoConstraints = false
    areaCongestLvlLabel.topAnchor.constraint(equalTo: areaNmLabel.bottomAnchor, constant: 5).isActive = true
    areaCongestLvlLabel.leadingAnchor.constraint(equalTo: populationCongestionLabel.trailingAnchor, constant: 3).isActive = true
  }
  
  private func areaCongestMsgLabelConstraints() {
    areaCongestMsgLabel.translatesAutoresizingMaskIntoConstraints = false
    areaCongestMsgLabel.topAnchor.constraint(equalTo: areaCongestLvlLabel.bottomAnchor, constant: 3).isActive = true
    areaCongestMsgLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
    areaCongestMsgLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
  }
  
  private func trafficCongestionLabelConstraints() {
    trafficCongestionLabel.translatesAutoresizingMaskIntoConstraints = false
    trafficCongestionLabel.topAnchor.constraint(equalTo: areaCongestMsgLabel.bottomAnchor, constant: 3).isActive = true
    trafficCongestionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
  }
  
  private func roadTrafficIdxLabelConstraints() {
    roadTrafficIdxLabel.translatesAutoresizingMaskIntoConstraints = false
    roadTrafficIdxLabel.topAnchor.constraint(equalTo: areaCongestMsgLabel.bottomAnchor, constant: 3).isActive = true
    roadTrafficIdxLabel.leadingAnchor.constraint(equalTo: trafficCongestionLabel.trailingAnchor, constant: 3).isActive = true
  }
  
  private func roadMSGLabelConstraints() {
    roadMSGLabel.translatesAutoresizingMaskIntoConstraints = false
    roadMSGLabel.topAnchor.constraint(equalTo: roadTrafficIdxLabel.bottomAnchor).isActive = true
    roadMSGLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
    roadMSGLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
  }
  
  private func mainHoriLineConstraints() {
    mainHoriLine.translatesAutoresizingMaskIntoConstraints = false
    mainHoriLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    mainHoriLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    mainHoriLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    mainHoriLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
  }
  
}
