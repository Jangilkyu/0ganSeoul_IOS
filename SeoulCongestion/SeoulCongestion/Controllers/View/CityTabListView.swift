//
//  CityTabListView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/08/20.
//

import UIKit

protocol CityTabListViewDelegate: AnyObject {
  func didSelectTab(_ tab: CityTab)
}

class CityTabListView: UIView {
  weak var delegate: CityTabListViewDelegate?
  
  let viewAllButton: UIButton = {
    let button = UIButton()
    button.setTitle("전체보기", for: .normal)
    button.titleLabel?.font = SCFont.bold(size: 16)
    button.isEnabled = false
    return button
  }()
  
  let culturalheritageButton: UIButton = {
    let button = UIButton()
    button.setTitle("고궁 · 문화유산", for: .normal)
    button.titleLabel?.font = SCFont.regular(size: 16)
    button.isEnabled = false
    return button
  }()
  
  let parkButton: UIButton = {
    let button = UIButton()
    button.setTitle("공원", for: .normal)
    button.titleLabel?.font = SCFont.regular(size: 16)
    button.isEnabled = false
    return button
  }()
  
  let tourismSpecialZoneButton: UIButton = {
    let button = UIButton()
    button.setTitle("관광특구", for: .normal)
    button.titleLabel?.font = SCFont.regular(size: 16)
    button.isEnabled = false
    return button
  }()
  
  let centralBusinessDistrictButton: UIButton = {
    let button = UIButton()
    button.setTitle("발달상권", for: .normal)
    button.titleLabel?.font = SCFont.regular(size: 16)
    button.isEnabled = false
    return button
  }()
  
  let denselyPopulatedAreaButton: UIButton = {
    let button = UIButton()
    button.setTitle("인구밀집지역", for: .normal)
    button.titleLabel?.font = SCFont.regular(size: 16)
    button.isEnabled = false
    return button
  }()
  
