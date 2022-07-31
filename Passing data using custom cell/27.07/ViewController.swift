//
//  ViewController.swift
//  27.07
//
//  Created by p h on 27.07.2022.
//

import UIKit

class ViewController: UIViewController, ColorDelegate {
    
    // MARK: - Properties
    private var colors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple] {
        didSet {
            tableView.reloadData()
        }
    }
    private var names = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupNib()
    }
    
    // MARK: - Funcs
    func color(color: UIColor) {
        view.backgroundColor = color
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .systemOrange
        tableView.layer.cornerRadius = 10
        tableView.backgroundView = UIImageView(image: UIImage(named: "Gradient"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    private func setupNib() {
        let cell = UINib(nibName: "CustomCelll", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "CustomCelll")
    }
}

// MARK: - Extensions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCelll", for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setLabel(with: "\(names[indexPath.row % names.count])")
        cell.myButton.backgroundColor = colors[indexPath.row % colors.count]
        //        cell.callback = { color in
        //            self.view.backgroundColor = color
        //        }
        cell.colorDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
