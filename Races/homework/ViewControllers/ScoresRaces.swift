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
    
    // MARK: - Properties
    private var date = UserDefaults.standard.value(forKey: "Date") as! Date
    
    // MARK: - Outlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        datePicker.date = date
        name()
        score()
        setupTableView()
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
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .systemRed
    }
}

extension ScoresRacesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayRacesVC.dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        dateFormatter.locale = Locale(identifier: "en_us")
        let dateString = dateFormatter.string(from: date)
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(Array(PlayRacesVC.dictionary.keys)[indexPath.row])'s score: \(Array(PlayRacesVC.dictionary.values)[indexPath.row]), \(dateString)"
        cell.backgroundColor = .systemYellow
        return cell
    }
}
