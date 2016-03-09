//
//  UIBaseViewController.m
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"
#import "Comments.h"
#import "HPAddsModel.h"
#import "AdvertisementWebViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "HotelSupplyListViewController.h"
#import "PreviewController.h"

@interface UIBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation UIBaseViewController
{
    /**
     *  设置按钮时是否同时存在文字和图片
     */
    BOOL isBoth;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.view.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    //    [self customNavigationBar];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    else {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    if (self.navigationController.viewControllers[0] == self) {
        //        [self showTabBar];
    }
    else {
        
        //        [self hideTabBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark - 视图相关

-(UIView *)customNavigationBar
{
    if (_customNavigationBar == nil) {
        
        _customNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        [self.view addSubview:_customNavigationBar];
        
        _customNavigationBar.backgroundColor = [UIColor clearColor];
        _customNavigationBar.alpha = 1;
        _customNavigationBar.userInteractionEnabled = YES;
        
        [_customNavigationBar addSubview:self.navBackGroundView];
        
        [self customNavBarLeftBtn];
        
        [self customNavBarRightBtn];
        
    }
    
    return _customNavigationBar;
}

-(UILabel *)customNavBarTitleLabel
{
    if (_customNavBarTitleLabel == nil) {
        
        _customNavBarTitleLabel = [UILabel new];
        [self.customNavigationBar addSubview:_customNavBarTitleLabel];
        [_customNavBarTitleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_customNavigationBar.mas_top).with.offset(25);
            make.centerY.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(-22);
            make.centerX.mas_equalTo(_customNavigationBar.mas_centerX);
        }];
        _customNavBarTitleLabel.backgroundColor = [UIColor clearColor];
        _customNavBarTitleLabel.textColor = UIColorFromRGB(WHITECOLOR);
        _customNavBarTitleLabel.tag = CUSTOM_TITLE_TAG;
        _customNavBarTitleLabel.font = [UIFont systemFontOfSize: LARGEFONTSIZE];
        _customNavBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _customNavBarTitleLabel;
}

-(UIView *)navBackGroundView
{
    if (_navBackGroundView == nil) {
        
        _navBackGroundView = [UIImageView new];
        [self.customNavigationBar addSubview:_navBackGroundView];
        [_navBackGroundView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _navBackGroundView.backgroundColor = UIColorFromRGB(NAVIGATIONBLUECOLOR);
        _navBackGroundView.alpha = 1;
    }
    
    return _navBackGroundView;
}

-(UIButton *)customNavBarLeftBtn
{
    if (_customNavBarLeftBtn == nil) {
        
        _customNavBarLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.customNavigationBar addSubview:_customNavBarLeftBtn];
        [_customNavBarLeftBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.customNavigationBar.mas_left).with.offset(10);
            make.top.mas_equalTo(self.customNavigationBar.mas_top).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        _customNavBarLeftBtn.backgroundColor = [UIColor clearColor];
        _navBackGroundView.tag = CUSTOM_LEFT_TAG;
        
        /**
         *  自定义label
         */
        if (isBoth) {
            
            _customNavBarLeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
            
            UILabel * customeTitleLabel          = [UILabel new];
            [_customNavBarLeftBtn addSubview:customeTitleLabel];
            [customeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_customNavBarLeftBtn.mas_centerX);
                make.bottom.mas_equalTo(_customNavBarLeftBtn.mas_bottom);
            }];
            customeTitleLabel.text               = @"分享";
            customeTitleLabel.font               = [UIFont systemFontOfSize:9];
            customeTitleLabel.textColor          = UIColorFromRGB(WHITECOLOR);
            customeTitleLabel.backgroundColor    = [UIColor clearColor];
        }
        
        [_customNavBarLeftBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _customNavBarLeftBtn;
}

-(UIButton *)customNavBarRightBtn
{
    if (_customNavBarRightBtn == nil) {
        
        _customNavBarRightBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customNavigationBar addSubview:_customNavBarRightBtn];
        [_customNavBarRightBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_customNavigationBar.mas_right).with.offset(- 10);
            make.top.mas_equalTo(_customNavigationBar.mas_top).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        _customNavBarRightBtn.backgroundColor = [UIColor clearColor];
        _customNavBarRightBtn.tag = CUSTOM_RIGHT_TAG;
        
        /**
         *  自定义label
         */
        if (isBoth) {
            
            _customNavBarRightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
            
            UILabel * customeTitleLabel           = [UILabel new];
            [_customNavBarRightBtn addSubview:customeTitleLabel];
            [customeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_customNavBarRightBtn.mas_centerX);
                make.bottom.mas_equalTo(_customNavBarRightBtn.mas_bottom);
            }];
            customeTitleLabel.text                = @"购物车";
            customeTitleLabel.font                = [UIFont systemFontOfSize:9];
            customeTitleLabel.textColor           = UIColorFromRGB(WHITECOLOR);
        }
        [self.customNavBarRightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _customNavBarRightBtn;
}

