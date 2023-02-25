//
//  CityCountView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/18.
//

import UIKit
import SkeletonView

class CityCountView: UIView {
  
  let totLabel: UILabel = {
    let lb = UILabel()
    lb.text = "총"
    lb.font = SCFont.Regular.of(size: 18)
    return lb
  }()
  
  let cityCntLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 26)
    lb.isSkeletonable = true
    return lb
  }()
  
  let gotLabel: UILabel = {
    let lb = UILabel()
    lb.text = "곳"
    lb.font = SCFont.regular(size: 18)
    return lb
  }()
  
  required init() {
    super.init(frame: .zero)

    addViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func addViews() {
    addSubview(totLabel)
    addSubview(cityCntLabel)
    addSubview(gotLabel)
  }
  
  private func setConstraints() {
    totLabelConstraints()
    cityCntLabelConstraints()
    gotLabelConstraints()
  }
  
  private func totLabelConstraints() {
    totLabel.translatesAutoresizingMaskIntoConstraints = false
    totLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    totLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    totLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
  }
  
  private func cityCntLabelConstraints() {
    cityCntLabel.translatesAutoresizingMaskIntoConstraints = false
    cityCntLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    cityCntLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    cityCntLabel.leadingAnchor.constraint(equalTo: totLabel.trailingAnchor, constant: 4).isActive = true
  }
  
  private func gotLabelConstraints() {
    gotLabel.translatesAutoresizingMaskIntoConstraints = false
    gotLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    gotLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    gotLabel.leadingAnchor.constraint(equalTo: cityCntLabel.trailingAnchor, constant: 3).isActive = true
  }
}
