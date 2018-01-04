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
    CGRect frame = CGRectMake(0, 0, menus.count*50, 50);
    if (self = [super initWithFrame:frame]) {
        
        self.menus = menus;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(50, 50);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
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

@end
