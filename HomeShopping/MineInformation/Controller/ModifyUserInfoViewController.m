//
//  ModifyUserInfoViewController.m
//  HomeShopping
//
//  Created by sooncong on 15/12/29.
//  Copyright © 2015年 Administrator. All rights reserved.
//


static NSString *const lastExtension = @".png";

#define iconKey @"iconkey"
#define iconImageNameKey @"iconImageName"
#define documentPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"images"]

#import "ModifyUserInfoViewController.h"
#import "AFNetworking.h"
#import "FullTimeView.h"
#import "UserInfo.h"

@interface ModifyUserInfoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (nonatomic, readwrite, strong) UITextField *nickNameTextField;
@property (nonatomic, readwrite, strong) UIImageView * headImageView;
@property (nonatomic, readwrite, strong) NSData *imageData;
@property (nonatomic, readwrite, copy) NSString *filepath;
@property (nonatomic, readwrite, copy) NSString *zipfileurl;
@property (nonatomic, readwrite, copy) NSString *fileurl;

@end
@implementation ModifyUserInfoViewController
{
    UserInfo * _user;
    
    //时间选择器
    FullTimeView * _fullTimePick;
    
    UIButton * _sexMale;        //男
    UIButton * _sexFemale;      //女
    NSString * _selectedSex;
    NSString * _birthDateString;    
    
    UIView * _birthBaseView;
}

-(instancetype)initWithUserInfo:(UserInfo *)userInfo
{
    self = [super init];
    
    if (self) {

        _user = userInfo;
        if ([userInfo.sex isKindOfClass:[NSString class]] && userInfo.sex != nil) {
            _selectedSex = userInfo.sex;
        }
        
        if ([userInfo.birthdate isKindOfClass:[NSString class]] && userInfo.birthdate != nil) {
            _birthDateString = _user.birthdate;
        }
    }
    
    return self;
}

//-(instancetype)initWithUserName:(NSString *)userName ImageString:(NSString *)iamgeString
//{
//    self = [super init];
//    
//    if (self) {
//        
//        _userName = userName;
//        _imageURL = iamgeString;
//    }
//    
//    return self;
//}

#pragma mark - 生命周期

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCustomView];
    
    self.view.backgroundColor = UIColorFromRGB(WHITECOLOR);
}

#pragma mark - 自定义视图

- (void)loadCustomView
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"修改基本资料"];
    
    [self setUpBaseView];
    
    _fullTimePick = [[FullTimeView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 200,SCREEN_WIDTH, 220)];
    _fullTimePick.curDate=[NSDate date];
    _fullTimePick.delegate = self;
    _fullTimePick.hidden   = YES;
    [self.view addSubview:_fullTimePick];
}

