//
//  DPPageCell.m
//  DPCyclePageDemo
//
//  Created by 朱力珅 on 2018/7/10.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "DPPageCell.h"

@implementation DPPageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
       
    }
    return self;
}

- (UILabel *)wordlabel{
    if(!_wordlabel){
        _wordlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(self.contentView.bounds) - 60, CGRectGetWidth(self.contentView.bounds), 30)];
        _wordlabel.textColor = [UIColor whiteColor];
        _wordlabel.font = [UIFont systemFontOfSize:30];
        [self.contentView addSubview:_wordlabel];
    }
    return _wordlabel;
}

@end