#pragma mark -- 设置

-(void)setNavigationBarLeftButtonTitle:(NSString *)leftButtonTitleStr
{
    [self.customNavBarLeftBtn setTitle:leftButtonTitleStr forState:UIControlStateNormal];
    [self.customNavBarLeftBtn setTitle:leftButtonTitleStr forState:UIControlStateHighlighted];
}

-(void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr
{
    [self.customNavBarLeftBtn setImage:[UIImage imageNamed:leftButtonImageStr] forState:UIControlStateNormal];
    [self.customNavBarLeftBtn setImage:[UIImage imageNamed:leftButtonImageStr] forState:UIControlStateHighlighted];
}

-(void)setNavigationBarRightButtonTitle:(NSString *)rightButtonTitleStr
{
    [self.customNavBarRightBtn setTitle:rightButtonTitleStr forState:UIControlStateNormal];
    [self.customNavBarRightBtn setTitle:rightButtonTitleStr forState:UIControlStateHighlighted];
    self.customNavBarRightBtn.titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
}

-(void)setNavigationBarRightButtonImage:(NSString *)rightButtonImageStr
{
    [self.customNavBarRightBtn setImage:[UIImage imageNamed:rightButtonImageStr] forState:UIControlStateNormal];
    [self.customNavBarRightBtn setImage:[UIImage imageNamed:rightButtonImageStr] forState:UIControlStateHighlighted];
}

-(void)setNavigationBarTitle:(NSString *)title
{
    self.customNavBarTitleLabel.text = title;
}

-(void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr WithTitle:(NSString *)title
{
    _customNavBarLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:_customNavBarLeftBtn];
    [_customNavBarLeftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.customNavigationBar.mas_left).with.offset(10);
        make.top.mas_equalTo(self.customNavigationBar.mas_top).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    _customNavBarLeftBtn.backgroundColor = [UIColor clearColor];
    _navBackGroundView.tag = CUSTOM_LEFT_TAG;
    
    [_customNavBarLeftBtn setImage:[UIImage imageNamed:leftButtonImageStr] forState:UIControlStateHighlighted];
    [_customNavBarLeftBtn setImage:[UIImage imageNamed:leftButtonImageStr] forState:UIControlStateNormal];
    _customNavBarLeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    
    UILabel * customeTitleLabel          = [UILabel new];
    [_customNavBarLeftBtn addSubview:customeTitleLabel];
    [customeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_customNavBarLeftBtn.mas_centerX);
        make.bottom.mas_equalTo(_customNavBarLeftBtn.mas_bottom);
    }];
    customeTitleLabel.text               = title;
    customeTitleLabel.font               = [UIFont systemFontOfSize:9];
    customeTitleLabel.textColor          = UIColorFromRGB(WHITECOLOR);
    customeTitleLabel.backgroundColor    = [UIColor clearColor];
    
    [_customNavBarLeftBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setNavigationBarRightButtonImage:(NSString *)rightButtonImageStr WithTitle:(NSString *)title
{
    _customNavBarRightBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_customNavigationBar addSubview:_customNavBarRightBtn];
    [_customNavBarRightBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_customNavigationBar.mas_right).with.offset(- 10);
        make.top.mas_equalTo(_customNavigationBar.mas_top).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    _customNavBarRightBtn.backgroundColor = [UIColor clearColor];
    _customNavBarRightBtn.tag = CUSTOM_RIGHT_TAG;
    [_customNavBarRightBtn setImage:[UIImage imageNamed:rightButtonImageStr] forState:UIControlStateHighlighted];
    [_customNavBarRightBtn setImage:[UIImage imageNamed:rightButtonImageStr] forState:UIControlStateNormal];
    
    _customNavBarRightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    
    UILabel * customeTitleLabel           = [UILabel new];
    [_customNavBarRightBtn addSubview:customeTitleLabel];
    [customeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_customNavBarRightBtn.mas_centerX);
        make.bottom.mas_equalTo(_customNavBarRightBtn.mas_bottom);
    }];
    customeTitleLabel.text                = @"购物车";
    customeTitleLabel.font                = [UIFont systemFontOfSize:9];
    customeTitleLabel.textColor           = UIColorFromRGB(WHITECOLOR);
    
    [self.customNavBarRightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

//- (void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr{
//    [self addLeftButtonTarget];
//    [_leftButton setImage:[UIImage imageNamed:leftButtonImageStr] forState:UIControlStateNormal];
//}
//
//
//
//- (void) addLeftButtonTarget {
//
//    if (_countL != 1) {
//        return;
//    }
//    _countL++;
//    [_leftButton  addTarget: self action:@selector(navigationLiftButonWasClick:) forControlEvents: UIControlEventTouchUpInside];
//
//}
//
//- (void) addRightButtonTarget {
//    if (_countR != 1) {
//        return;
//    }
//    _countR++;
//    [_rightButton  addTarget: self action:@selector(navigationRightButtonWasClick:) forControlEvents: UIControlEventTouchUpInside];
//}

#pragma mark - 事件相关

/**
 *  自定义导航条 左按钮点击事件
 */
- (void)leftButtonClicked
{
    
}

/**
 *  自定义导航条 右按钮点击事件
 */
- (void)rightButtonClicked
{
    
}


#pragma mark - methods

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *catchImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return catchImage;
}

