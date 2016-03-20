//
//  HomePageViewController.m
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//

/**
 *  segmentButton ——> tag left = 100, right = 101
 *
 *
 *
 *
 */

#import "HomePageViewController.h"
#import "SCHomeShowCell.h"
#import "ImageScrollCell.h"
#import "SCHomeNormalCell.h"
#import "SearchViewController.h"
#import "HPModelListsParser.h"
#import "HPAddsModel.h"
#import "HPCategorysModel.h"
#import "HomePageViewController.h"
#import "HotelSupplyListViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "ShoppingCartViewController.h"
#import "HPCategorysModel.h"
#import "SegmentTapView.h"
#import "PossibleLikeModelParser.h"
#import "LoginViewController.h"

#import "BaiduMapHeader.h"
#import "CCLocationManager.h"

#import "HotelSuppliesProductCell.h"
#import "AdvertisementWebViewController.h"
#import "Hotellikes.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"


/**
 *  自定义分页控制器点击类型
 */
typedef NS_ENUM(NSInteger, SegTouchType) {
    /**
     *  酒店用品
     */
    kSegTouchHotelThings = 0,
    /**
     *  酒店
     */
    kSegTouchHotel
};



@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    /**
     *  segmentControl下面的线
     */
    //    UILabel * _line;
    
    /**
     *  自定义 navigationBar left
     */
    UIButton * _customLeftNavigationButton;
    UIButton * _customRightNavigationButton;
    
    /**
     *  数据源
     */
    NSMutableArray * _adds;
    NSMutableArray * _possibleLikes;
    NSMutableArray * _categorys;
    NSMutableArray * _starlevels;
    
    NSMutableArray * _possibleLikeProducts;
    NSMutableArray * _possibleLikeRooms;
    
    //记录当前猜你喜欢产品类型
    ProductType _currentProductType;
    
    SegmentTapView * _segment;
    UIView * _PossibleLikeBaseView;
    
    CLLocationCoordinate2D _coordinate;
}

@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _adds                 = [NSMutableArray array];
    _possibleLikes        = [NSMutableArray array];
    _categorys            = [NSMutableArray array];
    _possibleLikeProducts = [NSMutableArray array];
    _possibleLikeRooms    = [NSMutableArray array];
    _currentProductType   = kProductTypeVirtual;
    
    self.automaticallyAdjustsScrollViewInsets = NO;     //处理scrollview问题
    
    [self setUpCustomNavigationBar];                    //设置导航栏
    
    [self loadUpMainTableView];                         //装载主tableview
    
    [self.view bringSubviewToFront:self.customNavigationBar];
    
    [self getHomePageData];
    
    // 用户允许定位权限
    if ([[CCLocationManager sharedManager] userAllowedLocation]) {
        
        self.locationService = [[BMKLocationService alloc] init];
        [self.locationService startUserLocationService];
    }
    
    [[CCLocationManager sharedManager] currentLocationCoordinate:^(CLLocationCoordinate2D locationCorrdinate) {
        
        _coordinate = locationCorrdinate;
        
        NSString * longitude = [NSString stringWithFormat:@"%.2f",locationCorrdinate.longitude];
        NSString * latituede = [NSString stringWithFormat:@"%.2f",locationCorrdinate.latitude];
        
        [[AppInformationSingleton shareAppInfomationSingleton] setLocationInfoWithCityName:nil CityCode:nil Longitude:longitude Latitude:latituede];
        
        [self.locationService stopUserLocationService];

    } address:^(NSString *address) {
//        NSLog(@"address = %@",address);
    }];
    
    //        [self WTNetWorkTestDemo];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 自定义导航条相关

/**
 *  设置导航栏
 */
-(void)setUpCustomNavigationBar
{
    self.navigationController.navigationBar.translucent = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navBackGroundView.backgroundColor = [UIColor clearColor];
    
    [self customNavigationBar];
    
    [self searchButton];
    
    [self setNavigationBarLeftButtonImage:@"NavBar_share" WithTitle:@"分享"];
    
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self.navBackGroundView setImage:[UIImage imageNamed:@"NavBG_top"]];
    
}

-(UIButton *)searchButton
{
    if (_searchButton == nil) {
        
        /**
         *  初始化
         */
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.customNavigationBar addSubview:_searchButton];
        
        /**
         *  位置
         */
        [_searchButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.customNavigationBar.mas_centerX);
            make.bottom.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(-5);
            make.size.mas_equalTo(CGSizeMake(220, 31));
        }];
        
        /**
         *  参数配置
         */
        [_searchButton setTitle:@"搜索酒店" forState:UIControlStateNormal];
        [_searchButton setTitle:@"搜索酒店" forState:UIControlStateHighlighted];
        [_searchButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
        [_searchButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateHighlighted];
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateNormal];
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateHighlighted]
        ;
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        [_searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _searchButton;
}

