//
//  YSMButton.h
//  Cell
//
//  Created by 忆思梦 on 2016/11/9.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Default = 0,
    HorizontalImageLeft = Default,//默认水平居中，图片在左
    HorizontalImageRight,//水平居中，图片在右
    VerticalImageTop,//垂直居中，图片在上
    VerticalImageBottom//垂直居中，图片在下
}AlignmentType;

@interface YSMButton : UIButton
//排列方式
@property (nonatomic, assign) AlignmentType alignment;
//内容间隔
@property (nonatomic, assign) CGFloat contentSpace;

@end