- (UIColor *)colorFromRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

// 用于求高度或宽度
- (CGSize) sizeForText:(NSString *)text WithMaxSize:(CGSize)maxSize AndWithFontSize:(CGFloat)fontSize
{
    CGRect rect = [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: fontSize]} context:nil];
    
    return rect.size;
}

/**
 *  计算评论cell 高度方法
 *
 *  @param comment 评论数据模型
 *
 *  @return 评论cell实际高度
 */
- (CGFloat)countCommentCellHeightWithModel:(Comments *)comment
{
    CGFloat contentHeight = 0;
    CGFloat businessReplyHeight = 0;
    
    if ([comment.content isKindOfClass:[NSString class]]) {
        contentHeight = [self sizeForText:comment.content WithMaxSize:CGSizeMake(GET_SCAlE_LENGTH(300), 1000) AndWithFontSize:14].height;
    }
    if ([comment.reback isKindOfClass:[NSString class]]) {
        if (comment.reback.length > 1) {
            businessReplyHeight = [self sizeForText:comment.reback WithMaxSize:CGSizeMake(GET_SCAlE_LENGTH(300), 1000) AndWithFontSize:14].height;
        }else{
            businessReplyHeight = 0;
        }
        
    }
    
    CGFloat imageHeight = 0;
    
    if ([comment.comimagelist isKindOfClass:[NSDictionary class]]) {
        imageHeight = GET_SCAlE_HEIGHT(55);
    }else{
        if (comment.comimagelist.count > 0) {
            imageHeight = GET_SCAlE_HEIGHT(55);
        }else{
            imageHeight = 0;
        }
    }
    
    CGFloat height = (GET_SCAlE_HEIGHT(70) + 25 + contentHeight + businessReplyHeight) + imageHeight;
    
    return height;
}

- (BOOL)isRequestSuccess:(NSDictionary *)responseBody
{
    if ([responseBody[@"head"][@"resultcode"] isEqualToString:@"0000"]) {
        return YES;
    }else{
        return NO;
    }
}

