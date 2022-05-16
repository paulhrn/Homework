//
//  ViewController.swift
//  homework
//
//  Created by p h on 06.05.2022.
//

import UIKit

 class ViewController: UIViewController {

     var x = [(1, "x"), (4, "y"), (6, "a"), (-3, "b")]

     override func viewDidLoad() {
         super.viewDidLoad()

         let y = x.map { (Int(pow(Double($0.0), 2)), $0.1) }.filter { $0.0 % 2 == 0 }.sorted { $0.1 < $1.1 }

         print(y)
     }
 }
 //       хотелось бы узнать, если сможешь это показать или скинуть статью, как эти два типа данных сделать в таком формате:
 //          let y = x.map {
 //
 //          }.filter { int in
 //          int % 2 == 0
 //          }.sorted { someint, someint2 in
 //          someint < someint2
 //          }
