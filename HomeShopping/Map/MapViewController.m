//
//  MapViewController.m
//  HomeShopping
//
//  Created by pfl on 16/1/16.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#define IS_IOS8_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define kUrlScheme   @"BaiduMapHomeShoppingURI://"
#define kAppDisplayName [[NSBundle mainBundle].localizedInfoDictionary objectForKey:@"CFBundleDisplayName"]


#import "MapViewController.h"
#import "BaiduMapHeader.h"
#import "CCLocationManager.h"

@interface MapViewController ()<BMKMapViewDelegate, CLLocationManagerDelegate, BMKLocationServiceDelegate, UIActionSheetDelegate>{
    
    BMKMapView *_mapView;
    // 百度自己定位封装
    BMKLocationService *_locationService;
    BMKPointAnnotation *_annotation;
    CLLocationCoordinate2D _coordinate;
    // 定位封装
    CLLocationManager *_locationManager;
    NSString *locality;
    NSString *postalCode;
    BOOL _local;
}

@end

@implementation MapViewController


- (instancetype)initForLocalCity {
  return  [self initForLocalCity:YES];
}

- (instancetype)initForLocalCity:(BOOL)local {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _local = local;
    }
    return self;
}

- (instancetype)initWithLatitude:(NSString *)latitude longitude:(NSString *)longitude {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _coordinate.latitude = latitude.floatValue;
        _coordinate.longitude = longitude.floatValue;
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = _local?[UIColor clearColor]:[UIColor groupTableViewBackgroundColor];
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
//    _mapView.showsUserLocation = YES;
    self.view = _mapView;
    
    // 用户允许定位权限
    if ([[CCLocationManager sharedManager] userAllowedLocation]) {
        
        _locationService = [[BMKLocationService alloc] init];
        [_locationService startUserLocationService];
    }
    
    [self loadUpCustomeView];
}

- (void)loadUpCustomeView
{
    //  初始化自定义导航摊
    [self setUpCustomNavigationBar];
    
}

- (void)setUpCustomNavigationBar
{
    [self setNavigationBarTitle:@"地图"];
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
}

- (void)leftButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locationService.delegate = nil;
    [_locationService stopUserLocationService];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // 创建一个大头针
    _annotation = [[BMKPointAnnotation alloc] init];
    _annotation.title = @"导航去:";
    _annotation.subtitle = @"目的地";
    _annotation.coordinate = _coordinate;
    _mapView.centerCoordinate = _annotation.coordinate;
    [_mapView addAnnotation:_annotation];
}


#pragma mark - 检查当前设备安装的地图

- (NSArray *)checkDeviceInstallMapApps{
    NSArray *mapSchemeArr = @[@"iosamap://navi",@"baidumap://map/"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0){
                [appListArr addObject:@"高德地图"];
            }else if (i == 1){
                [appListArr addObject:@"百度地图"];
            }
        }
    }
    return appListArr;
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *buttonTitle= [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"苹果地图"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]){
            
            MKMapItem *userCurrentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[userCurrentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            
        }
        
    }else if([buttonTitle isEqualToString:@"高德地图"]){
        
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",kAppDisplayName,kUrlScheme,_coordinate.latitude, _coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        
        
    }else if([buttonTitle isEqualToString:@"百度地图"]){
        
        if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",_coordinate.latitude, _coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        
    }
}


#pragma mark - BMKMapViewDelegate 修改大头针样式

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;
        newAnnotationView.canShowCallout = YES;
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - 点击大头针事件
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    
    NSLog(@"annotationViewForBubble");
    
    NSArray *installMaps = [self checkDeviceInstallMapApps];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];;
    for ( NSInteger i = 0; i < installMaps.count; i ++) {
        
        [sheet addButtonWithTitle:installMaps[i]];
        
    }
    
    [sheet showInView:self.view];
}


#pragma mark - BMKLocationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    

    if (_local) {
        [_mapView updateLocationData:userLocation];
        _coordinate = userLocation.location.coordinate;
        _annotation.coordinate = _coordinate;
        _annotation.title = @"导航去:";
        _annotation.subtitle = userLocation.subtitle?userLocation.subtitle:@"我的位置";
        
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        
        
        [[[CLGeocoder alloc]init] reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            CLPlacemark *placemarke = placemarks.firstObject;
            if (placemarke) {
                locality = placemarke.locality;
                postalCode = placemarke.postalCode;
                !self.callBackSelectedCity ?: self.callBackSelectedCity(locality);
            }
            
        }];
    }
    
    
    
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"didFailToLocateUserWithError:%@",error);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
@end







