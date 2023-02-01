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
  var cityList: [City] = []
  private let seoulCityInfoDict: [String] = [
    "강남 MICE 관광특구",
    "동대문 관광특구",
    "명동 관광특구",
    "이태원 관광특구",
    "잠실 관광특구",
    "종로·청계 관광특구",
    "홍대 관광특구",
    "경복궁·서촌마을",
    "광화문·덕수궁",
    "창덕궁·종묘",
    "가산디지털단지역",
    "강남역",
    "건대입구역",
    "고속터미널역",
    "교대역",
    "구로디지털단지역",
    "서울역",
    "선릉역",
    "신도림역",
    "신림역",
    "신촌·이대역",
    "역삼역",
    "연신내역",
    "용산역",
    "왕십리역",
    "DMC(디지털미디어시티)",
    "창동 신경제 중심지",
    "노량진",
    "낙산공원·이화마을",
    "북촌한옥마을",
    "가로수길",
    "성수카페거리",
    "수유리 먹자골목",
    "쌍문동 맛집거리",
    "압구정로데오거리",
    "여의도",
    "영등포 타임스퀘어",
    "인사동·익선동",
    "국립중앙박물관·용산가족공원",
    "남산공원",
    "뚝섬한강공원",
    "망원한강공원",
    "반포한강공원",
    "북서울꿈의숲",
    "서울대공원",
    "서울숲공원",
    "월드컵공원",
    "이촌한강공원",
    "잠실종합운동장",
    "잠실한강공원"
  ]
  
  let mainTitleLabel: UILabel = {
    let lb = UILabel()
    lb.text = "서울시 도시 현황"
    lb.font = SCFont.bold(size: 20)
    return lb
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
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchSeoulCityCongestion(cityDict: seoulCityInfoDict)
  }
  
  func fetchSeoulCityCongestion(cityDict: [String]) {
    
    for city in cityDict {
      let seoulCityCnt = self.seoulCityInfoDict.count
      var currentCityNum = 0
      
      RestProcessor.shared.requestSeoulCityInfo(cityID: city) { result in
        switch result {
        case .success(let cityInfoRes):
          self.cityList.append(cityInfoRes)
          currentCityNum = self.cityList.count
          print(currentCityNum)
          if currentCityNum % seoulCityCnt == 0 {
            print("seoulCityCnt % currentCityNum", seoulCityCnt % currentCityNum)
            DispatchQueue.main.async {
              self.collectionView.reloadData()
              self.collectionView.stopSkeletonAnimation()
              self.collectionView.hideSkeleton(reloadDataAfter: true)
            }
          }
        case .failure(_):
          print("실패")
        }
      }
    }
  }
  
  private func setup() {
    addViews()
    setConstraints()
    configureCollectionView()
    configureSkeletonView()
  }
  
  private func addViews() {
    view.addSubview(mainTitleLabel)
    view.addSubview(collectionView)
  }
  
  private func setConstraints() {
    mainTitleLabelConstraints()
    collectionViewConstraints()
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MainCell.self, forCellWithReuseIdentifier: mainCellId)
  }
  
  private func configureSkeletonView() {
    collectionView.isSkeletonable = true
    collectionView.showAnimatedSkeleton()
  }
  
  private func mainTitleLabelConstraints() {
    mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor).isActive = true
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
    return self.cityList.count
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
    let city = cityList[indexPath.item]
    cell.city = city
    
    DispatchQueue.main.async {
      cell.imageView.image = UIImage(named: city.areaNm!)
    }
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
    return CGSize(width: view.frame.width - 20, height: 160)
  }
}
