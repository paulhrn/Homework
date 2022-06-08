//
//  RacesViewController.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class RacesVC: UIViewController {
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    private func play() {
        let storyboard = UIStoryboard(name: "Races", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayRacesV")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func scores() {
        let storyboard = UIStoryboard(name: "Races", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScoresRacesV")
        navigationController?.pushViewController(viewController, animated: true)    }
    
    private func settings() {
        let storyboard = UIStoryboard(name: "Races", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsRacesV")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

