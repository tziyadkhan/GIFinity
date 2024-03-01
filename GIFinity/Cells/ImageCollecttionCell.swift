//
//  GifsCollectionCell.swift
//  GIFinity
//
//  Created by Ziyadkhan on 16.01.24.
//

import UIKit

class ImageCollecttionCell: UICollectionViewCell {
    static let identifier = "ImageCollecttionCell"
    
    let gifImage: UIImageView = {
        let gif = UIImageView()
        gif.layer.cornerRadius = 5
        gif.layer.masksToBounds = true
        gif.contentMode = .scaleAspectFill
        gif.translatesAutoresizingMaskIntoConstraints = false
        return gif
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    fileprivate func configureConstraint() {
        addSubview(gifImage)
        NSLayoutConstraint.activate([
            gifImage.topAnchor.constraint(equalTo: topAnchor),
            gifImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            gifImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            gifImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(image: String) {
        gifImage.showImage(imageURL: image)
    }
}
