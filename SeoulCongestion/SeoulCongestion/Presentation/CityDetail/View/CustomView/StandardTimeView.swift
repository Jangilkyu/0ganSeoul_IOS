//
//  StandardTimeView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/25.
//

import UIKit
import SnapKit

class StandardTimeView: UIView {
  
  let timeLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.regular(size: 15)
    lb.textColor = SCColor.white.color
    return lb
  }()
  
  required init() {
    super.init(frame: .zero)
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
    }
}
