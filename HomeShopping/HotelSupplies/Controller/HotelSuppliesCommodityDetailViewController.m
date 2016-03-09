//
//  HotelSuppliesCommodityDetailViewController.m
//  HomeShopping
//
//  Created by sooncong on 15/12/14.
//  Copyright © 2015年 Administrator. All rights reserved.
//

//控制器
#import "HotelSuppliesCommodityDetailViewController.h"
#import "ConfirmHotelSuppliesOrderViewController2.h"
#import "CommentViewController.h"
#import "ShoppingCartViewController.h"
#import "PreviewController.h"
#import "LoginViewController.h"
#import "HotelDetaiViewController.h"

//自定义视图
#import "ProductDetailHeaderView.h"
#import "ProductSelectedView.h"
#import "ImageScrollView.h"
#import "ProductDetailTabbar.h"
#import "cellDemonstrationView.h"

//模型
#import "ProductDetailModelParser.h"
#import "ProductDetail.h"
#import "HPPossibleLikeModel.h"
#import "PossibleLikeModelParser.h"
#import "PossibleLike.h"
#import "Norms.h"
#import "ShoppingCarProduct.h"

//自定义cell
#import "CommentCell.h"
#import "HotelProductInfoCell.h"
#import "HotelSuppliesProductCell.h"

#define SELECTIONHEADVIEW_TAG 600
#define SELECTIONVIEW_TAG 500

@interface HotelSuppliesCommodityDetailViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate,UITableViewDataSource,UITableViewDelegate,ImageScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray * controllsArray;

@end

