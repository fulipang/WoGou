//
//  GiveCommentViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "GiveCommentViewController.h"
#import "AFNetworking.h"


#define STAR_WIDTH GET_SCAlE_LENGTH(20)
#define BOARDCOLOR 0xe0e0e0

static NSString *const lastExtension = @".png";

#define iconKey @"photokey"
#define iconImageNameKey @"iconPhotoName"
#define documentPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"photos"]

@interface GiveCommentViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextViewDelegate>
/// 客服服务
@property (nonatomic, readwrite, assign) NSInteger customerServiceStar;
/// 描述相符
@property (nonatomic, readwrite, assign) NSInteger describeMatchStar;

@property (nonatomic, readwrite, strong) NSData *imageData;
@property (nonatomic, readwrite, copy) NSString *filepath;
@property (nonatomic, readwrite, copy) NSString *zipfileurl;
@property (nonatomic, readwrite, copy) NSString *fileurl;

@property (nonatomic, readwrite, strong) UIButton *selectedBtn;

@property (nonatomic, readwrite, strong) NSMutableArray *imageArr;

@property (nonatomic, readwrite, copy) NSString *content;

@property (nonatomic, readwrite, strong) UITextView *contentTextView;

@property (nonatomic, readwrite, strong) UILabel *tipLabel;

@end

@implementation GiveCommentViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCostomViw];
    _imageArr = [NSMutableArray arrayWithCapacity:4];
    
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"评价"];
    
    [self setUpCustomView];
    
}

- (void)setUpCustomView
{
    UIView * baseView = [UIView new];
    [self.view addSubview:baseView];
    [baseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    baseView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    [self createHeadBaseViewWithSuperView:baseView];
    
    [self createInputViewWithSuperView:baseView];
    
    [self createBottomViewWithSuperView:baseView];
    
}

/**
 *  创建底部视图
 *
 *  @param superView 父视图
 *
 *  @return 底部视图
 */
- (UIView *)createBottomViewWithSuperView:(UIView *)superView
{
    UIView * bottomView = [UIView new];
    [superView addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.mas_equalTo(superView);
        make.top.mas_equalTo(superView.top).with.offset(GET_SCAlE_HEIGHT(255));
    }];
    //    bottomView.backgroundColor = [UIColor orangeColor];
    
    UILabel * customTitleLabel  = [UILabel new];
    [bottomView addSubview:customTitleLabel];
    [customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.top).with.offset(GET_SCAlE_HEIGHT(15));
        make.left.mas_equalTo(bottomView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    customTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    customTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    customTitleLabel.text = @"上传照片:";
    
    UILabel * subTitleLabel  = [UILabel new];
    [bottomView addSubview:subTitleLabel];
    [subTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(customTitleLabel.centerY).with.offset(0);
        make.left.mas_equalTo(customTitleLabel.right).with.offset(0);
    }];
    subTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    subTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    subTitleLabel.text = @"(最多上传4张)";
    
    UIButton *btn_1;
    
    for (int i = 0; i < 4; i++) {
        
        UIButton * cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomView addSubview:cameraButton];
        [cameraButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(customTitleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(10));
            make.left.mas_equalTo(customTitleLabel.left).with.offset((SCREEN_WIDTH-GET_SCAlE_LENGTH(30))/4.0 * i);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-GET_SCAlE_LENGTH(30))/4.0, GET_SCAlE_LENGTH(80)));
        }];
        [cameraButton setImage:[UIImage imageNamed:@"mine_camera"] forState:UIControlStateNormal];
        [cameraButton setImage:[UIImage imageNamed:@"mine_camera"] forState:UIControlStateHighlighted];
        cameraButton.layer.borderWidth = 0.5;
        cameraButton.layer.borderColor = UIColorFromRGB(BOARDCOLOR).CGColor;
        [cameraButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            btn_1 = cameraButton;
            self.selectedBtn = cameraButton;
        }
    }
    
    
    
    
    UIButton * commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn_1.bottom).with.offset(GET_SCAlE_HEIGHT(15));
        make.centerX.mas_equalTo(bottomView.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
    [commitButton setTitle:@"提 交" forState:UIControlStateNormal];
    [commitButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [commitButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:253/255.0 green:150/255.0 blue:49/255.0 alpha:1];
    commitButton.layer.cornerRadius = 8;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    return bottomView;
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


/**
 *  创建输入视图
 *
 *  @param superView 父视图
 */
- (void)createInputViewWithSuperView:(UIView *)superView
{
    UIView * inputView = [UIView new];
    [superView addSubview:inputView];
    [inputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.top).with.offset(GET_SCAlE_HEIGHT(115));
        make.left.and.right.mas_equalTo(superView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(140)));
    }];
    
    UILabel * line_top = [UILabel new];
    [inputView addSubview:line_top];
    [line_top makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inputView.top);
        make.centerX.mas_equalTo(inputView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_top.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_bottom = [UILabel new];
    [inputView addSubview:line_bottom];
    [line_bottom makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(inputView.mas_bottom);
        make.centerX.mas_equalTo(inputView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_bottom.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UITextView * textView = [[UITextView alloc] init];
    self.contentTextView = textView;
    [inputView addSubview:textView];
    [textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(GET_SCAlE_HEIGHT(5), GET_SCAlE_LENGTH(15), GET_SCAlE_HEIGHT(5), GET_SCAlE_LENGTH(15)));
    }];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
    
    self.tipLabel.font = textView.font;
    self.tipLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    self.tipLabel.text = @"请写下对宝贝的感受吧";
    [textView addSubview:self.tipLabel];
}

