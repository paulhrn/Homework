//
//  ViewController.swift
//  homework
//
//  Created by p h on 06.05.2022.
//

import UIKit

let (a, d, g, j) = (2.5, 9.7, 6.9, 8.2)
let (b, e, h, k) = (Double(Int(a)), Double(Int(d)), Double(Int(g)), Double(Int(j)))
let (c, f, i, l) = (a - b, d - e, g - h, j - k)
let (intsum, fracsum) = (b + e + h + k, round((c + f + i + l)*10)/10)
var nums = 12

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("1. Сумма целых частей чисел = \(intsum), сумма дробных частей чисел = \(fracsum)")
       
        nums = 270
          if nums % 2 == 0 {
            print("2. \(nums) является чётным")
          } else {
            print("2. \(nums) является нечётным")
          }
        }
        }

