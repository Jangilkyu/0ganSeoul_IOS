//
//  PopulationCongestionCell.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/26.
//

import UIKit

class PopulationCongestionCell: UICollectionViewCell {
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
    setup()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func setup() {
    addViews()
    setConstraints()
  }
  
  private func addViews() {
    addSubview(populationImageView)
    addSubview(livePopulationAvgLabel)
    addSubview(populationAvgLabel)
    addSubview(malePopAvgLabel)
    addSubview(malePopAvgPerLabel)
    addSubview(femalePopAvgLabel)
    addSubview(femalePopAvgPerLabel)
    addSubview(resntPpltnLabel)
    addSubview(resntPpltnAvgLabel)
  }
  
  private func setConstraints() {
    populationImageViewConstraints()
    livePopulationAvgLabelConstraints()
    populationAvgLabelConstraints()
    malePopAvgLabelConstraints()
    malePopAvgPerLabelConstraints()
    femalePopAvgLabelConstraints()
    femalePopAvgPerLabelConstraints()
    resntPpltnLabelConstraints()
    resntPpltnAvgLabelConstraints()
  }
  
  private func populationImageViewConstraints() {
    populationImageView.translatesAutoresizingMaskIntoConstraints = false
    populationImageView.heightAnchor.constraint(equalToConstant: 86).isActive = true
    populationImageView.widthAnchor.constraint(equalTo: populationImageView.heightAnchor).isActive = true
    populationImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
    populationImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
    populationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
  }
  
  private func livePopulationAvgLabelConstraints() {
    livePopulationAvgLabel.translatesAutoresizingMaskIntoConstraints = false
    livePopulationAvgLabel.centerYAnchor.constraint(equalTo: populationAvgLabel.centerYAnchor).isActive = true
    livePopulationAvgLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23).isActive = true
    livePopulationAvgLabel.leadingAnchor.constraint(equalTo: populationImageView.trailingAnchor, constant: 16).isActive = true
  }
  
  private func populationAvgLabelConstraints() {
    populationAvgLabel.translatesAutoresizingMaskIntoConstraints = false
    populationAvgLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23).isActive = true
    populationAvgLabel.leadingAnchor.constraint(equalTo: livePopulationAvgLabel.trailingAnchor, constant: 4).isActive = true
    populationAvgLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
  }
  
  private func malePopAvgLabelConstraints() {
    malePopAvgLabel.translatesAutoresizingMaskIntoConstraints = false
    malePopAvgLabel.centerYAnchor.constraint(equalTo: malePopAvgPerLabel.centerYAnchor).isActive = true
    malePopAvgLabel.topAnchor.constraint(equalTo: livePopulationAvgLabel.bottomAnchor, constant: 1).isActive = true
    malePopAvgLabel.leadingAnchor.constraint(equalTo: populationImageView.trailingAnchor, constant: 16).isActive = true
  }
  
  private func malePopAvgPerLabelConstraints() {
    malePopAvgPerLabel.translatesAutoresizingMaskIntoConstraints = false
    malePopAvgPerLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    malePopAvgPerLabel.topAnchor.constraint(equalTo: livePopulationAvgLabel.bottomAnchor, constant: 3).isActive = true
    malePopAvgPerLabel.leadingAnchor.constraint(equalTo: malePopAvgLabel.trailingAnchor, constant: 14).isActive = true
    malePopAvgPerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
  }
  
  private func femalePopAvgLabelConstraints() {
    femalePopAvgLabel.translatesAutoresizingMaskIntoConstraints = false
    femalePopAvgLabel.centerYAnchor.constraint(equalTo: femalePopAvgPerLabel.centerYAnchor).isActive = true
    femalePopAvgLabel.topAnchor.constraint(equalTo: malePopAvgLabel.bottomAnchor, constant: 1).isActive = true
    femalePopAvgLabel.leadingAnchor.constraint(equalTo: populationImageView.trailingAnchor, constant: 16).isActive = true
  }
  
  private func femalePopAvgPerLabelConstraints() {
    femalePopAvgPerLabel.translatesAutoresizingMaskIntoConstraints = false
    femalePopAvgPerLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    femalePopAvgPerLabel.topAnchor.constraint(equalTo: malePopAvgPerLabel.bottomAnchor, constant: 3).isActive = true
    femalePopAvgPerLabel.leadingAnchor.constraint(equalTo: femalePopAvgLabel.trailingAnchor, constant: 14).isActive = true
    femalePopAvgPerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
  }
  
  private func resntPpltnLabelConstraints() {
    resntPpltnLabel.translatesAutoresizingMaskIntoConstraints = false
    resntPpltnLabel.centerYAnchor.constraint(equalTo: resntPpltnAvgLabel.centerYAnchor).isActive = true
    resntPpltnLabel.topAnchor.constraint(equalTo: femalePopAvgLabel.bottomAnchor, constant: 1).isActive = true
    resntPpltnLabel.leadingAnchor.constraint(equalTo: populationImageView.trailingAnchor, constant: 16).isActive = true
  }
  
  private func resntPpltnAvgLabelConstraints() {
    resntPpltnAvgLabel.translatesAutoresizingMaskIntoConstraints = false
    resntPpltnAvgLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    resntPpltnAvgLabel.topAnchor.constraint(equalTo: femalePopAvgPerLabel.bottomAnchor, constant: 3).isActive = true
    resntPpltnAvgLabel.leadingAnchor.constraint(equalTo: resntPpltnLabel.trailingAnchor, constant: 14).isActive = true
    resntPpltnAvgLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
  }
  
}
