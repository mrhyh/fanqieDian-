//
//  HomeViewController.m
//  fanqieDian
//
//  Created by chenzhihui on 13-11-4.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CanTingSelectViewController.h"
#import "UIViewController+TopView.h"
#import "CaiDanViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
UIImageView *imageViewBG;//头部的整体大图
UIImageView *imageView;//下方闪烁的圆圈
UIView *selectBGView; //滑动的背景
UIImageView *selcetCan;//上边的圆圈
UIImageView *loctationCan;//跳动的箭头
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.view.window.backgroundColor=[UIColor blackColor];
    [self loadTopView];
    [self loadMySelectedCanView];
    [self loadMyScrlloview];
    [self loadInditer];
    self.player=[[AVAudioPlayer alloc]init];
    [self loadBottomView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CustomView
-(void)loadTopView{
    [self loadNavBar];
    [self loadMiddleView:@"七彩源美食"];
    [self loadLeftButton:@"navbar_people" andSelected:@"navbar_people_selected"];
    [self setLeftButtonAction:^{
        NSLog(@"左键");
    }];
    [self loadRightButton:@"navbar_set" andSelected:@"navbar_set_selected"];
    [self setRightButtonAction:^{
        NSLog(@"右键");
    }];
    
}
//头部的选择餐厅界面
-(void)loadMySelectedCanView{
    
    imageViewBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 320, lcdH/3+155)];
    imageViewBG.image=[UIImage imageNamed:@"cm_sight"];
    imageViewBG.userInteractionEnabled=YES;
    [self.view addSubview:imageViewBG];
