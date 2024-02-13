//
//  ReusableAlert.swift
//  GIFinity
//
//  Created by Ziyadkhan on 13.02.24.
//

import Foundation
import UIKit

class AlertView: NSObject {
    static func showAlert(view: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        view.present(alertController, animated: true)
    }
}
