//
//  DropDownView.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/09/07.
//

import UIKit
import DropDown
import SnapKit

class DropDownView: UIView {
  
  var citiesData: [City] = []
  weak var mainController: MainController?
  
  let dropDownView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    view.layer.cornerRadius = 8
    return view
  }()
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "가나다 순"
    label.textColor = SCColor.black.color
    label.font = SCFont.regular(size: 16)
    return label
  }()
  
  let arrowImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(named: "arrow"))
    return iv
  }()
  
  let dropdown = DropDown()
  let itemList = ["가나다 순", "인구 혼잡도 순"]
  
  required init() {
    super.init(frame: .zero)
    setDropDown()
    setup()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  private func setup() {
    addViews()
      setUI()
  }
  
  private func addViews() {
    addSubview(dropDownView)
    addSubview(label)
    addSubview(arrowImageView)
  }
    
    func setUI() {
        [dropDownView ,label ,arrowImageView].forEach { self.addSubview($0) }
        
        dropDownView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(dropDownView.snp.top).offset(5)
            make.bottom.equalTo(dropDownView.snp.bottom).offset(-5)
            make.leading.equalTo(dropDownView.snp.leading).offset(7)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-60)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.equalTo(dropDownView.snp.top).offset(9)
            make.bottom.equalTo(dropDownView.snp.bottom).offset(-8)
            make.trailing.equalTo(dropDownView.snp.trailing).offset(-11)
        }
    }
  
  private func setDropDown() {
    DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
    DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
    DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
    DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
    DropDown.appearance().setupCornerRadius(8)
    dropdown.dismissMode = .automatic
    dropdown.dataSource = itemList
    dropdown.anchorView = self.dropDownView
    dropdown.bottomOffset = CGPoint(x: 0, y: dropDownView.bounds.height + 34)
  }
  
  func setupTapGestureRecognizer() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc private func handleTap(_ sender: UITapGestureRecognizer) {
    dropdown.selectionAction = { [weak self] (index, item) in
      self!.mainController?.updateCollectionViewWithSelectedString(item)
      self!.label.text = item
    }
    self.dropdown.show()
  }
}
