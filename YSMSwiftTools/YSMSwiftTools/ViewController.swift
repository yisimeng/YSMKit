//
//  ViewController.swift
//  YSMSwiftTools
//
//  Created by 马彬彬 on 2017/8/23.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var ball: FloatBall?
    
    var timer: GCDTimer?
    
    var customView: CustomView = CustomView(frame: CGRect(x: 100, y: 100, width: 160, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customView)
        timer = GCDTimer.scheduled(time: 2, block: {
            print("heh")
        })
        
    }
    @IBAction func click(_ sender: Any) {
//        ShareModule.shared.show()
        timer?.resume()
    }
    
    @IBAction func sus(_ sender: Any) {
        timer?.suspend()
    }
    
    @IBAction func cancel(_ sender: Any) {
        timer?.cancel()
    }
    func test() {
        print("hheh")
    }
}

