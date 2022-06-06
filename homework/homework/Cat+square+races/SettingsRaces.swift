//
//  SettingsRaces.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class SettingsRacesVC: UIViewController {
    
    // MARK: - Private Properties
    private lazy var button = makeButton()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        button.addTarget(self, action: #selector(didTapbutton2), for: .touchUpInside)
    }
    
    // MARK: - Private Funcs
    @objc private func didTapbutton2() {
        dismiss(animated: true)
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.setTitle("< Back", for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
