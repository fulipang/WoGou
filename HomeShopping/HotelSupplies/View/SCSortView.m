//
//  SCSortView.m
//  HomeShopping
//
//  Created by sooncong on 16/1/5.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SCSortView.h"
#import "Productbrands.h"
#import "Prices.h"
#import "Coinprices.h"
#import "Coinreturns.h"

#define CELLHEIGHT GET_SCAlE_HEIGHT(45)

@implementation SCSortView
{
    NSArray * _sortTitles;
    
    //记录当前状态
    currentSelected _currentStatus;
    ProductSortType _currentSortType;
    
    //筛选字典
    NSMutableDictionary * _sortDict;
    
    ProductSortModel * _model;
    
    SCSortCallBackBlock _callBackBlock;
    
    //是否需要预订
    BOOL _isNeedBook;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadCustomView];
        
        //        [self createSortArray];
        
        self.backgroundColor = UIColorFromRGB(WHITECOLOR);
    }
    
    return self;
}

#pragma mark - 自定义视图

-(void)loadCustomView
{
    //筛选视图导航
    UIView * sortNavBar = [UIView new];
    [self addSubview:sortNavBar];
    [sortNavBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(50), 64));
    }];
    
    //导航栏分割线
    UILabel * line = [UILabel new];
    [sortNavBar addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(sortNavBar.mas_bottom);
        make.centerX.mas_equalTo(sortNavBar.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(50), 1));
    }];
    line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * titleLab = [UILabel new];
    [sortNavBar addSubview:titleLab];
    [titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.top).with.offset(GET_SCAlE_HEIGHT(40));
        make.centerX.mas_equalTo(sortNavBar.centerX);
    }];
    titleLab.text = @"筛选";
    
    //确定按钮
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortNavBar addSubview:sureButton];
    [sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab.centerY);
        make.right.mas_equalTo(sortNavBar.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortNavBar addSubview:cancleButton];
    [cancleButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab.centerY);
        make.left.mas_equalTo(sortNavBar.left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    //筛选tableview
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
    [self addSubview:_mainTableView];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //赋值状态
    _currentStatus = kSelectedMain;
}

#pragma mark - 数据

/**
 *  数据预处理
 */
- (void)createSortArray
{
    if (_isNeedBook) {
        _sortTitles = [NSArray arrayWithObjects:@"价格",@"返积分",@"品牌",@"换购积分",@"是否需预约", nil];
    }else{
        _sortTitles = [NSArray arrayWithObjects:@"价格",@"返积分",@"品牌",@"换购积分", nil];
    }
    _sortDict = [[NSMutableDictionary alloc] initWithCapacity:1];
}

#pragma mark - 事件


/**
 *  隐藏副表视图
 */
- (void)hideSubTableView
{
    [UIView animateWithDuration:0 animations:^{
        _subTableView.hidden = YES;
    } completion:^(BOOL finished) {
        CGRect frame = _subTableView.frame;
        frame.origin.x = self.frame.size.width;
        _subTableView.frame = frame;
        
        //赋值状态
        _currentStatus = kSelectedMain;
    }];
}

- (void)cancelButtonClicked
{
    _callBackBlock(nil);
}

/**
 *  确定按钮点击事件
 */
-(void)sureButtonClicked
{
    switch (_currentStatus) {
        case kSelectedMain: {
            _callBackBlock(_sortDict);
            
            break;
        }
        case kSelectedSub: {
            
            switch (_currentSortType) {
                case kSortTypePrice: {
                    
                    [self setSortDicWithKeyMin:@"pricemin" KeyMax:@"pricemax"];
                    
                    break;
                }
                case kSortTypeCoinReturn: {
                    [self setSortDicWithKeyMin:@"coinreturnmin" KeyMax:@"coinreturnmax"];
                    break;
                }
                case kSortTypeProductBrand: {
                    
                    break;
                }
                case kSortTypeCoinPrice: {
                    [self setSortDicWithKeyMin:@"coinpricemin" KeyMax:@"coinpricemax"];
                    break;
                }
                case kSortTypeNeedBook:{
                    
                    break;
                }
            }
            
            [self hideSubTableView];
            
            break;
        }
    }
}

-(void)callBackWithBlock:(SCSortCallBackBlock)block
{
    _callBackBlock = block;
}

