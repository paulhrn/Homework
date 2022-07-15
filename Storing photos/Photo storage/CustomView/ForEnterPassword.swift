//
//  ForEnterPassword.swift
//  Photo storage
//
//  Created by p h on 14.07.2022.
//

import Foundation
import UIKit

class ContentView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    
 /* override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    } */
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("EnterPassword", owner: self)
        self.addSubview(contentView)
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
    }
}
