//
//  RoadCongestionCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/27.
//

import UIKit

class RoadCongestionCell: UICollectionViewCell {
  
  var road: AVG_ROAD_DATA? {
    didSet {
      guard let road = self.road else { return }
      roadTrafficLabel.text = road.roadTrafficIDX!
      roadTrafficSPDLabel.text = road.roadTrafficSPD!
      roadMSGLabel.text = road.roadMSG!
    }
  }
  
  let roadImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "buttonc2"))
    return iv
  }()
  
  let roadTrafficLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 18)
    lb.textColor = SCColor.black.color
    lb.numberOfLines = 3
    return lb
  }()
  
  let roadTrafficSPDLabel: UILabel = {
    let lb = UILabel()
    lb.textAlignment = .center
    lb.font = SCFont.bold(size: 14)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let KMLabel: UILabel = {
    let lb = UILabel()
    lb.text = "Km"
    lb.font = SCFont.bold(size: 14)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let roadMSGLabel: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 3
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 12.0
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
    addSubview(roadImageView)
    addSubview(roadTrafficLabel)
    addSubview(roadTrafficSPDLabel)
    addSubview(KMLabel)
    addSubview(roadMSGLabel)
  }
  
  private func setConstraints() {
    roadImageViewConstraints()
    roadTrafficLabelConstraints()
    roadTrafficSPDLabelConstraints()
    KMLabelConstraints()
    roadMSGLabelConstraints()
  }
  
  private func roadImageViewConstraints() {
    roadImageView.translatesAutoresizingMaskIntoConstraints = false
    roadImageView.heightAnchor.constraint(equalToConstant: 86).isActive = true
    roadImageView.widthAnchor.constraint(equalTo: roadImageView.heightAnchor).isActive = true
    roadImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
    roadImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
    roadImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
  }
  
  private func roadTrafficLabelConstraints() {
    roadTrafficLabel.translatesAutoresizingMaskIntoConstraints = false
    roadTrafficLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23).isActive = true
    roadTrafficLabel.leadingAnchor.constraint(equalTo: roadImageView.trailingAnchor, constant: 16).isActive = true
  }
  
  private func roadTrafficSPDLabelConstraints() {
    roadTrafficSPDLabel.translatesAutoresizingMaskIntoConstraints = false
    roadTrafficSPDLabel.widthAnchor.constraint(equalTo: roadTrafficLabel.widthAnchor).isActive = true
    roadTrafficSPDLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    roadTrafficSPDLabel.topAnchor.constraint(equalTo: roadTrafficLabel.bottomAnchor, constant: 2).isActive = true
    roadTrafficSPDLabel.leadingAnchor.constraint(equalTo: roadImageView.trailingAnchor, constant: 16).isActive = true
  }

  private func KMLabelConstraints() {
    KMLabel.translatesAutoresizingMaskIntoConstraints = false
    KMLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    KMLabel.topAnchor.constraint(equalTo: roadTrafficLabel.bottomAnchor, constant: 2).isActive = true
    //MARK: constant 수정 필요
    KMLabel.leadingAnchor.constraint(equalTo: roadTrafficSPDLabel.trailingAnchor, constant: 3).isActive = true
  }
  
  private func roadMSGLabelConstraints() {
    roadMSGLabel.translatesAutoresizingMaskIntoConstraints = false
    roadMSGLabel.topAnchor.constraint(equalTo: roadTrafficSPDLabel.bottomAnchor, constant: 2).isActive = true
//    roadMSGLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
    roadMSGLabel.leadingAnchor.constraint(equalTo: roadImageView.trailingAnchor, constant: 16).isActive = true
    roadMSGLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
  }
}
