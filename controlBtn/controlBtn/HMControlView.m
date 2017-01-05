//
//  HMControlView.m
//  controlBtn
//
//  Created by 侯谢送 on 2016/12/25.
//  Copyright © 2016年 侯谢送. All rights reserved.
//

#import "HMControlView.h"
#import "HMShapedButton.h"
#import "UIView+Extension.h"
#import "Masonry.h"

#define HM_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

typedef NS_ENUM(NSUInteger, HMControlButtonType) {
    HMControlButtonTypePlay = 1000,
    HMControlButtonTypeAdd,
    HMControlButtonTypeNext,
    HMControlButtonTypeReduce,
    HMControlButtonTypePre,
};

@interface HMControlView ()

@property (weak, nonatomic) HMShapedButton *addBtn;//音量+
@property (weak, nonatomic) HMShapedButton *nextBtn;//下一曲
@property (weak, nonatomic) HMShapedButton *reduceBtn;//音量-
@property (weak, nonatomic) HMShapedButton *preBtn;//上一曲

@property (weak, nonatomic) HMShapedButton *playBtn;//播放


@end

@implementation HMControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {

    HMShapedButton *addBtn = [[HMShapedButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"music_add_n"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"music_add_y"] forState:UIControlStateHighlighted];
    addBtn.tag = HMControlButtonTypeAdd;
    [addBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.backgroundColor = HM_RandomColor;
    [self addSubview:addBtn];
    self.addBtn = addBtn;
    
    HMShapedButton *nextBtn = [[HMShapedButton alloc] init];
    [nextBtn setImage:[UIImage imageNamed:@"music_back_n"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"music_back_y"] forState:UIControlStateHighlighted];
    nextBtn.tag = HMControlButtonTypeNext;
    nextBtn.backgroundColor = HM_RandomColor;
    [nextBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];
    self.nextBtn = nextBtn;
    
    HMShapedButton *reduceBtn = [[HMShapedButton alloc] init];
    [reduceBtn setImage:[UIImage imageNamed:@"music_reduce_n"] forState:UIControlStateNormal];
    [reduceBtn setImage:[UIImage imageNamed:@"music_reduce_y"] forState:UIControlStateHighlighted];
    reduceBtn.tag = HMControlButtonTypeReduce;
    [reduceBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    reduceBtn.backgroundColor = HM_RandomColor;
    [self addSubview:reduceBtn];
    self.reduceBtn = reduceBtn;
    
    HMShapedButton *preBtn = [[HMShapedButton alloc] init];
    [preBtn setImage:[UIImage imageNamed:@"music_forword_n"] forState:UIControlStateNormal];
    [preBtn setImage:[UIImage imageNamed:@"music_forword_y"] forState:UIControlStateHighlighted];
    preBtn.tag = HMControlButtonTypePre;
    preBtn.backgroundColor = HM_RandomColor;
    [preBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:preBtn];
    self.preBtn = preBtn;
    
    HMShapedButton *playBtn = [[HMShapedButton alloc] init];
    [playBtn setImage:[UIImage imageNamed:@"music_play_n"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"music_play_y"] forState:UIControlStateHighlighted];
//    playBtn.backgroundColor = HM_RandomColor;
    playBtn.tag = HMControlButtonTypePlay;
    [playBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtn];
    self.playBtn = playBtn;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    self.playBtn.size = self.playBtn.currentImage.size;
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    self.playBtn.path = [self getPath:5];
    
    self.addBtn.size = self.addBtn.currentImage.size;
    NSLog(@"%f",self.addBtn.currentImage.size.width);
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-self.width * 0.5 - self.playBtn.width * 0.5 * cos(M_PI_4));
    }];
    self.addBtn.path = [self getPath:1];
    
    self.nextBtn.size = self.nextBtn.currentImage.size;
   [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(self.width * 0.5 + self.playBtn.width * 0.5 * cos(M_PI_4));
       make.centerY.equalTo(self);
   }];
   self.nextBtn.path = [self getPath:2];
    
    self.reduceBtn.size = self.reduceBtn.currentImage.size;
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.width * 0.5 + self.playBtn.width * 0.5 * cos(M_PI_4));
        make.centerX.equalTo(self);
    }];
    self.reduceBtn.path = [self getPath:3];
    
    self.preBtn.size = self.preBtn.currentImage.size;
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-self.width * 0.5 - self.playBtn.width * 0.5 * cos(M_PI_4));
    }];
    self.preBtn.path = [self getPath:4];
}

