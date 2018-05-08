//
//  NewShareView.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/3/5.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class NewShareItem {
    var shareImage: String
    var shareType: Int
    init(image: String, share type: Int) {
        shareImage = image
        shareType = type
    }

}

typealias ShareChannel = (Int) -> ()

protocol ShareViewDelegate: class {
    func shareView(_ shareView: NewShareView, didSelected type: Int)
}

class NewShareModule: ShareViewDelegate {
    static private let shared: NewShareModule = NewShareModule()
    var shareView: NewShareView = NewShareView(frame: CGRect.zero)
    
    var shareItems: [NewShareItem] {
        var items: [NewShareItem] = []
        if true {
            let item1 = NewShareItem(image: "share_qq", share: 1)
            items.append(item1)
        }
        if true {
            let item1 = NewShareItem(image: "share_qq", share: 2)
            items.append(item1)
        }
        return items
    }
    
    /// 外部唯一接口
    class func share(link url: String, title: String, description: String, image: String?) {
        shared.showShareView()
    }
    
    func showShareView() {
        shareView.delegate = NewShareModule.shared
        shareView.setupSubView(with: shareItems)
        shareView.animatedShow()
    }
    
    
    /// protocol ShareViewDelegate
    func shareView(_ shareView: NewShareView, didSelected type: Int) {
        // 设置分享
        print("\(type)")
    }
}
    


private let shareContentViewHeight: CGFloat = 114
class NewShareView: UIView {
    
    weak var delegate: ShareViewDelegate?
    
    var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: shareContentViewHeight))
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview(contentView)
        
        addTarget(target: self, action: #selector(animatedHide))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubView(with shareItems: [NewShareItem]) {
        let space: CGFloat = 42
        let totalWidth: CGFloat = CGFloat(shareItems.count)*46+(CGFloat(shareItems.count)-1)*space
        var left: CGFloat = (bounds.width-totalWidth)/2
        for (index, item) in shareItems.enumerated() {
            let shareButton = UIButton(type: .custom)
            shareButton.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
            shareButton.setImage(UIImage(named: item.shareImage), for: .normal)
            shareButton.sizeToFit()
            shareButton.tag = index
            shareButton.center = CGPoint(x: left+shareButton.bounds.width/2, y: shareContentViewHeight/2)
            contentView.addSubview(shareButton)
            left = shareButton.frame.maxX + space
        }
    }
    
    @objc private func shareAction(_ btn: UIButton) {
        animatedHide()
        delegate?.shareView(self, didSelected: btn.tag)
    }
    
    
    func animatedShow() {
        guard let window: UIWindow = UIApplication.shared.delegate?.window as? UIWindow else { return }
        window.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.contentView.frame = CGRect(x: 0, y: self.bounds.height-self.contentView.bounds.height, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        }
    }
    func animatedHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.contentView.frame = CGRect(x: 0, y: self.bounds.height, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        }) { complete in
            self.contentView.removeAllSubviews()
            self.removeFromSuperview()
        }
    }
    

}
