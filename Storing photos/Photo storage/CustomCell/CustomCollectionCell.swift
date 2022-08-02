//
//  CustomCollectionCell.swift
//  01.08
//
//  Created by p h on 01.08.2022.
//

import Foundation
import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static var reuseIdentifier = String(describing: CustomCollectionCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setImageView(with image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
    }
}
