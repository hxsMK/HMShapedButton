//
//  ViewController.m
//  controlBtn
//
//  Created by 侯谢送 on 2016/12/25.
//  Copyright © 2016年 侯谢送. All rights reserved.
//

#import "ViewController.h"
#import "HMShapedButton.h"
#import "UIView+Extension.h"
#import "HMControlView.h"
#import "Masonry.h"
@interface ViewController ()<HMControlViewDelegate>

@property (strong, nonatomic) HMShapedButton *addBtn;

@property (strong, nonatomic) HMControlView *controlView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"music_bg"]]];
    
    HMShapedButton *addBtn = [[HMShapedButton alloc] init];
    //        btn3.frame = CGRectMake(10, 370, 200, 100);
//    addBtn.centerX = 120;
//    addBtn.x = 100;
    addBtn.y = 268;
//    addBtn.path = [self getPath:3];
    [addBtn setImage:[UIImage imageNamed:@"music_add_y"] forState:UIControlStateHighlighted];
    [addBtn setImage:[UIImage imageNamed:@"music_add_n"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentImage.size;
//    addBtn.size = CGSizeMake(131, 63);
//    [addBtn setTitle:@"音量+" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    addBtn.backgroundColor = [UIColor clearColor];
    
    self.addBtn = addBtn;
    
    
    
//    HMControlView *controlView = [[HMControlView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    HMControlView *controlView = [[HMControlView alloc] init];
    controlView.size = CGSizeMake(350, 350);
    controlView.center = self.view.center;
    controlView.delegate = self;
    [self.view addSubview:controlView];
    self.controlView = controlView;
    
    
    [self.view addSubview:addBtn];
    [self.view bringSubviewToFront:addBtn];
    NSLog(@"%d",self.controlView.userInteractionEnabled);
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.controlView.mas_top).offset(65);
    }];
    
    NSLog(@"%f  %f",self.controlView.x, self.controlView.y);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"%f",self.controlView.width);
    

    
}

- (void)HMControlView:(HMControlView *)controlView ClickPlayButton:(HMShapedButton *)playBtn {
    NSLog(@"播放歌曲");
}
- (void)HMControlView:(HMControlView *)controlView ClickAddButton:(HMShapedButton *)addBtn {
    NSLog(@"音量+");
}
- (void)HMControlView:(HMControlView *)controlView ClickNextButton:(HMShapedButton *)nextBtn {
    NSLog(@"下一曲");
}

- (void)HMControlView:(HMControlView *)controlView ClickReduceButton:(HMShapedButton *)reduceBtn {
    NSLog(@"音量-");
}

- (void)HMControlView:(HMControlView *)controlView ClickPreButton:(HMShapedButton *)preBtn {
    NSLog(@"上一曲");
}

- (UIBezierPath *)getPath:(NSInteger)num {
    
    return nil;
}

- (void)btnAction:(HMShapedButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 + 1) / 255.0
                                             green:(arc4random() % 255 + 1) / 255.0
                                              blue:(arc4random() % 255 + 1) / 255.0
                                             alpha:1.0];
}

@end
