//
//  QHTextView.h
//  QHLoginFramework
//
//  Created by duanzengguang on 2018/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSMTextView : UITextView

@property(nonatomic, assign) IBInspectable NSUInteger characterLimit;
@property(nonatomic, copy) IBInspectable NSString * placeholder;

@end

NS_ASSUME_NONNULL_END