//    main_map
    NSMutableArray *iArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<10; i++) {
        NSString *name=[NSString stringWithFormat:@"abFrame_%d",i%10+1];
        UIImage *image=[UIImage imageNamed:name];
        [iArr addObject:image];
    }
    UITapGestureRecognizer *selcetCanTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCan:)];
   
    selcetCan=[[UIImageView alloc]initWithFrame:CGRectMake(120, 40, 80, 80)];
    selcetCan.userInteractionEnabled=YES;
    selcetCan.contentMode=UIViewContentModeScaleToFill;
    selcetCan.animationImages=iArr;
    selcetCan.image=[UIImage imageNamed:@"abFrame_2"];
    selcetCan.animationDuration=2;
    [selcetCan addGestureRecognizer:selcetCanTap];
    [imageViewBG addSubview:selcetCan];
    [selcetCan startAnimating];
    loctationCan=[[UIImageView alloc]initWithFrame:CGRectMake(25, 25, 30, 30)];
    loctationCan.contentMode=UIViewContentModeScaleToFill;
    loctationCan.image=[UIImage imageNamed:@"main_map"];
  
    [selcetCan addSubview:loctationCan];
    
}
//滑动选择数量的scrlloview
-(void)loadMyScrlloview{
    selectBGView=[[UIView alloc]initWithFrame:CGRectMake(0, 300, 320, 60)];
    selectBGView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:selectBGView];
    
    UIImageView *imageBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    imageBG.image=[UIImage imageNamed:@"topscroll_sight"];
    imageBG.contentMode=UIViewContentModeScaleToFill;
    
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 15, 280, 30)];
    self.myScrollView.contentSize=CGSizeMake(11*40+40*6 , 30);
    self.myScrollView.delegate=self;
    for (int i=0; i<11; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(120+i*40, 0, 39, 30);
        [button setTitle:[NSString stringWithFormat:@"%d",i+2] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor blackColor];
        button.alpha=0.7;
        [button addTarget:self action:@selector(numBtnTaped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=100+i;
        [self.myScrollView addSubview:button];
    }
    self.myScrollView.showsHorizontalScrollIndicator=NO;
    self.myScrollView.backgroundColor=[UIColor clearColor];
    self.myScrollView.scrollsToTop=NO;
    self.myScrollView.bounces=NO;
    [selectBGView addSubview:self.myScrollView];
    [selectBGView addSubview:imageBG];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(135, 5, 50, 50)];
    
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:24];
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor clearColor];
    self.numLabel=label;
    int x=(int)self.myScrollView.contentOffset.x/40;
    self.numLabel.text=[NSString stringWithFormat:@"%d",x+2];
    //添加监听 self.numlabel.text改变内容的时候播放音乐
    [self addObserver:self forKeyPath:@"numLabel.text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [selectBGView addSubview:self.numLabel];
    
}
//左右的显示标示
-(void)loadInditer{
    UIImageView *leftIn=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 20, 30)];
    leftIn.image=[UIImage imageNamed:@"topscroll_arrow_left"];
    leftIn.backgroundColor=[UIColor blackColor];
    leftIn.alpha=0.6;
    leftIn.contentMode=UIViewContentModeCenter;
    leftIn.hidden=YES;
    self.leftIn=leftIn;
    [selectBGView addSubview:self.leftIn];
    
    UIImageView *rightIn=[[UIImageView alloc]initWithFrame:CGRectMake(300, 15, 20, 30)];
    rightIn.image=[UIImage imageNamed:@"topscroll_arrow_right"];
    rightIn.contentMode=UIViewContentModeCenter;
    rightIn.backgroundColor=[UIColor blackColor];
    rightIn.alpha=0.6;
    rightIn.hidden=NO;
    self.rightIn=rightIn;
    [selectBGView addSubview:self.rightIn];
    NSMutableArray *iArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=1; i<=10; i++) {
        NSString *name=[NSString stringWithFormat:@"abFrame_%d",i];
        UIImage *image=[UIImage imageNamed:name];
        [iArr addObject:image];
    }
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(125, -5, 70, 70)];
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.animationImages=iArr;
    imageView.animationDuration=2;
    [selectBGView addSubview:imageView];
    
    [imageView startAnimating];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(jumpToWait) userInfo:nil repeats:YES];
    [self.timer fire];
    
}
#pragma mark - Scrollview Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>=120||scrollView.contentOffset.y<=10*40+120) {
        int x=(int)scrollView.contentOffset.x/40;
        int y=(int)scrollView.contentOffset.x%40;
        if (y>20) {
            self.numLabel.text=[NSString stringWithFormat:@"%d",x+3];
            [self.myScrollView setContentOffset:CGPointMake(x*40+40, 0)animated:YES];
        }else{
            [self.myScrollView setContentOffset:CGPointMake(x*40, 0)animated:YES];
            self.numLabel.text=[NSString stringWithFormat:@"%d",x+2];
        }
        
    }
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        int x=(int)scrollView.contentOffset.x/40;
        int y=(int)scrollView.contentOffset.x%40;
        if (y>20) {
            [self.myScrollView setContentOffset:CGPointMake(x*40+40, 0)animated:YES];
            self.numLabel.text=[NSString stringWithFormat:@"%d",x+3];
        }else{
            [self.myScrollView setContentOffset:CGPointMake(x*40, 0)animated:YES];
            self.numLabel.text=[NSString stringWithFormat:@"%d",x+2];
        }
        
    }else{
        
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int x=(int)scrollView.contentOffset.x/40;
    int y=(int)scrollView.contentOffset.x%40;
    if (y>20) {
        self.numLabel.text=[NSString stringWithFormat:@"%d",x+3];
    }else{
        self.numLabel.text=[NSString stringWithFormat:@"%d",x+2];
    }
    if (scrollView.contentOffset.x<=120) {
        self.leftIn.hidden=YES;
    }else{
        self.leftIn.hidden=NO;
    }
    if (scrollView.contentOffset.x>scrollView.contentSize.width-300-40*3) {
        self.rightIn.hidden=YES;
    }else{
        self.rightIn.hidden=NO;
    }
    
    
}
-(void)numBtnTaped:(UIButton *)button{
    
    int index=button.tag-100;
    [self.myScrollView setContentOffset:CGPointMake(index*40, 0) animated:YES];
}
#pragma mark - PlayMusic
-(void)playMustic:(int)kind{
    NSString *str=nil;
    switch ((kind-2)%5) {
        case 0:
            str=@"wav_1";
            break;
        case 1:
            str=@"wav_2";
            break;
        case 2:
            str=@"wav_3";
            break;
        case 3:
            str=@"wav_4";
            break;
        case 4:
            str=@"wav_5";
            break;
        default:
            break;
    }
    NSString *sourcePath=[[NSBundle mainBundle]pathForResource:str ofType:@"wav"];
    NSURL *url=[[NSURL alloc]initFileURLWithPath:sourcePath];
    [self.player initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    [self.player play];
    
}
//根据、观察到的numlabel的变化 播放不同的音乐
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    int newValue=[[change valueForKey:NSKeyValueChangeOldKey]intValue];
    int oldValue=[[change valueForKey:NSKeyValueChangeNewKey]intValue];
    if (newValue!=oldValue) {
        [self playMustic:newValue];
    }
    [imageView stopAnimating];
    
}

