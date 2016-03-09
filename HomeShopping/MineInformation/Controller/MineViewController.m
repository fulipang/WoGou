//
//  MineViewController.m
//  HomeShopping
//
//  Created by sooncong on 15/12/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MineViewController.h"
#import "ModifyUserInfoViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "ReceivingGoodsAddressViewController.h"
#import "ModifyAccountOrPasswordViewController.h"
#import "SettingViewController.h"
#import "MyCoinViewController.h"
#import "CollectionViewController.h"
#import "BrowseHistoryViewController.h"
#import "MyCommentViewController.h"
#import "MyOrderHotelSuppliesViewController.h"
#import "MyOrderRoomReservationViewController.h"
#import "UIImageView+WebCache.h"
#import "UserInfoParser.h"
#import "ShoppingCartViewController.h"
#import "ModifyPassWordViewController.h"

#define INFO_CELL_HEIGHT 135
#define NORMAL_CELL_HEIGHT 44
#define NORMAL_FONTSIZE 15

@implementation MineViewController
{
    UITableView * _mainTableView;
    
    //标题
    NSArray * _titles;
    
    UserInfo * _user;
    
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getUserInfoData];
    
    if (_mainTableView) {
        [_mainTableView reloadData];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTitles];
    
    [self loadUpCustomeView];
}

#pragma mark - 初始化数据

-(void)initTitles
{
    _titles = [NSArray arrayWithObjects:@"我的商品订单",@"我的订房订单",@"我的评价",@"我的狗币",@"修改密码",@"收货地址管理",@"设置", nil];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图
 */
- (void)loadUpCustomeView
{
    //  初始化自定义导航摊
    [self setUpCustomNavigationBar];
    
    //  初始化自定义视图
    [self setUpCustomView];
}

- (void)setUpCustomNavigationBar
{
    [self setNavigationBarTitle:@"我的"];
    
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
}

- (void)setUpCustomView
{
    [self setUpMainTableView];
}

-(void)setUpMainTableView
{
    
    //初始化
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_mainTableView];
    
    //位置
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    
    //配置
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置代理
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    
    //注册cell
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];
}

#pragma mark -- 自定义cell

/**
 *  根据index 判断创建不同的cell
 *
 *  @param indexPath
 *
 *  @return 自定义cell 的view
 */
- (UIView *)viewWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self createInfoView];
    }else{
        return [self createNormalViewWithIndexPath:indexPath];
    }
}

/**
 *  创建个人信息cell view
 *
 *  @return
 */
