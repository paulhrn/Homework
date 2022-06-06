//
//  RacesViewController.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class RacesVC: UIViewController {
    
    // MARK: - Private Properties
    private lazy var button = makeButton()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Actions
    @objc private func didTapbutton2() {
        dismiss(animated: true)
    }
    
    @IBAction func PlayButton(_ sender: UIButton) {
        play()
    }
    
    @IBAction func ScoresButton(_ sender: UIButton) {
        scores()
    }
    
    @IBAction func SettingsButton(_ sender: UIButton) {
        settings()
    }
    
    // MARK: - Private Funcs
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.setTitle("< Back", for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    private func play() {
        let storyboard = UIStoryboard(name: "Races", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayRacesV")
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        present(viewController, animated: true)
    }
    
    private func scores() {
        let storyboard = UIStoryboard(name: "Races", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScoresRacesV")
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        present(viewController, animated: true)
    }
    
    private func settings() {
        let storyboard = UIStoryboard(name: "Races", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsRacesV")
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        present(viewController, animated: true)
    }
}

