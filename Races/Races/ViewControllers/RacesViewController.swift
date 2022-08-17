//
//  RacesViewController.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class RacesVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var Scores: UIButton!
    @IBOutlet weak var Settings: UIButton!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let view = view {
            view.layer.insertSublayer(CALayer(layer: view), at: 0)
        }
        view.addGradientLocation(colors: [#colorLiteral(red: 0.7411764706, green: 0.9019607843, blue: 0.9215686275, alpha: 1).cgColor, #colorLiteral(red: 0.6862745098, green: 0.9333333333, blue: 0.9333333333, alpha: 1).cgColor, #colorLiteral(red: 0.4392156863, green: 0.6784313725, blue: 0.6901960784, alpha: 1).cgColor], locations: [0, 0.5, 1])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(L10n.user, forKey: "Name")
        guard let buttonsOutlets = [Play, Scores, Settings] as? [UIButton] else { return }
        buttonsOutlets.forEach{ $0.addCornerRadius() }
        buttonsOutlets.forEach{ $0.addGradientPoints() }
        buttonsOutlets.forEach{ $0.addShadow() }
        buttonsOutlets.forEach{ $0.setTitleColor(.white, for: .normal) }
        if let font = UIFont(name: L10n.font, size: 25) {
            buttonsOutlets.forEach{ $0.titleLabel?.addFont(font: font) }
        }
        buttonsOutlets.forEach{ $0.titleLabel?.addShadow(shadowColor: .darkGray, offset: .init(width: 10, height: 8), radius: 7, opacity: 1) }
        buttonsOutlets.forEach{ $0.attrStringUnderline() }
        
        addParallax(buttons: [Play, Scores, Settings])
    }
    
    // MARK: - Actions
    @IBAction func PlayButton(_ sender: Any) {
        play()
    }
    
    @IBAction func ScoresButton(_ sender: Any) {
        scores()
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
        settings()
    }
    
    @IBAction func changeName(_ sender: Any) {
        let alert = UIAlertController(title: L10n.racesAlertTitle, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField1) in
            textField1.placeholder = L10n.yourNamePlaceholder
        }
        let action1 = UIAlertAction(title: L10n.continueAction, style: .default) { _ in
            if let nameText = alert.textFields?[0].text {
                UserDefaults.standard.set(nameText, forKey: "Name")
            }
        }
        let action2 = UIAlertAction(title: L10n.back, style: .cancel)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
    
    // MARK: - Private Funcs
    private func play() {
            let storyboard = UIStoryboard(name: "Play", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PlayRacesV")
            self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func scores() {
        let storyboard = UIStoryboard(name: "Scores", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScoresRacesV")
        navigationController?.pushViewController(viewController, animated: true)    }
    
    private func settings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsRacesV")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func addParallax(buttons: [UIButton]) {
        let amount = 25

        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount

        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        buttons.forEach{ $0.addMotionEffect(group) }
    }
}