- (void)JumpToadvertisementWithModel:(id)model
{
    
    HPAddsModel * ads = (HPAddsModel *)model;
    
    switch ([ads.linktype integerValue]) {
        case 1:
        case 2:
        {
            AdvertisementWebViewController * VC = [[AdvertisementWebViewController alloc] initWithUrlString:ads.linkcontent adsTitle:ads.title];
            [self presentViewController:VC animated:YES completion:^{
                
            }];
            break;
        }
        case 3:
        {
            self.hidesBottomBarWhenPushed = YES;
            HotelSupplyListViewController * VC = [[HotelSupplyListViewController alloc] initWithCategoryID:ads.linkcontent];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 4:
        {
            ProductType type = [ads.producttype integerValue];
            
            switch (type) {
                case kProductTypeEntity: {
                    self.hidesBottomBarWhenPushed = YES;
                    HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:ads.linkcontent];
                    [self.navigationController pushViewController:VC animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    break;
                }
                case kProductTypeVirtual: {
                    self.hidesBottomBarWhenPushed = YES;
                    RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithSellerID:ads.linkcontent];
                    [self.navigationController pushViewController:VC animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    break;
                }
            }
            
            break;
        }
            
        default:
            break;
    }
}


- (void)showEmptyViewWithTableView:(UITableView *)tableView
{
    if (_emptyImageView != nil) {
        return;
    }
    
    UIImage * emptyImage = [UIImage imageNamed:@"noneImage"];
    
    _emptyImageView = [UIView new];
    [tableView addSubview:_emptyImageView];
    [_emptyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tableView.centerX);
        make.centerY.mas_equalTo(tableView.centerY).with.offset(GET_SCAlE_HEIGHT(-50));
        make.size.mas_equalTo(CGSizeMake(emptyImage.size.width, emptyImage.size.height + GET_SCAlE_HEIGHT(60)));
    }];
    
    UIImageView * emptyImageView = [UIImageView new];
    [_emptyImageView addSubview:emptyImageView];
    emptyImageView.image = emptyImage;
    [emptyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tableView.centerX);
        make.centerY.mas_equalTo(tableView.centerY).with.offset(GET_SCAlE_HEIGHT(-50));
        make.size.mas_equalTo(CGSizeMake(emptyImageView.image.size.width, emptyImageView.image.size.height));
    }];
    
    UILabel * titleLabel  = [UILabel new];
    [_emptyImageView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(emptyImageView.centerX).with.offset(0);
        make.bottom.mas_equalTo(_emptyImageView.bottom);
    }];
    titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    titleLabel.text = @"暂时没发现更多内容";
    
}

-(void)removeEmptyViewWithTableView:(UITableView *)tableView
{
    [_emptyImageView removeFromSuperview];
    _emptyImageView = nil;
}

- (void)CommentImageTapWithComment:(Comments *)model
{
    PreviewController * VC = [[PreviewController alloc] initWithParentViewController:self];
    
    if ([model.comimagelist isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary * dic = (NSDictionary *)model.comimagelist;
        NSString * url = dic[@"comimage"];
        
        NSArray * arrM = [NSArray arrayWithObjects:url, nil];
        VC.imageArr = arrM;
    }else{
        
        NSMutableArray * arrM = [NSMutableArray array];
        
        for (NSString * url in model.comimagelist) {
            if ([url isKindOfClass:[NSString class]]) {
                [arrM addObject:url];
            }
        }
        
        VC.imageArr = arrM;
    }
    
    [VC didMoveToParentViewController];
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(NSString *)countDistanceWithOriginLocaton:(CLLocationCoordinate2D)location HotelLongitude:(NSString *)longitude HotelLatitude:(NSString *)latitude
{
    
    
    CLLocation * origin = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    
    CLLocation * dist = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    
    CLLocationDistance distance = [origin distanceFromLocation:dist];
    
    return [NSString stringWithFormat:@"%.2f",distance];
    
}

#pragma mark - calculate distance  根据2个经纬度计算距离

#define PI 3.1415926
- (NSString *) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2
{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return [NSString stringWithFormat:@"%.2f",dist];
}

#pragma mark - 蒙版

- (void)addMaskViewWithShowView:(UIView *)showView
{
    UIView * mask = [UIView new];
    mask.tag = 1000;
    [self.view addSubview:mask];
    [mask makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    mask.backgroundColor = UIColorFromRGB(BLACKCOLOR);
    mask.alpha = 0.2;
    [self.view bringSubviewToFront:showView];
    
    UITapGestureRecognizer * maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTap)];
    [mask addGestureRecognizer:maskTap];
}

-(void)setMaskFrame:(CGRect)frame WithReferenceView:(UIView *)referenceView
{
    UIView * mask = [self.view viewWithTag:1000];
    
    [mask updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(referenceView.bottom).with.offset(frame.origin.y);
        make.left.mas_equalTo(self.view.left).with.offset(frame.origin.x);
        make.size.mas_equalTo(CGSizeMake(frame.size.width, frame.size.height));
    }];
}


- (void)maskTap
{
    NSLog(@"%s", __func__);
}

- (void)removeMask
{
    UIView * view = [self.view viewWithTag:1000];
    [view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
