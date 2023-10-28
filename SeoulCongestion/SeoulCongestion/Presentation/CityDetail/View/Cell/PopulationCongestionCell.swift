//
//  PopulationCongestionCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/26.
//

import UIKit
import SnapKit

class PopulationCongestionCell: UICollectionViewCell {
    
    static let identifier = "populationCongestionCell"
  var areaPpltnMIN = 0
  var areaPpltnMAX = 0
  
  var population: LIVE_PPLTN_STTS? {
    didSet {
      guard let population = self.population else { return }
      
      if let areaPpltnMAX = population.areaPpltnMAX, let areaPpltnMAX = Int(areaPpltnMAX) {
        self.areaPpltnMAX = areaPpltnMAX
      }
      
      if let areaPpltnMIN = population.areaPpltnMIN, let areaPpltnMIN = Int(areaPpltnMIN) {
        self.areaPpltnMIN = areaPpltnMIN
      }
      
      let popAvg = (self.areaPpltnMIN + self.areaPpltnMAX) / 2
      
      populationAvgLabel.lb.text = "\(popAvg.formattedComma)명"
      
      if let malePpltnRATE = population.malePpltnRATE {
        malePopAvgPerLabel.lb.text = "\(malePpltnRATE)%"
      }
      
      if let femalePpltnRATE = population.femalePpltnRATE {
        femalePopAvgPerLabel.lb.text = "\(femalePpltnRATE)%"
      }
      
      if let resntPpltnRATE = population.resntPpltnRATE {
        resntPpltnAvgLabel.lb.text =  "\(resntPpltnRATE)%"
      }
    }
  }
  
  let populationImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "buttonc3"))
    return iv
  }()
  
  let livePopulationAvgLabel: UILabel = {
    let lb = UILabel()
    lb.text = "실시간 인구 평균"
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  lazy var populationAvgLabel = RatioLabelView(bgColor: .black)
  
  let malePopAvgLabel: UILabel = {
    let lb = UILabel()
    lb.text = "남성 인구 비율"
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let malePopAvgPerLabel = RatioLabelView(bgColor: .blue)
  
  let femalePopAvgLabel: UILabel = {
    let lb = UILabel()
    lb.text = "여성 인구 비율"
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let femalePopAvgPerLabel = RatioLabelView(bgColor: .blue)
  
  let resntPpltnLabel: UILabel = {
    let lb = UILabel()
    lb.text = "상주 인구 비율"
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.blue.color
    return lb
  }()
  
  let resntPpltnAvgLabel = RatioLabelView(bgColor: .blue)

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 12.0
      setUI()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
    
    func setUI() {
        [populationImageView, livePopulationAvgLabel, populationAvgLabel, malePopAvgLabel, malePopAvgPerLabel, femalePopAvgLabel, femalePopAvgPerLabel, resntPpltnLabel, resntPpltnAvgLabel].forEach { self.addSubview($0)}
        
        populationImageView.snp.makeConstraints { make in
            make.height.equalTo(86)
            make.width.equalTo(populationImageView.snp.height)
            make.top.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        livePopulationAvgLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalTo(populationImageView.snp.trailing).offset(16)
            make.centerY.equalTo(populationAvgLabel.snp.centerY)
        }
        
        populationAvgLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalTo(livePopulationAvgLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        malePopAvgLabel.snp.makeConstraints { make in
            make.top.equalTo(livePopulationAvgLabel.snp.bottom).offset(1)
            make.leading.equalTo(populationImageView.snp.trailing).offset(16)
            make.centerY.equalTo(malePopAvgPerLabel.snp.centerY)
        }
        
        malePopAvgPerLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(livePopulationAvgLabel.snp.bottom).offset(3)
            make.leading.equalTo(malePopAvgLabel.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        femalePopAvgLabel.snp.makeConstraints { make in
            make.centerY.equalTo(femalePopAvgPerLabel.snp.centerY)
            make.top.equalTo(malePopAvgLabel.snp.bottom).offset(1)
            make.leading.equalTo(populationImageView.snp.trailing).offset(16)
        }
        
        femalePopAvgPerLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(malePopAvgPerLabel.snp.bottom).offset(3)
            make.leading.equalTo(femalePopAvgLabel.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        resntPpltnLabel.snp.makeConstraints { make in
            make.centerY.equalTo(resntPpltnAvgLabel.snp.centerY)
            make.top.equalTo(femalePopAvgLabel.snp.bottom).offset(1)
            make.leading.equalTo(populationImageView.snp.trailing).offset(16)
        }
    
        resntPpltnAvgLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(femalePopAvgPerLabel.snp.bottom).offset(3)
            make.leading.equalTo(resntPpltnLabel.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
