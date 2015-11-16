//
//  CanTingSelectViewController.m
//  fanqieDian
//
//  Created by chenzhihui on 13-11-4.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import "CanTingSelectViewController.h"
#import "UIViewController+TopView.h"
@interface CanTingSelectViewController ()

@end

@implementation CanTingSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor blackColor];
    [self loadTopView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(50, 50, 150, 40);
    [button setTitle:@"选择这家餐厅" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backoo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadTopView{
    [self loadNavBar];
    [self loadMiddleView:@"餐厅选择"];
    [self loadLeftButton:@"navbar_people" andSelected:@"navbar_people_selected"];
    [self setLeftButtonAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
}
-(void)backoo{
    NSDictionary *dic=[NSDictionary dictionary];
    [self.delegate selectedCanTing:dic];
    [self.navigationController popViewControllerAnimated:YES];

}
@end
