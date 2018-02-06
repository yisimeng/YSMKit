//
//  Protocol.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/31.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

protocol NibLoadable {
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}

