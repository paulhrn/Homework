//
//  ViewController.swift
//  homework
//
//  Created by p h on 06.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firsttask.plus(5.0, 5.0)
        firsttask.minus(5, 5)
        firsttask.asterisk(5.0, 5.0)
        firsttask.slash(5, 5)
        secondtask.qw()
        thirdtask.equal("авб", "ввш")
        fifthtask.squared(6.0)
        sixthtask.ln()
        // четвёртое вызвал последним :)
        fourthtask.crash(-1000)
    }
}
class firsttask {
    
    static func plus(_ x: Int, _ y : Int) {
        print(x + y)
    }
    static func plus(_ x: Double, _ y: Double) {
        print(x + y)
    }
    static func minus(_ x: Int, _ y : Int) {
        print(x - y)
    }
    static func minus(_ x: Double, _ y: Double) {
        print(x - y)
    }
    static func asterisk(_ x: Int, _ y : Int) {
        print(x * y)
    }
    static func asterisk(_ x: Double, _ y: Double) {
        print(x * y)
    }
    static func slash(_ x: Int, _ y : Int) {
        print(x / y)
    }
    static func slash(_ x: Double, _ y: Double) {
        print(x / y)
    }
}

class secondtask {
    
    static func qw() {
        func digitSum(_ n : Int) -> Int {
            var n = n
            var sum = 0
            while n > 0 {
                sum = sum + n % 10 // sum += n % 10
                n = n / 10        // n /= 10
            }
            return sum
        }
        
        print(digitSum(1785))
    }
}

class thirdtask {
    
    static func equal(_ first: String,_ second: String) {
        if first > second {
            print(first + " > " + second)
        } else if second > first {
            print(second + " > " + first)
        } else {
            print(first + " = " + second)
        }
    }
}

class fourthtask {
    
    static func crash(_ times: Int) {
        while times > Int.min {
            fourthtask.crash(0)
        }
    }
}
class fifthtask {
    
    static func squared(_ a: Double) {
        let b = 2.0
        print("\(a) ^ \(b) = \(pow(a, b))")  //or print(a * a)
    }
}

class sixthtask {
    
    static func ln() {
        func factorial(_ n: Int) -> Int {
            if n == 0 {
                return 1
            } else {
                return n * factorial(n-1)
            }
        }
        print(factorial(5))
    }
}
