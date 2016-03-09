//
//  ChooseCityViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/4.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "CityModel.h"
#import "CityModels.h"
#import "CityModelsParser.h"
#import "MapViewController.h"

#import "ChineseInclude.h"
#import "PinYinForObjc.h"

@interface ChooseCityViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
@property (nonatomic, readwrite, strong) NSArray *listArr;

/// 按照索引分类好的城市数组
@property (nonatomic, readwrite, strong) NSArray *sortArr;

/// 未分类的城市数组
@property (nonatomic, readwrite, strong) NSMutableArray *citiesArr;

/// 只包含城市名称的数组
@property (nonatomic, readwrite, strong) NSMutableArray *allCityNameArr;

/// 城市字典,key为索引, value为城市数组
@property (nonatomic, readwrite, strong) NSMutableDictionary *citiesDic;

/// 城市code字典 key为城市名, value为城市code
@property (nonatomic, readwrite, strong) NSMutableDictionary *cityCodeDic;
/// 搜索城市数组
@property (nonatomic, readwrite, strong) NSMutableArray *searchArr;
@property (nonatomic, readwrite, strong) UIView *headerView;
@property (nonatomic, readwrite, strong) UISearchBar *mSearchBar;
@property (nonatomic, readwrite, strong) UISearchDisplayController *mySearchDisplayController;
@property (nonatomic, readwrite, copy) NSString *localCity;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ChooseCityViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _listArr = @[@"定位",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    [self getCityData];
    
    [self loadCostomViw];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self locationLocalCity];
    });
}


#pragma mark 获取当前城市

/// 获取当前城市
- (void)locationLocalCity {
    MapViewController *map = [[MapViewController alloc]initForLocalCity];
    UITableViewCell * cell = [self.mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    self.activityIndicatorView.center = CGPointMake(30, CGRectGetHeight(cell.bounds)/2);
    [cell.contentView addSubview:self.activityIndicatorView];
    [map setCallBackSelectedCity:^(NSString *localCity) {
        [self.activityIndicatorView stopAnimating];
        [self.activityIndicatorView removeFromSuperview];
        cell.textLabel.text = localCity;
        self.localCity = localCity;
        
        [[AppInformationSingleton shareAppInfomationSingleton] setLocationInfoWithCityName:localCity CityCode:self.cityCodeDic[localCity] Longitude:nil Latitude:nil];
    }];
    [self addChildViewController:map];
    [map didMoveToParentViewController:self];
    map.view.hidden = YES;
    [self.view insertSubview:map.view belowSubview:self.mainTableView];
}

#pragma mark - 自定义视图

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        self.activityIndicatorView.frame = CGRectMake(0, 0, 30, 30);
        [_activityIndicatorView startAnimating];
    }
    return _activityIndicatorView;
}

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"选择城市"];
    
    [self loadMainTableView];
    
    [self.view addSubview:self.headerView];

}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(@(CGRectGetMaxY(self.headerView.frame)));
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.mainTableView setSeparatorInset:UIEdgeInsetsZero];
    self.mainTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}



#pragma mark - 网络

- (void)getCityData
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
    [bodyDic setObject:@"findcity" forKey:@"functionid"];
    [bodyDic setObject:@"1000" forKey:@"pagesize"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {

        NSLog(@"result = %@",responseBody);
        
        if (responseBody) {
            if ([responseBody isKindOfClass:[NSDictionary class]]) {
                NSDictionary *citys = [responseBody objectForKey:@"body"];
                [self.citiesArr removeAllObjects];
                [self.allCityNameArr removeAllObjects];
                if (citys && [citys isKindOfClass:[NSDictionary class]]) {
                    CityModels *models = [CityModels modelObjectWithDictionary:citys];
                    [self.citiesArr addObjectsFromArray:models.cityModel];
                    for (CityModel *model in self.citiesArr) {
                        if (model.title) {
                            [self.allCityNameArr addObject:model.title];
                            [self.cityCodeDic setObject:model.code?:@"" forKey:model.title];
                        }
                    }
                    [self sortArr:self.citiesArr];
                }
            }
        }
        
        if (self.cityCodeDic.count > 0) {
            [[AppInformationSingleton shareAppInfomationSingleton] setCityCodeListWithDictionary:self.cityCodeDic];
        }
        
        [SVProgressHUD dismiss];
        
    } FailureBlock:^(NSString *error) {
        
//        NSLog(@"erro = %@",error);
        [SVProgressHUD dismiss];
        
    }];
}