@implementation HotelSuppliesCommodityDetailViewController
{
    //商品模型
    HSProduct * _product;
    ProductDetail * _productDetail;
    NSString * _productID;
    
    //商品类型
    //    productType _productType;
    
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
    NSMutableArray * _possibleLikeData;
    NSArray * _imageLists;
    
    //请求参数
    NSMutableDictionary * _postNormDic;
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

-(instancetype)initWithProduct:(id)product
{
    self = [super init];
    
    if (self) {
        
        if ([product isKindOfClass:[HSProduct class]]) {
            _product                    = (HSProduct *)product;
            _productID                  = _product.productid;
        }else{
            HPPossibleLikeModel * model = (HPPossibleLikeModel *)product;
            _product                    = [[HSProduct alloc] init];
            _productID                  = model.productid;
        }
        
        _normsData        = [NSMutableArray array];
        _postNormDic      = [[NSMutableDictionary alloc] initWithCapacity:1];
        _commentData      = [NSMutableArray array];
        _possibleLikeData = [NSMutableArray array];
    }
    
    return self;
}

-(instancetype)initWithProductID:(NSString *)productID
{
    self = [super init];
    
    if (self) {
        
        _productID = productID;
        
        _possibleLikeData = [[NSMutableArray alloc] initWithCapacity:1];
        _normsData        = [NSMutableArray array];
        _postNormDic      = [[NSMutableDictionary alloc] initWithCapacity:1];
        _commentData      = [NSMutableArray array];
        _possibleLikeData = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [self addShopCarOrCollectionWithType:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self leftTableView];
    
    [self rightBaseView];
    
    [self setUpHeaderView];
    
    [self setUpTitleSegmentView];
    
    [self getProductDetailData];
    
    [self getPossibleLikeData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - 自定义视图

/**
 *  懒加载 左侧表视图
 *
 *  @return 左侧表视图
 */
-(UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];
        [self.view addSubview:_leftTableView];
        
        _leftTableView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        _leftTableView.delegate        = self;
        _leftTableView.dataSource      = self;
        _leftTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        
        [_leftTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        [_leftTableView registerClass:[HotelProductInfoCell class] forCellReuseIdentifier:@"HotelProductInfoCell"];
        [_leftTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _leftTableView;
}

-(UIView *)rightBaseView
{
    if (_rightBaseView == nil) {
        _rightBaseView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)];
        [self.view addSubview:_rightBaseView];
        
        [self loadUpDetailView];
    }
    
    return _rightBaseView;
}

- (void)loadUpDetailView
{
    _headView = [[ProductDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(100))];
    [_rightBaseView addSubview:_headView];
    
    
    SegmentTapView * SegmentView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, GET_SCAlE_HEIGHT(100), SCREEN_WIDTH, GET_SCAlE_HEIGHT(40)) withDataArray:[NSArray arrayWithObjects:@"商品介绍",@"规格参数",@"包装售后", nil] withFont:16];
    [_rightBaseView addSubview:SegmentView];
    [SegmentView setTextColor:UIColorFromRGB(BLACKFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
    [SegmentView setNoticeType:kNoticeTypeLine];
    SegmentView.delegate = self;
    
    UIScrollView * scrollBaseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(320))];
    [_rightBaseView addSubview:scrollBaseView];
    [scrollBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(_rightBaseView);
        make.top.mas_equalTo(SegmentView.mas_bottom);
        make.bottom.mas_equalTo(_rightBaseView.bottom);
    }];
    scrollBaseView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, scrollBaseView.frame.size.height);
    scrollBaseView.pagingEnabled = YES;
    scrollBaseView.scrollEnabled = NO;
    
    [SegmentView callBackWithBlock:^(NSInteger index) {
        CGFloat x = index * scrollBaseView.frame.size.width;
        [scrollBaseView setContentOffset:CGPointMake(x, 0) animated:YES];
    }];
    
    for (NSInteger i = 0; i<3; i++) {
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, scrollBaseView.frame.size.width, scrollBaseView.frame.size.height)];
        [scrollBaseView addSubview:webView];
        webView.tag = 200 + i;
    }
    
    _tabbar = [[ProductDetailTabbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95/2.0) callBackBlock:^(ProductTabType type) {
        NSLog(@"type = %ld",type);
        
        [self bottomViewClickWithType:type];
        
    }];
    [self.view addSubview:_tabbar];
    [_tabbar makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 95/2.0));
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toSellerHome)];
    [_headView addGestureRecognizer:tap];
    _headView.userInteractionEnabled = YES;
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
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBaseView addSubview:leftButton];
    [leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.bottom.mas_equalTo(titleBaseView);
        make.size.mas_equalTo(CGSizeMake(titleBaseView.frame.size.width/2, titleBaseView.frame.size.height));
    }];
    [leftButton setTitle:@"商品" forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftButton setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
    leftButton.tag = 151;
    [leftButton addTarget:self action:@selector(titleSegmentClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBaseView addSubview:rightButton];
    [rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.and.bottom.mas_equalTo(titleBaseView);
        make.size.mas_equalTo(CGSizeMake(titleBaseView.frame.size.width/2, titleBaseView.frame.size.height));
    }];
    [rightButton setTitle:@"详情" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    rightButton.tag = 152;
    [rightButton addTarget:self action:@selector(titleSegmentClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUpHeaderView
{
    _ImageScrollHederView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(140))];
    _ImageScrollHederView.delegate = self;
    
    //    NSArray * arr = [NSArray arrayWithObjects:@"d",@"d", nil];
    
    //    [ImageScrollHederView setImageArray:arr];
    
    [self.leftTableView setTableHeaderView:_ImageScrollHederView];
    
}




#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProductIndexType type = section;
    
    switch (type) {
        case kProductIndexTypeInfo: {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
            return view;
            break;
        }
        case kProductIndexTypeSelect: {
            if (_selectionHeadView == nil) {
                _selectionHeadView = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,GET_SCAlE_HEIGHT(68/2))];
                _selectionHeadView.tag = SELECTIONHEADVIEW_TAG;
                _selectionHeadView.backgroundColor = UIColorFromRGB(WHITECOLOR);
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTaped)];
                [_selectionHeadView addGestureRecognizer:tap];
            }
            if (_normsData.count > 0) {
                NSDictionary * dic = _normsData[0];
                [_selectionHeadView setViewWithTitle:@"已选:" SubTitle:nil RightTitle:[NSString stringWithFormat:@"%@ 1件",dic[@"normtitle"]] SymbolImage:[UIImage imageNamed:@"arrow_right"]];
                [_postNormDic setObject:_normsData[0][@"normtitle"] forKey:@"normtitle"];
                [_postNormDic setObject:@"1" forKey:@"buycount"];
                [_postNormDic setObject:_productDetail.productid forKey:@"productid"];
            }
            return _selectionHeadView;
            break;
        }
        case kProductIndexTypeComment: {
            cellDemonstrationView * view = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,GET_SCAlE_HEIGHT(68/2))];
            view.backgroundColor = UIColorFromRGB(WHITECOLOR);
            UILabel * line = [UILabel new];
            [view addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(view.mas_bottom);
                make.centerX.mas_equalTo(view.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toCommentViewController)];
            [view addGestureRecognizer:tap];
            [view setViewWithTitle:@"评价" SubTitle:_productDetail.score RightTitle:[NSString stringWithFormat:@"%@ 人评论",_productDetail.commentcount] SymbolImage:[UIImage imageNamed:@"arrow_right"]];
            return view;
            break;
        }
        case kProductIndexTypePossibleLike: {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(30))];
            view.backgroundColor = UIColorFromRGB(WHITECOLOR);
            
            UIImageView * heart = [UIImageView new];
            heart.image = [UIImage imageNamed:@"HomePageHeart"];
            [view addSubview:heart];
            [heart makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY);
                make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
                make.size.mas_equalTo(CGSizeMake(heart.image.size.width, heart.image.size.height));
            }];
            
            UILabel * titleLabel  = [UILabel new];
            [view addSubview:titleLabel];
            [titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(heart.right).with.offset(GET_SCAlE_LENGTH(5));
                make.centerY.mas_equalTo(heart.centerY).with.offset(0);
            }];
            titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
            titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
            titleLabel.text = @"猜你喜欢";
        
            return view;
            break;
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
            return GET_SCAlE_HEIGHT(30);
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        ProductIndexType type = indexPath.section;
        CGFloat height = 0;
        
        switch (type) {
            case kProductIndexTypeInfo: {
                height = GET_SCAlE_HEIGHT(180/2);
                break;
            }
            case kProductIndexTypeSelect: {
                height = GET_SCAlE_HEIGHT(68/2);
                break;
            }
            case kProductIndexTypeComment: {
                //                height = GET_SCAlE_HEIGHT(550/2);
                Comments * comment = _commentData[indexPath.row];
                return [self countCommentCellHeightWithModel:comment];
                
                break;
            }
            case kProductIndexTypePossibleLike: {
                height = GET_SCAlE_HEIGHT(115);
                break;
            }
        }
        
        return height;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    ProductIndexType type = section;
    
    switch (type) {
        case kProductIndexTypeInfo: {
            return 1;
            break;
        }
        case kProductIndexTypeSelect: {
            return 0;
            break;
        }
        case kProductIndexTypeComment: {
            return (_commentData.count > 0)?1:0;
            break;
        }
        case kProductIndexTypePossibleLike: {
            return _possibleLikeData.count;
            break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductIndexType type = indexPath.section;
    
    switch (type) {
        case kProductIndexTypeInfo: {
            HotelProductInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelProductInfoCell"];
            [cell setCellWithModel:_productDetail];
            return cell;
            break;
        }
        case kProductIndexTypeSelect: {
            break;
        }
        case kProductIndexTypeComment: {
            CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
            [cell setCellWithModel:_commentData[indexPath.row]];
            return cell;
            break;
        }
        case kProductIndexTypePossibleLike: {
            HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (_possibleLikeData.count > 0) {
//                [cell setCellWithModel:_possibleLikeData[indexPath.row]];
                [cell cellForHoelSuppListVC:NO];
                [cell cellForRowWithPossibleLike:_possibleLikeData[indexPath.row]];
                [cell cellForHoelSuppListVC:YES];
            }
            return cell;
            break;
        }
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        [self toCommentViewController];
    }
    else if (indexPath.section == 1){
        
        [self selectedTaped];
    }
    else if (indexPath.section == 3){
        
        if (_possibleLikeData.count > 0) {
            PossibleLike * model = _possibleLikeData[indexPath.row];
            self.hidesBottomBarWhenPushed = YES;
            HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:model.productid];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
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

-(void)maskTapWithDictionary:(NSDictionary *)dic OperationType:(OperationType)type
{
    NSLog(@"dic = %@,type = %ld",dic,type);    [_selectionHeadView setViewWithTitle:@"已选:" SubTitle:nil RightTitle:[NSString stringWithFormat:@"%@ %@件",dic[@"normtitle"],dic[@"number"]] SymbolImage:[UIImage imageNamed:@"arrow_right"]];
    
    [_postNormDic setObject:dic[@"normtitle"] forKey:@"normtitle"];
    [_postNormDic setObject:dic[@"number"] forKey:@"buycount"];
}

-(void)didSelectImageAtIndex:(NSInteger)index
{
    PreviewController * VC = [[PreviewController alloc] initWithParentViewController:self];
    VC.imageArr = _imageLists;
    [VC didMoveToParentViewController];
}
/**
 *  点击时触发
 *
 *  @param index 识别用下标
 */
-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    //    [self.flipView selectIndex:index];
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

- (void)toSellerHome
{
    NSLog(@"%s", __func__);
    
    self.hidesBottomBarWhenPushed = YES;
    HotelDetaiViewController *detailVc = [[HotelDetaiViewController alloc]initWithProduct:_productDetail];
    [self.navigationController pushViewController:detailVc animated:YES];
    detailVc.intro = _productDetail.shortintro;
    detailVc.logo = _productDetail.sellerlogo;
    detailVc.rateScore = _productDetail.sellerscore;
    detailVc.shopName = _productDetail.sellername;
    detailVc.sellerid = _productDetail.sellerid;
    detailVc.isProduct = YES;
//    detailVc.monthDayArr = _productDetail.turnover;
}

/**
 *  底部按钮点击事件
 *
 *  @param type 点击类型
 */
- (void)bottomViewClickWithType:(ProductTabType)type;
{
    
    if (type != kTapTelPhone && type != kTapGustclothing) {
        
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
    
    switch (type) {
        case kTapGustclothing: {
            NSString *showMsg = @"敬请期待";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                            message: showMsg
                                                           delegate: self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles: nil, nil];
            
            [alert show];
            
            break;
        }
        case kTapTelPhone: {
            [self callPhone];
            break;
        }
        case kTapCollection: {
            [self addShopCarOrCollectionWithType:kGetInTypeCollection];
            break;
        }
        case kTapShoppingCart: {
            [self addShopCarOrCollectionWithType:kGetInTypeShopCar];
            break;
        }
        case kTapBuy: {
            self.hidesBottomBarWhenPushed = YES;
//            ConfirmHotelSuppliesOrderViewController * VC = [[ConfirmHotelSuppliesOrderViewController alloc] initWithProductDetailFromHSView:_productDetail NormData:_normsData];
//            [self.navigationController pushViewController:VC animated:YES];
            [self configureDataSource];
            break;
        }
    }
}


#pragma mark 配置数据

- (void)configureDataSource {
    ShoppingCarProduct *order = [ShoppingCarProduct new];
    order.productid = _productDetail.productid;
    order.buycount = @(1).stringValue;
    order.sellername = _productDetail.sellername;
    order.price = _productDetail.price;
    order.coinprice = _productDetail.coinprice;
    order.coinreturn = _productDetail.coinreturn;
    order.logo = _productDetail.logo;
    order.title = _productDetail.title;
    order.cityname = _productDetail.cityname;
    order.citycode = _productDetail.citycode;
    order.starlevel = _productDetail.starlevel;
    order.isneedbook = _productDetail.isneedbook;
    order.producttype = _productDetail.producttype;
    order.turnover = _productDetail.turnover;
    order.distance = _productDetail.distance;
    order.address = _productDetail.address;
    order.score = _productDetail.score;
    order.isspecial = _productDetail.isspecial;
    order.normtitle = _postNormDic[@"normtitle"];
    
    NSString *buyNum = _postNormDic[@"buycount"]?:@"1";
    NSArray *products = @[order,buyNum];
    NSArray *dataSource = @[products];
    ConfirmHotelSuppliesOrderViewController2 * VC = [[ConfirmHotelSuppliesOrderViewController2 alloc] initWithDataSource:dataSource withOrderType:kOrderTypeHotelSupplies];
    VC.totalMoney = order.price.floatValue/100.0;
    VC.totalReturn = order.coinreturn.floatValue;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
    
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClicked
{
    if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        NSString *showMsg = @"请先登录";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles: @"确定", nil];
        
        alert.tag = 100;
        [alert show];
        
    }else{
        
        self.hidesBottomBarWhenPushed = YES;
        ShoppingCartViewController * VC = [[ShoppingCartViewController alloc] initWithProductType:kProductTypeEntity];
        [self.navigationController pushViewController:VC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
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

- (void)titleSegmentClicked:(UIButton *)sender
{
    NSInteger index = sender.tag % 15;
    
    TitleSegmentClickType clickType = index;
    
    CGRect leftFrame = _leftTableView.frame;
    CGRect rightFrame = _rightBaseView.frame;
    CGRect segBGFrame = _segBackView.frame;
    
    switch (clickType) {
            
        case kClickCommodity: {
            
            leftFrame.origin.x    = 0;
            rightFrame.origin.x   = SCREEN_WIDTH;
            segBGFrame.origin.x   = 0;
            _leftTableView.hidden = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                _leftTableView.frame  = leftFrame;
                _rightBaseView.frame  = rightFrame;
                _segBackView.frame    = segBGFrame;
                [sender setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
                UIButton * rightBtn   = [[sender superview] viewWithTag:152];
                [rightBtn setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                _rightBaseView.hidden = YES;
            }];
            break;
        }
        case kClickDetails: {
            
            leftFrame.origin.x    = - SCREEN_WIDTH;
            rightFrame.origin.x   = 0;
            segBGFrame.origin.x   = [sender superview].frame.size.width/2;
            _rightBaseView.hidden = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                _leftTableView.frame  = leftFrame;
                _rightBaseView.frame  = rightFrame;
                _segBackView.frame    = segBGFrame;
                [sender setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
                UIButton * rightBtn   = [[sender superview] viewWithTag:151];
                [rightBtn setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                _leftTableView.hidden = YES;
            }];;
            break;
        }
        default: {
            break;
        }
    }
}

/**
 *  筛选headview点击事件
 */
- (void)selectedTaped
{
    ProductSelectedView * View = [[ProductSelectedView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, GET_SCAlE_HEIGHT(280)) withDataArray:_normsData];
    View.delegate = self;
    [self.view addSubview:View];
    View.tag = SELECTIONVIEW_TAG;
    [View show];
    [self addMaskViewWithShowView:View];
    [View callBackWithBlock:^(NSDictionary *dictionary, OperationType type) {
        NSLog(@"dic = %@,type = %ld",dictionary,type);
        [_selectionHeadView setViewWithTitle:@"已选:" SubTitle:nil RightTitle:[NSString stringWithFormat:@"%@ %@件",dictionary[@"normtitle"],dictionary[@"number"]] SymbolImage:[UIImage imageNamed:@"arrow_right"]];
        
        [_postNormDic setObject:dictionary[@"normtitle"] forKey:@"normtitle"];
        [_postNormDic setObject:dictionary[@"number"] forKey:@"buycount"];
        
        [View hide];
        [self removeMask];
        
        switch (type) {
            case kNone: {
                
                break;
            }
            case kShoppingCart: {
                [self bottomViewClickWithType:kTapShoppingCart];
                break;
            }
            case kBuyImmediately: {
                [self bottomViewClickWithType:kTapBuy];
                break;
            }
        }
    }];
}

/**
 *  拨打电话
 */
- (void)callPhone {
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectZero];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_productDetail.servicephone]]]];
    [self.view addSubview:web];
}

