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
    
    var customView: CustomView = CustomView(frame: CGRect(x: 100, y: 100, width: 160, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customView)
        
        
        
        
//        let item1 = ShareItem(image: "share_qq") {
//            print("1")
//        }
//        let item2 = ShareItem(image: "share_qq") {
//            print("2")
//        }
//        let item3 = ShareItem(image: "share_qq") {
//            print("3")
//        }
//        let shareView = ShareView(shareItems: [item1,item3])
//        shareView.backgroundColor = .yellow
//        shareView.frame = CGRect(x: 0, y: 300, width: view.bounds.width, height: 100)
//        view.addSubview(shareView)
        
    }
    @IBAction func click(_ sender: Any) {
        ShareModule.shared.show()
    }
}

