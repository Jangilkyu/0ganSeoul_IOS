//
//  BikeAverageUtilizationRateView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit

class BikeAverageUtilizationRateView: UIView {
  
  let avgUTLRateLabel: UILabel = {
    let lb = UILabel()
    lb.text = "평균 거치율"
    lb.font = SCFont.bold(size: 15)
    lb.textColor = SCColor.black.color
    return lb
  }()
  
  let utilizationRateLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 15)
    lb.textColor = SCColor.black.color
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.masksToBounds = true
    layer.cornerRadius = 4.0
    backgroundColor = .white
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
    addSubview(avgUTLRateLabel)
    addSubview(utilizationRateLabel)
  }
  
  private func setConstraints() {
    avgUTLRateLabelConstraints()
    utilizationRateLabelConstraints()
  }
  
  private func avgUTLRateLabelConstraints() {
    avgUTLRateLabel.translatesAutoresizingMaskIntoConstraints = false
    avgUTLRateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    avgUTLRateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23).isActive = true
    avgUTLRateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
  }
  
  private func utilizationRateLabelConstraints() {
    utilizationRateLabel.translatesAutoresizingMaskIntoConstraints = false
    utilizationRateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    utilizationRateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    utilizationRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19).isActive = true
  }
}
