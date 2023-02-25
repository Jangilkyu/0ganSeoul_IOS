//
//  EmptyView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/23.
//

import UIKit

class EmptyView: UIView {
  
  let emptyImageView : UIImageView = {
    let iv = UIImageView(image: UIImage(named: "empty"))
    return iv
  }()
  
  required init() {
    super.init(frame: .zero)

    addViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func addViews() {
    addSubview(emptyImageView)
  }
  
  private func setConstraints() {
    emptyImageViewConstraints()
  }
  
  private func emptyImageViewConstraints() {
    emptyImageView.translatesAutoresizingMaskIntoConstraints = false
//    emptyImageView.heightAnchor.constraint(equalToConstant: 94).isActive = true
    emptyImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    emptyImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    emptyImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    emptyImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  
}
