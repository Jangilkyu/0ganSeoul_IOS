//
//  AreaCongestLvlView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/02.
//

import UIKit
import SkeletonView
import SnapKit

class AreaCongestLvlView: UIView {
  
  let popIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.isSkeletonable = true
    return iv
  }()
  
  let areaCongestLvlLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.white.color
    lb.isSkeletonable = true
    return lb
  }()

  required init() {
    super.init(frame: .zero)
    layer.masksToBounds = true
    layer.cornerRadius = 6
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
      private func setUI() {
        [popIconImageView, areaCongestLvlLabel].forEach { self.addSubview($0) }
        
        popIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(areaCongestLvlLabel.snp.leading).offset(-4.5)
        }
        
        areaCongestLvlLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalTo(popIconImageView.snp.trailing).offset(4.5)
            make.trailing.equalToSuperview().offset(10)
        }
    }
}
