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
        secondtask.digitSum(2121)
        thirdtask.equal("авб", "ввш")
        fifthtask.squared(10)
        sixthtask.calculateFactorial(5)
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
    
    static func digitSum(_ n : Int) {
        var n = n
        var sum = 0
        while n > 0 {
            let lastDigit = n % 10
            sum = sum + lastDigit
            n = n / 10
        }
        
        print(sum)
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
    
    static func squared(_ a: Int, b: Double = 2) {
        let intpow = Int(pow(Double(a), b))
        let intb = Int(b)
        print("\(a) ^ \(intb) = \(intpow)")
    }
}

class sixthtask {
    
    static func calculateFactorial(_ n: Int) {
        var factorial = 1
        for nums in 1...n {
            factorial = factorial * nums
        }
        print(factorial)
    }
}

// also working :
//
//static func factorial1(_ n: Int) {
//        var n = n
//        var factorial = 1
//        while n > 0 {
//            if n >= 1 {
//                factorial = factorial * n
//                n = n - 1
//            }
//        }
//        print(factorial)
//    }
//}