/**
 *  创建上部评分视图
 *
 *  @param superView 父视图
 *
 *  @return 评分视图
 */
- (UIView *)createHeadBaseViewWithSuperView:(UIView *)superView
{
    UIView * headBaseView = [UIView new];
    [superView addSubview:headBaseView];
    [headBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.mas_equalTo(superView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(115)));
    }];
    //    headBaseView.backgroundColor = [UIColor orangeColor];
    
    UILabel * label1  = [UILabel new];
    [headBaseView addSubview:label1];
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headBaseView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.centerY.mas_equalTo(headBaseView.centerY).with.offset(GET_SCAlE_HEIGHT(- 115/5.0));
    }];
    label1.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    label1.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    label1.text = @"客服服务:";
    
    UILabel * label2  = [UILabel new];
    [headBaseView addSubview:label2];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headBaseView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.centerY.mas_equalTo(headBaseView.centerY).with.offset(GET_SCAlE_HEIGHT(115/5.0));
    }];
    label2.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    label2.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    label2.text = @"描述相符:";
    
    UIView * scoreView_UP = [self createScoreViewWithBeginOfTag:200];
    [headBaseView addSubview:scoreView_UP];
    [scoreView_UP makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label1.centerY);
        make.right.mas_equalTo(headBaseView.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(164), STAR_WIDTH));
    }];
    
    UIView * scoreView_down = [self createScoreViewWithBeginOfTag:300];
    [headBaseView addSubview:scoreView_down];
    [scoreView_down makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label2.centerY);
        make.right.mas_equalTo(headBaseView.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(164), STAR_WIDTH));
    }];
    
    return headBaseView;
}




#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.contentTextView resignFirstResponder];
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

/**
 *  创建评分星星视图
 *
 *  @param beginTag 其实标记位
 *
 *  @return 评分星星视图
 */
- (UIView *)createScoreViewWithBeginOfTag:(NSInteger)beginTag
{
    UIView * baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GET_SCAlE_LENGTH(115), STAR_WIDTH)];
    for (NSInteger i = 0; i < 5; i++) {
        UIButton * star = [UIButton buttonWithType:UIButtonTypeCustom];
        [star setBackgroundImage:[UIImage imageNamed:@"mine_CommentStar"] forState:UIControlStateNormal];
        [star setBackgroundImage:[UIImage imageNamed:@"mine_CommentStar_selected"] forState:UIControlStateSelected];
        [star addTarget:self action:@selector(setEvaluation:) forControlEvents:UIControlEventTouchUpInside];
        star.frame = CGRectMake(i * (STAR_WIDTH + GET_SCAlE_LENGTH(16)), 0, STAR_WIDTH, STAR_WIDTH);
        [baseView addSubview:star];
        star.tag = i + beginTag;
    }
    
    return baseView;
}

#pragma mark 给予评价

- (void)setEvaluation:(UIButton*)sender {
    [self selectSelectStar:sender.tag view:sender.superview];
}

- (void)selectSelectStar:(NSInteger)index view:(UIView*)parentView {
    
    if (index < 300) {
        self.customerServiceStar = index - 200 + 1;
    }
    else {
        self.describeMatchStar = index - 300 + 1;
    }
    
    
    for (UIButton *btn in parentView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = NO;
        }
    }
    
    for (int i = 0; i < parentView.subviews.count; i++) {
        
        UIButton *btn = (UIButton*)parentView.subviews[i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = (btn.tag <= index);
        }
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

/**
 *  上传照片事件
 */
- (void)cameraClicked:(UIButton*)sender
{
    self.selectedBtn = sender;
    [self getPhotoFromDevice];
}

/**
 *  提交按钮点击事件
 */
- (void)commitButtonClicked
{
    if (self.customerServiceStar == 0 || self.describeMatchStar == 0 || self.contentTextView.text.length == 0 || !self.contentTextView.text) {
        return;
    }
    
    [self sendRequest];
    
}


#pragma mark 获取照片

- (void)getPhotoFromDevice {
    [self selectIconFromDevice:nil];
}



- (void)selectIconFromDevice:(UITapGestureRecognizer*)tap {
    
    CGFloat IOS_VERSION = [[[UIDevice currentDevice] systemVersion]floatValue];
    
    if (IOS_VERSION >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
                [self selectIcon:UIImagePickerControllerSourceTypeCamera];
            }
        }];
        UIAlertAction *alumLibraryAction = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)]) {
                [self selectIcon:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }
        }];
        
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"照片库" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
                [self selectIcon:UIImagePickerControllerSourceTypePhotoLibrary];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:cameraAction];
        [alertController addAction:alumLibraryAction];
        [alertController addAction:photoLibraryAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"照片库",nil];
        [actionSheet showFromToolbar:self.navigationController.toolbar];
    }
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
                [self selectIcon:UIImagePickerControllerSourceTypeCamera];
            }
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)]) {
                [self selectIcon:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }
            break;
        case 2:
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
                [self selectIcon:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            break;
        case 3:
            break;
            
        default:
            break;
    }
}


