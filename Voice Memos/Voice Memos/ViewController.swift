//
//  ViewController.swift
//  Voice Memos
//
//  Created by p h on 09.08.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private let fileManager = FileManager.default
    private var recordNumber: Int = 0
    private var recorder: AVAudioRecorder!
    private var player: AVAudioPlayer!
    
    @IBOutlet weak var myButtonLabel: UIButton!
    @IBOutlet weak var myRecordsLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let number = UserDefaults.standard.value(forKey: "Number") as? Int {
            recordNumber = number
        }
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    @IBAction func record(_ sender: UIButton) {
        switch recorder == nil {
        case true:
            recordNumber += 1
            let recording = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(recordNumber).m4a")
            do {
                recorder = try AVAudioRecorder(url: recording, settings: [:])
                recorder.record()
                myButtonLabel.setTitle("Stop", for: .normal)
            }
            catch {
                alert(title: "Unable to record", message: "", actionTitle: "Back")
            }
        case false: recorder.stop()
            recorder = nil
            UserDefaults.standard.set(recordNumber, forKey: "Number")
            myTableView.reloadData()
            myButtonLabel.setTitle("Record", for: .normal)
        }
    }
    
    private func alert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordNumber
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(indexPath.row + 1).m4a")
        do {
            player = try AVAudioPlayer(contentsOf: path)
            player.play()
        }
        catch {
            alert(title: "Unable to play", message: "", actionTitle: "Back")
        }
    }
}
