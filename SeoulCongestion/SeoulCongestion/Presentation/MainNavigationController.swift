//
//  MainNavigationController.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/25.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        viewControllers = [MainController()]
    }
}
