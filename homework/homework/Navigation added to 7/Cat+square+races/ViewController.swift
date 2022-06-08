//
//  ViewController.swift
//  homework
//
//  Created by p h on 06.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Actions
    @IBAction func CatButton(_ sender: UIButton) {
        showCatGame()
    }
    
    @IBAction func SquaresButton(_ sender: UIButton) {
        showSquares()
    }
    
    @IBAction func RacesButton(_ sender: UIButton) {
        toRaces()
    }
    
    // MARK: - Private Funcs
    private func showSquares() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "2ndVC")
        viewController.modalPresentationStyle = .automatic
        viewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(viewController, animated: true)
    }
    private func showCatGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "3rdVC")
        viewController.modalPresentationStyle = .automatic
        viewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(viewController, animated: true)
    }
    private func toRaces() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Races", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RacesVC1")
        newViewController.modalPresentationStyle = .overFullScreen
        newViewController.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(newViewController, animated: true)
    }
}

