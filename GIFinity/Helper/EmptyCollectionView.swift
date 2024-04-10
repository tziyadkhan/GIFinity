//
//  EmptyCollectionView.swift
//  GIFinity
//
//  Created by Ziyadkhan Taghiyev on 10.04.24.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(image: UIImage?) {
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            let xPosition = (containerView.bounds.width - image.size.width) / 2
            let yPosition = (containerView.bounds.height - image.size.height) / 3
            imageView.frame = CGRect(x: xPosition, y: yPosition, width: image.size.width, height: image.size.height)
            
            containerView.addSubview(imageView)
        }
        self.backgroundView = containerView
    }

    func restore() {
        self.backgroundView = nil
    }
}