#pragma mark - 视图处理

/**
 *  初始化主tableview
 */
- (void)loadUpMainTableView
{
    /**
     *  初始化和位置
     */
    self.mainTableView    = [UITableView new];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).with.offset(0);
    }];
    
    /**
     *  自定义操作
     */
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.separatorStyle  = UITableViewCellSelectionStyleNone;
    self.mainTableView.delegate        = self;
    self.mainTableView.dataSource      = self;
    //    self.mainTableView.
    
    /**
     *  注册cell
     */
    [self.mainTableView registerClass:[SCHomeShowCell class] forCellReuseIdentifier:@"SCHomeShowCell"];
    [self.mainTableView registerClass:[ImageScrollCell class] forCellReuseIdentifier:@"ImageScrollCell"];
    [self.mainTableView registerClass:[SCHomeNormalCell class] forCellReuseIdentifier:@"SCHomeNormalCell"];
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"cell"];
    
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        /**
         *  背景view
         */
        if (_PossibleLikeBaseView == nil) {
            _PossibleLikeBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            _PossibleLikeBaseView.backgroundColor = [UIColor whiteColor];
            //            _PossibleLikeBaseView.userInteractionEnabled = YES;
            
            /**
             *  猜你喜欢部分
             */
            UIView * descriptionView = [UIView new];
            [_PossibleLikeBaseView addSubview:descriptionView];
            [descriptionView makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.top.mas_equalTo(_PossibleLikeBaseView);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3.0, _PossibleLikeBaseView.frame.size.height));
            }];
            descriptionView.backgroundColor = [UIColor clearColor];
            
            UIImageView * heartImageView = [UIImageView new];
            [descriptionView addSubview:heartImageView];
            [heartImageView makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(descriptionView.mas_centerY);
                make.left.mas_equalTo(descriptionView.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(18, 18));
            }];
            heartImageView.backgroundColor = [UIColor clearColor];
            heartImageView.userInteractionEnabled = YES;
            heartImageView.image = [UIImage imageNamed:@"HomePageHeart"];
            
            UILabel * describeLabel = [UILabel new];
            [descriptionView addSubview:describeLabel];
            [describeLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(heartImageView.mas_centerY);
                make.left.mas_equalTo(heartImageView.mas_right).with.offset(10);
            }];
            describeLabel.text = @"猜你喜欢";
            describeLabel.font = [UIFont systemFontOfSize:13];
        }
        
        
        
        /**
         *  自定义分页控制器
         */
        
