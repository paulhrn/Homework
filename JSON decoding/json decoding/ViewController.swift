//
//  ViewController.swift
//  json decoding
//
//  Created by p h on 02.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let jsonData = decoderData(), let medicine = try? decoder.decode(Medicine.self, from: jsonData) else { return }
        print(medicine.medications.first?.aceInhibitors.first?.pillCount ?? "nil")
    }
}

private extension ViewController {
    func decoderData() -> Data? {
            if let bundlePath = Bundle.main.path(forResource: "medicine", ofType: "json"),
               let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
        }
        return nil
    }
}
