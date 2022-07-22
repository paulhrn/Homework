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
    private lazy var pix: [UIImageView] = []
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var commentLabel: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var viewInteractions: UIView!
    @IBOutlet weak var interactionsBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.isHidden = true
        forTextView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pix = [createImageView(UIImage(named: "Image")!), createImageView(UIImage(named: "Image")!)]
        view.bringSubviewToFront(stackShowDelete)
        guard let labels = [showLabel, deleteLabel, uploadLabel, likeLabel, commentLabel] as? [UIButton] else { return }
        labels.forEach{ $0.layer.cornerRadius = $0.frame.height / 2 }
        managerSetup()
        textView.layer.cornerRadius = 20
        index = UserDefaults.standard.value(forKey: key) as! Int
        scrollViewImages()
        keyboardAnimation()
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
            view.bringSubviewToFront(scrollView)
            view.bringSubviewToFront(viewInteractions)
        } else if textView.isHidden == false {
            textView.isHidden = true
            view.removeBlur()
            view.bringSubviewToFront(stackShowDelete)
            textView.endEditing(true)
            forTextView()
        }
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
            let alert = UIAlertController(title: "Pictures' names:", message: "\(try fileManager.contentsOfDirectory(atPath: imagePath!.path).joined(separator: ", "))", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                self?.view.removeBlur()
            }
            alert.addAction(action)
            present(alert, animated: true)
            print(try fileManager.contentsOfDirectory(atPath: imagePath!.path))
        } catch {
            print("caught")
        }
    }
    
    private func delete() {
        let alert = UIAlertController(title: "Delete picture:", message: "Enter file name omitting .format", preferredStyle: .alert)
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
                }
            }
        }
        let hideNotification = UIResponder.keyboardWillHideNotification
        notificationCenter.addObserver(forName: hideNotification, object: nil, queue: .main) { _ in
            self.interactionsBottomConstraint.constant = 154
            UIView.animate(withDuration: 5.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func scrollViewImages() {
        pix.enumerated().forEach{ index, item in
            NSLayoutConstraint.activate([
                pix[index].heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                pix[index].widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                pix[0].topAnchor.constraint(equalTo: scrollView.topAnchor),
                pix[index].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            ])
            if index != 0 {
                pix[index].topAnchor.constraint(equalTo: pix[index - 1].bottomAnchor).isActive = true
            }
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: (view.frame.height * CGFloat(index + 1)))
        }
    }
    
    private func createImageView(_ image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

// MARK: - Extensions
extension Images: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            guard let data = image.jpegData(compressionQuality: 5),
                  let imagePath = imagePath?.appendingPathComponent("pic\(index).jpeg") else { return }
            fileManager.createFile(atPath: imagePath.path, contents: data)
//            var n = 0
//            pix.insert(createImageView(image), at: 0)
//            n += 1
        }
        picker.dismiss(animated: true)
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

extension UIView {
    func addBlur(style: UIBlurEffect.Style) {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        addSubview(blurEffectView)
    }
    
    func removeBlur() {
        for view in self.subviews {
            if let view = view as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
    }
}
