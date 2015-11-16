//
//  HomeViewController.h
//  fanqieDian
//
//  Created by chenzhihui on 13-11-4.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : UIViewController<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *myScrollView;
@property(strong,nonatomic)UILabel *numLabel;
@property(strong,nonatomic)UIImageView *leftIn;
@property(strong,nonatomic)UIImageView *rightIn;
@property(strong,nonatomic)AVAudioPlayer *player;
@property(strong,nonatomic)NSTimer *timer;
-(void)selectedCanTing:(NSDictionary *)dic;
@end