//        if (_segment == nil) {
//            _segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55/2.0) withDataArray:[NSArray arrayWithObjects:@"酒店", nil] withFont:NORMALFONTSIZE];
//            [_PossibleLikeBaseView addSubview:_segment];
//            [_segment makeConstraints:^(MASConstraintMaker *make) {
//                make.left.and.bottom.mas_equalTo(_PossibleLikeBaseView);
//                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 55/2.0));
//            }];
//            [_segment setTextColor:UIColorFromRGB(BLACKFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
//            [_segment callBackWithBlock:^(NSInteger index) {
//                _currentProductType = index + 1;
//                NSLog(@"_currenttype = %ld",_currentProductType);
//                [self.mainTableView reloadData];
//                
//            }];
//        }
        
        //        [self showSegmentViewWithSuperView:_PossibleLikeBaseView];
        
        UILabel * grayLine = [UILabel new];
        [_PossibleLikeBaseView addSubview:grayLine];
        [grayLine makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.and.bottom.mas_equalTo(_PossibleLikeBaseView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        grayLine.backgroundColor = UIColorFromRGB(GRAYLINECOLOR);
        
        return _PossibleLikeBaseView;
        
    }else{
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }else{
        return 0.1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /**
     *  section 0 ——> 2
     *  section 1 ——> dataSource.count
     */
    
    if (section > 0) {
        
        switch (_currentProductType) {
            case kProductTypeEntity: {
                return _possibleLikeProducts.count;
                break;
            }
            case kProductTypeVirtual: {
                return _possibleLikeRooms.count;
                break;
            }
        }
        
    }else{
        return 2;
    }
    
    //    NSInteger rows = (section > 0)?_possibleLikes.count:2;
    
    //    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        }else{
            return GET_SCAlE_HEIGHT(170/2);
        }
    }else{
        return (_currentProductType == kProductTypeEntity)?GET_SCAlE_HEIGHT(115):GET_SCAlE_HEIGHT(135);
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  段落一
     */
    if (indexPath.section == 0) {
        
        /**
         *  第一行 滚动cell
         */
        if (indexPath.row == 0) {
            
            ImageScrollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ImageScrollCell"];
            
            if (_adds.count > 0) {
                
                [cell setImageArray:_adds];
                
                [cell callBackMethod:^(NSInteger index) {
                    
                    NSLog(@"index = %ld",index);
                    HPAddsModel * model = _adds[index];
                    
                    [self JumpToadvertisementWithModel:model];
                }];
            }
            
            return cell;
        }
        /**
         *  第二行 分类展示cell
         */
        else{
            
            SCHomeShowCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCHomeShowCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_categorys.count > 0) {
                [cell setCellWithData:_starlevels];
            }
            
            /**
             *  点击回调方法
             *
             *  @param clickType 点击类型
             *
             *  @return 点击哪个按钮
             */
            [cell callBackWithBlock:^(HomeShowClickType clickType) {
                
//                NSLog(@"tag = %ld",clickType);
                
//                HPCategorysModel * category   = _categorys[clickType];
                self.hidesBottomBarWhenPushed = YES;
                
//                if (clickType > 3) {
                
                    NSString * star = _starlevels[clickType][@"title"];
                    
                    HotelSupplyListViewController * VC = [[HotelSupplyListViewController alloc] initWithStarLevels:star];
                    [self.navigationController pushViewController:VC animated:YES];
//                }else{
//                    HotelSupplyListViewController * VC = [[HotelSupplyListViewController alloc] initWithCategoryModel:category];
//                    [self.navigationController pushViewController:VC animated:YES];
//                }
                self.hidesBottomBarWhenPushed = NO;
            }];
            
            return cell;
            
        }
    }else{
        
//        SCHomeNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCHomeNormalCell"];
        HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (_currentProductType) {
            case kProductTypeEntity: {
                if (_possibleLikeProducts.count > 0) {
                    HPPossibleLikeModel * likes  = _possibleLikeProducts[indexPath.row];
                    [cell cellForHoelSuppListVC:NO];
                    [cell showDetail:YES];
                    [cell cellForRowWithModel:(HSProduct *)likes];
                }
                break;
            }
            case kProductTypeVirtual: {
                if (_possibleLikeRooms.count > 0) {
                    Hotellikes * likes  = _possibleLikeRooms[indexPath.row];
                    [cell cellForHoelSuppListVC:YES];
                    [cell showDetail:NO];
                    [cell cellForRowWithModel:(HSProduct *)likes];
                    
                    NSString * distance = [self LantitudeLongitudeDist:[likes.coordinatex doubleValue] other_Lat:[likes.coordinatey doubleValue] self_Lon:_coordinate.longitude self_Lat:_coordinate.latitude];
                    
                    cell.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%.2fkm",distance.doubleValue/1000];// 系统方法:89.16,89.24,70.42 民间方法: 89.38,89.45,70.57
                }
                break;
            }
        }
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_currentProductType) {
        case kProductTypeEntity: {
            if (_possibleLikeProducts.count > 0) {
                HPPossibleLikeModel *model = _possibleLikeProducts[indexPath.row];
                self.hidesBottomBarWhenPushed = YES;
                HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProduct:model];
                [self.navigationController pushViewController:VC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }

            break;
        }
        case kProductTypeVirtual: {
            if (_possibleLikeRooms.count > 0) {
                Hotellikes * model = _possibleLikeRooms[indexPath.row];
                self.hidesBottomBarWhenPushed = YES;
                RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithHotelModel:(Hotels *)model];
                [self.navigationController pushViewController:VC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
    }
    

}

#pragma mark - UIScrollViewDelegate

/**
 *  滚动视图正在滚动时触发代理函数
 *
 *  @param scrollView 正在滚动的视图
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:self.mainTableView]) {

    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastScrollOffSet_y = scrollView.contentOffset.y;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  }

#pragma mark - 事件处理


///**
// *  自定义分页控制器按钮点击事件
// *
// *  @param sender 按钮
// */
//- (void)segmentButtonClicked:(UIButton *)sender
//{
//
//    SegTouchType touchType = sender.tag - 1000;
//    UIButton * leftBtn = [sender.superview viewWithTag:1000];
//    UIButton * rightBtn = [sender.superview viewWithTag:1001];
//
//    switch (touchType) {
//            //      酒店用品
//        case kSegTouchHotelThings: {
//
//            [leftBtn setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
//            [rightBtn setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
//
//            [UIView animateWithDuration:3 animations:^{
//                [_line updateConstraints:^(MASConstraintMaker *make) {
//                    make.centerX.mas_equalTo(sender.superview.mas_centerX).with.offset(-(SCREEN_WIDTH/4.0));
//                }];
//            }];
//
////            _currentProductType = kProductTypeEntity;
////            [self.mainTableView reloadData];
//
//            break;
//        }
//            //      酒店
//        case kSegTouchHotel: {
//
//            [leftBtn setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
//            [rightBtn setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
//
//            [UIView animateWithDuration:3 animations:^{
//                [_line updateConstraints:^(MASConstraintMaker *make) {
//                    make.centerX.mas_equalTo(sender.superview.mas_centerX).with.offset((SCREEN_WIDTH/4.0));
//                }];
//            }];
//
////            _currentProductType = kProductTypeVirtual;
////            [self.mainTableView reloadData];
//
//            break;
//        }
//        default: {
//            break;
//        }
//    }
//}

-(void)leftButtonClicked
{
    NSString *showMsg = @"敬请期待";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                    message: showMsg
                                                   delegate: self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil, nil];
    
//    [alert show];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56dfd3b1e0f55a9f6c000d99"
                                      shareText:@"预定国内最低价的酒店就在这里"
                                     shareImage:[UIImage imageNamed:@"AppIcon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToSina,UMShareToQQ,UMShareToTencent,UMShareToSms,UMShareToAlipaySession]
                                       delegate:self];


    
    [UMSocialData defaultData].extConfig.qqData.url = @"分享url";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"分享url";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"分享url";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"分享url";
    [UMSocialData defaultData].extConfig.qqData.title = @"分享url";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"分享url";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"分享url";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"分享url";

    
    [UMSocialData defaultData].extConfig.sinaData.shareText = @"分享text";
    
}

