//
//  YSMUtils.swift
//  YSMSwiftTools
//
//  Created by 马彬彬 on 2017/9/12.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import UIKit

extension Array {
    func value(for index: Int) throws -> Element {
        guard index < count, index >= 0 else {
            throw NSError(domain: "下标越界", code: 1000, userInfo: ["count": count, "index": index])
        }
        return self[index]
    }
}
