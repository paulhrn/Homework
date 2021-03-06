//
//  ViewController.swift
//  homework
//
//  Created by p h on 06.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private Properties
    private let swipe = UISwipeGestureRecognizer()
    private var calculator = Calculator()
    
    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var topview: UIView!
    
    // Buttons for func 'digits'
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    // Buttons for func 'operations'
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var positivenegative: UIButton!
    @IBOutlet weak var percent: UIButton!
    
    // Button for func 'erase'
    @IBOutlet weak var ACButton: UIButton!
    
    // Button for func 'results'
    @IBOutlet weak var resultButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeButtonsRound()
        swipe.addTarget(self, action: #selector(move))
        topview.addGestureRecognizer(swipe)
    }
    
    // MARK: - Actions
    // @objc function works only for integers
    @objc private func move() {
        guard let results = Float(resultLabel.text!) else { return }
        let new = results.truncatingRemainder(dividingBy: 10)
        let new1 = (results - new) / 10
        resultLabel.text = String(new1)
    }
    
    @IBAction func digits(_ sender: Any) {
        guard let results = resultLabel.text, let titleLabels = (sender as! UIButton).titleLabel!.text else { return }
        if resultLabel.text == "0" {
            resultLabel.text = titleLabels
        }
        else if titleLabels == "." && results.contains(".") {
            resultLabel.text = resultLabel.text
        }
        else {
            resultLabel.text = results + titleLabels
        }
    }
    
    @IBAction func operations(_ sender: UIButton) {
        guard let titleLabels = sender.titleLabel!.text, let results = Float(resultLabel.text!) else { return }
        calculator.input = results
        switch titleLabels {
        case "??":
            calculator.eachCase = .divide
            resultLabel.text = "0"
        case "??":
            calculator.eachCase = .multiply
            resultLabel.text = "0"
        case "-":
            calculator.eachCase = .minus
            resultLabel.text = "0"
        case "+":
            calculator.eachCase = .plus
            resultLabel.text = "0"
        case "+/-":
            calculator.eachCase = .plusminus
            forResults()
        case "%":
            calculator.eachCase = .percent
            forResults()
        default:
            break
        }
    }
    
    @IBAction func erase(_ sender: Any) {
        resultLabel.text = "0"
    }
    
    @IBAction func results(_ sender: Any) {
        forResults()
    }
    
    // MARK: - Private Funcs
    private func forResults() {
        guard let results = Float(resultLabel.text!) else { return }
        calculator.newNumber(results)
        resultLabel.text = String(calculator.result)
    }
    
    private func makeButtonsRound() {
        let buttons = [ACButton, positivenegative, percent, divideButton, multiplyButton, minusButton, plusButton, resultButton, buttonDot, button1, button2, button3, button4, button5, button6, button7, button8, button9]
        for button in buttons {
            if let btn = button {
                btn.layer.cornerRadius = btn.bounds.width / 2
            }
            button0.layer.cornerRadius = button0.bounds.height / 2
        }
    }
}
