//
//  ModifyAddrViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ModifyAddrViewController.h"
#import "Addresse.h"

@interface ModifyAddrViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, readwrite, strong) UIPickerView *addressPickerView;
/// 省份
@property (nonatomic, readwrite, copy) NSString *provinceName;
/// 城市名
@property (nonatomic, readwrite, copy) NSString *cityName;
/// 区域名
@property (nonatomic, readwrite, copy) NSString *distrName;

/// 收货地址ID,该属性值为空时则为新增收货地址
@property (nonatomic, readwrite, copy) NSString *addressid;
/// 收件人
@property (nonatomic, readwrite, copy) NSString *consignee;
/// 收件人地址
@property (nonatomic, readwrite, copy) NSString *consigneeaddress;
/// 收件人联系号码
@property (nonatomic, readwrite, copy) NSString *consigneephone;
/// 是否默认，1-是，0-否
@property (nonatomic, readwrite, copy) NSString *isdefault;
/// 省代码，例如440000
@property (nonatomic, readwrite, copy) NSString *province;
/// 市代码,例如210100
@property (nonatomic, readwrite, copy) NSString *city;
/// 区代码，例如140211
@property (nonatomic, readwrite, copy) NSString *area;
/// 省市区信息，例如广东省广州市番禺区
@property (nonatomic, readwrite, copy) NSString *pca;
/// 邮政编码
@property (nonatomic, readwrite, copy) NSString *postcode;

@property (nonatomic, readwrite, strong) Addresse *address;

@property (nonatomic, readwrite, assign) BOOL addressSelected;

@property (nonatomic, readwrite, strong) UILabel *tipLabel;

@end

@implementation ModifyAddrViewController
{
    NSString * _navTitle;
    NSMutableArray *_provinceArr;
    NSArray *_citiesArr;
    NSArray *_distrsArr;
    
    NSMutableDictionary *_provinceDic;
    NSDictionary *_distrDic;
    NSDictionary *_citiesDic;
    UIToolbar *_bankToolBar;
    
    NSMutableDictionary *_distrCodeDic;
    NSString *_addressID;
}

- (instancetype)initWithWithAddressID:(NSString *)addressID {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _addressID = addressID;
    }
    return self;
}

-(instancetype)initWithWithTitle:(NSString *)navTitle
{
    self = [super init];
    
    if (self) {
        
        _navTitle = navTitle;
    }
    
    return self;
}

- (instancetype)initForUpdateAddress:(Addresse *)address selected:(BOOL)selected {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _addressSelected = selected;
        _address = address;
    }
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _provinceDic = [NSMutableDictionary dictionary];
    _provinceArr = [NSMutableArray array];
    _distrCodeDic = [NSMutableDictionary dictionary];
    
    
    [self loadCostomViw];
    [self getProvinceAndCitiesAndBankList];
    
    
}

#pragma mark 获取省市列表



