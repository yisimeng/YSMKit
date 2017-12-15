//
//  YSMButton.m
//  Cell
//
//  Created by 忆思梦 on 2016/11/9.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "YSMButton.h"

@implementation YSMButton

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGSize labelSize = self.titleLabel.bounds.size;
    //内容的宽度
//    CGFloat contentWidth = imageSize.width+labelSize.width+self.contentSpace;
    //内容的高度
    CGFloat contentHeight = imageSize.height+labelSize.height+self.contentSpace;
    if (self.alignment == Default) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.contentSpace/2, 0, self.contentSpace/2)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.contentSpace/2, 0, -self.contentSpace/2)];
    }else if (self.alignment == HorizontalImageRight) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, labelSize.width+self.contentSpace/2, 0, -labelSize.width-self.contentSpace/2)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width-self.contentSpace/2, 0, imageSize.width+self.contentSpace/2)];
    }else if (self.alignment == VerticalImageTop){
        //先在button的左上角对齐
        //图片上，文字下，居中。UIEdgeInsets，是距离原来位置设值。
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self setImageEdgeInsets:UIEdgeInsetsMake((size.height-contentHeight)/2, (size.width - imageSize.width)/2, (size.height-contentHeight)/2+(contentHeight-imageSize.height), (size.width - imageSize.width)/2)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake((size.height-contentHeight)/2+(contentHeight-labelSize.height), (size.width-labelSize.width)/2-imageSize.width, (size.height-contentHeight)/2, (size.width-labelSize.width)/2-imageSize.width)];
    }else if (self.alignment == VerticalImageBottom){
        //先在button的左上角对齐
        //图片下，文字上，居中。
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        
        [self setImageEdgeInsets:UIEdgeInsetsMake((size.height-contentHeight)/2+(contentHeight- imageSize.height), (size.width - imageSize.width)/2, (size.height-contentHeight)/2, (size.width - imageSize.width)/2)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake((size.height-contentHeight)/2, (size.width-labelSize.width)/2-imageSize.width, (size.height-contentHeight)/2+(contentHeight- labelSize.height), (size.width-labelSize.width)/2-imageSize.width)];
    }
}

@end