- (UIView *)createInfoView
{
    
    UIView * infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(INFO_CELL_HEIGHT))];
    //    infoView.backgroundColor = [UIColor orangeColor];
    
    //头像
    UIImageView * _headImageView = [UIImageView new];
    UIImage * headImage = [UIImage imageNamed:@"mine_defaultHead"];
    _headImageView.image = headImage;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_user.logo] placeholderImage:headImage];
    [infoView addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoView.mas_left).with.offset(GET_SCAlE_LENGTH(15));
        make.centerY.mas_equalTo(infoView.mas_centerY).with.offset(- GET_SCAlE_HEIGHT(INFO_CELL_HEIGHT/4));
        make.size.mas_equalTo(CGSizeMake(headImage.size.width, headImage.size.height));
    }];
    _headImageView.layer.cornerRadius = headImage.size.width/2;
    _headImageView.clipsToBounds = YES;
    UITapGestureRecognizer * headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapWithObject:)];
    [_headImageView addGestureRecognizer:headTap];
    _headImageView.userInteractionEnabled = YES;
    
    
    
    //登陆注册组件
    UIView * AuthorizedView = [UIView new];
    [infoView addSubview:AuthorizedView];
    [AuthorizedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.centerY);
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(110), GET_SCAlE_HEIGHT(35)));
    }];
    //    AuthorizedView.backgroundColor = [UIColor greenColor];
    
    //中部横线
    UILabel * line1 = [UILabel new];
    [infoView addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(infoView.centerY);
        make.centerX.mas_equalTo(infoView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line1.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    //底部横线
    UILabel * line2 = [UILabel new];
    [infoView addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(infoView.mas_bottom);
        make.centerX.mas_equalTo(infoView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line2.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //底部中线
    UILabel * line = [UILabel new];
    [infoView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(infoView.mas_centerX);
        make.centerY.mas_equalTo(infoView.mas_bottom).with.offset(- GET_SCAlE_HEIGHT(INFO_CELL_HEIGHT)/4.0);
        make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(50)));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //创建item
    
    UIView * history = [self createItemViewWithImageName:@"mine_history" Title:@"浏览历史"];
    [infoView addSubview:history];
    [history makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_centerY);
        make.centerX.mas_equalTo(infoView.mas_centerX).with.offset( -SCREEN_WIDTH/4);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(120), GET_SCAlE_HEIGHT(60)));
    }];
    history.tag = 160;
    
    UIView * myCollection = [self createItemViewWithImageName:@"mine_star" Title:@"我的收藏"];
    [infoView addSubview:myCollection];
    [myCollection makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_centerY);
        make.centerX.mas_equalTo(infoView.mas_centerX).with.offset(SCREEN_WIDTH/4);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(120), GET_SCAlE_HEIGHT(60)));
    }];
    myCollection.tag = 161;
    
    //添加事件
    UITapGestureRecognizer * historyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoViwTapedWithTap:)];
    UITapGestureRecognizer * collectionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoViwTapedWithTap:)];
    [history addGestureRecognizer:historyTap];
    [myCollection addGestureRecognizer:collectionTap];
    
    NSString * code = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
    
    if (code) {
        
        UILabel * UserNameLabel  = [UILabel new];
        [infoView addSubview:UserNameLabel];
        [UserNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_headImageView.centerY).with.offset(0);
            make.left.mas_equalTo(_headImageView.right).with.offset(GET_SCAlE_LENGTH(10));
        }];
        UserNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
        UserNameLabel.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
        UserNameLabel.text = _user.nickname;
        
        UIImageView * arrow = [UIImageView new];
        arrow.image = [UIImage imageNamed:@"arrow_right"];
        [infoView addSubview:arrow];
        [arrow makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_headImageView.centerY);
            make.right.mas_equalTo(infoView.right).with.offset(GET_SCAlE_LENGTH(- 15));
            make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
        }];
        
    }else{
        //登陆按钮
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [AuthorizedView addSubview:loginButton];
        [loginButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.and.bottom.mas_equalTo(AuthorizedView);
            make.width.mas_equalTo(GET_SCAlE_LENGTH(110)/2);
        }];
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [loginButton setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //注册按钮
        UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [AuthorizedView addSubview:registerButton];
        [registerButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.and.bottom.mas_equalTo(AuthorizedView);
            make.width.mas_equalTo(GET_SCAlE_LENGTH(110)/2);
        }];
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [registerButton setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //分割线
        UILabel * authorLine = [UILabel new];
        [AuthorizedView addSubview:authorLine];
        [authorLine makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(AuthorizedView.mas_centerY);
            make.centerX.mas_equalTo(AuthorizedView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(20)));
        }];
        authorLine.backgroundColor = UIColorFromRGB(LINECOLOR);
        
    }
    return infoView;

}

- (UIView *)createItemViewWithImageName:(NSString *)imageName Title:(NSString *)title
{
    UIView * contentView = [[UIView alloc] init];
    
    UIImageView * picturView = [UIImageView new];
    [contentView addSubview:picturView];
    [picturView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY).with.offset(- 10);
        make.centerX.mas_equalTo(contentView.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(25), GET_SCAlE_LENGTH(25)));
    }];
    picturView.image = [UIImage imageNamed:imageName];
    
    UILabel * titleLabel = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(picturView.mas_bottom);
        make.left.bottom.and.right.mas_equalTo(contentView);
    }];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return contentView;
}

/**
 *  创建通用cell view
 *
 *  @return
 */