- (void)getProvinceAndCitiesAndBankList
{
    
    NSString *citiesPath = [[NSBundle mainBundle] pathForResource:@"area1" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:citiesPath];
    
    NSArray *provence = [dic objectForKey:@"p"];
    
    for (NSDictionary *provenceD in provence)
    {
        [_provinceArr addObject:provenceD[@"n"]];// 省份
        [_distrCodeDic setObject:provenceD[@"code"] forKey:provenceD[@"n"]];
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableDictionary *cityDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary *city in provenceD[@"c"]) {
            [arr addObject:city[@"n"]];// 城市名
            /// 拼接省市作为code的key确保唯一性
            [_distrCodeDic setObject:city[@"code"] forKey:[provenceD[@"n"]stringByAppendingString:city[@"n"]]];
            NSMutableArray *distrArr = [NSMutableArray array];
            for (NSDictionary *distr in city[@"a"]) {
                [distrArr addObject:distr[@"n"]]; // 区域
                /// 拼接省市区作为code的key确保唯一性
                [_distrCodeDic setObject:distr[@"code"] forKey:[[provenceD[@"n"] stringByAppendingString:city[@"n"]]stringByAppendingString:distr[@"n"]]];
            }
            [cityDic setObject:distrArr forKey:city[@"n"]];
            
        }
        [_provinceDic setObject:cityDic forKey:provenceD[@"n"]];
    }
    
    // 查找省份
    BOOL isContain = NO;
    NSString *tempProvince = _provinceArr[0];
    if (self.address) {
        tempProvince = [self.address.pca substringToIndex:2];
        NSRange temRang;
        for (NSString *province in _provinceArr) {
            NSRange range = [province rangeOfString:tempProvince];
            if (range.location != NSNotFound) {
                isContain = YES;
                tempProvince = province;
                temRang = [self.address.pca rangeOfString:tempProvince];
                self.provinceName = province;
                break;
            }
        }
        // 查找城市
        if (isContain) {
            NSString *city_distr = [self.address.pca stringByReplacingCharactersInRange:temRang withString:@""];
            NSString *temCity = [city_distr substringToIndex:2];
            NSRange temR;
            if (temCity) {
                _citiesDic = _provinceDic[tempProvince];
                _citiesArr = [_citiesDic allKeys];
                for (NSString *city in _citiesArr) {
                    NSRange cityRange = [city rangeOfString:temCity];
                    if (cityRange.location != NSNotFound) {
                        temCity = city;
                        temR = [city_distr rangeOfString:temCity];
                        self.cityName = city;
                        break;
                    }
                }
                
                // 查找区域
                if (temR.location != NSNotFound) {
                    NSString *tempDistr = [city_distr stringByReplacingCharactersInRange:temR withString:@""];
                    self.distrName = tempDistr;
                }
                
            }

        }
        
    }
    
    if (!isContain) {
        _citiesDic = _provinceDic[_provinceArr[0]];
        _citiesArr = [_citiesDic allKeys];
        _distrsArr = _citiesDic[_citiesArr[0]];
        [self.addressPickerView reloadAllComponents];
        self.provinceName = _provinceArr[0];
        self.cityName = _citiesArr.firstObject;
        self.distrName = _distrsArr.firstObject;
    }
    
}


#pragma mark 设置toolbar

- (void)setupToolBar
{
    if (!_bankToolBar) {
        _bankToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(barClick:)];
        rightBar.tag = 2;
        UIBarButtonItem *midBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(barClick:)];
        leftBar.tag  = 1;
        [leftBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xffaf48)} forState:(UIControlStateNormal)];
        [rightBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xffaf48)} forState:(UIControlStateNormal)];
        _bankToolBar.items = @[leftBar,midBar,rightBar];
    }
    
    
}

- (void)barClick:(UIBarButtonItem*)item {
    [_regionTextField resignFirstResponder];
    
    if (item.tag == 2) {
        _regionTextField.text = [[self.provinceName?:@"" stringByAppendingString:self.cityName?:@""] stringByAppendingString:self.distrName];
    }
    
}

- (UILabel*)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 18)];
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.text = @"详细地址";
        _tipLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);

    }
    return _tipLabel;
}


#pragma mark UIPickerView

- (UIPickerView *)addressPickerView {
    if (!_addressPickerView) {
        _addressPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216)];
        _addressPickerView.delegate = self;
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}


#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArr.count;
    }
    else if (component == 1) {
        return _citiesArr.count;
    }
    else if (component == 2) {
        return _distrsArr.count;
    }
    return 0;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == component) {
        _citiesDic = _provinceDic[_provinceArr[row]];
        _citiesArr = [_citiesDic allKeys];
        _distrsArr = _citiesDic[_citiesArr[0]];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        self.provinceName = _provinceArr[row];
        self.cityName = _citiesArr[0];
        self.distrName = _distrsArr[0];
    }
    else if (1==component) {
        _distrsArr = _citiesDic[_citiesArr[row]];
        [pickerView reloadComponent:2];
        self.cityName = _citiesArr[row];
    }
    else if (2==component) {
        self.distrName = _distrsArr[row];
    }
    
    _regionTextField.text = [[self.provinceName?:@"" stringByAppendingString:self.cityName?:@""] stringByAppendingString:self.distrName];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        return _provinceArr[row];
    }
    else if (1==component) {
        return _citiesArr[row];
    }
    else if (2== component) {
        return _distrsArr[row];
    }
    return nil;
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    if (_navTitle) {
        [self setNavigationBarTitle:_navTitle];
    }else{
        [self setNavigationBarTitle:@"修改收货地址"];
    }
    
    [self createBaseView];
}