#pragma mark UMSocialUIDelegate 

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    NSLog(@"response:%@", response.data.allValues);
}



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

- (void)searchButtonClicked
{
    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * VC = [[SearchViewController alloc] initWithProductType:_currentProductType];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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

#pragma mark - 网络

-(void)tap
{
    NSLog(@"%s",__func__);
}


/**
 *  获取首页数据
 */
- (void)getHomePageData
{
    NSMutableDictionary *headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"sj_index" forKey:@"functionid"];
    /*    单例方法已封装成2个方法，以完成所有请求通用的情况，方法1 分别传入head字典和body字典。方法2 传入整个参数字典。
     你这里没有写判断网络情况的代码，
     解析器不需要声明成当前类的全局变量，事实上，如果一个容器（字典、数组、对象变量）经常需要重新指向其他对象
     时，需要声明成属性，即property关键字描述，其他如果需要在不同代码块内共同使用同一变量的情况可声明为全局变量。
     主要原因是property关键字描述的变量系统会自动生成get set 方法
     以 @property (nonatomic, copy) NSString *name; 为例，
     系统生成的 set方法格式大约如下：
     
     -(void) setName:(NSString *)name{
     if (_name != name) {
     [_name release];
     _name = [name copy];
     }
     }
     可以看见，系统生成的set方法内部会有一次release  如果name两次赋值同一个字符串，则方法内不执行，
     如果不同，先释放掉前一个，然后再重新给name赋值。
     因解析器在当前类只有一个地方使用，一旦完成解析任务就失去价值，所以不必声明为全局变量。
     
     代码缩进的规则， HomePageRequestParser *parser *号紧贴变量名， 与类名之间有一个空格，
     双目运算符两边各一个空格 详见下面 =
     行与行之间尽量不要有空行的情况（除去不同功能代码之间的情况。），当然，不同功能的代码集合 之间要有一个空行，比如方法之间。
     
     */
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        HPModelListsParser *parser = [[HPModelListsParser alloc] initWithDictionary:responseBody];
        _adds = [NSMutableArray arrayWithArray:parser.modelLists.addsModel];
        _categorys = [NSMutableArray arrayWithArray:parser.modelLists.categorysModel];
        
        if (_starlevels == nil) {
            _starlevels = [NSMutableArray array];
        }
        [_starlevels addObjectsFromArray:responseBody[@"body"][@"starlevels"]];
        
        [self.mainTableView reloadData];
        
        [self getPossibleLikeData];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

- (void)getPossibleLikeData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"sj_like" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        PossibleLikeModelParser * parser = [[PossibleLikeModelParser alloc] initWithDictionary:responseBody];
        
        
//        [_possibleLikeProducts addObjectsFromArray:parser.possibleLikeModel.possibleLike];
        [_possibleLikeRooms addObjectsFromArray:parser.possibleLikeModel.hotellikes];

        
        [parser.possibleLikeModel.possibleLike enumerateObjectsUsingBlock:^(PossibleLike * _Nonnull possibleLike, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            if ([possibleLike.producttype integerValue] == 1) {
                [_possibleLikeProducts addObject:possibleLike];
            }
        }];
        
        [self.mainTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
    }];
    
}



#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
