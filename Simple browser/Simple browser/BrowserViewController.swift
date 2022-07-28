//
//  BrowserViewController.swift
//  Simple browser
//
//  Created by p h on 21.07.2022.
//

import Foundation
import UIKit
import WebKit

class BrowserVC: ViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var googleLogoImage: UIImageView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL()
        googleLogoImage.isUserInteractionEnabled = true
        googleLogoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLogo(_:))))
    }
    
    // MARK: - Actions
    @IBAction func backButton(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func forwardButton(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        webView.reload()
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        webView.stopLoading()
    }
    
    // MARK: - Funcs
    @objc private func didTapLogo(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: "https://google.com") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func loadURL() {
        let searchString = "https://google.com/search?q=\(ViewController.search)"
        guard let url = URL(string: searchString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
