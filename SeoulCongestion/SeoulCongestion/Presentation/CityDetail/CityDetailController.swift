//
//  CityDetailController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/25.
//

import UIKit
import SnapKit

class CityDetailController: UIViewController {
  
  var livePpltnStts: LIVE_PPLTN_STTS!
  var avgRoadData: AVG_ROAD_DATA!
  var sbikeStts: [SBIKE_STTS]?
  var cityNm: String?
  
  let quotationcomImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "quotationcom"))
    return iv
  }()
  
  let mainTitleLabel: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 4
    lb.font = SCFont.bold(size: 32)
    lb.textColor = SCColor.white.color
    return lb
  }()
  
  let subTitleLabel: UILabel = {
    let lb = UILabel()
    lb.numberOfLines = 2
    lb.text = "실시간 교통상황과 인구 혼잡도를\n확인할 수 있어요."
    lb.font = SCFont.regular(size: 12)
    lb.textColor = SCColor.white.color
    return lb
  }()
  
  let standardTimeView = StandardTimeView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = SCColor.black.color
    navigationController?.interactivePopGestureRecognizer?.delegate = self
    setup()
    backButton()
  }
  
  convenience init(_ city: City? = nil) {
    self.init()
    guard let city = city else { return }
    livePpltnStts = city.LIVE_PPLTN_STTS
    avgRoadData = city.AVG_ROAD_DATA
    sbikeStts = city.SBIKE_STTS
    self.cityNm = city.areaNM
    
    if let cityNm = city.areaNM {
      mainTitleLabel.text = "지금\n\(cityNm)\n에 방문하면?"
    }
  }
  
  func backButton() {
    let backButton = UIButton(type: .custom)
    backButton.setImage(UIImage(named: "backPolygon"), for: .normal)
    backButton.heightAnchor.constraint(equalToConstant: 29).isActive = true
    backButton.imageEdgeInsets = UIEdgeInsets(
      top: 0,
      left: 8,
      bottom: 0,
      right: 0
    )
    backButton.addTarget(
      self,
      action: #selector(backButtonTapped),
      for: .touchUpInside
    )
    
    let backBarButtonItem = UIBarButtonItem(customView: backButton)
    backButton.tintColor = SCColor.white.color
    navigationItem.leftBarButtonItem = backBarButtonItem
  }
  
  private func setup() {
      setUI()
    setConstraints()
    configureCollectionView()
      
  }

  private func setConstraints() {
//    subTitleLabelConstraints()
    standardTimeViewConstraints()
    collectionViewConstraints()
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // MARK: 인구 혼잡도
    collectionView.register(
      PopulationCongestionCell.self,
      forCellWithReuseIdentifier: PopulationCongestionCell.identifier
    )
    
    // MARK: 차량 혼잡도
    collectionView.register(
      RoadCongestionCell.self,
      forCellWithReuseIdentifier: RoadCongestionCell.identifier)
    
    // MARK: 따릉이
    collectionView.register(
      PublicBikeCell.self,
      forCellWithReuseIdentifier: PublicBikeCell.identifier
    )
  }
    
    func setUI() {
        [quotationcomImageView, mainTitleLabel, subTitleLabel, standardTimeView, collectionView].forEach { view.addSubview($0)}
        
        quotationcomImageView.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(66)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(quotationcomImageView.snp.bottom)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalTo(quotationcomImageView.snp.leading)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(40)
        }
    }
  
  private func standardTimeViewConstraints() {
    standardTimeView.translatesAutoresizingMaskIntoConstraints = false
    standardTimeView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 36).isActive = true
    standardTimeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = SCColor.black.color
    collectionView.topAnchor.constraint(equalTo: standardTimeView.bottomAnchor, constant: 36).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
  }
  
  
  @objc func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
}

extension CityDetailController: UICollectionViewDelegate {
  
}

extension CityDetailController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 3
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    var cell: UICollectionViewCell!
    switch indexPath.item {
    case 0:
      guard let populationCongestionCell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PopulationCongestionCell.identifier,
        for: indexPath) as? PopulationCongestionCell else { return UICollectionViewCell() }
      populationCongestionCell.population = livePpltnStts
      cell = populationCongestionCell
    case 1:
      guard let roadCongestionCell = collectionView.dequeueReusableCell(
        withReuseIdentifier: RoadCongestionCell.identifier,
        for: indexPath) as? RoadCongestionCell else { return UICollectionViewCell() }
      roadCongestionCell.road = avgRoadData
      cell = roadCongestionCell
    case 2:
      guard let publicBikeCell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PublicBikeCell.identifier,
        for: indexPath) as? PublicBikeCell else { return UICollectionViewCell()}
      publicBikeCell.bike = sbikeStts
      publicBikeCell.city = self.cityNm
      cell = publicBikeCell
    default:
      cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PopulationCongestionCell.identifier,
        for: indexPath)
    }
    return cell
  }
}

extension CityDetailController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    switch indexPath.item {
    case 0:
      return CGSize(width: view.frame.width - 80, height: 122)
    case 1:
      return CGSize(width: view.frame.width - 80, height: 122)
    case 2:
      return CGSize(width: view.frame.width - 80, height: 122)
    default:
      return CGSize(width: view.frame.width - 80 , height: 150)
    }
  }
}

extension CityDetailController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
  }

}
