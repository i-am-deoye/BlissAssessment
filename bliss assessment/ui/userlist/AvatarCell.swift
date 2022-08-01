//
//  AvatarCell.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit


final class AvatarCell: UICollectionViewCell {
    static let identifier = "\(String(describing: self))"
    
    private lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 6
        imageview.layer.borderColor = UIColor.white.cgColor
        imageview.layer.borderWidth = 1.5
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    
    var avatar: User? {
        didSet {
            if let avatar = avatar {
                imageView.set(avatar.avatarUrl)
            }
        }
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
