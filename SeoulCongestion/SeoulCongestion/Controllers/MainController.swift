//
//  MainController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit
import SkeletonView

class MainController: UIViewController {
  fileprivate let mainCellId = "mainCellId"
  var seoulCities: SeoulCities!
  var cityList: [City] = []
  var api: RestProcessor!
  var resHandler: ResHandler!
  
  let logoImageView : UIImageView = {
    let iv = UIImageView(image: UIImage(named: "logo"))
    return iv
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout)
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    // API fetch begins
    api = RestProcessor()
    api.reqeustDelegate = self
    getCitiesAPIInfo()
    setup()
  }
  
  private func setup() {
    addViews()
    setConstraints()
    configureCollectionView()
    configureSkeletonView()
  }
  
  private func getCitiesAPIInfo() {
    api.makeRequest(
      toURL: EndPoint.seoulCitiesData.url,
      withHttpMethod: .get,
      usage: .seoulCitiesData
    )
  }
  
  private func addViews() {
    view.addSubview(logoImageView)
    view.addSubview(collectionView)
  }
  
  private func setConstraints() {
    logoImageViewConstraints()
    collectionViewConstraints()
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MainCell.self, forCellWithReuseIdentifier: mainCellId)
  }
  
  private func configureSkeletonView() {
    collectionView.isSkeletonable = true
    let skeletonAnimation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    self.collectionView.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.lightGray, .gray]), animation: skeletonAnimation, transition: .none)
  }
  
  private func logoImageViewConstraints() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.heightAnchor.constraint(equalToConstant: 81).isActive = true
    logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
    logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -112).isActive = true
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
}

extension MainController: UICollectionViewDelegate {
  
}

extension MainController: SkeletonCollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return self.seoulCities == nil ? 0 : self.seoulCities.getNumberOfCities()
  }
  
  func collectionSkeletonView(
    _ skeletonView: UICollectionView,
    cellIdentifierForItemAt indexPath: IndexPath
  ) -> SkeletonView.ReusableCellIdentifier {
    return mainCellId
  }
  
  func collectionSkeletonView(
    _ skeletonView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return UICollectionView.automaticNumberOfSkeletonItems
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: mainCellId,
      for: indexPath) as? MainCell else { return UICollectionViewCell() }
    guard let cities = self.seoulCities else { return UICollectionViewCell() }
    let city = cities.getCity()
    
    cell.city = city?[indexPath.item]
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
    let image = UIImage(named: city?[indexPath.item].areaNM ?? "")
    imageView.image = image
    
    let gradientViewFrame = imageView.frame;
    imageView.addGradient(frame: gradientViewFrame)
    cell.backgroundView = UIView()
    cell.backgroundView!.addSubview(imageView)
    return cell
  }
  
  
  func collectionSkeletonView(
    _ skeletonView: UICollectionView,
    skeletonCellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell? {
    skeletonView.dequeueReusableCell(withReuseIdentifier: mainCellId, for: indexPath)
  }
}

extension MainController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collecitonView: UICollectionView,
    layout collectionVIewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: view.frame.width - 80, height: 165)
  }
}

extension MainController: RestProcessorRequestDelegate {
  
  func didReceiveResponseFromDataTask(
    _ result: RestProcessor.Results,
    _ usage: EndPoint
  ) {
    resHandler = ResHandler(result: result)
    switch resHandler.getResult() {
    case .ok(_, let data):
      if let data = data,
         let citiesData = try? JSONDecoder().decode([Cities].self, from: data) {
        
        self.seoulCities = SeoulCities(citiesData)
        
        DispatchQueue.main.async {
          self.collectionView.reloadData()
          self.collectionView.hideSkeleton()
        }
      }
    default:
      break
    }
  }
  
  func didFailToPrepareRequest(
    _ result: RestProcessor.Results,
    _ usage: EndPoint
  ) {
    
  }
}
