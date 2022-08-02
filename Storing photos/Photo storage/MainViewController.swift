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
    private let notificationCenter = NotificationCenter.default
    private lazy var pix: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private let key = "Index"
    private let commentString = "Add a comment or tap 💬 to hide..."
    private var index = 0
    private var textViewHidden = false
    private var imageBottomConstraint: NSLayoutConstraint?
    private var imageCenterYConstraint: NSLayoutConstraint?
    
    // MARK: - Outlets
    @IBOutlet weak var showLabel: UIButton!
    @IBOutlet weak var deleteLabel: UIButton!
    @IBOutlet weak var stackShowDelete: UIStackView!
    @IBOutlet weak var uploadLabel: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var commentLabel: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var viewInteractions: UIView!
    @IBOutlet weak var interactionsBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var interactionsTopConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.isHidden = true
        forTextView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "Image") {
            pix.append(image)
        }
        view.bringSubviewToFront(stackShowDelete)
        guard let labels = [showLabel, deleteLabel, uploadLabel, likeLabel, commentLabel] as? [UIButton] else { return }
        labels.forEach{ $0.layer.cornerRadius = $0.frame.height / 2 }
        managerSetup()
        textView.layer.cornerRadius = 20
        index = UserDefaults.standard.value(forKey: key) as? Int ?? 0
        keyboardAnimation()
        setupCollectionView()
    }
    
    // MARK: - Actions
    @IBAction func showAction(_ sender: UIButton) {
        show()
        view.addBlur(style: .regular)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        delete()
        view.addBlur(style: .regular)
    }
    
    @IBAction func uploadAction(_ sender: UIButton) {
        upload()
        index += 1
        UserDefaults.standard.set(index, forKey: key)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        
    }
    
    @IBAction func commentAction(_ sender: Any) {
        if textView.isHidden == true {
            textView.isHidden = false
            view.addBlur(style: .regular)
            view.bringSubviewToFront(collectionView)
            view.bringSubviewToFront(viewInteractions)
        } else if textView.isHidden == false {
            viewInteractions.backgroundColor = .clear
            textView.isHidden = true
            view.removeBlur()
            view.bringSubviewToFront(stackShowDelete)
            textView.endEditing(true)
            forTextView()
        }
    }
    
    // MARK: - Private Funcs
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
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
        if let pixFirst = try? (fileManager.contentsOfDirectory(atPath: imagePath!.path).first as? NSString)?.deletingPathExtension {
            do {
                
                let alert = UIAlertController(title: "Last added picture:", message: "\(pixFirst)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                    self?.view.removeBlur()
                }
                alert.addAction(action)
                present(alert, animated: true)
                if let contentsOfDirectory = try? fileManager.contentsOfDirectory(atPath: imagePath!.path) {
                    print(contentsOfDirectory)
                }
            }
        } else {
            do {
                let alert = UIAlertController(title: "No pictures", message: "Tap \"OK\" and upload pictures", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                    self?.view.removeBlur()
                }
                alert.addAction(action)
                present(alert, animated: true)
            }
        }
    }
    
    private func delete() {
        let alert = UIAlertController(title: "Delete last added picture:", message: "Enter last picture's name as it was shown", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "File name"
        }
        let action1 = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.view.removeBlur()
        }
        let action2 = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            self?.view.removeBlur()
            let imageName = (alert.textFields?[0].text)!
            if let imagePath = self?.imagePath?.appendingPathComponent("\(imageName).jpeg") {
                do {
                    try self?.fileManager.removeItem(at: imagePath)
                    if self?.pix.isEmpty == false {
                        self?.pix.removeLast()
                    }
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
    
    private func forTextView() {
        textView.text = commentString
        textView.textColor = UIColor.lightGray
        textView.delegate = self
    }
    
    private func keyboardAnimation() {
        let showNotifiction = UIResponder.keyboardWillShowNotification
        notificationCenter.addObserver(forName: showNotifiction, object: nil, queue: .main) { notification in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.textView.isHidden == false {
                    self.interactionsBottomConstraint.constant = (keyboardSize.height - 20)
                    UIView.animate(withDuration: 5.0) {
                        self.view.layoutIfNeeded()
                    }
                    self.interactionsTopConstraint.constant = -(keyboardSize.height)
                }
            }
        }
        let hideNotification = UIResponder.keyboardWillHideNotification
        notificationCenter.addObserver(forName: hideNotification, object: nil, queue: .main) { _ in
            self.interactionsBottomConstraint.constant = 154 //initial
            UIView.animate(withDuration: 5.0) {
                self.view.layoutIfNeeded()
            }
            self.interactionsTopConstraint.constant = 17 //initial
        }
    }
}

// MARK: - Extensions
extension Images: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            guard let data = image.jpegData(compressionQuality: 5),
                  let imagePath = imagePath?.appendingPathComponent("pic\(index).jpeg") else { return }
            fileManager.createFile(atPath: imagePath.path, contents: data)
            pix.append(image)
        }
        picker.dismiss(animated: true)
    }
}

extension Images: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionCell else { return UICollectionViewCell() }
        cell.setImageView(with: pix[indexPath.row])
        return cell
    }
}

extension Images: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = commentString
            textView.textColor = UIColor.lightGray
        }
    }
}
