//
//  BikeAverageUtilizationRateView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit
import SnapKit

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
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        [avgUTLRateLabel, utilizationRateLabel].forEach{ self.addSubview($0) }
        
        avgUTLRateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(23)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        utilizationRateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-6)
            make.trailing.equalToSuperview().offset(-19)
        }
    }
}
