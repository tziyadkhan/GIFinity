//
//  SearchPageCoordinator.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.03.24.
//

import Foundation
import UIKit

class SearchPageCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(SearchPageController.self)") as! SearchPageController
        navigationController.show(controller, sender: nil)
    }
}
