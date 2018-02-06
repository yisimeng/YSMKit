//
//  ShareView.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/31.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit


typealias SingleClosure = ()->()
class ShareItem  {
    var imageName: String
    var selectAction: SingleClosure
    init(image: String, click callBack: @escaping SingleClosure) {
        imageName = image
        selectAction = callBack
    }
}

class ShareModule {
    static let shared: ShareModule = ShareModule()
    
    var bgView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        return view
    }()
    var shareView: ShareView
    var shareItems: [ShareItem] = []
    
    
    init() {
        if true {
            let item1 = ShareItem(image: "share_qq") {
            }
            shareItems.append(item1)
        }
        if true {
            let item2 = ShareItem(image: "share_qq") {
            }
            shareItems.append(item2)
        }
        shareView = ShareView(shareItems: shareItems)
        shareView.frame = CGRect(x: 0, y: bgView.bounds.height, width: shareView.bounds.width, height: shareView.bounds.height)
        bgView.addSubview(shareView)
        bgView.addTarget(target: self, action: #selector(hide))
    }
    
    func show() {
        guard let window: UIWindow = UIApplication.shared.delegate?.window as? UIWindow else { return }
        window.addSubview(bgView)
        UIView.animate(withDuration: 0.3) {
            self.bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.shareView.frame = CGRect(x: 0, y: self.bgView.bounds.height-self.shareView.bounds.height, width: self.shareView.bounds.width, height: self.shareView.bounds.height)
        }
    }
    
    @objc func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.shareView.frame = CGRect(x: 0, y: self.bgView.bounds.height, width: self.shareView.bounds.width, height: self.shareView.bounds.height)
        }) { (complete) in
            self.bgView.removeFromSuperview()
        }
    }
}

class ShareView: UIView {
    
    var items: [ShareItem]
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    init(shareItems: [ShareItem]) {
        items = shareItems
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 114))
        backgroundColor = .yellow
        setupSubView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubView() {
        let space: CGFloat = 42
        let totalWidth: CGFloat = CGFloat(items.count)*46+(CGFloat(items.count)-1)*space
        var left: CGFloat = (bounds.width-totalWidth)/2
        for item in items {
            let shareButton = UIButton(type: .custom)
            shareButton.addTarget(self, action: #selector(sharedAction(_:)), for: .touchUpInside)
            shareButton.setImage(UIImage(named: item.imageName), for: .normal)
            shareButton.sizeToFit()
            shareButton.center = CGPoint(x: left+shareButton.bounds.width/2, y: bounds.height/2)
            addSubview(shareButton)
            left = shareButton.frame.maxX + space
        }
    }
    
    @objc func sharedAction(_ btn: UIButton) {
        let item = items[btn.tag]
        item.selectAction()
    }
    
}






