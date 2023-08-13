//
//  AvailableBikeCountView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit

class AvailableBikeCountView: UIView {
  
  let availableBikeLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 15)
    lb.textColor = SCColor.white.color
    lb.text = "잔여 대여수"
    return lb
  }()
  
  let parkingBikeTotCntLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 15)
    lb.textColor = SCColor.white.color
    return lb
  }()
  
  let slashLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.medium(size: 15)
    lb.textColor = SCColor.black.color
    lb.text = "/"
    return lb
  }()
  
  let rackTotCntLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.medium(size: 15)
    lb.textColor = SCColor.black.color
    return lb
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.masksToBounds = true
    layer.cornerRadius = 4.0
    backgroundColor = .gray
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
    addSubview(availableBikeLabel)
    addSubview(parkingBikeTotCntLabel)
    addSubview(slashLabel)
    addSubview(rackTotCntLabel)
  }
  
  private func setConstraints() {
    availableBikeLabelConstraints()
    parkingBikeTotCntLabelConstraints()
    slashLabelConstraints()
    rackTotCntLabelConstraints()
  }
  private func availableBikeLabelConstraints() {
    availableBikeLabel.translatesAutoresizingMaskIntoConstraints = false
    availableBikeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    availableBikeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23).isActive = true
    availableBikeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
  }
  
  private func parkingBikeTotCntLabelConstraints() {
    parkingBikeTotCntLabel.translatesAutoresizingMaskIntoConstraints = false
    parkingBikeTotCntLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    parkingBikeTotCntLabel.trailingAnchor.constraint(equalTo: slashLabel.leadingAnchor, constant: -3).isActive = true
  }
  
  private func slashLabelConstraints() {
    slashLabel.translatesAutoresizingMaskIntoConstraints = false
    slashLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    slashLabel.trailingAnchor.constraint(equalTo: rackTotCntLabel.leadingAnchor, constant: -3).isActive = true
  }
  
  private func rackTotCntLabelConstraints() {
    rackTotCntLabel.translatesAutoresizingMaskIntoConstraints = false
    rackTotCntLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    rackTotCntLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
  }
}
