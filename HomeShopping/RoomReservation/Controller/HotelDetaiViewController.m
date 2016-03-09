//
//  HotelDetaiViewController.m
//  HomeShopping
//
//  Created by pfl on 16/1/16.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "HotelDetaiViewController.h"
#import "CommentViewController.h"
#import "ProductDetailModelParser.h"
#import "ProductDetail.h"
#import "HPPossibleLikeModel.h"
#import "Norms.h"
#import "ProductDetailHeaderView.h"
#import "ProductSelectedView.h"
#import "ProductDetailTabbar.h"
#import "ImageScrollView.h"
#import "cellDemonstrationView.h"
#import "CommentCell.h"
#import "HotelProductInfoCell.h"
#import "HotelSuppliesProductCell.h"
#import "HSproductListModelParser.h"
#import "SearchViewController.h"
#import "HotelDetailModel.h"
#import "ConfirmRoomOrderViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "HotelDetailModelParser.h"

#define SELECTIONHEADVIEW_TAG 600
#define SELECTIONVIEW_TAG 500




@interface HotelDetaiViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray * controllsArray;
@property (nonatomic, readwrite, strong) UITableView *midTableView;
@property (nonatomic, readwrite, strong) UIWebView *rightWebViwe;
@property (nonatomic, readwrite, strong) UIButton *searchButton;
@property (nonatomic, readwrite, assign) NSUInteger pageIndex;
@property (nonatomic, readwrite, assign) NSUInteger pageCount;
@end

@implementation HotelDetaiViewController
{
    //商品模型
    HSProduct * _product;
    ProductDetail * _productDetail;
    HotelDetailModel * _hotelDetail;
    
    
    //商品类型
    productType _productType;
    
    //顶部视图
    ProductDetailHeaderView * _headView;
    ProductDetailTabbar * _tabbar;
    
    //选择款式头视图
    cellDemonstrationView * _selectionHeadView;
    
    //标题seg背景
    UIView * _segBackView;
    
    //顶部滚动视图
    ImageScrollView * _ImageScrollHederView;
    
    //数据源
    NSMutableArray * _commentData;
    NSMutableArray * _normsData;
    UIScrollView * _scrollBaseView;
    NSMutableArray *_dataSource;
    NSMutableArray *_dataSource2;

    SegmentTapView * _segmentView;
}

/**
 *  初始化方法
 *
 *  @return
 */
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc {
//    [self.leftTableView removeObserver:self forKeyPath:@"contentOffset"];
//    [self.midTableView removeObserver:self forKeyPath:@"contentOffset"];

}

-(instancetype)initWithProduct:(id)product
{
    self = [super init];
    
    if (self) {
        
        if ([product isKindOfClass:[HSProduct class]]) {
            _product     = (HSProduct *)product;
            _productType = [_product.producttype integerValue];
        }
        
        else if ([product isKindOfClass:[HotelDetailModel class]])
        {
        
        }
        else{
            HPPossibleLikeModel * model = (HPPossibleLikeModel *)product;
            _product           = [[HSProduct alloc] init];
            _product.productid = model.productid;
            _productType       = [model.producttype integerValue];
        }
        
        _normsData   = [NSMutableArray array];
        _commentData = [NSMutableArray array];
        _dataSource = [NSMutableArray array];
        _dataSource2 = [NSMutableArray array];

    }
    
    return self;
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isProduct) {
        [self getSellerDetailData];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    _dataSource2 = [NSMutableArray array];

    self.pageCount = 100;
    self.pageIndex = 1;
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
//    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
//    [self leftTableView];
    
    [self rightBaseView];
    
    [self setUpHeaderView];
    
//    [self setUpTitleSegmentView];
    
    [self getProductListDataIsspecial:NO];
    
    [self searchButton];
    
//    [self addpull2RefreshWithTableView:self.leftTableView];
//    [self addPush2LoadMoreWithTableView:self.leftTableView];
//
//    [self addpull2RefreshWithTableView:self.midTableView];
//    [self addPush2LoadMoreWithTableView:self.midTableView];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView {
    self.pageIndex = 1;
    if (scrollerView == self.leftTableView) {
        [self getProductListDataIsspecial:NO];
    }
    else if (scrollerView == self.midTableView) {
        [self getProductListDataIsspecial:YES];
    }
}

- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView {
    self.pageIndex++;
    if (scrollerView == self.leftTableView) {
        [self getProductListDataIsspecial:NO];
    }
    else if (scrollerView == self.midTableView) {
        [self getProductListDataIsspecial:YES];
    }

}

#pragma mark - 自定义视图


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
        [_searchButton setTitle:@"搜索酒店用品/酒店" forState:UIControlStateNormal];
        [_searchButton setTitle:@"搜索酒店用品/酒店" forState:UIControlStateHighlighted];
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

- (void)searchButtonClicked
{
    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * VC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

/**
 *  懒加载 左侧表视图
 *
 *  @return 左侧表视图
 */
-(UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_headView.frame)-84) style:UITableViewStyleGrouped];
        _leftTableView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        _leftTableView.delegate        = self;
        _leftTableView.dataSource      = self;
        _leftTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        
        [_leftTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    }
    
    return _leftTableView;
}

-(UITableView *)midTableView
{
    if (_midTableView == nil) {
        
        _midTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.leftTableView.frame.size.height) style:UITableViewStyleGrouped];
        _midTableView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        _midTableView.delegate        = self;
        _midTableView.dataSource      = self;
        _midTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [_midTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    }
    
    return _midTableView;
}

-(UIWebView *)rightWebViwe
{
    if (_rightWebViwe == nil) {
        
        UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(365))];
        [web loadHTMLString:self.intro baseURL:nil];
        _rightWebViwe = web;
    }
    
    return _rightWebViwe;
}



-(UIView *)rightBaseView
{
    if (_rightBaseView == nil) {
        _rightBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        [self.view addSubview:_rightBaseView];
        
        [self loadUpDetailView];
    }
    
    return _rightBaseView;
}

- (void)loadUpDetailView
{
    _headView = [[ProductDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(100))];
    [_headView.headImageView sd_setImageWithURL:[NSURL URLWithString:self.logo]];
    [_headView.scoreLabel setText:[@"评分:" stringByAppendingString:self.rateScore?:@""]];
    [_headView.collectionLabel setText:[self.favNumber?:@"0" stringByAppendingString:@"人收藏"]];
    [_headView.titleLabel setText:self.shopName];
    
    [_rightBaseView addSubview:_headView];
    
    SegmentTapView * SegmentView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, GET_SCAlE_HEIGHT(100), SCREEN_WIDTH, GET_SCAlE_HEIGHT(40)) withDataArray:[NSArray arrayWithObjects:@"全部商品",@"特惠商品",@"商家介绍", nil] withFont:16];
    _segmentView = SegmentView;
    [_rightBaseView addSubview:SegmentView];
    [SegmentView setTextColor:UIColorFromRGB(BLACKFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
    [SegmentView setNoticeType:kNoticeTypeLine];
    SegmentView.delegate = self;
    
    UIScrollView * scrollBaseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [_rightBaseView addSubview:scrollBaseView];
    [scrollBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(_rightBaseView);
        make.top.mas_equalTo(SegmentView.mas_bottom);
        make.bottom.mas_equalTo(_rightBaseView.bottom);
    }];
    _scrollBaseView = scrollBaseView;
    scrollBaseView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, scrollBaseView.frame.size.height);
    scrollBaseView.pagingEnabled = YES;
    scrollBaseView.delegate = self;
    
    [scrollBaseView addSubview:self.leftTableView];
    [scrollBaseView addSubview:self.midTableView];
    [scrollBaseView addSubview:self.rightWebViwe];
}

- (void)setUpProductTabbar
{
    
}

