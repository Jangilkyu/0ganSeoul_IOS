//
//  MainCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit
import SkeletonView
import SnapKit

class MainCell: UICollectionViewCell {
  static let identifier = "mainCellId"
  var city: City? {
    didSet {
      guard let city = self.city else { return print("city가 없습니다.")}
      self.areaNmLabel.text = city.areaNM
      
      guard let areaCongestLvl = city.LIVE_PPLTN_STTS?.areaCongestLvl else { return }
      areaCongestLvlView.areaCongestLvlLabel.text = "인구 \(areaCongestLvl)"
      
      switch areaCongestLvl {
      case "여유":
        self.areaCongestLvlView.backgroundColor = SCColor.green.color
        let image = UIImage(named: "p01")
        self.areaCongestLvlView.popIconImageView.image = image
      case "보통":
        self.areaCongestLvlView.backgroundColor = SCColor.yellow.color
        let image = UIImage(named: "p02")
        self.areaCongestLvlView.popIconImageView.image = image
      case "약간 붐빔":
        self.areaCongestLvlView.backgroundColor = SCColor.orange.color
        let image = UIImage(named: "p03")
        self.areaCongestLvlView.popIconImageView.image = image
      case "붐빔":
        self.areaCongestLvlView.backgroundColor = SCColor.red.color
        let image = UIImage(named: "p04")
        self.areaCongestLvlView.popIconImageView.image = image
      default:
        break
      }
      
      guard let roadTrafficIDX = city.AVG_ROAD_DATA?.roadTrafficIDX else { return }
      roadTrafficView.roadTrafficLabel.text = "차량 \(roadTrafficIDX)"
      
      switch roadTrafficIDX {
      case "원활":
        self.roadTrafficView.backgroundColor = SCColor.green.color
        let image = UIImage(named: "car01")
        self.roadTrafficView.carIconImageView.image = image
      case "서행":
        self.roadTrafficView.backgroundColor = SCColor.yellow.color
        let image = UIImage(named: "car02")
        self.roadTrafficView.carIconImageView.image = image
      case "정체":
        self.roadTrafficView.backgroundColor = SCColor.red.color
        let image = UIImage(named: "car04")
        self.roadTrafficView.carIconImageView.image = image
      default:
        break
      }
    }
  }
  
  let areaNmLabel: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.semiBold(size: 30)
    lb.textColor = SCColor.white.color
    lb.numberOfLines = 0
    return lb
  }()
  
  let areaCongestLvlView = AreaCongestLvlView()
  
  let roadTrafficView = RoadTrafficView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonAttribute(at: self)
    commonAttribute(at: areaNmLabel)
    commonAttribute(at: areaCongestLvlView)
    commonAttribute(at: roadTrafficView)
    setup()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func setup() {
    layer.masksToBounds = true
    layer.cornerRadius = 12
      setUI()
  }
  
  private func commonAttribute(at targetView: UIView) {
    targetView.isSkeletonable = true
  }
    
    private func setUI() {
        [areaNmLabel, areaCongestLvlView, roadTrafficView].forEach { self.addSubview($0) }
        
        areaNmLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        areaCongestLvlView.snp.makeConstraints { make in
            make.top.equalTo(areaNmLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-22)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalTo(roadTrafficView.snp.leading).offset(-12)
        }
        
        roadTrafficView.snp.makeConstraints { make in
            make.width.equalTo(areaCongestLvlView.snp.width)
            make.top.equalTo(areaNmLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-22)
            make.leading.equalTo(areaCongestLvlView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-41)
        }
    }
}
