//
//  ImageExtension.swift
//  GIFinity
//
//  Created by Ziyadkhan on 16.01.24.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage
extension UIImageView {
    func showImage(imageURL: String?) {
        self.sd_setImage(with: URL(string: "\(imageURL ?? "")"), placeholderImage: UIImage(named: "purple"))
    }
}
