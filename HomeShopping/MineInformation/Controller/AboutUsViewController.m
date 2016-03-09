//
//  AboutUsViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/2/5.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "AboutUsViewController.h"

@implementation AboutUsViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"关于我们"];
    
    [self createContent];
}

- (void)createContent
{
    UILabel * contentLabel  = [UILabel new];
    [self.view addSubview:contentLabel];
    [contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom).with.offset(GET_SCAlE_HEIGHT(25));
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_LENGTH(15));
        make.right.mas_equalTo(self.view.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    contentLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    contentLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    contentLabel.numberOfLines = 0;
    contentLabel.text = @"          购窝商城由深圳前海大爱联盟网络科技有限公司于2015年创建，是一个以互联网技术为核心的线上线下积分联盟平台，由运营商、联盟商家、消费者三种角色组成，能为所有消费者获得更多的实惠。\n         购窝商城一直以来以“诚信”作为公司和每位员工的行为准则，以“超越客户期望”为目标，致力于为消费者提供省心、省力、省钱的最佳购物体验。";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentLabel.text.length)];
    
    contentLabel.attributedText = attributedString;

}


#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

@end
