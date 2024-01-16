//
//  GifsCollectionCell.swift
//  GIFinity
//
//  Created by Ziyadkhan on 16.01.24.
//

import UIKit

class GifsCollectionCell: UICollectionViewCell {
    static let identifier = "GifsCollectionCell"
    
     let gifImage: UIImageView = {
        let gif = UIImageView()
        gif.contentMode = .scaleAspectFill
        gif.backgroundColor = .red
         gif.layer.cornerRadius = 5
         gif.layer.masksToBounds = true
        return gif
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(gifImage)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gifImage.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImage.image = nil
    }
    
    func configure(image: String) {
        gifImage.image = UIImage(named: image)
    }
}
