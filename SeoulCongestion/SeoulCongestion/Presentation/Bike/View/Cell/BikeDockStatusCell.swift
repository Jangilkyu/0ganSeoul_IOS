//
//  BikeDockStatusCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit
import SnapKit

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
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        
        [bikeRentalPlaceLabel, bikeAvlstatusLabel, bikeAvlLabel, slashLabel, bikeAvlToTLabel, underLine].forEach{ self.addSubview($0) }
        
        bikeRentalPlaceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-39)
        }
        
        bikeAvlstatusLabel.snp.makeConstraints { make in
            make.top.equalTo(bikeRentalPlaceLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        bikeAvlLabel.snp.makeConstraints { make in
            make.top.equalTo(bikeRentalPlaceLabel.snp.bottom).offset(12)
            make.leading.equalTo(bikeAvlstatusLabel.snp.trailing).offset(4)
        }
        
        slashLabel.snp.makeConstraints { make in
            make.top.equalTo(bikeRentalPlaceLabel.snp.bottom).offset(12)
            make.leading.equalTo(bikeAvlLabel.snp.trailing).offset(3)
        }
        
        bikeAvlToTLabel.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.top.equalTo(bikeRentalPlaceLabel.snp.bottom).offset(12)
            make.leading.equalTo(slashLabel.snp.trailing).offset(3)
        }
        
        underLine.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.top.equalTo(bikeAvlLabel.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview()
        }
    }
}