- (void)createBaseView
{
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(50)));
    }];
    bottomView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:doneButton];
    [doneButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView.center);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(140), GET_SCAlE_HEIGHT(22)));
    }];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [doneButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"mine_ellipseButtonBG"] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"mine_ellipseButtonBG"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * baseView = [UIView new];
    [self.view addSubview:baseView];
    [baseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottomView.top);
    }];
    baseView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    UILabel * line_bottom = [UILabel new];
    [baseView addSubview:line_bottom];
    [line_bottom makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(baseView.mas_bottom);
        make.centerX.mas_equalTo(baseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_bottom.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //创建准线
    UILabel * line_one   = [UILabel new];
    UILabel * line_two   = [UILabel new];
    UILabel * line_Three = [UILabel new];
    UILabel * line_four  = [UILabel new];
    UILabel * line_five  = [UILabel new];
    
    [self positionLineWithLine:line_one Index:1 SuperView:baseView];
    [self positionLineWithLine:line_two Index:2 SuperView:baseView];
    [self positionLineWithLine:line_Three Index:3 SuperView:baseView];
    [self positionLineWithLine:line_four Index:5 SuperView:baseView];
    [self positionLineWithLine:line_five Index:6 SuperView:baseView];
    
    //内容相关
    _NameTextField     = [UITextField new];
    _TelPhoneTextField = [UITextField new];
    _PostCodeTextField = [UITextField new];
    _regionTextField   = [UITextField new];
    _detailTextView    = [UITextView new];
    _regionTextField.inputView = [self addressPickerView];
    [self setupToolBar];
    _regionTextField.inputAccessoryView = _bankToolBar;
    
    
    [self positionContentWithTitle:@"收货人姓名" TextField:_NameTextField baseLine:line_one SuperView:baseView];
    [self positionContentWithTitle:@"手机号码" TextField:_TelPhoneTextField baseLine:line_two SuperView:baseView];
    [self positionContentWithTitle:@"邮政编码" TextField:_PostCodeTextField baseLine:line_five SuperView:baseView];
    [self positionContentWithTitle:@"所在区域" TextField:_regionTextField baseLine:line_Three SuperView:baseView];
    
    //所在区域按钮
    UIButton * areaSymbol = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:areaSymbol];
    [areaSymbol makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_Three.centerY).with.offset(GET_SCAlE_HEIGHT(-55/2.0));
        make.right.mas_equalTo(baseView.right).with.offset(GET_SCAlE_HEIGHT(-10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    //    areaSymbol.backgroundColor = [UIColor orangeColor];
    [areaSymbol addTarget:self action:@selector(areaButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //详细地址
    //    UILabel * detailLabel  = [UILabel new];
    //    [baseView addSubview:detailLabel];
    //    [detailLabel makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(baseView.left).with.offset(GET_SCAlE_LENGTH(10));
    //        make.centerY.mas_equalTo(line_Three.bottom).with.offset(GET_SCAlE_HEIGHT(55/2.0));
    //    }];
    //    detailLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    //    detailLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    //    detailLabel.text = @"详细地址";
    
    [self.view addSubview:_detailTextView];
    [_detailTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(baseView.left).with.offset(GET_SCAlE_LENGTH(10));
        make.top.mas_equalTo(line_Three.bottom).with.offset(GET_SCAlE_HEIGHT(55/4.0));
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(20), GET_SCAlE_HEIGHT(80)));
    }];
    //    _detailTextView.backgroundColor = [UIColor orangeColor];
//    _detailTextView.text = @"详细地址";
//    _detailTextView.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _detailTextView.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    
    if (self.address) {
        if (self.address.pca && _tipLabel) {
            [self.tipLabel setHidden:YES];
        }
        _TelPhoneTextField.text = self.address.consigneephone;
        _NameTextField.text = self.address.consignee;
        _PostCodeTextField.text = self.address.postcode;
        _detailTextView.text = self.address.consigneeaddress;
        _regionTextField.text = self.address.pca;
    }
    else {
        [_detailTextView addSubview:self.tipLabel];
    }
    
    //设置代理
    _NameTextField.delegate     = self;
    _TelPhoneTextField.delegate = self;
    _PostCodeTextField.delegate = self;
    _detailTextView.delegate    = self;
    _regionTextField.delegate   = self;
}

/**
 *  配置输入栏方法
 *
 *  @param title     输入栏前标签内容
 *  @param textField 当前输入栏
 *  @param line      基准线
 *  @param superView 父视图
 */
- (void)positionContentWithTitle:(NSString *)title TextField:(UITextField *)textField baseLine:(UILabel *)line SuperView:(UIView *)superView
{
    UILabel * titleLabel  = [UILabel new];
    [superView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.centerY).with.offset(GET_SCAlE_HEIGHT(-55/2.0));
        make.left.mas_equalTo(superView.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    titleLabel.text = title;
    
    if (textField == nil) {
        return;
    }
    
    [superView addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.left).with.offset(GET_SCAlE_LENGTH(100));
        make.centerY.mas_equalTo(titleLabel.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(200), GET_SCAlE_HEIGHT(40)));
    }];
}


