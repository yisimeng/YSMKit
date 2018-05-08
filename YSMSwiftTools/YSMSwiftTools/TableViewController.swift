//
//  TableViewController.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/3/6.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "aa")
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aa", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        print("indexpath")
        return cell
    }
}
