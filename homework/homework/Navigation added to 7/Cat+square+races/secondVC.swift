//
//  secondVC.swift
//  homework
//
//  Created by p h on 25.05.2022.


import UIKit

class secondVC: UIViewController {
    
    // MARK: - Private Properties
    private var square = UIView()
    private let points = 100
    
    private enum MyColor: String, CaseIterable {
        case firstColor = "red"
        case secondColor = "blue"
        case thirdColor = "yellow"
        case fourthColor = "green"
        case fifthColor = "magenta"
        case sixthColor = "orange"
        case seventhColor = "cyan"
        case eighthColor = "brown"
        case ninthColor = "gray"
        
        var color: UIColor {
            switch self {
            case .firstColor:
                return UIColor.red
            case .secondColor:
                return UIColor.blue
            case .thirdColor:
                return UIColor.yellow
            case .fourthColor:
                return UIColor.green
            case .fifthColor:
                return UIColor.magenta
            case .sixthColor:
                return UIColor.orange
            case .seventhColor:
                return UIColor.cyan
            case .eighthColor:
                return UIColor.brown
            case .ninthColor:
                return UIColor.gray
            }
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var buttonLooks: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8916817563, green: 0.9905012619, blue: 1, alpha: 1)
        
    }
    // MARK: - Actions
    @IBAction func buttonDoes(_ sender: UIButton) {
        fillDisplay()
    }
    
    
    // MARK: - Private Funcs
    private func fillDisplay() {
        for everyX in 0...Int(view.frame.maxX / CGFloat(points)) {
            for everyY in 0...Int(view.frame.maxY / CGFloat(points)) {
                
                let element = MyColor.allCases.randomElement()!
                
                let label = UILabel()
                label.frame = CGRect(x: everyX * points, y: everyY * points, width: points, height: points)
                label.backgroundColor = element.color
                label.textAlignment = .center
                label.text = element.rawValue
                label.textColor = .black
                label.font = label.font.withSize(20)
                view.addSubview(label)
            }
        }
        view.bringSubviewToFront(buttonLooks)
    }
}
