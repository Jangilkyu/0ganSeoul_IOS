//
//  RoadCongestionCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/27.
//

import UIKit
import SnapKit

class RoadCongestionCell: UICollectionViewCell {
    
    static let identifier = "roadCongestionCell"
  
  var road: AVG_ROAD_DATA? {
    didSet {
      guard let road = self.road else { return }
      roadTrafficLabel.text = road.roadTrafficIDX!
      roadTrafficSPDLabel.text = road.roadTrafficSPD!
      roadMSGLabel.text = road.roadMSG!
    }
  }
  
  let roadImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "buttonc2"))
    return iv
  }()
  
  let roadTrafficLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 18)
    lb.textColor = SCColor.black.color
    lb.numberOfLines = 3
    return lb
  }()
  
  let roadTrafficSPDLabel: UILabel = {
    let lb = UILabel()
    lb.textAlignment = .center
    lb.font = SCFont.bold(size: 14)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let kmLabel: UILabel = {
    let lb = UILabel()
    lb.text = "Km"
    lb.font = SCFont.bold(size: 14)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let roadMSGLabel: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 3
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 12.0
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    private func setUI() {
        [roadImageView, roadTrafficLabel, roadTrafficSPDLabel, roadTrafficSPDLabel, kmLabel, roadMSGLabel].forEach { self.addSubview($0) }

        roadImageView.snp.makeConstraints { make in
            make.height.equalTo(86)
            make.width.equalTo(roadImageView.snp.height)
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        roadTrafficLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalTo(roadImageView.snp.trailing).offset(16)
        }
        
        roadTrafficSPDLabel.snp.makeConstraints { make in
            make.width.equalTo(roadTrafficLabel.snp.width)
            make.height.equalTo(18)
            make.top.equalTo(roadTrafficLabel.snp.bottom).offset(2)
            make.leading.equalTo(roadImageView.snp.trailing).offset(16)
        }
        
        kmLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(roadTrafficLabel.snp.bottom).offset(2)
            make.leading.equalTo(roadTrafficSPDLabel.snp.trailing).offset(3)
        }
        
        roadMSGLabel.snp.makeConstraints { make in
            make.top.equalTo(roadTrafficSPDLabel.snp.bottom).offset(2)
            make.leading.equalTo(roadImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-25)
        }
    }
}