- (void)setUpTitleSegmentView
{
    UIView * titleBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GET_SCAlE_LENGTH(202),30)];
    [self.customNavigationBar addSubview:titleBaseView];
    [titleBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarLeftBtn.centerY);
        make.centerX.mas_equalTo(self.customNavigationBar.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(202),30));
    }];
    titleBaseView.backgroundColor = [UIColor clearColor];
    titleBaseView.layer.cornerRadius = 5;
    titleBaseView.clipsToBounds = YES;
    titleBaseView.layer.borderWidth = 1;
    titleBaseView.layer.borderColor = UIColorFromRGB(WHITECOLOR).CGColor;
    
    _segBackView = [UIView new];
    [titleBaseView addSubview:_segBackView];
    [_segBackView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(titleBaseView);
        make.size.mas_equalTo(CGSizeMake((titleBaseView.frame.size.width/2.0), titleBaseView.frame.size.height));
    }];
    _segBackView.backgroundColor = UIColorFromRGB(WHITECOLOR);
}

- (void)setUpHeaderView
{
//    _ImageScrollHederView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(140))];
//    
//    
//    [self.leftTableView setTableHeaderView:_ImageScrollHederView];
    
}




#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
        
        if (_isProduct) {
            HSProduct * model = _dataSource[indexPath.row];
            self.hidesBottomBarWhenPushed = YES;
            HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:model.productid];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
        
        HSProduct * model = _dataSource[indexPath.row];
        
        self.hidesBottomBarWhenPushed = YES;
        ConfirmRoomOrderViewController * VC = [[ConfirmRoomOrderViewController alloc] init];
        VC.productid = model.productid;
        VC.productDetail = _productDetail;
        VC.MonthDayArr = _monthDayArr;
        VC.longIntro = _productDetail.longintro;
        
        [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    ProductIndexType type = section;
    
    switch (type) {
        case kProductIndexTypeInfo: {
            return 0.1;
            break;
        }
        case kProductIndexTypeSelect: {
            return GET_SCAlE_HEIGHT(34);
            break;
        }
        case kProductIndexTypeComment: {
            return GET_SCAlE_HEIGHT(34);
            break;
        }
        case kProductIndexTypePossibleLike: {
            return 0.1;
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (_isProduct)?GET_SCAlE_HEIGHT(115):GET_SCAlE_HEIGHT(135);
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.midTableView) {
        return _dataSource2.count;
    }
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelSuppliesProductCell"];
    if (_dataSource.count > 0) {
        
        if (_isProduct) {
            [cell cellForHoelSuppListVC:NO];
            [cell showDetail:YES];
        }else{
            [cell showDetail:NO];
            [cell cellForHoelSuppListVC:YES];
        }

        if (tableView == self.midTableView) {
            [cell cellForRowWithModel:_dataSource2[indexPath.row]];
            [cell cellShowSpecialSymbol:YES];

        }
        else {
            [cell cellShowSpecialSymbol:YES];
            [cell cellForRowWithModel:_dataSource[indexPath.row]];
        }
    }
//    [cell cellForHoelSuppListVC:YES];


    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != _scrollBaseView ) {return;}
    
    NSInteger index = scrollView.contentOffset.x/(SCREEN_WIDTH)+1;
    [_segmentView selectIndex:index];
 
    if (index != 3) {
        [self getProductListDataIsspecial:index==2];
    }
    
}


#pragma mark - flipView

/**
 *  分页控制视图
 *
 *  @return
 */
-(SegmentTapView *)segMentTapView
{
    
    if (_segMentTapView == nil) {
        
        _segMentTapView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_HEIGHT, 40) withDataArray:[NSArray arrayWithObjects:@"商品介绍",@"规格参数",@"包装售后", nil] withFont:15];
        _segMentTapView.delegate = self;
        [self.view addSubview:_segMentTapView];
    }
    return _segMentTapView;
}

#pragma mark - 代理方法
/**
 *  点击时触发
 *
 *  @param index 识别用下标
 */
