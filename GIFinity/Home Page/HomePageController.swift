//
//  HomePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit

class HomePageController: UIViewController {
    let viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        configureViewModel()
//         Do any additional setup after loading the view.
    }

}

extension HomePageController {
    
    func configureViewModel() {
        viewModel.error = { error in
            print(error)
        }
        viewModel.getItems()
        
        
    }
}