#pragma mark ---

- (void)sortArr:(NSArray*)cities {
    
    NSMutableArray *temArr = [NSMutableArray arrayWithCapacity:27];
    
    for (int i = 0; i < self.listArr.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        [temArr addObject:arr];
    }
    
    for (CityModel *city in cities) {
        
        CFStringRef cString = (__bridge CFStringRef)(city.title?:@"");
        CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (CFStringRef)cString);
        
        CFStringTransform(string, NULL, kCFStringTransformToLatin, false);
        CFStringTransform(string, NULL, kCFStringTransformStripCombiningMarks, false);
        
        NSString *toString = (__bridge NSString *)(string);
        if (toString.length == 0 || !toString) {
            NSMutableArray *arr = [temArr objectAtIndex:self.listArr.count-1];
            [arr addObject:city];
            continue;
        }
        NSString *firstString = [toString substringToIndex:1];
        
        [self.listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *str = obj;

            if ([[str lowercaseString]isEqualToString:[firstString lowercaseString]]) {
                NSMutableArray *arr = [temArr objectAtIndex:idx];
                [arr addObject:city];
                *stop = YES;
            }
            
        }];
        CFRelease(string);
    }
    
    self.sortArr = [temArr copy];
    for (int i = 0; i < self.sortArr.count; i++) {
        [self.citiesDic setObject:self.sortArr[i]?:@"" forKey:self.listArr[i]];
    }
    [self.mainTableView reloadData];
}


#pragma mark - 事件

-(void)leftButtonClicked
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)rightButtonClicked
{
    
}


#pragma mark headView

- (UIView*)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 49)];
        _mSearchBar = [UISearchBar new];
        [_headerView addSubview:_mSearchBar];
        [_mSearchBar makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerView.mas_top);
            make.left.and.right.mas_equalTo(_headerView);
            make.bottom.mas_equalTo(_headerView.mas_bottom);
        }];
        _headerView.backgroundColor = _mSearchBar.backgroundColor;
        _mSearchBar.placeholder = @"中文/拼音首字母";
        
        //设置搜索条的return键类型
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.1) {
            _mSearchBar.returnKeyType = UIReturnKeyDone;
        }else{
            for (id obj in _mSearchBar.subviews) {
                if ([obj isKindOfClass:[UITextField class]]) {
                    UITextField *textField = (UITextField *)obj;
                    textField.returnKeyType = UIReturnKeyDone;
                }
            }
        }
        _mSearchBar.delegate = self;
        _mySearchDisplayController =[[UISearchDisplayController alloc] initWithSearchBar:_mSearchBar contentsController:self];
        _mySearchDisplayController.searchResultsDelegate= self;
        _mySearchDisplayController.searchResultsDataSource = self;
        _mySearchDisplayController.delegate = self;
    }
    return _headerView;
}


