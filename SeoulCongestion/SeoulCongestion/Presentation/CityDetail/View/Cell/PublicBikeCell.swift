//
//  PublicBikeCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/01.
//

import UIKit
import SnapKit

class PublicBikeCell: UICollectionViewCell {
  
    static let identifier = "publicBikeCell"
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
      setUI()
      configureBikeRentalCheckButton()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        [bikeImageView, areaPublicBikeCountLabel, bikeRentalCountLabel, gotLabel, bikeRentalCheckButton].forEach { self.addSubview($0) }
        
        bikeImageView.snp.makeConstraints { make in
            make.width.equalTo(bikeImageView.snp.height)
            make.top.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        areaPublicBikeCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(bikeImageView.snp.trailing).offset(16)
        }
        
        bikeImageView.snp.makeConstraints { make in
            make.width.equalTo(bikeImageView.snp.height)
            make.top.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        areaPublicBikeCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(bikeImageView.snp.trailing).offset(16)
        }
        
        bikeRentalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(areaPublicBikeCountLabel.snp.bottom).offset(6)
            make.leading.equalTo(bikeImageView.snp.trailing).offset(16)
        }
        
        gotLabel.snp.makeConstraints { make in
            make.top.equalTo(areaPublicBikeCountLabel.snp.bottom).offset(6)
            make.leading.equalTo(bikeRentalCountLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(132)
        }
        
        bikeRentalCheckButton.snp.makeConstraints { make in
            make.top.equalTo(bikeRentalCountLabel.snp.bottom).offset(6)
            make.leading.equalTo(bikeImageView.snp.trailing).offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
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
    
}
