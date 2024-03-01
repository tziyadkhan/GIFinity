//
//  Coordinator.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.03.24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