/**
 *  画线方法
 *
 *  @param line      当前配置的线
 *  @param index     下标
 *  @param superView 父视图
 */
- (void)positionLineWithLine:(UILabel *)line Index:(NSInteger)index SuperView:(UIView *)superView
{
    [superView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(superView.top).with.offset(GET_SCAlE_HEIGHT(55 * index));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_NameTextField resignFirstResponder];
    [_TelPhoneTextField resignFirstResponder];
    [_PostCodeTextField resignFirstResponder];
    [_regionTextField resignFirstResponder];
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _regionTextField) {
        _regionTextField.text = [[self.provinceName?:@"" stringByAppendingString:self.cityName?:@""] stringByAppendingString:self.distrName];
    }
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_detailTextView resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.tipLabel.hidden = YES;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0 || !textView.text) {
        self.tipLabel.hidden = NO;
    }
}



#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

- (void)doneButtonClicked
{
    NSLog(@"%s", __func__);
    
    
    if (!_NameTextField.text || _NameTextField.text.length == 0) {
        [self showMsg:@"收件人不能为空!"];
        return;
    }
    if (!_TelPhoneTextField.text || _TelPhoneTextField.text.length == 0) {
        [self showMsg:@"手机号不能为空!"];
        return;
    }
    if (!_regionTextField.text || _regionTextField.text.length == 0) {
        [self showMsg:@"所在区域不能为空!"];
        return;
    }
    if (!_detailTextView.text || _detailTextView.text.length == 0) {
        [self showMsg:@"地址不能为空!"];
        return;
    }
    
    if (!_PostCodeTextField.text || _PostCodeTextField.text.length == 0) {
        [self showMsg:@"邮编不能为空!"];
        return;
    }
    
    if (!self.cityName || !self.provinceName || !self.distrName || self.distrName.length == 0 || self.cityName.length == 0 || self.provinceName.length == 0) {
        return;
    }
    
    if (self.address) {
        [self sendRequestForUpdateAddress:self.address selected:self.addressSelected];
    }
    else {
        [self sendRequestForUpdateAddress];
    }
}

- (void)areaButtonClicked
{
    NSLog(@"%s", __func__);
}

#pragma mark - 网络

- (void)addAddressData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:@"updateshaddress" forKey:@"functionid"];
    
    //    NSMutableDictionary * address = [[NSMutableDictionary alloc] initWithCapacity:1];
    if (_TelPhoneTextField.text.length > 0) {
        //        address
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismissWithSuccess:@"提交成功" afterDelay:1];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismissWithSuccess:@"提交失败" afterDelay:1];
        
    }];
}