-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    //    [self.flipView selectIndex:index];
    
    if (index == 2) {
        
    }
    else if (index == 1) {
        [self getProductListDataIsspecial:YES];
    }
    else if (index == 0) {
        [self getProductListDataIsspecial:NO];
    }
    
    [_scrollBaseView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
    
}

/**
 *  点击自定义分页控制器按钮时 改变页面显示内容
 *
 *  @param index 下标
 */
-(void)scrollChangeToIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.segMentTapView selectIndex:index];
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

- (void)titleSegmentClicked:(UIButton *)sender
{
}

- (void)selectedTaped
{
    ProductSelectedView * View = [[ProductSelectedView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, GET_SCAlE_HEIGHT(280)) withDataArray:_normsData];
    [self.view addSubview:View];
    View.tag = SELECTIONVIEW_TAG;
    [View show];
    [self addMaskViewWithShowView:View];
    [View callBackWithBlock:^(NSDictionary *dictionary, OperationType type) {
        NSLog(@"dic = %@,type = %ld",dictionary,type);
        [_selectionHeadView setViewWithTitle:@"已选:" SubTitle:nil RightTitle:[NSString stringWithFormat:@"%@ %@件",dictionary[@"normtitle"],dictionary[@"number"]] SymbolImage:[UIImage imageNamed:@"arrow_right"]];
        [View hide];
        [self removeMask];
    }];
}


#pragma mark - 网络

- (void)getSellerDetailData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"sellerdetail" forKey:@"functionid"];
    [bodyDic setObject:self.sellerid forKey:@"sellerid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        HotelDetailModelParser * parser = [[HotelDetailModelParser alloc] initWithDictionary:responseBody];
        _hotelDetail = parser.hotelDetailModel;
        [_rightWebViwe loadHTMLString:_hotelDetail.sellerintro baseURL:nil];

        
        [self.mainTableView reloadData];
        
//        if ([self isRequestSuccess:responseBody]) {
//            NSLog(@"result = %@",responseBody);
//        }
        
    } FailureBlock:^(NSString *error) {
        
    }];
}


#pragma mark - 网络

- (void)getProductListDataIsspecial:(BOOL)isspecial
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"productlist" forKey:@"functionid"];
    [bodyDic setObject:self.sellerid?:@"" forKey:@"sellerid"];
    if (_isProduct) {
        [bodyDic setObject:@"1" forKey:@"producttype"];
    }else{
        [bodyDic setObject:[NSString stringWithFormat:@"%d",2] forKey:@"producttype"];
    }
    if (isspecial) {
        [bodyDic setObject:@"是" forKey:@"isspecial"];
    }
    
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",(unsigned long)self.pageIndex] forKey:@"pageno"];
    [bodyDic setObject:@(self.pageCount).stringValue forKey:@"pagesize"];
    
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
        
        isspecial?[_dataSource2 removeAllObjects]:[_dataSource removeAllObjects];
        for (HSProduct * product in parser.productListModel.product) {
            
            if (isspecial) {
                if ([product isKindOfClass:[HSProduct class]]) {
                    if ([product.productid integerValue] != 0) {
                        [_dataSource2 addObject:product];
                    }
                }
            }else{
                if ([product isKindOfClass:[HSProduct class]]) {
                    if ([product.productid integerValue] != 0) {
                        [_dataSource addObject:product];
                    }
                }
            }
            
            
//            isspecial?[_dataSource2 addObject:product]:[_dataSource addObject:product];
        }
        isspecial?[self.midTableView reloadData]:[self.leftTableView reloadData];
       
        [self endRefreshing];

        
        
    } FailureBlock:^(NSString *error) {
        
        [self endRefreshing];

    }];
    
}




- (void)addShopCarOrCollectionWithType:(ProductGetInType)type
{
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"addtocar" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismissWithError:nil afterDelay:0.3];
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismissWithError:nil afterDelay:0.3];
    }];
}

#pragma mark - 公用方法

-(void)maskTap
{
    ProductSelectedView * view = [self.view viewWithTag:SELECTIONVIEW_TAG];
    [view hide];
    [self removeMask];
}

@end
