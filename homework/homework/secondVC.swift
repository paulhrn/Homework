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
    @IBOutlet weak var buttonLook: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8916817563, green: 0.9905012619, blue: 1, alpha: 1)
        
    }
    // MARK: - Actions
    @IBAction func buttonDo(_ sender: UIButton) {
        fillDisplay()
    }
    
    // MARK: - Private Funcs
    private func fillDisplay() {
        for everyX in 0...Int(view.frame.maxX / CGFloat(points)) {
            for everyY in 0...Int(view.frame.maxY / CGFloat(points)) {
                
                //Creating multiple UIViews
                let square = UIView()
                square.frame = CGRect(x: everyX * points, y: everyY * points, width: points, height: points)
                square.backgroundColor = MyColor.allCases.randomElement()!.color
                view.addSubview(square)
                
                //Creating multiple UILabels
                let label = UILabel()
                label.frame = square.frame
                label.textAlignment = .center
                if square.backgroundColor == MyColor.firstColor.color {
                    label.text = MyColor.firstColor.rawValue
                }
                else if square.backgroundColor == MyColor.secondColor.color {
                    label.text = MyColor.secondColor.rawValue
                }
                else if square.backgroundColor == MyColor.thirdColor.color {
                    label.text = MyColor.thirdColor.rawValue
                }
                else if square.backgroundColor == MyColor.fourthColor.color {
                    label.text = MyColor.fourthColor.rawValue
                }
                else if square.backgroundColor == MyColor.fifthColor.color {
                    label.text = MyColor.fifthColor.rawValue
                }
                else if square.backgroundColor == MyColor.sixthColor.color {
                    label.text = MyColor.sixthColor.rawValue
                }
                else if square.backgroundColor == MyColor.seventhColor.color {
                    label.text = MyColor.seventhColor.rawValue
                }
                else if square.backgroundColor == MyColor.eighthColor.color {
                    label.text = MyColor.eighthColor.rawValue
                }
                else if square.backgroundColor == MyColor.ninthColor.color {
                    label.text = MyColor.ninthColor.rawValue
                }
                label.textColor = .black
                label.font = label.font.withSize(20)
                view.addSubview(label)
            }
        }
        view.bringSubviewToFront(buttonLook)
    }
}
