//
//  CityCountView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/18.
//

import UIKit
import SkeletonView
import SnapKit

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
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    func setUI() {
        [totLabel ,cityCntLabel ,gotLabel].forEach { self.addSubview($0) }
        
        totLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        cityCntLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(totLabel.snp.trailing).offset(4)
        }
        
        gotLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(cityCntLabel.snp.trailing).offset(3)
        }
    }
}