- (UIView *)createNormalViewWithIndexPath:(NSIndexPath *)indexPath
{
    UIView * normalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(NORMAL_CELL_HEIGHT))];
    
    if (indexPath.row != 7) {
        
        //底部线
        UILabel * line = [UILabel new];
        [normalView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(normalView.mas_bottom);
            make.right.mas_equalTo(normalView.mas_right);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 1));
        }];
        line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        
        //标题
        UILabel * titleLabel = [UILabel new];
        [normalView addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(normalView.centerY);
            make.left.mas_equalTo(normalView.mas_left).with.offset(GET_SCAlE_LENGTH(25));
        }];
        
        
        
        titleLabel.text = _titles[indexPath.row];
        titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
        titleLabel.font = [UIFont systemFontOfSize:NORMAL_FONTSIZE];
        
        //图标
        UIImageView * symbol = [UIImageView new];
        symbol.image = [UIImage imageNamed:@"arrow_right"];
        [normalView addSubview:symbol];
        [symbol makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(normalView.centerY);
            make.right.mas_equalTo(normalView.mas_right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(symbol.image.size.width, symbol.image.size.height));
        }];
    }
    
    else
    {
        UIButton * logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [normalView addSubview:logOutButton];
        [logOutButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(normalView.centerX);
            make.centerY.mas_equalTo(normalView.centerY);
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(280), GET_SCAlE_HEIGHT(35)));
        }];
        [logOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [logOutButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
        [logOutButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
        logOutButton.backgroundColor = [UIColor orangeColor];
        logOutButton.layer.cornerRadius = 10;
        logOutButton.clipsToBounds = YES;
        
        [logOutButton addTarget:self action:@selector(logOutClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return normalView;
}

#pragma mark - 网络

- (void)getUserInfoData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"userdetail" forKey:@"functionid"];
    
    NSString * userid = [[AppInformationSingleton shareAppInfomationSingleton] getUserID];
    NSString * ut = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
    
    if (ut) {
        [headDic setObject:userid forKey:@"userid"];
        [headDic setObject:ut forKey:@"ut"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        UserInfoParser * parser  = [[UserInfoParser alloc] initWithDictionary:responseBody];
        _user = parser.userInfo;
        
        [_mainTableView reloadData];
    } FailureBlock:^(NSString *error) {
        
    }];
}

#pragma mark - 事件

-(void)rightButtonClicked
{
    if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        NSString *showMsg = @"请先登录";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles: @"确定", nil];
        
        [alert show];
        
    }else{
        self.hidesBottomBarWhenPushed = YES;
        ShoppingCartViewController * VC = [[ShoppingCartViewController alloc] initWithProductType:kProductTypeVirtual];
        [self.navigationController pushViewController:VC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)headTapWithObject:(UITapGestureRecognizer *)tap
{
    
    self.hidesBottomBarWhenPushed     = YES;
    ModifyUserInfoViewController * VC = [[ModifyUserInfoViewController alloc] initWithUserInfo:_user];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed     = NO;
}

- (void)registerButtonClicked
{
    RegisterViewController * VC = [[RegisterViewController alloc] initWithApperType:kApperTypePresent];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:^{
        [_mainTableView reloadData];
    }];
}

- (void)loginButtonClicked
{

    LoginViewController * VC = [[LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

/**
 *  顶部信息栏点击事件
 *
 *  @param tap 当前手势
 */
-(void)infoViwTapedWithTap:(UITapGestureRecognizer *)tap
{
    InfoViewTapType type = tap.view.tag % 10;
    
    switch (type) {
        case kInfoViewTypeHistory: {
            self.hidesBottomBarWhenPushed = YES;
            BrowseHistoryViewController * VC = [[BrowseHistoryViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case kInfoViewTypeCollection: {
            
            if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
                NSString *showMsg = @"请先登录";
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                                message: showMsg
                                                               delegate: self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles: @"确定", nil];
                
                [alert show];
                
            }else{
                self.hidesBottomBarWhenPushed = YES;
                CollectionViewController * VC = [[CollectionViewController alloc] init];
                [self.navigationController pushViewController:VC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
    }
}

- (void)logOutClicked
{
    [[AppInformationSingleton shareAppInfomationSingleton] logOutUser];
    
    [self getUserInfoData];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(10))];
    headerView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0)?0:GET_SCAlE_HEIGHT(10);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0)?1:([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode])?8:7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (id obj in cell.contentView.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView * view = (UIView *)obj;
            [view removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:[self viewWithIndexPath:indexPath]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0 && indexPath.section == 0)?GET_SCAlE_HEIGHT(INFO_CELL_HEIGHT):GET_SCAlE_HEIGHT(NORMAL_CELL_HEIGHT);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self headTapWithObject:nil];
        return;
    }
    
    if (indexPath.row != 6) {
        if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
            NSString *showMsg = @"请先登录";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                            message: showMsg
                                                           delegate: self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles: @"确定", nil];
            
            [alert show];
            return;
        }
    }
    
    MineTableViewSelectType type = indexPath.row;
    
    switch (type) {
        case kMineTableViewSelectTypeCommodityOrder: {
            self.hidesBottomBarWhenPushed = YES;
            MyOrderHotelSuppliesViewController * VC = [[MyOrderHotelSuppliesViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case kMineTableViewSelectTypeHotelOrder: {
            self.hidesBottomBarWhenPushed = YES;
            MyOrderRoomReservationViewController * VC = [[MyOrderRoomReservationViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
            break;
        }
        case kMineTableViewSelectTypeMyComment: {
            self.hidesBottomBarWhenPushed = YES;
            MyCommentViewController * VC = [[MyCommentViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case kMineTableViewSelectTypeMyCoin: {
            self.hidesBottomBarWhenPushed = YES;
            MyCoinViewController * VC = [[MyCoinViewController alloc] initWithCoinNumber:_user.coints];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case kMineTableViewSelectTypeModifyAccountOrPassWord: {
            self.hidesBottomBarWhenPushed = YES;
            ModifyPassWordViewController * VC = [[ModifyPassWordViewController alloc] initWithTelPhoneNumber:_user.telephone];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case kMineTableViewSelectTypeReceivingGoodsAddress: {
            self.hidesBottomBarWhenPushed = YES;
            ReceivingGoodsAddressViewController * VC = [[ReceivingGoodsAddressViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case kMineTableViewSelectTypeSetting: {
            self.hidesBottomBarWhenPushed = YES;
            SettingViewController * VC = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        LoginViewController * VC = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}


@end
