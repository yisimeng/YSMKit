//
//  ViewController.swift
//  YSMSwiftTools
//
//  Created by 马彬彬 on 2017/8/23.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func click(_ sender: Any) {
        ShareModule.shared.show()
    }
    
    @IBAction func sus(_ sender: Any) {
        NewShareModule.share(link: "hehe", title: "hehe", description: "hee", image: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.present(TableViewController(), animated: true, completion: nil)
    }
}

