//
//  ScoresRaces.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

// MARK: - Singleton
class ManageScores {
    static let set = ManageScores(name: "user", score: 0)
    var name: String
    var score: Int
    
    private init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}

// MARK: - VC class
class ScoresRacesVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScore: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        name()
        score()
    }
    
    // MARK: - Private Funcs
    private func name() {
        let name = UserDefaults.standard.value(forKey: "Name") as? String
        if let name = name {
            ManageScores.set.name = name
        }
        userName.text = "Hi, \(ManageScores.set.name)!"
        if userName.text == "Hi, !" {
            userName.text = "Hi, user!"
        }
    }
    
    private func score() {
        let score = UserDefaults.standard.value(forKey: "Score") as? Int
        if let score = score {
            ManageScores.set.score = score - 1
        }
        userScore.text = "Current score is: \(ManageScores.set.score)"
    }
}