/**
 *  跳转评论页面
 */
- (void)toCommentViewController
{
    self.hidesBottomBarWhenPushed = YES;
    CommentViewController * VC = [[CommentViewController alloc] initWithProductDetail:_productDetail];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 网络

- (void)getProductDetailData
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if (_productID) {
        [bodyDic setObject:_productID forKey:@"productid"];
    }
    [bodyDic setObject:@"productdetail" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        ProductDetailModelParser * parser = [[ProductDetailModelParser alloc] initWithDictionary:responseBody];
        _productDetail = parser.productDetailModel.productDetail;
        [[AppInformationSingleton shareAppInfomationSingleton] setBrowseHistory:_productDetail];
        
        id norms = parser.productDetailModel.productDetail.norms;
        if ([norms isKindOfClass:[NSArray class]]) {
            _normsData = [NSMutableArray arrayWithArray:(NSArray *)norms];
        }
        else if ([norms isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * dicM = (NSDictionary *)norms;
            [_normsData addObject:[dicM objectForKey:@"norm"]];
        }
        _commentData   = [NSMutableArray arrayWithArray:parser.productDetailModel.productDetail.comments];
        
        [_ImageScrollHederView setImageArray:parser.productDetailModel.productDetail.imagelist];
        _imageLists = parser.productDetailModel.productDetail.imagelist;
        [_headView setParameterWithModel:_productDetail];
        
        UIWebView * web_intro = [_rightBaseView viewWithTag:200];
        [web_intro loadHTMLString:_productDetail.longintro baseURL:nil];
        
        UIWebView * web_nrom = [_rightBaseView viewWithTag:201];
        [web_nrom loadHTMLString:_productDetail.normintro baseURL:nil];
        
        UIWebView * web_pack = [_rightBaseView viewWithTag:202];
        [web_pack loadHTMLString:_productDetail.packafserv baseURL:nil];
        
        [_leftTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

/**
 *  获取猜你喜欢数据
 */
- (void)getPossibleLikeData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"sj_like" forKey:@"functionid"];
    [bodyDic setObject:@"1" forKey:@"producttype"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        id arrM = responseBody[@"body"][@"likes"];
        if ([arrM isKindOfClass:[NSDictionary class]]) {
            PossibleLike * model = [PossibleLike modelObjectWithDictionary:arrM[@"product"]];
            [_possibleLikeData addObject:model];
        }else{
        
        PossibleLikeModelParser * parser = [[PossibleLikeModelParser alloc] initWithDictionary:responseBody];
        _possibleLikeData = (NSMutableArray *)parser.possibleLikeModel.possibleLike;
        }
//        [arrM enumerateObjectsUsingBlock:^(PossibleLike * _Nonnull possibleLike, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            if ([possibleLike isKindOfClass:[PossibleLike class]]) {
//                [_possibleLikeData addObject:possibleLike];
//            }
//        }];
        
        [self.leftTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
    }];
    
}

- (void)addShopCarOrCollectionWithType:(ProductGetInType)type
{
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        NSString *showMsg = @"请检查网络";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];
        
        
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"addtocar" forKey:@"functionid"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    NSArray * arrM = [NSArray arrayWithObjects:_postNormDic, nil];
    
    [bodyDic setObject:arrM forKey:@"products"];
    
    [bodyDic setObject:_productID forKey:@"scproductid"];
    //    [bodyDic setObject:_productDetail.sellerid forKey:@"sellerid"];
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        
        if ([responseBody[@"head"][@"resultcode"] isEqualToString:@"0000"])
        {
            switch (type) {
                case kGetInTypeShopCar: {
                    [SVProgressHUD dismissWithSuccess:@"已成功加入购物车" afterDelay:1];
                    break;
                }
                case kGetInTypeCollection: {
                    [SVProgressHUD dismissWithSuccess:@"收藏成功" afterDelay:1];
                    break;
                }
            }
            
        }else{
            [SVProgressHUD dismissWithSuccess:nil afterDelay:0.3];
        }
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
