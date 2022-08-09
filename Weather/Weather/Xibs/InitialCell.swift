//
//  InitialCell.swift
//  Simple Weather
//
//  Created by p h on 05.08.2022.
//

import Foundation
import UIKit

class InitialCell: UITableViewCell {
    static let reuseIdentifier = String(describing: InitialCell.self)
    
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
