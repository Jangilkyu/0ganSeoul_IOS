//
//  EmptyView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/23.
//

import UIKit
import SnapKit

class EmptyView: UIView {
  
  let emptyImageView : UIImageView = {
    let iv = UIImageView(image: UIImage(named: "empty"))
    return iv
  }()
  
  required init() {
    super.init(frame: .zero)
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    func setUI() {
        [emptyImageView].forEach { self.addSubview($0) }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