- (void)setUpBaseView
{
    UIView * baseView = [UIView new];
    [self.view addSubview:baseView];
    [baseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(600)));
    }];
    baseView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    UILabel * line_one = [UILabel new];
    [baseView addSubview:line_one];
    [line_one makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(baseView.mas_top).with.offset(GET_SCAlE_HEIGHT(70));
        make.centerX.mas_equalTo(baseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line_one.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * line_two = [UILabel new];
    [baseView addSubview:line_two];
    [line_two makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_one.mas_bottom).with.offset(GET_SCAlE_HEIGHT(70));
        make.centerX.mas_equalTo(baseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line_two.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * line_three = [UILabel new];
    [baseView addSubview:line_three];
    [line_three makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_two.mas_bottom).with.offset(GET_SCAlE_HEIGHT(70));
        make.centerX.mas_equalTo(baseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line_three.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UIButton * commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(baseView.mas_centerX);
        make.top.mas_equalTo(line_three.mas_bottom).with.offset(GET_SCAlE_HEIGHT(80));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
    [commitButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [commitButton setBackgroundColor:[UIColor orangeColor]];
    commitButton.layer.cornerRadius = 10;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(sendRequestForModifyUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * HeadLabel = [UILabel new];
    [baseView addSubview:HeadLabel];
    [HeadLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_one.mas_centerY).with.offset(- GET_SCAlE_HEIGHT(35));
        make.left.mas_equalTo(baseView.mas_left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    HeadLabel.text = @"头像";
    HeadLabel.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    HeadLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UILabel * nickNameLabel = [UILabel new];
    [baseView addSubview:nickNameLabel];
    [nickNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_two.mas_centerY).with.offset(- GET_SCAlE_HEIGHT(35));
        make.left.mas_equalTo(baseView.mas_left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    nickNameLabel.text = @"昵称";
    nickNameLabel.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    nickNameLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UILabel * sexLabel  = [UILabel new];
    [baseView addSubview:sexLabel];
    [sexLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_three.mas_centerY).with.offset(- GET_SCAlE_HEIGHT(35));
        make.left.mas_equalTo(baseView.mas_left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    sexLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    sexLabel.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    sexLabel.text = @"性别";
    
    UIImage * sexSelected_d = [UIImage imageNamed:@"sex_selected_d"];
    UIImage * sexSelected   = [UIImage imageNamed:@"sex_selected"];
    
    _sexFemale = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:_sexFemale];
    [_sexFemale makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_three.mas_centerY).with.offset(- GET_SCAlE_HEIGHT(35));
        make.right.mas_equalTo(baseView.mas_right).with.offset(GET_SCAlE_LENGTH(-55));
        make.size.mas_equalTo(CGSizeMake(sexSelected.size.width, sexSelected.size.height));
    }];
    
    _sexMale = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:_sexMale];
    [_sexMale makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_three.mas_centerY).with.offset(- GET_SCAlE_HEIGHT(35));
        make.right.mas_equalTo(baseView.mas_right).with.offset(GET_SCAlE_LENGTH(-125));
        make.size.mas_equalTo(CGSizeMake(sexSelected.size.width, sexSelected.size.height));
    }];
    [_sexMale setBackgroundImage:sexSelected_d forState:UIControlStateSelected];
    [_sexMale setBackgroundImage:sexSelected forState:UIControlStateNormal];
    [_sexMale setBackgroundImage:sexSelected_d forState:UIControlStateHighlighted];

    [_sexFemale setBackgroundImage:sexSelected_d forState:UIControlStateSelected];
    [_sexFemale setBackgroundImage:sexSelected forState:UIControlStateNormal];
    [_sexFemale setBackgroundImage:sexSelected_d forState:UIControlStateHighlighted];
    
    _sexFemale.selected = ([_selectedSex integerValue] == 1)?NO:YES;
    _sexMale.selected   = ([_selectedSex integerValue] == 1)?YES:NO;
    
    [_sexMale addTarget:self action:@selector(sexSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_sexFemale addTarget:self action:@selector(sexSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * maleLab  = [UILabel new];
    [baseView addSubview:maleLab];
    [maleLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_sexMale.centerY).with.offset(0);
        make.left.mas_equalTo(_sexMale.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    maleLab.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    maleLab.font      = [UIFont systemFontOfSize:LARGEFONTSIZE];
    maleLab.text      = @"男";
    
    UILabel * FeMaleLab  = [UILabel new];
    [baseView addSubview:FeMaleLab];
    [FeMaleLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_sexMale.centerY).with.offset(0);
        make.left.mas_equalTo(_sexFemale.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    FeMaleLab.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    FeMaleLab.font      = [UIFont systemFontOfSize:LARGEFONTSIZE];
    FeMaleLab.text      = @"女";
    
    
    UILabel * birthLabel  = [UILabel new];
    [baseView addSubview:birthLabel];
    [birthLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_three.mas_centerY).with.offset(GET_SCAlE_HEIGHT(35));
        make.left.mas_equalTo(baseView.mas_left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    birthLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    birthLabel.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    birthLabel.text = @"生日";
    
    _birthBaseView = [UIView new];
    [baseView addSubview:_birthBaseView];
    [_birthBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(birthLabel.centerY);
        make.right.mas_equalTo(self.view.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(220), GET_SCAlE_HEIGHT(30)));
    }];
//    _birthBaseView.backgroundColor = [UIColor orangeColor];
    
    UITapGestureRecognizer * birthTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPickerView)];
    [_birthBaseView addGestureRecognizer:birthTap];
    
    if (_birthDateString) {
        NSArray * arrM = [_birthDateString componentsSeparatedByString:@"-"];
        [self setDateWithRightOffSets:0 text:@"日" detail:arrM[2] Tag:50];
        [self setDateWithRightOffSets:GET_SCAlE_LENGTH(80) text:@"月" detail:arrM[1] Tag:51];
        [self setDateWithRightOffSets:GET_SCAlE_LENGTH(160) text:@"年" detail:arrM[0] Tag:52];
    }else{
        [self setDateWithRightOffSets:0 text:@"日" detail:@"01" Tag:50];
        [self setDateWithRightOffSets:GET_SCAlE_LENGTH(80) text:@"月" detail:@"01" Tag:51];
        [self setDateWithRightOffSets:GET_SCAlE_LENGTH(160) text:@"年" detail:@"1985" Tag:52];
    }
    
    UIImageView * headImageView = [UIImageView new];
    _headImageView = headImageView;
    [baseView addSubview:headImageView];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_user.logo] placeholderImage:[UIImage imageNamed:@"mine_defaultHead"]];
    [headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(HeadLabel.mas_centerY);
        make.right.mas_equalTo(baseView.mas_right).with.offset(-GET_SCAlE_LENGTH(15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(55), GET_SCAlE_LENGTH(55)));
    }];
    headImageView.layer.cornerRadius = GET_SCAlE_LENGTH(55)/2.0;
    headImageView.clipsToBounds = YES;
    headImageView.backgroundColor = [UIColor orangeColor];
    [headImageView setUserInteractionEnabled:YES];
    [headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPhotoFromDevice)]];
    
    UITextField *nickNameTextField = [[UITextField alloc]init];
    _nickNameTextField = nickNameTextField;
    [baseView addSubview:nickNameTextField];
    [nickNameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickNameLabel.right).offset(GET_SCAlE_LENGTH(10));
        make.right.equalTo(baseView.right);
        make.top.height.equalTo(nickNameLabel);
    }];
    _nickNameTextField.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    _nickNameTextField.text = _user.nickname;
    _nickNameTextField.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
}