- (void)selectIcon:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    picker.allowsEditing = YES;
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    image = [self adjustImage:image toSize:CGSizeMake(320, 320)];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    [self saveImage:UIImagePNGRepresentation(image) forPhoneNumber:@"111222"];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadUserIcon];
    }];
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



/**
 *  修改图片尺寸
 *
 *  @param image 原Image
 *  @param size  尺寸大小
 *
 *  @return 修改后图片
 */
- (UIImage*)adjustImage:(UIImage*)image toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aImage;
}

- (void)saveImage:(NSData*)imageData forPhoneNumber:(NSString*)phoneNumber {
    
    NSString *imagePath = documentPath;
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imagePath]) {
        BOOL isFm = [fm createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isFm) {
            NSLog(@"can't createDirectoryAtPath");
        }
    }
    
    NSDate *imageDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMDDHHmmss";
    NSString *imageName = [[phoneNumber?:@"" stringByAppendingString:@"_"] stringByAppendingString:[dateFormatter stringFromDate:imageDate]];
    imagePath = [imagePath stringByAppendingPathComponent:[imageName stringByAppendingString: lastExtension]];
    [[NSUserDefaults standardUserDefaults] setValue:imagePath forKey:iconKey];
    [[NSUserDefaults standardUserDefaults] setObject:[imagePath lastPathComponent]?:@"" forKey:iconImageNameKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [imageData writeToFile:imagePath atomically:YES];
    
}

- (UIImage*)getImageFromDocument {
    
    NSString *imagePath = [[NSUserDefaults standardUserDefaults] valueForKey:iconKey];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    return [UIImage imageWithData:imageData];
}

- (void)removeOldUserIcon {
    
    NSError *err = nil;
    [[NSFileManager defaultManager]removeItemAtPath:[[NSUserDefaults standardUserDefaults]valueForKey:iconKey] error:&err];
    if (err) {
        NSLog(@"removeUserIconFailed");
    }
    else {
        NSLog(@"removeUserIconSuccessed");
    }
}


- (void)uploadUserIcon {
    NSString *imagePath = [[NSUserDefaults standardUserDefaults]valueForKey:iconKey];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    NSString *imageName = @"userfile";
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = self.selectedBtn.bounds;
    [activityView startAnimating];
    [self.selectedBtn addSubview:activityView];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager POST:[NSString stringWithFormat:@"%@?filename=%@",HOST_UPLOAD_IP,imageName] parameters:@{@"filename":imageName} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            [activityView stopAnimating];
            [activityView removeFromSuperview];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:nil];
            self.filepath = [dic objectForKey:@"filepath"]?:@"";
            self.zipfileurl = [dic objectForKey:@"zipfileurl"]?:@"";
            self.fileurl = [dic objectForKey:@"fileurl"]?:@"";
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {}];
    
}

- (void)setZipfileurl:(NSString *)zipfileurl {
    _zipfileurl = zipfileurl;
    [self.imageArr addObject:self.filepath];
    if (zipfileurl) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:zipfileurl]];
        [self.selectedBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }
}


#pragma mark 上传评价

- (void)sendRequest {
    
    NSMutableDictionary *headDic = @{}.mutableCopy;
    NSMutableDictionary *bodyDic = @{}.mutableCopy;
    [bodyDic setObject:@"auditorder" forKey:@"functionid"];
    [bodyDic setObject:self.orderid forKey:@"orderid"];
    [bodyDic setObject:self.contentTextView.text?:@"" forKey:@"content"];
    [bodyDic setObject:@(self.customerServiceStar).stringValue forKey:@"kfstars"];
    [bodyDic setObject:@(self.describeMatchStar).stringValue forKey:@"remarkstars"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (NSString *filename in _imageArr) {
//        [arr addObject:@{@"comimage":filename}];
//    }
    
    if (_imageArr.count > 0) {
        [bodyDic setObject:_imageArr forKey:@"comimagelist"];
    }
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if (responseBody) {
            if ([responseBody isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dic = (NSDictionary*)responseBody;
                NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
                NSString *resultdesc = [[dic objectForKey:@"head"] objectForKey:@"resultdesc"];
                if ([resultcode isEqualToString:@"0000"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD showSuccessWithStatus:@"评价成功"];
                }
                else {
                    [SVProgressHUD showErrorWithStatus:resultdesc duration:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
        
        
    } FailureBlock:^(NSString *error) {
        
    }];
    
}


@end










