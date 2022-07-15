//
//  PhotosViewController.swift
//  Photo storage
//
//  Created by p h on 14.07.2022.
//

import Foundation
import UIKit

class Images: UIViewController {
    
    // MARK: - Private Properties
    private let fileManager = FileManager.default
    private var imagePath: URL?
    private var pix: [UIImage] = []
    private let key = "Index"
    private var index = 0
    
    // MARK: - Outlets
    @IBOutlet weak var showLabel: UIButton!
    @IBOutlet weak var deleteLabel: UIButton!
    @IBOutlet weak var uploadLabel: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let labels = [showLabel, deleteLabel, uploadLabel] as! [UIButton]
        labels.forEach{ $0.layer.cornerRadius = $0.frame.height / 2 }
        
        managerSetup()
        index = UserDefaults.standard.value(forKey: key) as! Int
    }
    
    // MARK: - Actions
    @IBAction func showAction(_ sender: UIButton) {
        show()
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        delete()
    }
    
    @IBAction func uploadAction(_ sender: UIButton) {
        upload()
        index += 1
        UserDefaults.standard.set(index, forKey: key)
    }
    
    // MARK: - Private Funcs
    private func managerSetup() {
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let imagesDirectory = documentPath?.appendingPathComponent("Images") else { return }
        imagePath = imagesDirectory
        if fileManager.fileExists(atPath: imagesDirectory.path) == false {
            do {
                try fileManager.createDirectory(atPath: imagesDirectory.path, withIntermediateDirectories: true)
            } catch {
                print("caught")
            }
        }
    }
    
    private func show() {
        do {
            try fileManager.contentsOfDirectory(atPath: imagePath!.path).forEach{
                let alert = UIAlertController(title: "Last picture:", message: "\($0)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(action)
                present(alert, animated: true)
                print($0)
            }
        } catch {
            print("caught")
        }
    }
    
    private func delete() {
        let alert = UIAlertController(title: "Delete pic", message: "Enter file name to delete", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "File name"
        }
        let action1 = UIAlertAction(title: "Cancel", style: .cancel)
        let action2 = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            let imageName = (alert.textFields?[0].text)!
            if let imagePath = self?.imagePath?.appendingPathComponent("\(imageName).jpeg") {
                do {
                    try self?.fileManager.removeItem(at: imagePath)
                } catch {
                    print("caught")
                }
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
    
    private func upload() {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
}

// MARK: - Extensions
extension Images: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            guard let data = image.jpegData(compressionQuality: 5),
                  let imagePath = imagePath?.appendingPathComponent("pic\(index).jpeg") else { return }
            fileManager.createFile(atPath: imagePath.path, contents: data)
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
}