- (void)showMsg:(NSString*)msg {
    [[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
}


#pragma mark 网络请求

- (void)sendRequestForUpdateAddress {
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithObject:@"updateshaddress" forKey:@"functionid"];
    self.consignee = _NameTextField.text?:@"";
    NSMutableDictionary *addressDic = [NSMutableDictionary dictionaryWithObject:self.consignee forKey:@"consignee"];
    [addressDic setObject:_detailTextView.text?:@"" forKey:@"consigneeaddress"];
    [addressDic setObject:_TelPhoneTextField.text?:@"" forKey:@"consigneephone"];
    [addressDic setObject:_PostCodeTextField.text?:@"" forKey:@"postcode"];
    [addressDic setObject:[[self.provinceName?:@"" stringByAppendingString:self.cityName?:@""] stringByAppendingString:self.distrName?:@""] forKey:@"pca"];
    
    if (_addressID) {
        [addressDic setObject:_addressID forKey:@"addressid"];
    }
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    NSString *cityKey = [self.provinceName stringByAppendingString:self.cityName];
    NSString *distrKey = [[self.provinceName stringByAppendingString:self.cityName] stringByAppendingString:self.distrName];
    
    [addressDic setObject:[_distrCodeDic[cityKey] stringValue]?:@"" forKey:@"city"];
    [addressDic setObject:[_distrCodeDic[distrKey] stringValue]?:@"" forKey:@"area"];
    [addressDic setObject:self.defaultAddress?@"1":@"0" forKey:@"isdefault"];
    [addressDic setObject:[_distrCodeDic[self.provinceName] stringValue]?:@"" forKey:@"province"];
    
    [bodyDic setObject:addressDic forKey:@"address"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        NSLog(@"responseBody:%@",responseBody);
        NSDictionary *dic = (NSDictionary*)responseBody;
        NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
        NSString *resultdesc = [[dic objectForKey:@"head"] objectForKey:@"resultdesc"];
        
        if ([resultcode isEqualToString:@"0000"]) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [SVProgressHUD showSuccessWithStatus:resultdesc];
            
        }
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD showSuccessWithStatus:error];
        
    }];
    
}

#pragma mark 更默认状态

- (void)sendRequestForUpdateAddress:(Addresse*)address selected:(BOOL)selected {
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithObject:@"updateshaddress" forKey:@"functionid"];
    self.consignee = _NameTextField.text?:@"";
    NSMutableDictionary *addressDic = [NSMutableDictionary dictionaryWithObject:self.consignee forKey:@"consignee"];
    [addressDic setObject:_detailTextView.text?:address.consigneeaddress forKey:@"consigneeaddress"];
    [addressDic setObject:_TelPhoneTextField.text?:address.consigneephone forKey:@"consigneephone"];
    [addressDic setObject:_PostCodeTextField.text?:address.postcode forKey:@"postcode"];
    [addressDic setObject:[[self.provinceName?:@"" stringByAppendingString:self.cityName?:@""] stringByAppendingString:self.distrName?:address.pca] forKey:@"pca"];
    
    
    [addressDic setObject:_addressID?:address.addressid forKey:@"addressid"];
    
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    NSString *cityKey = [self.provinceName stringByAppendingString:self.cityName];
    NSString *distrKey = [[self.provinceName stringByAppendingString:self.cityName] stringByAppendingString:self.distrName];
    
    [addressDic setObject:[_distrCodeDic[cityKey] stringValue]?:address.city forKey:@"city"];
    [addressDic setObject:[_distrCodeDic[distrKey] stringValue]?:address.area forKey:@"area"];
    [addressDic setObject:self.defaultAddress?@"1":@"0" forKey:@"isdefault"];
    [addressDic setObject:[_distrCodeDic[self.provinceName] stringValue]?:address.province forKey:@"province"];
    
    
    [bodyDic setObject:addressDic forKey:@"address"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        NSLog(@"responseBody:%@",responseBody);
        NSDictionary *dic = (NSDictionary*)responseBody;
        NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
        NSString *resultdesc = [[dic objectForKey:@"head"] objectForKey:@"resultdesc"];
        
        if ([resultcode isEqualToString:@"0000"]) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            [SVProgressHUD showSuccessWithStatus:resultdesc];
            
        }
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD showSuccessWithStatus:error];
        
    }];
    
}



@end