  let selectedButton: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isHidden = true
    view.layer.cornerRadius = 2
    return view
  }()
  
  
  required init() {
    super.init(frame: .zero)
    layer.cornerRadius = 5
    setup()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func setup() {
    addViews()
    setConstraints()
    
    viewAllButton.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
    culturalheritageButton.addTarget(self, action: #selector(culturalheritageButtonTapped), for: .touchUpInside)
    parkButton.addTarget(self, action: #selector(parkButtonTapped), for: .touchUpInside)
    tourismSpecialZoneButton.addTarget(self, action: #selector(tourismSpecialZoneButtonTapped), for: .touchUpInside)
    centralBusinessDistrictButton.addTarget(self, action: #selector(centralBusinessDistrictButtonTapped), for: .touchUpInside)
    denselyPopulatedAreaButton.addTarget(self, action: #selector(denselyPopulatedAreaButtonTapped), for: .touchUpInside)
  }
  
  private func addViews() {
    addSubview(viewAllButton) // 전체보기
    addSubview(culturalheritageButton) // 고궁 문화유산
    addSubview(parkButton) // 공원
    addSubview(tourismSpecialZoneButton) // 관광특구
    addSubview(centralBusinessDistrictButton) // 발달상권
    addSubview(denselyPopulatedAreaButton) // 인구밀집지역
    addSubview(selectedButton)
  }
  
  private func setConstraints() {
    viewAllButtonConstraints()
    culturalheritageButtonConstraints()
    parkButtonConstraints()
    tourismSpecialZoneButtonConstraints()
    centralBusinessDistrictButtonConstraints()
    denselyPopulatedAreaButtonConstraints()
  }
  
  private func viewAllButtonConstraints() {
    viewAllButton.translatesAutoresizingMaskIntoConstraints = false
    viewAllButton.widthAnchor.constraint(equalTo: viewAllButton.titleLabel!.widthAnchor).isActive = true
    viewAllButton.heightAnchor.constraint(equalTo: viewAllButton.titleLabel!.heightAnchor).isActive = true
    viewAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
    viewAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 39.5).isActive = true
  }
  
  private func culturalheritageButtonConstraints() {
    culturalheritageButton.translatesAutoresizingMaskIntoConstraints = false
    culturalheritageButton.widthAnchor.constraint(equalTo: culturalheritageButton.titleLabel!.widthAnchor).isActive = true
    culturalheritageButton.heightAnchor.constraint(equalTo: culturalheritageButton.titleLabel!.heightAnchor).isActive = true
    culturalheritageButton.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
    culturalheritageButton.leadingAnchor.constraint(equalTo: viewAllButton.trailingAnchor, constant: 18).isActive = true
  }
  
  private func parkButtonConstraints() {
    parkButton.translatesAutoresizingMaskIntoConstraints = false
    parkButton.widthAnchor.constraint(equalTo: parkButton.titleLabel!.widthAnchor).isActive = true
    parkButton.heightAnchor.constraint(equalTo: parkButton.titleLabel!.heightAnchor).isActive = true
    parkButton.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
    parkButton.leadingAnchor.constraint(equalTo: culturalheritageButton.trailingAnchor, constant: 18).isActive = true
      if UIScreen.main.nativeBounds.size.width >= 1284 {
      parkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -88.5).isActive = true
      } else if UIScreen.main.nativeBounds.size.width >= 1170 {
        parkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50.5).isActive = true
      } else {
      parkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39.5).isActive = true
    }
  }
  
  private func tourismSpecialZoneButtonConstraints() {
    tourismSpecialZoneButton.translatesAutoresizingMaskIntoConstraints = false
    tourismSpecialZoneButton.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 15).isActive = true
    tourismSpecialZoneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
    tourismSpecialZoneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
  }
  
  private func centralBusinessDistrictButtonConstraints() {
    centralBusinessDistrictButton.translatesAutoresizingMaskIntoConstraints = false
    centralBusinessDistrictButton.topAnchor.constraint(equalTo: culturalheritageButton.bottomAnchor, constant: 15).isActive = true
    centralBusinessDistrictButton.leadingAnchor.constraint(equalTo: tourismSpecialZoneButton.trailingAnchor, constant: 18).isActive = true
    centralBusinessDistrictButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
  }
  
  private func denselyPopulatedAreaButtonConstraints() {
    denselyPopulatedAreaButton.translatesAutoresizingMaskIntoConstraints = false
    denselyPopulatedAreaButton.topAnchor.constraint(equalTo: parkButton.bottomAnchor, constant: 15).isActive = true
    denselyPopulatedAreaButton.leadingAnchor.constraint(equalTo: centralBusinessDistrictButton.trailingAnchor, constant: 18).isActive = true
    denselyPopulatedAreaButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
  }
  
  @objc private func viewAllButtonTapped() {
    delegate?.didSelectTab(.viewAll)
    updateSelectedButtonPosition(anchorView: viewAllButton)
    
  }
  
  @objc private func culturalheritageButtonTapped() {
    delegate?.didSelectTab(.culturalheritage)
    updateSelectedButtonPosition(anchorView: culturalheritageButton)
  }
  
  @objc private func parkButtonTapped() {
    delegate?.didSelectTab(.park)
    updateSelectedButtonPosition(anchorView: parkButton)
  }
  
  @objc private func specialTouristZoneButtonTapped() {
    delegate?.didSelectTab(.specialTouristZone)
    updateSelectedButtonPosition(anchorView: tourismSpecialZoneButton)
  }
  
  @objc private func tourismSpecialZoneButtonTapped() {
    delegate?.didSelectTab(.specialTouristZone)
    updateSelectedButtonPosition(anchorView: tourismSpecialZoneButton)
  }
  
  @objc private func centralBusinessDistrictButtonTapped() {
    delegate?.didSelectTab(.centralBusinessDistrict)
    updateSelectedButtonPosition(anchorView: centralBusinessDistrictButton)
  }
  
  @objc private func denselyPopulatedAreaButtonTapped() {
    delegate?.didSelectTab(.denselyPopulatedArea)
    updateSelectedButtonPosition(anchorView: denselyPopulatedAreaButton)
    
  }
  
  private func updateSelectedButtonPosition(anchorView: UIButton) {
    selectedButton.isHidden = false
    selectedButton.frame = CGRect(
      x: anchorView.frame.origin.x,
      y: anchorView.frame.origin.y + anchorView.frame.size.height,
      width: anchorView.frame.size.width,
      height: 3
    )
    
    anchorView.titleLabel?.font = SCFont.bold(size: 16)
    
    let allButtons = [
      viewAllButton,
      culturalheritageButton,
      parkButton,
      tourismSpecialZoneButton,
      centralBusinessDistrictButton,
      denselyPopulatedAreaButton
    ]
    
    for button in allButtons {
      if button != anchorView {
        button.titleLabel?.font = SCFont.regular(size: 16)
      }
    }
  }
  
  func enableAllTabButtons() {
      viewAllButton.isEnabled = true
      culturalheritageButton.isEnabled = true
      parkButton.isEnabled = true
      tourismSpecialZoneButton.isEnabled = true
      centralBusinessDistrictButton.isEnabled = true
      denselyPopulatedAreaButton.isEnabled = true
  }
}
