//
//  CommentViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/2.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentsModelParser.h"
#import "PreviewController.h"

@implementation CommentViewController
{
    ProductDetail * _product;
    
    NSMutableArray * _dataSource;
    
    //记录当前页
    NSInteger _currentPage;
    
    //记录当前类型
    CommentListType _currentType;
    
    //记录一共有多少页
    NSInteger  _totalPageCount;
    
    CommentsModelParser * _commentParser;
    
    CommentHeaderView * _headerView;
}

-(instancetype)initWithProductDetail:(ProductDetail *)product
{
    self = [super init];
    
    if (self) {
        
        _product = product;
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getCommentList];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDataSource];
    
    [self loadCostomViw];
}

- (void)initDataSource
{
    _dataSource = [NSMutableArray array];
    
    _currentPage = 1;
    _currentType = kCommentTypeAll;
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"商品评价"];
    
    [self loadMainTableView];
    
    [self loadCommentHeaderView];
}

- (void)loadCommentHeaderView
{
    _headerView = [[CommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(63)) withDataArray:[NSArray arrayWithObjects:@"全部评价",@"好评",@"中评",@"差评", nil] withFont:14];
    [self.view addSubview:_headerView];
    [_headerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(61)));
    }];
    
    _headerView.delegate = self;
    [_headerView setNoticeType:kNoticeTypeLine];
    [_headerView setTextColor:UIColorFromRGB(BLACKFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.bottom).with.offset(GET_SCAlE_HEIGHT(63));
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    [self addpull2RefreshWithTableView:self.mainTableView];
    [self addPush2LoadMoreWithTableView:self.mainTableView];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comments * comment = _dataSource[indexPath.row];
    
    return [self countCommentCellHeightWithModel:comment];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    if (_dataSource.count > 0) {
        if ([_dataSource[indexPath.row] isKindOfClass:[Comments class]]) {
            Comments * model = _dataSource[indexPath.row];
            [cell setCellWithModel:model];
            
            //评论cell图片点击事件
            [cell imageTaped:^(Comments *model) {
                [self CommentImageTapWithComment:model];
            }];
//            [cell imageTaped:^{
//                [self CommentImageTapWithComment:model];
//            }];
        }
    }
    
    return cell;
}

-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    [_dataSource removeAllObjects];
    
    [self getCommentList];
}

-(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    if (_totalPageCount <= 1) {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    
    else if (_currentPage < _totalPageCount) {
        _currentPage ++;
        [self getCommentList];
    }else{
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    
//    if (_totalPageCount < 2) {
//        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
//    }
//    else
//    {
//        if (_currentPage < _totalPageCount)
//            _currentPage ++;
//        [self getCommentList];
//    }
}

#pragma mark - 网络

- (void)getCommentList
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"spcommentlist" forKey:@"functionid"];
    [bodyDic setObject:@"10" forKey:@"pagesize"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentType] forKey:@"type"];
    
    if ([_product.sellerid isKindOfClass:[NSString class]] && (_product.sellerid.length > 0)) {
        [bodyDic setObject:_product.sellerid forKey:@"sellerid"];
    }
    if ([_product.productid isKindOfClass:[NSString class]] && (_product.productid.length > 0)) {
        [bodyDic setObject:_product.productid forKey:@"productid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        
        CommentsModelParser * parser = [[CommentsModelParser alloc] initWithDictionary:responseBody];
        _commentParser = parser;
        NSArray * arrM = parser.commentsModel.comments;
        _totalPageCount = [parser.commentsModel.totalpage integerValue];
        
        id temArr = responseBody[@"body"][@"comments"];
        
        if ([temArr isKindOfClass:[NSDictionary class]]) {
            Comments * model = [Comments modelObjectWithDictionary:temArr[@"comment"]];
            [_dataSource addObject:model];
        }else{

            
            [arrM enumerateObjectsUsingBlock:^(Comments *  comment, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([comment isKindOfClass:[Comments class]]) {
                    if ([comment.commentid integerValue]!=0) {
                        [_dataSource addObject:comment];
                    }
                }
            }];
        }
        
        NSArray * numbers = [NSArray arrayWithObjects:parser.commentsModel.totalcount0,parser.commentsModel.totalcount1,parser.commentsModel.totalcount2,parser.commentsModel.totalcount3, nil];
        [_headerView setCellwithNumberArr:numbers];
        
        if (_dataSource.count == 0) {
            [self showEmptyViewWithTableView:self.mainTableView];
        }else{
            [self removeEmptyViewWithTableView:self.mainTableView];
        }
        
        [self.mainTableView reloadData];
        
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        
        [self endRefreshing];
    }];
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

-(void)selectedIndex:(NSInteger)index
{
    CommentListType type = index;
    _currentType = type;
    
    [_dataSource removeAllObjects];
    [self getCommentList];
}

@end
