//
//  RatioLabelView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/22.
//

import UIKit
import SnapKit

class RatioLabelView: UIView {
  
    let lb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .right
        lb.textColor = SCColor.white.color
        lb.font = SCFont.bold(size: 12)
        return lb
    }()
  
  required init(bgColor: SCColor) {
    super.init(frame: .zero)
    self.clipsToBounds = true
    self.layer.cornerRadius = 2.0
    backgroundColor = bgColor.color
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        [lb].forEach { self.addSubview($0) }
        lb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        lb.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lb.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true

        lb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
    }
}
