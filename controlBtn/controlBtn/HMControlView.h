//
//  HMControlView.h
//  controlBtn
//
//  Created by 侯谢送 on 2016/12/25.
//  Copyright © 2016年 侯谢送. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMShapedButton;
@class HMControlView;
@protocol HMControlViewDelegate <NSObject>
//播放按钮点击事件
- (void)HMControlView:(HMControlView *)controlView ClickPlayButton:(HMShapedButton *)playBtn;
//音量+
- (void)HMControlView:(HMControlView *)controlView ClickAddButton:(HMShapedButton *)addBtn;
//下一曲
- (void)HMControlView:(HMControlView *)controlView ClickNextButton:(HMShapedButton *)nextBtn;
//音量-
- (void)HMControlView:(HMControlView *)controlView ClickReduceButton:(HMShapedButton *)reduceBtn;
//上一曲
- (void)HMControlView:(HMControlView *)controlView ClickPreButton:(HMShapedButton *)preBtn;
@end

@interface HMControlView : UIView

@property (weak, nonatomic) id<HMControlViewDelegate> delegate;

@end
