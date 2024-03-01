//
//  SelectedItemCoordinator.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.03.24.
//

import Foundation
import UIKit

class SelectedItemCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(item: SelectedGifModel) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(SelectedItemPageController.self)") as! SelectedItemPageController
        controller.selectedItem = item
        navigationController.show(controller, sender: nil)
    }
    
    
}