- (void)setSortDicWithKeyMin:(NSString *)keyMin KeyMax:(NSString *)keyMax
{
    UITextField * min = [_subTableView viewWithTag:100];
    UITextField * max = [_subTableView viewWithTag:101];
    if (min.text.length > 0) {
        [_sortDict setObject:min.text forKey:keyMin];
    }
    if (max.text.length > 0) {
        [_sortDict setObject:max.text forKey:keyMax];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mainTableView) {
        return _sortTitles.count;
    }else{
        
        switch (_currentSortType) {
            case kSortTypePrice: {
                return _model.prices.count + 1;
                break;
            }
            case kSortTypeCoinReturn: {
                return _model.coinreturns.count + 1;
                break;
            }
            case kSortTypeProductBrand: {
                return _model.productbrands.count + 1;
                break;
            }
            case kSortTypeCoinPrice: {
                return _model.coinprices.count + 1;
                break;
            }
            case kSortTypeNeedBook:
                return 2;
                break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:[self createContentViewWithIndexPath:indexPath TableView:tableView]];
    
    if (tableView == _subTableView) {
        switch (_currentSortType) {
            case kSortTypePrice: {
                if (indexPath.row == _model.prices.count + 1) {
                    [cell.contentView addSubview:[self createModifyRangeViewWithIndexPath:indexPath]];
                }
                break;
            }
            case kSortTypeCoinReturn: {
                if (indexPath.row == _model.coinreturns.count + 1) {
                    [cell.contentView addSubview:[self createModifyRangeViewWithIndexPath:indexPath]];
                }
                break;
            }
            case kSortTypeProductBrand: {
                if (indexPath.row == _model.productbrands.count + 1) {
                    //                    [cell.contentView addSubview:[self createModifyRangeViewWithIndexPath:indexPath]];
                }
                break;
            }
            case kSortTypeCoinPrice: {
                if (indexPath.row == _model.coinprices.count + 1) {
                    [cell.contentView addSubview:[self createModifyRangeViewWithIndexPath:indexPath]];
                }
                break;
            }
            case kSortTypeNeedBook:{
                
                break;
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(UIView *)createModifyRangeViewWithIndexPath:(NSIndexPath *)indexPath
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CELLHEIGHT)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.userInteractionEnabled = YES;
    
    UITextField * textMin = [UITextField new];
    [contentView addSubview:textMin];
    [textMin makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY);
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(70), GET_SCAlE_LENGTH(30)));
    }];
    textMin.borderStyle = UITextBorderStyleRoundedRect;
    textMin.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    textMin.keyboardType = UIKeyboardTypeNumberPad;
    textMin.tag = 100;
    textMin.placeholder = @"起始价格";
    
    UITextField * textMax = [UITextField new];
    [contentView addSubview:textMax];
    [textMax makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY);
        make.left.mas_equalTo(textMin.right).with.offset(GET_SCAlE_LENGTH(20));
        make.centerY.mas_equalTo(contentView.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(70), GET_SCAlE_HEIGHT(30)));
    }];
    textMax.borderStyle = UITextBorderStyleRoundedRect;
    textMax.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    textMax.keyboardType = UIKeyboardTypeNumberPad;
    textMax.tag = 101;
    textMax.placeholder = @"终止价格";
    
    return contentView;
}

- (void)text
{
    NSLog(@"%s", __func__);
}

/**
 *  创建contentview
 *
 *  @param indexPath
 *  @param tableView
 *
 *  @return cell的contentview
 */