- (void)setDateWithRightOffSets:(CGFloat)rightOffSets text:(NSString *)text detail:(NSString *)detail Tag:(NSInteger)tag
{
    UILabel * label  = [UILabel new];
    [_birthBaseView addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(_birthBaseView).with.offset(0);
        make.right.mas_equalTo(_birthBaseView.right).with.offset(- rightOffSets);
    }];
    label.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    label.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    label.text = text;

    UIView * backView = [UIView new];
    [_birthBaseView addSubview:backView];
    [backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(_birthBaseView).with.offset(0);
        make.right.mas_equalTo(label.left).with.offset(- 5);
        make.width.mas_equalTo(@(GET_SCAlE_LENGTH(45)));
    }];
    
    backView.layer.borderColor = UIColorFromRGB(GRAYLINECOLOR).CGColor;
    backView.layer.borderWidth = 2;
    
    UILabel * detailLab  = [UILabel new];
    [backView addSubview:detailLab];
    [detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(_birthBaseView).with.offset(0);
//        make.left.mas_equalTo(backView.left).with.offset(5);
        make.centerX.mas_equalTo(backView.centerX);
    }];
    detailLab.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    detailLab.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    detailLab.text = detail;
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.tag = tag;
    
}

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


#pragma mark 网络请求

- (void)sendRequestForModifyUserInfo {
    
    if(![[Reachability reachabilityForInternetConnection]isReachable]){return;}
    
    if (self.nickNameTextField.text == 0 || !self.nickNameTextField.text ) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    [bodyDic setObject:@"updateuser" forKey:@"functionid"];
    [bodyDic setObject:self.filepath?:@"" forKey:@"logo"];
    [bodyDic setObject:self.nickNameTextField.text forKey:@"nickname"];
    if (_selectedSex) {
        [bodyDic setObject:_selectedSex forKey:@"sex"];
    }else{
        return;
    }
    
    if (_birthDateString) {
        [bodyDic setObject:_birthDateString forKey:@"borndate"];
    }
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    NSDictionary *parameters = @{@"body":bodyDic,@"head":headDic};
    [WTRequestCenter postWithURL:HOST_IP parameters:parameters finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
        if ([resultcode isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        }
    } failed:^(NSURLResponse *response, NSError *error) {[SVProgressHUD showErrorWithStatus:@"修改失败"];}];
    
    
}

- (void)uploadUserIcon {
    NSString *imagePath = [[NSUserDefaults standardUserDefaults]valueForKey:iconKey];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    NSString *imageName = @"userfile";
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = self.headImageView.bounds;
    [activityView startAnimating];
    [self.headImageView addSubview:activityView];
    
    
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
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:nil];
            self.filepath = [dic objectForKey:@"filepath"]?:@"";
            self.zipfileurl = [dic objectForKey:@"zipfileurl"]?:@"";
            self.fileurl = [dic objectForKey:@"fileurl"]?:@"";
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.zipfileurl]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {}];
    
}


#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sexSelected:(UIButton *)sender
{
    if (sender == _sexMale) {
        _sexMale.selected   = YES;
        _sexFemale.selected = NO;
        _selectedSex = @"1";
    }else{
        _sexFemale.selected = YES;
        _sexMale.selected   = NO;
        _selectedSex = @"2";
    }
}

- (void)showPickerView
{
    _fullTimePick.hidden = NO;
    [self addMaskViewWithShowView:_fullTimePick];
}

-(void)maskTap
{
    _fullTimePick.hidden = YES;
    [self removeMask];
}

- (void)setBirthDateWithArray:(NSArray *)arr
{
    UILabel * day = [_birthBaseView viewWithTag:50];
    UILabel * month = [_birthBaseView viewWithTag:51];
    UILabel * year = [_birthBaseView viewWithTag:52];
    
    day.text = [arr objectAtIndex:2];
    month.text = [arr objectAtIndex:1];
    year.text = [arr objectAtIndex:0];
}

#pragma mark - birthPickerView

-(void)didFinishPickView:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    NSLog(@"result = %@",destDateString);
    NSArray * arrM = [destDateString componentsSeparatedByString:@"-"];
    _birthDateString = destDateString;

    [self setBirthDateWithArray:arrM];
    
}

@end

