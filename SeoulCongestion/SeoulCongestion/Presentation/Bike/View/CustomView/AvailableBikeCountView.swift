//
//  AvailableBikeCountView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit
import SnapKit

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
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        [availableBikeLabel, parkingBikeTotCntLabel, slashLabel, rackTotCntLabel].forEach{ self.addSubview($0)}
        
        availableBikeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        parkingBikeTotCntLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(slashLabel.snp.leading).offset(-3)
        }
        
        slashLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(rackTotCntLabel.snp.leading).offset(-3)
        }
        
        rackTotCntLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
