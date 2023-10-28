//
//  BikeInfoController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit
import SnapKit

class BikeInfoController: UIViewController {
  var sbike: [SBIKE_STTS]!
  
  fileprivate let bikeDockStatusCell = "BikeDockStatusCell"
  
  let bikeImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "graybicycle"))
    return iv
  }()
  
  let bikeMainTitle: UILabel = {
    let lb = UILabel()
    lb.font = SCFont.bold(size: 32)
    lb.textColor = SCColor.white.color
    lb.numberOfLines = 3
    lb.text = "강남 MICE 관광특구 따릉이 거치현황"
    return lb
  }()
  
  let availableBikeCountView = AvailableBikeCountView()
  let bikeAverageUtilizationRateView = BikeAverageUtilizationRateView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout)
    cv.layer.cornerRadius = 12.0
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = SCColor.black.color
      setUI()
      backButton()
      configureCollectionView()
  }
  
  convenience init(_ bike: [SBIKE_STTS]? = nil, _ city: String? = nil) {
    self.init()
    self.sbike = bike
    
    self.bikeMainTitle.text = "\(city!)에\n따릉이 거치현황"
    
    let totalParkingCount = sbike.reduce(0) { result, bike in
      return result + (Int(bike.parkingCnt!) ?? 0)
    }
    
    availableBikeCountView.parkingBikeTotCntLabel.text = "\(totalParkingCount)"
    
    let rackCnt = sbike.reduce(0) { result, bike in
      return result + (Int(bike.rackCnt!) ?? 0)
    }
    availableBikeCountView.rackTotCntLabel.text = "\(rackCnt)"
    
    let shared = sbike.reduce(0) { result, bike in
      return result + (Int(bike.shared!) ?? 0)
    }
    
    let bikeAvg = Int(shared / sbike.count)
    
    bikeAverageUtilizationRateView.utilizationRateLabel.text = "\(bikeAvg)%"
  }
    
    private func setUI() {
        [bikeImageView, bikeMainTitle, availableBikeCountView, bikeAverageUtilizationRateView, collectionView].forEach{ view.addSubview($0) }
        
        bikeImageView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(bikeImageView.snp.height)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        bikeMainTitle.snp.makeConstraints { make in
            make.top.equalTo(bikeImageView.snp.bottom)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-91)
        }
        
        availableBikeCountView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(bikeMainTitle.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        } 
        
        bikeAverageUtilizationRateView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(availableBikeCountView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        } 
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bikeAverageUtilizationRateView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
  
  @objc func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.setContentOffset(.zero, animated: true)

    collectionView.register(
      BikeDockStatusCell.self,
      forCellWithReuseIdentifier: bikeDockStatusCell
    )
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let yOffset = scrollView.contentOffset.y
      if yOffset < 0 {
          scrollView.contentOffset = CGPoint(x: 0, y: 0)
      }
  }
}

extension BikeInfoController: UICollectionViewDelegate {
  
}

extension BikeInfoController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return self.sbike.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: bikeDockStatusCell,
      for: indexPath) as? BikeDockStatusCell else { return UICollectionViewCell()
    }
    cell.bikeRentalPlaceLabel.text = sbike[indexPath.row].spotName
    cell.bikeAvlLabel.text = sbike[indexPath.row].parkingCnt
    cell.bikeAvlToTLabel.text = sbike[indexPath.row].rackCnt
    
    switch sbike.count {
    case 0:
      cell.underLine.isHidden = false
    case _ where indexPath.row == sbike.count-1:
      cell.underLine.isHidden = true
    default:
      cell.underLine.isHidden = false
    }
    
    return cell
  }
}

extension BikeInfoController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: view.frame.width - 80, height: 100)
  }
}
