//
//  ViewController.swift
//  YSMSwiftTools
//
//  Created by 马彬彬 on 2017/8/23.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var tableView: UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), style: .plain)
        return tableView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 2000))
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2000)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "a")
        view.addSubview(scrollView)
        scrollView.addSubview(tableView)
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "a", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        print("啊啊啊啊啊啊")
        return cell
    }
}