- (UIView *)createContentViewWithIndexPath:(NSIndexPath *)indexPath TableView:(UITableView *)tableView
{
    UIView * superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CELLHEIGHT)];
    
    UILabel * line = [UILabel new];
    [superView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(superView.mas_bottom);
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * titleLabel = [UILabel new];
    [superView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(superView.centerY);
        make.left.mas_equalTo(superView.mas_left).with.offset(GET_SCAlE_LENGTH(25));
    }];
    
    titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    
    //分开处理
    
    if (tableView == _mainTableView) {
        
        UIImageView * symbol = [UIImageView new];
        symbol.image = [UIImage imageNamed:@"arrow_right"];
        [superView addSubview:symbol];
        [symbol makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(superView.mas_centerY);
            make.right.mas_equalTo(superView.mas_right).with.offset(- GET_SCAlE_LENGTH(10));
            make.size.mas_equalTo(CGSizeMake(symbol.image.size.width, symbol.image.size.height));
        }];
        
        titleLabel.text = _sortTitles[indexPath.row];
    }else{
        
        switch (_currentSortType) {
            case kSortTypePrice: {
                if (indexPath.row == 0) {
                    titleLabel.text = @"全部";
                }else if(indexPath.row == _model.prices.count + 1){
                    
                }
                else{
                    Prices * price = _model.prices[indexPath.row - 1];
                    titleLabel.text = [NSString stringWithFormat:@"%@ - %@",price.pricemin,price.pricemax];
                }
                break;
            }
            case kSortTypeCoinReturn: {
                if (indexPath.row == 0) {
                    titleLabel.text = @"全部";
                }else if(indexPath.row == _model.coinreturns.count + 1){
                    
                }
                else{
                    if (_model.coinreturns.count > 0) {
                        NSInteger row = indexPath.row - 1;
                        Coinreturns * model = _model.coinreturns[row];
                        titleLabel.text = [NSString stringWithFormat:@"%@ - %@",model.coinreturnmin,model.coinreturnmax];
                    }
                }
                break;
            }
            case kSortTypeProductBrand: {
                if (indexPath.row == 0) {
                    titleLabel.text = @"全部";
                }else{
                    Productbrands * model = _model.productbrands[indexPath.row - 1];
                    titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
                }
                break;
            }
            case kSortTypeCoinPrice: {
                if (indexPath.row == 0) {
                    titleLabel.text = @"全部";
                }else if(indexPath.row == _model.coinprices.count + 1){
                    NSLog(@"r = %ld",indexPath.row);
                }else{
                    NSInteger row = indexPath.row - 1;
                    Coinprices * model = _model.coinprices[row];
                    titleLabel.text = [NSString stringWithFormat:@"%@ - %@",model.coinpricemin,model.coinpricemax];
                }
                break;
            }
            case kSortTypeNeedBook:
                if (indexPath.row == 0) {
                    titleLabel.text = @"是";
                }else{
                    titleLabel.text = @"否";
                }
                break;
        }
    }
    
    return superView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTableView) {
        
        ProductSortType type = indexPath.row;
        
        switch (type) {
                
            case kSortTypePrice: {
                _currentSortType = kSortTypePrice;
                [self setUpSubSortTableViewWithData:_model.prices];
                break;
            }
            case kSortTypeCoinReturn: {
                _currentSortType = kSortTypeCoinReturn;
                [self setUpSubSortTableViewWithData:_model.coinreturns];
                break;
            }
            case kSortTypeProductBrand: {
                _currentSortType = kSortTypeProductBrand;
                [self setUpSubSortTableViewWithData:_model.productbrands];
                break;
            }
            case kSortTypeCoinPrice: {
                _currentSortType = kSortTypeCoinPrice;
                [self setUpSubSortTableViewWithData:_model.coinprices];
                break;
            }
            case kSortTypeNeedBook:{
                _currentSortType = kSortTypeNeedBook;
                [self setUpSubSortTableViewWithData:nil];
                break;
            }
        }
    }else{
        
        switch (_currentSortType) {
            case kSortTypePrice: {
                if (indexPath.row == 0) {
                    [_sortDict removeObjectForKey:@"pricemax"];
                    [_sortDict removeObjectForKey:@"pricemin"];
                }
                else if (indexPath.row == _model.prices.count + 1)
                {
                    return;
                }
                else
                {
                    Prices * price = _model.prices[indexPath.row - 1];
                    [_sortDict setObject:price.pricemax forKey:@"pricemax"];
                    [_sortDict setObject:price.pricemin forKey:@"pricemin"];
                }
                break;
            }
            case kSortTypeCoinReturn: {
                if (indexPath.row == 0) {
                    [_sortDict removeObjectForKey:@"coinreturnmax"];
                    [_sortDict removeObjectForKey:@"coinreturnmin"];
                }
                else if (indexPath.row == _model.prices.count + 1)
                {
                    
                }
                else
                {
                    Coinreturns * coinReturn = _model.coinreturns[indexPath.row - 1];
                    [_sortDict setObject:coinReturn.coinreturnmax forKey:@"coinreturnmax"];
                    [_sortDict setObject:coinReturn.coinreturnmin forKey:@"coinreturnmin"];
                }
                break;
            }
            case kSortTypeProductBrand: {
                if (indexPath.row == 0) {
                    //                    [_sortDict removeObjectForKey:@"<#@#>"];
                    [_sortDict removeObjectForKey:@"productbrandid"];
                }
                else if (indexPath.row == _model.prices.count + 1)
                {
                    
                }
                else
                {
                    Productbrands * brand = _model.productbrands[indexPath.row - 1];
                    [_sortDict setObject:brand.productbrandid forKey:@"productbrandid"];
                    //                    [_sortDict setObject:<#@#>.pricemin forKey:@"<#@#>"];
                }
                break;
            }
            case kSortTypeCoinPrice: {
                if (indexPath.row == 0) {
                    [_sortDict removeObjectForKey:@"coinpricemax"];
                    [_sortDict removeObjectForKey:@"coinpricemin"];
                }
                else if (indexPath.row == _model.prices.count + 1)
                {
                    
                }
                else
                {
                    Coinprices * price = _model.coinprices[indexPath.row - 1];
                    [_sortDict setObject:price.coinpricemax forKey:@"coinpricemax"];
                    [_sortDict setObject:price.coinpricemin forKey:@"coinpricemin"];
                }
                break;
            }
            case kSortTypeNeedBook:{
                
                if (indexPath.row == 0) {
                    [_sortDict setObject:@"是" forKey:@"isneedbook"];
                }else{
                    [_sortDict setObject:@"否" forKey:@"isneedbook"];
                }
                break;
            }
        }
        [self hideSubTableView];
    }
}

-(void)setUpSubSortTableViewWithData:(NSArray *)data
{
    //赋值状态
    _currentStatus = kSelectedSub;
    
    if (_subTableView) {
        
        _subTableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _subTableView.frame;
            frame.origin.x = 0;
            _subTableView.frame = frame;
        }];
        
        [_subTableView reloadData];
        
        return;
    }
    
    _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width, 64, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    [self addSubview:_subTableView];
    _subTableView.tag = 201;
    
    //    _subTableView.backgroundColor = [UIColor greenColor];
    _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _subTableView.delegate = self;
    _subTableView.dataSource = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _subTableView.frame;
        frame.origin.x = 0;
        _subTableView.frame = frame;
    }];
}

-(void)setParameterWithModle:(ProductSortModel *)model NeedBook:(BOOL)needBook
{
    _model = model;
    _isNeedBook = needBook;
    
    [self createSortArray];
}

@end