- (NSMutableArray*)searchArr {
    if (!_searchArr) {
        _searchArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _searchArr;
}

- (NSMutableArray*)citiesArr {
    if (!_citiesArr) {
        _citiesArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _citiesArr;
}

- (NSMutableArray*)allCityNameArr {
    if (!_allCityNameArr) {
        _allCityNameArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _allCityNameArr;
}

- (NSMutableDictionary *)citiesDic {
    if (!_citiesDic) {
        _citiesDic = [NSMutableDictionary dictionary];
    }
    return _citiesDic;
}

- (NSMutableDictionary *)cityCodeDic {
    if (!_cityCodeDic) {
        _cityCodeDic = [NSMutableDictionary dictionary];
    }
    return _cityCodeDic;
}




#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.mainTableView) {
        return self.sortArr.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        if (section == 0) {
            return 1;
        }
        return [(NSArray*)self.sortArr[section] count];
    }
    return self.searchArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.mainTableView) {
        if (self.searchArr.count != 0)
        {
            static NSString *Cell1 = @"Cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell1];
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: Cell1];
            }
            cell.textLabel.text = self.searchArr[indexPath.row];
            return cell;
        }
        else
        {
            static NSString *Cell2 = @"Cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell2];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: Cell2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize: 25.0];
                cell.textLabel.textColor = [UIColor lightGrayColor];
            }
            cell.textLabel.text = @"亲，暂无你想要的结果";
            return cell;
        }
    }
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _localCity?:@"";
    }
    else {
        
        CityModel *city = [self.sortArr objectAtIndex:indexPath.section][indexPath.row];
        cell.textLabel.text = city.title;
    }
    
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (tableView == self.mainTableView) {
        if (indexPath.section == 0) {
            if (self.localCity) {
                !self.selectedCityCallBack ?: self.selectedCityCallBack(self.localCity, self.cityCodeDic[self.localCity]);
                [[AppInformationSingleton shareAppInfomationSingleton] setSelctedCityName:self.localCity CityCode:self.cityCodeDic[self.localCity]];
            }
        }
        else {
            NSString *city = [(CityModel*)self.sortArr[indexPath.section][indexPath.row] title];
            !self.selectedCityCallBack ?: self.selectedCityCallBack(city, self.cityCodeDic[city]);
            [[AppInformationSingleton shareAppInfomationSingleton] setSelctedCityName:city CityCode:self.cityCodeDic[city]];
        }
        
    }
    else {
        NSString *city = self.searchArr[indexPath.row];
        !self.selectedCityCallBack ?: self.selectedCityCallBack(city, self.cityCodeDic[city]);
        [[AppInformationSingleton shareAppInfomationSingleton] setSelctedCityName:city CityCode:self.cityCodeDic[city]];
    }
    [self leftButtonClicked];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView != self.mainTableView) {
        return 0.001;
    }
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView != self.mainTableView) {
        return nil;
    }
    return self.listArr;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView != self.mainTableView) {
        return nil;
    }
    return self.listArr[section];
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView != self.mainTableView) {
        return nil;
    }
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 25)];
    label.text = [self.listArr objectAtIndex:section];
    [vi addSubview:label];
    return vi;
}


#pragma mark - UISearchDisplayControllerdelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // searchBar开始编辑时改变取消按钮的文字
    _mSearchBar.showsCancelButton = YES;
    
    NSArray *subViews = [(_mSearchBar.subviews[0]) subviews];

    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //一旦SearchBar输入內容有变化，则执行這个方法，询问要不要重装searchResultTableView的数据
    //    NSLog(@"searchString = %@",searchString);
    [self filterContentForSearchText:searchString];
    
    return YES;
}



//源字符串内容是否包含或等于要搜索的字符串内容
-(void)filterContentForSearchText:(NSString*)searchText
{
    [self.searchArr removeAllObjects];
    
    if (_mSearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_mSearchBar.text]) {
        
        NSString *key = [[_mSearchBar.text substringToIndex: 1] uppercaseString];
        
        NSMutableArray *tempResults = [[NSMutableArray alloc] initWithArray:_citiesDic[key]];
        //        tempResults = _citiesDic[key];
        
        for (CityModel *city in tempResults)
        {
            if (![city isKindOfClass:[CityModel class]]) {return;}
            
            NSString *str = city.title;
            NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin: str];
            NSRange titleResult=[tempPinYinStr rangeOfString:_mSearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0)
            {
                [self.searchArr addObject: str];
                
            }else{
                
                if (searchText.length>1) {
                    
                    //拆分首字母
                    NSString *tmpStr = searchText;
                    NSMutableArray *arr = [NSMutableArray array];
                    for (NSInteger i=0; i<searchText.length; i++) {
                        NSString *string = [tmpStr substringToIndex:1];
                        tmpStr = [tmpStr substringFromIndex:1];
                        [arr addObject:string];
                    }
                    
                    BOOL isMatch = YES;
                    
                    for (NSInteger i=0; i<arr.count; i++) {
                        NSRange range = [tempPinYinStr rangeOfString:arr[i] options:NSCaseInsensitiveSearch];
                        if (range.length == 0) {
                            isMatch = NO;
                        }
                    }
                    
                    if (isMatch) {
                        [self.searchArr addObject:str];
                    }
                }
            }
        }
    }
    else if (_mSearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:_mSearchBar.text])
    {
        
        [self.searchArr removeAllObjects];
        NSArray *keys = [_citiesDic allKeys];
        
        for (NSString *position in keys) {
            if (![position isEqualToString:@"定位"]) {
                NSMutableArray *tempResults = _citiesDic[position];
                for (CityModel *city in tempResults) {
                    if ([city isKindOfClass:[CityModel class]]) {
                        NSString *cityStr = city.title;
                        NSString *text = _mSearchBar.text;
                        if ([cityStr rangeOfString: text].location != NSNotFound)
                        {
                            [self.searchArr addObject: cityStr];
                        }
                    }
                }
            }
        }
    }
}






@end















