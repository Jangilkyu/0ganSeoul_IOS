//
//  PublicBikeCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/01.
//

import UIKit

class PublicBikeCell: UICollectionViewCell {
  
  var areaNm: String?
  
  var bike: [SBIKE_STTS]? {
    didSet {
      guard let bike = self.bike else { return }
      bikeRentalCountLabel.text = "\(bike.count)"
      if bike.count == 0 {
        bikeRentalCheckButton.isHidden = true
      }
    }
  }
  
  var city: String? {
    didSet {
      self.areaNm = city
    }
  }
  
  let bikeImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "buttonc1"))
    return iv
  }()
  
  let areaPublicBikeCountLabel: UILabel = {
    let lb = UILabel()
    lb.text = "지역 따릉이 대여소 수"
    lb.font = SCFont.semiBold(size: 14)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let bikeRentalCountLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 16)
    lb.textColor = SCColor.black.color
    return lb
  }()
  
  let gotLabel: UILabel = {
    let lb = UILabel()
    lb.text = "곳"
    lb.font = SCFont.bold(size: 16)
    lb.textColor = SCColor.black.color
    return lb
  }()
  
  let bikeRentalCheckButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("대여소 확인하러가기", for: .normal)
    btn.backgroundColor = SCColor.blue.color
    btn.titleLabel?.font = SCFont.bold(size: 12)
    btn.layer.cornerRadius = 4.0
    return btn
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
    configureBikeRentalCheckButton()
  }
  
  private func addViews() {
    addSubview(bikeImageView)
    addSubview(areaPublicBikeCountLabel)
    addSubview(bikeRentalCountLabel)
    addSubview(gotLabel)
    addSubview(bikeRentalCheckButton)
  }
  
  private func setConstraints() {
    bikeImageViewConstraints()
    areaPublicBikeCountLabelConstraints()
    bikeRentalCountLabelConstraints()
    gotLabelConstraints()
    bikeRentalCheckButtonConstraints()
  }
  
  private func configureBikeRentalCheckButton() {
    bikeRentalCheckButton.addTarget(
      self,
      action: #selector(handleBikeRentalCheckButton),
      for: .touchUpInside
    )
  }
  
  @objc private func handleBikeRentalCheckButton() {
    let cityDetailController = BikeInfoController(bike,areaNm)
    guard let navController = self.window?.rootViewController as? UINavigationController else {
        fatalError("Unable to get navigation controller")
    }
    navController.pushViewController(cityDetailController, animated: true)
  }
  
  private func bikeImageViewConstraints() {
    bikeImageView.translatesAutoresizingMaskIntoConstraints = false
    bikeImageView.widthAnchor.constraint(equalTo: bikeImageView.heightAnchor).isActive = true
    bikeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
    bikeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
    bikeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
    bikeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
  }
  private func areaPublicBikeCountLabelConstraints() {
    areaPublicBikeCountLabel.translatesAutoresizingMaskIntoConstraints = false
    areaPublicBikeCountLabel.topAnchor.constraint(equalTo: topAnchor,constant: 24).isActive = true
    areaPublicBikeCountLabel.leadingAnchor.constraint(equalTo: bikeImageView.trailingAnchor, constant: 16).isActive = true
  }
  
  private func bikeRentalCountLabelConstraints() {
    bikeRentalCountLabel.translatesAutoresizingMaskIntoConstraints = false
    bikeRentalCountLabel.topAnchor.constraint(equalTo: areaPublicBikeCountLabel.bottomAnchor, constant: 6).isActive = true
    bikeRentalCountLabel.leadingAnchor.constraint(equalTo: bikeImageView.trailingAnchor, constant: 16).isActive = true
  }
  private func gotLabelConstraints() {
    gotLabel.translatesAutoresizingMaskIntoConstraints = false
    gotLabel.topAnchor.constraint(equalTo: areaPublicBikeCountLabel.bottomAnchor, constant: 6).isActive = true
    gotLabel.leadingAnchor.constraint(equalTo: bikeRentalCountLabel.trailingAnchor, constant: 6).isActive = true
    gotLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 132).isActive = true
  }
  
  private func bikeRentalCheckButtonConstraints() {
    bikeRentalCheckButton.translatesAutoresizingMaskIntoConstraints = false
    bikeRentalCheckButton.topAnchor.constraint(equalTo: bikeRentalCountLabel.bottomAnchor ,constant: 6).isActive = true
    bikeRentalCheckButton.leadingAnchor.constraint(equalTo: bikeImageView.trailingAnchor, constant: 16).isActive = true
    bikeRentalCheckButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    bikeRentalCheckButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
  }
}
