//
//  MainController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/25.
//

import UIKit
import SkeletonView
import Lottie

class MainController: UIViewController {
  fileprivate let mainCellId = "mainCellId"
  var seoulCities: SeoulCities!
  var api: RestProcessor!
  var resHandler: ResHandler!
    
  let logoImageView : UIImageView = {
    let iv = UIImageView(image: UIImage(named: "logo"))
    return iv
  }()
  
  let citySearchTextField = CitySearchTextField()
  
  let cityCountView = CityCountView()
  
  let emptyView = EmptyView()
  
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
    emptyView.isHidden = true
    self.citySearchTextField.textField.isEnabled = false
    configureTFDelegate()
    
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
    configureSearchButton()
  }
  
  private func getCitiesAPIInfo() {
    api.makeRequest(
      toURL: EndPoint.seoulCitiesData.url,
      withHttpMethod: .get,
      usage: .seoulCitiesData
    )
  }
  
  private func configureTFDelegate() {
    self.citySearchTextField.textField.delegate = self
  }
  
  private func addViews() {
    view.addSubview(logoImageView)
    view.addSubview(citySearchTextField)
    view.addSubview(cityCountView)
    view.addSubview(collectionView)
    view.addSubview(emptyView)
  }
  
  private func setConstraints() {
    logoImageViewConstraints()
    citySearchTextFieldConstraints()
    cityCountViewConstraints()
    collectionViewConstraints()
    emptyViewConstraints()
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
  
  private func configureSearchButton() {
    citySearchTextField.searchButton.addTarget(
      self,
      action: #selector(handleSearchButton),
      for: .touchUpInside
    )
  }
  
  @objc func handleSearchButton() {
    getCitiesSearchAPI()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  private func getCitiesSearchAPI() {
    guard let searchCities = self.citySearchTextField.textField.text?.trimmingCharacters(in: .whitespaces) else { return }
    if searchCities.count == 0{
      DispatchQueue.main.async {
        let alert = UIAlertController(title: nil, message: "지역을 입력 해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
      }
    } else {
      self.citySearchTextField.buttonState = .loading
      self.citySearchTextField.textField.isEnabled = false
      api.urlQueryParameters.add(
        value: searchCities,
        forKey: "searchId"
      )
      
      api.makeRequest(
        toURL: EndPoint.search.url,
        withHttpMethod: .get,
        usage: .search
      )
    }
  }
  
  private func logoImageViewConstraints() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.heightAnchor.constraint(equalToConstant: 81).isActive = true
    logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
    logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -112).isActive = true
  }
  
  private func citySearchTextFieldConstraints() {
    citySearchTextField.translatesAutoresizingMaskIntoConstraints = false
    citySearchTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
    citySearchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 25).isActive = true
    citySearchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    citySearchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
  }
  
  private func cityCountViewConstraints() {
    cityCountView.translatesAutoresizingMaskIntoConstraints = false
    cityCountView.topAnchor.constraint(equalTo: citySearchTextField.bottomAnchor, constant: 32).isActive = true
    cityCountView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: cityCountView.bottomAnchor, constant: 32).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func emptyViewConstraints() {
    emptyView.translatesAutoresizingMaskIntoConstraints = false
    emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive =  true
    emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

//    emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 121).isActive = true
//    emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -121).isActive = true
  }
  
}

extension MainController: UICollectionViewDelegate {
  
}

extension MainController: SkeletonCollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    if self.seoulCities == nil {
      return 0
    }
    
    if self.seoulCities.getNumberOfCities() == 0 {
      emptyView.isHidden = false
      collectionView.isHidden = true
      return 0
    } else {
      emptyView.isHidden = true
      collectionView.isHidden = false
      return self.seoulCities.getNumberOfCities()
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    view.endEditing(true)
    let city = self.seoulCities.getOneCenter(at: indexPath)
    let cityDetailController = CityDetailController(city)
    navigationController?.pushViewController(cityDetailController, animated: true)
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
    if (usage == .seoulCitiesData) {
      switch resHandler.getResult() {
      case .ok(_, let data):
        if let data = data,
           let citiesData = try? JSONDecoder().decode([Cities].self, from: data) {
          self.seoulCities = SeoulCities(citiesData)
          
          guard let tot = self.seoulCities.cities[0].cities?.count else { return }
          
          DispatchQueue.main.async {
            self.cityCountView.cityCntLabel.text = String(tot)
            self.collectionView.reloadData()
            self.collectionView.hideSkeleton()
            self.citySearchTextField.textField.isEnabled = true
          }
        }
      default:
        break
      }
    } else if (usage == .search) {
      switch resHandler.getResult() {
      case .ok(_, let data):
        if let data = data,
           let citiesData = try? JSONDecoder().decode([City].self, from: data) {
          self.seoulCities.setCity(city: citiesData)
          
          guard let tot = self.seoulCities.cities[0].cities?.count else { return }
          
          DispatchQueue.main.async {
            self.citySearchTextField.buttonState = .success
            self.cityCountView.cityCntLabel.text = String(tot)
            self.citySearchTextField.textField.isEnabled = true
            self.collectionView.reloadData()
          }
        }
        
      default:
        break
      }
    }
  }
  
  func didFailToPrepareRequest(
    _ result: RestProcessor.Results,
    _ usage: EndPoint
  ) {
    
  }
}

extension MainController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    getCitiesSearchAPI()
    textField.resignFirstResponder()
    return true
  }
}
