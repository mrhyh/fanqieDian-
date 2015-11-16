//
//  UIdefine.h
//  TianKeLong
//
//  Created by chenzhihui on 13-9-5.
//  Copyright (c) 2013年 青岛晨之辉信息服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIdefine : NSObject
#define HEIGTH [UIScreen mainScreen].bounds.size.height
#define LcdSize [[UIScreen mainScreen] bounds]
#define lcdW LcdSize.size.width
#define lcdH LcdSize.size.height
#define HEight_3 (HEIGTH-50-20-44)/3
#define BG @"bg"
#define systemVesion [[UIDevice currentDevice] systemVersion]
#define MHHeadUrl @"http://api.chenzhihui.com/interface.php?"
#define ImageMHUrl @"http://api.chenzhihui.com"
//color
#define CellBGColor [UIColor colorWithRed:111.0/256 green:67.0/256 blue:15.0/256 alpha:1]
#define MiaoBianColor [UIColor colorWithRed:210.0/256 green:145.0/256 blue:62.0/256 alpha:1]
#define CharColor [UIColor colorWithRed:206.0/256 green:140.0/256 blue:62.0/256 alpha:1]
#define BUNDLE_NAME @"Resource"
#define DefulatImage [UIImage imageNamed:@"123.jpg"]
//新浪微博
#define App_Key @"2543493366"
#define App_Secret @"6d26bf591f35823c6e02a180a23ccc7f"
#define RedirectURI @"http://www.sina.com"
#define IMAGE_NAME @"icon"
#define IMAGE_EXT @"png"
#define CONTENT @"黔乡牧人主题火锅店，拍3D照片，吃特色美食"
#define SHARE_URL @"http://qcyqd.com"


@end
