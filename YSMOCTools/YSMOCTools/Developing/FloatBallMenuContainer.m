//
//  FloatBallMenuContainer.m
//  YSMOCTools
//
//  Created by duanzengguang on 2018/1/3.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

#import "FloatBallMenuContainer.h"
#import "UIColor+Category.h"

@interface FloatBallMenuContainer ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(strong, nonatomic) UICollectionView * collectionView;
@property(strong, nonatomic) NSArray<FloatBallMenu *>* menus;

@end

@implementation FloatBallMenuContainer

- (instancetype)initWithMenus:(NSArray<FloatBallMenu *> *)menus{
    CGRect frame = CGRectMake(0, 0, menus.count*40+10, 50);
    if (self = [super initWithFrame:frame]) {
        self.menus = menus;
        self.layer.masksToBounds = YES;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(30, 30);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        [self addSubview:_collectionView];
    }
    return self;
}

#pragma mark -- UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _menus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.backgroundColor = [UIColor randomColor];
    return item;
}

- (void)animateShowLeft:(BOOL) isLeft{
    if (isLeft == YES) {
        _collectionView.frame = CGRectMake(-_collectionView.frame.size.width, _collectionView.frame.origin.y, _collectionView.frame.size.width, _collectionView.frame.size.height);
    }else{
        _collectionView.frame = CGRectMake(_collectionView.frame.size.width*2, _collectionView.frame.origin.y, _collectionView.frame.size.width, _collectionView.frame.size.height);
    }
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _collectionView.frame =  CGRectMake(0, _collectionView.frame.origin.y, _collectionView.frame.size.width, _collectionView.frame.size.height);
    } completion:nil];
}

@end
