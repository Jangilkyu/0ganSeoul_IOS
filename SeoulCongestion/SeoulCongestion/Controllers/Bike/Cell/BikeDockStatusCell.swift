//
//  BikeDockStatusCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit

class BikeDockStatusCell: UICollectionViewCell {

  let bikeRentalPlaceLabel: UILabel = {
    let lb = UILabel()
    lb.textColor = SCColor.black.color
    lb.font = SCFont.bold(size: 15)
    return lb
  }()
  
  let bikeAvlstatusLabel: UILabel = {
    let lb = UILabel()
    lb.text = "잔여 현황"
    lb.textColor = SCColor.bikeGray.color
    lb.font = SCFont.bold(size: 15)
    return lb
  }()
  
  let bikeAvlLabel: UILabel = {
    let lb = UILabel()
    lb.textColor = SCColor.blue.color
    lb.font = SCFont.bold(size: 15)
    return lb
  }()
  
  let slashLabel: UILabel = {
    let lb = UILabel()
    lb.text = "/"
    lb.textColor = SCColor.black.color
    lb.font = SCFont.medium(size: 15)
    return lb
  }()
  
  let bikeAvlToTLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.medium(size: 15)
    lb.textColor = SCColor.black.color
    return lb
  }()
  
  let underLine: UIView = {
      let view = UIView()
      view.backgroundColor = .black
      return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
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
    addSubview(bikeRentalPlaceLabel)
    addSubview(bikeAvlstatusLabel)
    addSubview(bikeAvlLabel)
    addSubview(slashLabel)
    addSubview(bikeAvlToTLabel)
    addSubview(underLine)
  }
  
  private func setConstraints() {
    bikeRentalPlaceLabelConstraints()
    bikeAvlstatusLabelConstraints()
    bikeAvlLabelConstraints()
    slashLabelConstraints()
    bikeAvlToTLabelConstraints()
    underLineConstraints()
  }
  
  private func bikeRentalPlaceLabelConstraints() {
    bikeRentalPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
    bikeRentalPlaceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
    bikeRentalPlaceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    bikeRentalPlaceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39).isActive = true
  }
  
  private func bikeAvlstatusLabelConstraints() {
    bikeAvlstatusLabel.translatesAutoresizingMaskIntoConstraints = false
    bikeAvlstatusLabel.topAnchor.constraint(equalTo: bikeRentalPlaceLabel.bottomAnchor, constant: 12).isActive = true
    bikeAvlstatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    bikeAvlstatusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
  }
  
  private func bikeAvlLabelConstraints() {
    bikeAvlLabel.translatesAutoresizingMaskIntoConstraints = false
    bikeAvlLabel.topAnchor.constraint(equalTo: bikeRentalPlaceLabel.bottomAnchor, constant: 12).isActive = true
    bikeAvlLabel.leadingAnchor.constraint(equalTo: bikeAvlstatusLabel.trailingAnchor, constant: 4).isActive = true
  }
  
  private func slashLabelConstraints() {
    slashLabel.translatesAutoresizingMaskIntoConstraints = false
    slashLabel.topAnchor.constraint(equalTo: bikeRentalPlaceLabel.bottomAnchor, constant: 12).isActive = true
    slashLabel.leadingAnchor.constraint(equalTo: bikeAvlLabel.trailingAnchor, constant: 3).isActive = true
  }
  
  private func bikeAvlToTLabelConstraints() {
    bikeAvlToTLabel.translatesAutoresizingMaskIntoConstraints = false
    bikeAvlToTLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    bikeAvlToTLabel.topAnchor.constraint(equalTo: bikeRentalPlaceLabel.bottomAnchor, constant: 12).isActive = true
    bikeAvlToTLabel.leadingAnchor.constraint(equalTo: slashLabel.trailingAnchor, constant: 3).isActive = true
  }
  
  private func underLineConstraints() {
    underLine.translatesAutoresizingMaskIntoConstraints = false
    underLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
    underLine.topAnchor.constraint(equalTo: bikeAvlToTLabel.bottomAnchor, constant: 17).isActive = true
    underLine.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    underLine.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }

}
