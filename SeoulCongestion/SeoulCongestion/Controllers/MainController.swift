//
//  MainController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit

class MainController: UIViewController {
  
  fileprivate let mainCellId = "mainCellId"
  
  let mainTitleLabel: UILabel = {
    let lb = UILabel()
    lb.text = "서울시 혼잡도"
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
  private func setup() {
    addViews()
    setConstraints()
    configureCollectionView()
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

extension MainController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: mainCellId,
      for: indexPath) as? MainCell else { return UICollectionViewCell() }
    return cell
  }
  
}

extension MainController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collecitonView: UICollectionView,
    layout collectionVIewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
}
