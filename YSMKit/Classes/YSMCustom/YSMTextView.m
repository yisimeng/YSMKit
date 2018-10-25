//
//  QHTextView.m
//  QHLoginFramework
//
//  Created by duanzengguang on 2018/9/25.
//

#import "YSMTextView.h"
#import "NSString+YSMCategory.h"
#import "YSMKit.h"

@interface YSMTextView ()

@end

@implementation YSMTextView{
    UILabel * _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _characterLimit = NSUIntegerMax;
        [self _setupToolBar];
        [self _addObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _characterLimit = NSUIntegerMax;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _setupToolBar];
    [self _addObserver];
}

- (void)dealloc{
    [_placeholderLabel removeFromSuperview];
    _placeholderLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat offsetLeft = self.textContainerInset.left + self.textContainer.lineFragmentPadding;
    CGFloat offsetRight = self.textContainerInset.right + self.textContainer.lineFragmentPadding;
    CGFloat offsetTop = self.textContainerInset.top;
    CGFloat offsetBottom = self.textContainerInset.bottom;
    CGSize expectedSize = [_placeholderLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame)-offsetLeft-offsetRight, CGRectGetHeight(self.frame)-offsetTop-offsetBottom)];
    _placeholderLabel.frame = CGRectMake(offsetLeft, offsetTop, expectedSize.width, expectedSize.height);
}

#pragma mark -- Getter & Setter

- (void)setPlaceholder:(NSString *)placeholder{
    NSLog(@"33333");
    _placeholder = placeholder;
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeholderLabel.numberOfLines = 0;
        if (self.font) {
            _placeholderLabel.font = self.font;
        }else {
            _placeholderLabel.font = [UIFont systemFontOfSize:12];
        }
        _placeholderLabel.textAlignment = self.textAlignment;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        _placeholderLabel.alpha = 0;
        [self addSubview:_placeholderLabel];
        NSLog(@"22222");
    }
    NSLog(@"11111");
    _placeholderLabel.text = placeholder;
    [self _refreshPlaceholder];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self _refreshPlaceholder];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    _placeholderLabel.font = font;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    [super setTextAlignment:textAlignment];
    _placeholderLabel.textAlignment = textAlignment;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark -- private
- (void)_setupToolBar{
    UIToolbar * accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    accessoryView.translucent = YES;
    accessoryView.backgroundColor = [UIColor clearColor];
    NSMutableArray *itemsArray = [NSMutableArray array];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [itemsArray addObject:space];
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(_doneBarItemAction:)];
    [itemsArray addObject:doneBarItem];
    [accessoryView setItems:itemsArray animated:NO];
    self.inputAccessoryView = accessoryView;
}

- (void)_refreshPlaceholder{
    if ([self.text length]) {
        [_placeholderLabel setAlpha:0];
    }else {
        [_placeholderLabel setAlpha:1];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark -- NSNotification
- (void)_addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)_textViewTextDidChange:(NSNotification *)noti{
    // 限制长度
    if ([noti.object isEqual:self]) {
        NSInteger textLength = [self.text ysm_unicodeLength];
        NSString* lang = self.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { // 中文
            UITextRange* selectedRange = [self markedTextRange];
            UITextPosition* position =
            [self positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (textLength > self.characterLimit) {
                    self.text = [self.text ysm_substringToMaxCharacterLimit:self.characterLimit];
                }
            }
        }else {
            if (textLength > self.characterLimit) {
                self.text = [self.text ysm_substringToMaxCharacterLimit:self.characterLimit];
            }
        }
    }
    [self _refreshPlaceholder];
}

#pragma mark -- Action
- (void)_doneBarItemAction:(UIBarButtonItem *)item {
    [self resignFirstResponder];
}

@end
