//
//  CustomCell.swift
//  27.07
//
//  Created by p h on 27.07.2022.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    // MARK: - Properties
    //    var callback: ((UIColor) -> ())?
    weak var colorDelegate: ColorDelegate?
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    // MARK: - Funcs
    @IBAction func myButtonTap(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            sender.setTitle("✅", for: .selected)
            sender.superview?.backgroundColor = sender.backgroundColor
            //            callback?(myButton.backgroundColor ?? .white)
            colorDelegate?.color(color: myButton.backgroundColor ?? .white)
        } else {
            sender.isSelected = false
            sender.setTitle("Tap me!", for: .normal)
            sender.superview?.backgroundColor = .white
        }
    }
    
    func setLabel(with string: String) {
        myLabel.text = string
    }
    
    func setButton(color: UIColor) {
        myButton.backgroundColor = color
    }
}
