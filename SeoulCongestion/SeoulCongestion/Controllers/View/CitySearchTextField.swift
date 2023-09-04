//
//  CitySearchTextField.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/12.
//

import UIKit
import Lottie

class CitySearchTextField: UIView {
  
  enum State {
    case initial
    case loading
    case success
  }
  
  var buttonState: State = .initial {
    didSet {
      switch self.buttonState {
      case .loading:
        let lottieView = LottieAnimationView(name: "loading")
         lottieView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
         lottieView.loopMode = .loop
         lottieView.play()
         textField.rightView = lottieView
         textField.rightViewMode = .always
      case .success:
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        textField.rightView = searchButton
        textField.rightViewMode = .always
      default:
        return
      }
    }
  }

  let lottieView: LottieAnimationView = LottieAnimationView()
  
  let textField: UITextField = {
    let tf = UITextField()
    tf.autocapitalizationType = .none
    tf.layer.borderWidth = 3.0
    tf.layer.borderColor = UIColor.black.cgColor
    tf.addLeftPadding()
    tf.font = SCFont.semiBold(size: 24)
    return tf
  }()
  
  let searchButton: UIButton = {
      let btn = UIButton()
      let originalImage = UIImage(named: "search")
      let resizedImage = originalImage?.resized(to: CGSize(width: 20, height: 20))
      btn.setImage(resizedImage, for: .normal)
      btn.imageView?.contentMode = .scaleAspectFit
      btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
      btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
      return btn
  }()

  
  func playLottie(
    _ animation: LottieAnimation?,
    toProgress: AnimationProgressTime,
    loopMode: LottieLoopMode,
    completion: LottieCompletionBlock? = nil)
  {
    lottieView.isHidden = false
    
    lottieView.play(
      fromProgress: 0,
      toProgress: toProgress,
      loopMode: loopMode,
      completion: completion
    )
  }
  
  required init() {
    super.init(frame: .zero)
    addViews()
    setConstraints()
    configureLottie()
    textField.rightView = searchButton
    textField.rightViewMode = .always
    textField.layer.cornerRadius = 3
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func addViews() {
    addSubview(textField)
    addSubview(lottieView)
  }
  
  private func setConstraints() {
    textFieldConstraints()
  }
  
  private func configureLottie() {
    lottieView.isHidden = true
    lottieView.backgroundColor = .white
  }
  
  private func textFieldConstraints() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
    textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
  }
}