- (UIBezierPath *)getPath:(NSInteger)num {

    CGFloat circleRadius = self.addBtn.width * (sqrt(2) / 2.0);
    CGFloat a = cos(M_PI_4) * self.playBtn.width;
    CGFloat b = (self.addBtn.width - a) / 2.0;
    switch (num) {
        case 1:
        {
            //音量+
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.addBtn.centerX, circleRadius) radius:circleRadius startAngle:-M_PI_2 - M_PI_4 endAngle:-M_PI_2 + M_PI_4 clockwise:1];
            [path addLineToPoint:CGPointMake(b + a, self.addBtn.height)];
            [path addArcWithCenter:CGPointMake(self.addBtn.centerX, circleRadius) radius:self.playBtn.width * 0.5 startAngle:-M_PI_2 + M_PI_4 endAngle:-M_PI_2 - M_PI_4 clockwise:1];
            [path addLineToPoint:CGPointMake(0, self.addBtn.height - b)];
            [path closePath];
            return path;
        }
            break;
        case 2:
        {
            //下一曲  -a / 2.0
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.nextBtn.width -circleRadius,  cos(M_PI_4) * circleRadius) radius:circleRadius startAngle:-M_PI_2 + M_PI_4 endAngle:-M_PI_2 + M_PI_4 * 3 clockwise:1];
            [path addLineToPoint:CGPointMake(0, a + b)];
            [path addArcWithCenter:CGPointMake(-a / 2.0, cos(M_PI_4) * circleRadius) radius:self.playBtn.width * 0.5 startAngle:-M_PI_2 + M_PI_4 * 3 endAngle:-M_PI_2 + M_PI_4 clockwise:1];
            [path addLineToPoint:CGPointMake(b, 0)];
            [path closePath];
            return path;
        }
            break;
        case 3:
        {
            //音量- -cos(M_PI_4) * self.playBtn.width * 0.5
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.addBtn.centerX, self.reduceBtn.height - circleRadius) radius:circleRadius startAngle:-M_PI_2 + M_PI_4 * 3 endAngle:-M_PI_2 + M_PI_4 * 3 + M_PI_4 * 2 clockwise:1];
            [path addLineToPoint:CGPointMake(b, 0)];
            [path addArcWithCenter:CGPointMake(self.addBtn.centerX, -cos(M_PI_4) * self.playBtn.width * 0.5) radius:self.playBtn.width * 0.5 startAngle:-M_PI_2 + M_PI_4 * 3 + M_PI_4 * 2 endAngle:-M_PI_2 + M_PI_4 * 3 clockwise:1];
            [path addLineToPoint:CGPointMake(self.reduceBtn.width, b)];
            [path closePath];
            return path;
        }
            break;
        case 4:
        {
            //上一曲 a / 2.0 + self.preBtn.width
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circleRadius,  cos(M_PI_4) * circleRadius) radius:circleRadius startAngle:-M_PI_2 + M_PI_4 * 3 + M_PI_4 * 2  endAngle:-M_PI_2 + M_PI_4 * 3 + M_PI_4 * 2 + M_PI_4 * 2 clockwise:1];
            [path addLineToPoint:CGPointMake(self.preBtn.width, b)];
            [path addArcWithCenter:CGPointMake(a / 2.0 + self.preBtn.width,  cos(M_PI_4) * circleRadius) radius:self.playBtn.width * 0.5 startAngle:-M_PI_2 + M_PI_4 * 3 + M_PI_4 * 2 + M_PI_4 * 2 endAngle:-M_PI_2 + M_PI_4 * 3 + M_PI_4 * 2 clockwise:1];
            [path addLineToPoint:CGPointMake(self.preBtn.width - b, self.preBtn.height)];
            [path closePath];
//            [path addClip];
            return path;
        }
            break;
        case 5:
        {
            //播放
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.playBtn.centerX, self.playBtn.centerY) radius:self.playBtn.width * 0.5 startAngle:0 endAngle:M_PI * 2 clockwise:1];
            [path closePath];
            return path;
        }
            break;
        default:
            break;
    }
    
    
    return nil;
}

- (void)btnAction:(HMShapedButton *)sender
{
    if (sender.tag == HMControlButtonTypePlay) {
        if ([self.delegate respondsToSelector:@selector(HMControlView:ClickPlayButton:)]) {
            [self.delegate HMControlView:self ClickPlayButton:sender];
        }
    }
    if (sender.tag == HMControlButtonTypeAdd) {
        if ([self.delegate respondsToSelector:@selector(HMControlView:ClickAddButton:)]) {
            [self.delegate HMControlView:self ClickAddButton:sender];
        }
    }
    if (sender.tag == HMControlButtonTypeNext) {
        if ([self.delegate respondsToSelector:@selector(HMControlView:ClickNextButton:)]) {
            [self.delegate HMControlView:self ClickNextButton:sender];
        }
    }
    if (sender.tag == HMControlButtonTypeReduce) {
        if ([self.delegate respondsToSelector:@selector(HMControlView:ClickReduceButton:)]) {
            [self.delegate HMControlView:self ClickReduceButton:sender];
        }
    }
    if (sender.tag == HMControlButtonTypePre) {
        if ([self.delegate respondsToSelector:@selector(HMControlView:ClickPreButton:)]) {
            [self.delegate HMControlView:self ClickPreButton:sender];
        }
    }
    NSLog(@"点我啊 %ld",(long)sender.tag);
}


@end