#pragma mark - buttonTaped Methods
-(void)loginButtonTaped:(UIButton *)button{

}
//选择餐厅的实现
-(void)selectCan:(UIGestureRecognizer *)tap{
    //回复动画现场
    [[self.view viewWithTag:111]removeFromSuperview];
    selcetCan.frame=CGRectMake(120, 40, 80, 80);
    loctationCan.frame =CGRectMake(25, 25, 30, 30);
    CanTingSelectViewController *canTingVC=[[CanTingSelectViewController alloc]init];
    canTingVC.delegate=self;
    [self.navigationController pushViewController:canTingVC animated:YES];
}
#pragma mark 计时器
-(void)jumpToWait{
    //关键帧动画 ，关于位置的动画用 position
    CAKeyframeAnimation *keyAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSMutableArray *frameArr=[NSMutableArray arrayWithCapacity:0];
    CGPoint point=loctationCan.center;
    [frameArr addObject:[NSValue valueWithCGPoint:point]];
    for (int height=16; height>=2; height=height/2) {
        CGPoint p1=CGPointMake(point.x,point.y-height);
        CGPoint p2=CGPointMake(point.x,point.y);
        [frameArr addObject:[NSValue valueWithCGPoint:p1]];
        [frameArr addObject:[NSValue valueWithCGPoint:p2]];
    }
    keyAnimation.duration=4;
    keyAnimation.values=frameArr;
    keyAnimation.repeatCount=1;
    keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];;
    [loctationCan.layer addAnimation:keyAnimation forKey:@"position"];

}
-(void)selectedCanTing:(NSDictionary *)dic{
    [self.timer invalidate];
    [selcetCan stopAnimating];
    UIImageView *imgeView1=[[UIImageView alloc]initWithFrame:CGRectMake(100, 125, 120, 50)];
    imgeView1.backgroundColor=[UIColor blackColor];
    [imageViewBG insertSubview:imgeView1 belowSubview:selcetCan];
    loctationCan.contentMode=UIViewContentModeScaleAspectFit;
    
    [UIView animateWithDuration:0.8 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imgeView1.frame=CGRectMake(30, 70, 260 ,150);
        imgeView1.tag=111;
        selcetCan.frame=CGRectMake(120, 20, 80, 80);
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark Bottom
-(void)loadBottomView{
    UIButton *buttonLeft=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLeft.frame=CGRectMake(20, lcdH-80, 100, 35);
    [buttonLeft setTitle:@"一键点餐" forState:UIControlStateNormal];
    [buttonLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"cm_btn_red_selected"] forState:UIControlStateHighlighted];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"cm_btn_red"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(leftButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    buttonLeft.layer.cornerRadius=5;
    buttonLeft.layer.masksToBounds=YES;

    [self.view addSubview:buttonLeft];
    
    UIButton *buttonRight=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonRight.frame=CGRectMake(200, lcdH-80, 100, 35);
    [buttonRight setTitle:@"查看菜单" forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"cm_btn_red_selected"] forState:UIControlStateHighlighted];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"cm_btn_red"] forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(rightButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    buttonRight.layer.cornerRadius=5;
    buttonRight.layer.masksToBounds=YES;
    [self.view addSubview:buttonRight];

}
-(void)leftButtonTaped:(UIButton *)button{

}
-(void)rightButtonTaped:(UIButton *)button{
    CaiDanViewController *canDanVC=[[CaiDanViewController alloc]init];
    [self.navigationController pushViewController:canDanVC animated:YES];
}
@end
