//
//  CellWeekForecast.swift
//  Simple Weather
//
//  Created by p h on 05.08.2022.
//

import Foundation
import UIKit

class CellWeekForecast: UITableViewCell {
    static let xib = "CelllWeekForecast"
    static let reuseIdentifier = String(describing: CellWeekForecast.self)
    
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
