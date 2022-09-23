//
//  ViewController.swift
//  Rx
//
//  Created by p h on 23.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let publishSubject = PublishSubject<Int>()
    let replaySubject = ReplaySubject<Int>.create(bufferSize: 2)
    let behaviorSubject = BehaviorSubject<Int>(value: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishSub()
        replaySub()
        behaviorSub()
    }
    
//    Output:
//    publishSubject first: next(2)
//    publishSubject first: next(3)
//    publishSubject second: next(3)
//    publishSubject first: next(1)
//    publishSubject second: next(1)
//    replaySubject first: next(2)
//    replaySubject second: next(2)
//    replaySubject first: next(3)
//    replaySubject second: next(3)
//    behaviorSubject first: next(1)
//    behaviorSubject first: next(2)
//    behaviorSubject second: next(2)
//    behaviorSubject first: next(3)
//    behaviorSubject second: next(3)
    
    func publishSub() {
        publishSubject.onNext(1)
        
        _ = publishSubject.subscribe({ print("publishSubject first: \($0)") })
            .disposed(by: disposeBag)
        publishSubject.onNext(2)
        _ = publishSubject.subscribe({ print("publishSubject second: \($0)") })
            .disposed(by: disposeBag)
        
        publishSubject.onNext(3)
    }
    
    func replaySub() {
        publishSubject.onNext(1)
        
        _ = replaySubject.subscribe({ print("replaySubject first: \($0)") })
            .disposed(by: disposeBag)
        replaySubject.onNext(2)
        _ = replaySubject.subscribe({ print("replaySubject second: \($0)") })
            .disposed(by: disposeBag)
        
        replaySubject.onNext(3)
    }
    
    func behaviorSub() {
        behaviorSubject.onNext(1)
        
        _ = behaviorSubject.subscribe({ print("behaviorSubject first: \($0)") })
            .disposed(by: disposeBag)
        behaviorSubject.onNext(2)
        _ = behaviorSubject.subscribe({ print("behaviorSubject second: \($0)") })
            .disposed(by: disposeBag)
        
        behaviorSubject.onNext(3)
    }
}

