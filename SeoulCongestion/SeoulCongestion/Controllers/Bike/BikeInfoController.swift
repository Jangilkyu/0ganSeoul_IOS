//
//  BikeInfoController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/03/07.
//

import UIKit

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
    setup()
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
  
  private func setup() {
    addViews()
    setConstraints()
    configureCollectionView()
  }
  
  private func addViews() {
    view.addSubview(bikeImageView)
    view.addSubview(bikeMainTitle)
    view.addSubview(availableBikeCountView)
    view.addSubview(bikeAverageUtilizationRateView)
    view.addSubview(collectionView)
  }
  
  private func setConstraints() {
    bikeImageViewConstraints()
    bikeMainTitleConstraints()
    bikeAvailabilityRateViewConstraints()
    bikeAverageUtilizationRateViewConstraints()
    collectionViewConstraints()
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

  
  private func bikeImageViewConstraints() {
    bikeImageView.translatesAutoresizingMaskIntoConstraints = false
    bikeImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    bikeImageView.widthAnchor.constraint(equalTo: bikeImageView.heightAnchor).isActive = true
    bikeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    bikeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
  }
  
  private func bikeMainTitleConstraints() {
    bikeMainTitle.translatesAutoresizingMaskIntoConstraints = false
    bikeMainTitle.topAnchor.constraint(equalTo: bikeImageView.bottomAnchor).isActive = true
    bikeMainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    bikeMainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -91).isActive = true
  }
  
  private func bikeAvailabilityRateViewConstraints() {
    availableBikeCountView.translatesAutoresizingMaskIntoConstraints = false
    availableBikeCountView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    availableBikeCountView.topAnchor.constraint(equalTo: bikeMainTitle.bottomAnchor, constant: 15).isActive = true
    availableBikeCountView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    availableBikeCountView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
  }
  
  private func bikeAverageUtilizationRateViewConstraints() {
    bikeAverageUtilizationRateView.translatesAutoresizingMaskIntoConstraints = false
    bikeAverageUtilizationRateView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    bikeAverageUtilizationRateView.topAnchor.constraint(equalTo: availableBikeCountView.bottomAnchor, constant: 12).isActive = true
    bikeAverageUtilizationRateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    bikeAverageUtilizationRateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: bikeAverageUtilizationRateView.bottomAnchor, constant: 15).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
