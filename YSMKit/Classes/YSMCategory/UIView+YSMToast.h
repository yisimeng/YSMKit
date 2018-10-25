/***************************************************************************
 
UIView+Toast.h
Toast
Version 2.2

Copyright (c) 2013 Charles Scalesse.
 
Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:
 
The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
***************************************************************************/

#import <UIKit/UIKit.h>

@interface UIView (YSMToast)

// each makeToast method creates a view and displays it as toast
- (void)ysm_makeToast:(NSString *)message;
- (void)ysm_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;
- (void)ysm_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position image:(UIImage *)image;
- (void)ysm_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title;
- (void)ysm_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title image:(UIImage *)image;

// displays toast with an activity spinner
- (void)ysm_makeToastActivity;
- (void)ysm_makeToastActivity:(id)position;
- (void)ysm_hideToastActivity;

// the showToast methods display any view as toast
- (void)ysm_showToast:(UIView *)toast;
- (void)ysm_hideToast:(UIView *)toast;
- (void)ysm_showToastWithOutFade:(UIView *)toast;
- (void)ysm_showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;

// keyboard
- (void)ysm_setKeyBoardOffset:(CGFloat)offect;

@end
