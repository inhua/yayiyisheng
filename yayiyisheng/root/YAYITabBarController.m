//
//  YAYITabBarController.m
//  YAYIDoctor
//
//  Created by hxp on 16/4/28.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import "YAYITabBarController.h"

//#import "YAYILoginViewController.h"

#import "YAYINavigationController.h"
#import "YAHomeViewController.h"  // 主页
#import "YAIMViewController.h" //   患者
#import "YAMineViewController.h" // 个人中心

#import <CoreLocation/CoreLocation.h>




@interface YAYITabBarController()<CLLocationManagerDelegate, UIAlertViewDelegate>

// 关于定位
@property (nonatomic, strong) CLLocationManager *clMgr;
@property (nonatomic, strong) CLGeocoder *geo;
@property (nonatomic, strong) CLPlacemark *placemark;

/** 网络状态 */
@property (nonatomic, assign) NSInteger netState;



@end

@implementation YAYITabBarController

- (CLLocationManager *)clMgr
{
    if (nil == _clMgr) {
        _clMgr = [[CLLocationManager alloc] init];
        _clMgr.delegate = self;
        _clMgr.desiredAccuracy = kCLLocationAccuracyBest;
        //        _clMgr.allowsBackgroundLocationUpdates = YES;
        [_clMgr requestWhenInUseAuthorization];
        
    }
    return _clMgr;
}

- (CLGeocoder *)geo
{
    if (nil == _geo) {
        _geo = [[CLGeocoder alloc] init];
    }
    return _geo;
}

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    //    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //
    //    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    //    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    //    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    //
    //    UITabBarItem *item = [UITabBarItem appearance];
    //    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    //    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
   // [UITableView appearance].backgroundColor = [UIColor colorWithWhite:0.965 alpha:1];
//    [UITabBar appearance].barTintColor = [UIColor whiteColor];
   // [[UITabBar appearance] setShadowImage:[UIImage new]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
  
    
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_ios"]];
//    
//    [[UITabBar appearance] setShadowImage:nil];;

    //[tabbar.tabBar setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.shadowimage.hidden = YES;
}
-(void)createView{
    /*
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage  imageNamed:@"tbabar_shadow_icon"];
    imageView.frame = CGRectMake(0, SCREEN_height - 59, SCREEN_width, 10);
    self.shadowimage = imageView;
    [self.view addSubview:imageView];
     */
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [UITabBar appearance].backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [self dropShadowWithOffset:CGSizeMake(0, -0.5)
                        radius:1
                         color:[UIColor grayColor]
                       opacity:0.1];
    
    //[UITabBar appearance].clipsToBounds = YES;

    //[[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_ios"]];
    //[UITabBar appearance].clipsToBounds = YES;
    [self.tabBar setShadowImage:img];
    ;
    [self.clMgr startUpdatingLocation];
    
    // 添加子控制器
    [self setupChildVc:[[YAHomeViewController alloc] init] title:@"牙艺" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_highlight"];
    
    [self setupChildVc:[[YAIMViewController alloc] init] title:@"消息" image:@"tabbar_find_normal" selectedImage:@"tabbar_find_highlight"];
    
    
    
    
    [self setupChildVc:[[YAMineViewController alloc] init] title:@"我的" image:@"tabbar_me_normal" selectedImage:@"tabbar_me_highlight"];
    
    
    self.netState = -2;
    [self monitorNetworking];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *userdef = [NSUserDefaults  standardUserDefaults];
    NSString *cookieName = [userdef valueForKey:YAYILoginCookieKey];
    
    if (cookieName) {
        
        [self imLogin];
    }
    
    //添加阴影
    
    /*
    if (self.shadowimage == nil) {
        [self createView];
    }else{
        self.shadowimage.hidden = false;
    }
     */
    
   
   
}
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}



- (void)imLogin
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault stringForKey:YAYIUsernameKey];
    NSString *password = [userDefault stringForKey:YAYIPasswordKey];
    /*
    [[SPKitExample sharedInstance] callThisAfterISVAccountLoginSuccessWithYWLoginId:username passWord:password preloginedBlock:^{
        
    } successBlock:^{
        
        YAYILog(@"-------IM登录成功------");
    } failedBlock:^(NSError *error) {
        YAYILog(@"-------IM登录失败------");
    }];
    */
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage  imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:YAYIColor(92, 169, 239)} forState:UIControlStateSelected];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器;
    YAYINavigationController *nav = [[YAYINavigationController alloc] initWithRootViewController:vc];
    nav.title = title;
    [self addChildViewController:nav];
}


#pragma mark cllocation代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    CLLocation *loc = locations.lastObject;
    //    loc.coordinate.latitude
    // 反地理编码
    [self.geo reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//            NSString *city = [NSString stringWithFormat:@"%@%@",placemark.administrativeArea, placemark.locality];
            
            NSString *lastAddress = [NSString stringWithFormat:@"country:%@, administrativeArea:%@, locality:%@, subLocality:%@, thoroughfare:%@, subThoroughfare:%@",placemark.country, placemark.administrativeArea, placemark.locality, placemark.subLocality, placemark.thoroughfare,placemark.subThoroughfare];//详细地址
           // YAYILog(@"______%@",lastAddress);
            
            if (placemark.locality) {
                [self areaChanged:placemark];
            }
        }
    }];
    
    [self.clMgr stopUpdatingLocation];
}

/**
 *  获取到位置提示
 */
- (void)areaChanged:(CLPlacemark *)placemark
{
    self.placemark = placemark;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *locationDict = [userDefaults dictionaryForKey:YAYILocationKey];
    
    // 判断是城市如果不是当前城市则弹出提示
    if (locationDict) {
        if ([locationDict[@"locality"] isEqualToString:placemark.locality]) {
            [self saveLocationWith:placemark];
            
        }else{
            NSString *alertStr = [NSString stringWithFormat:@"系统定位到您在%@，需要切换至%@吗", placemark.locality, placemark.locality];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        
    }else{
        [self saveLocationWith:placemark];
        //        NSDictionary *curLocDict = @{@"locality":placemark.locality,
        //                                     @"administrativeArea":placemark.administrativeArea,
        //                                     @"latitude":@(placemark.location.coordinate.latitude),
        //                                     @"longitude":@(placemark.location.coordinate.longitude)};
        //        [userDefaults setObject:curLocDict forKey:YAYILocationKey];
        //        [userDefaults synchronize];
    }
    
    NSDictionary *locDcit = [[NSUserDefaults standardUserDefaults] dictionaryForKey:YAYILocationKey];
    //YAYILog(@"locDcit:%@", locDcit);
}


#pragma mark alertview代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex) {

        [self saveLocationWith:self.placemark];
    }
}


- (void)saveLocationWith:(CLPlacemark *)placemark
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = placemark.locality;
    
    /*
    [YAYINetWorking getWithURL:all_local_city_url param:param finish:^(NSData *data, NSDictionary *dict, NSError *error) {
        if (nil == error) {
            //YAYILog(@"返回：%@", dict);
            
            NSArray *citys = dict[@"data"];
            
            if (citys.count > 0) {
                NSString *areaCode = [NSString stringWithFormat:@"%@", [citys firstObject][@"id"]];
                
                NSDictionary *curLocDict = @{@"locality":self.placemark.locality,
                                             @"administrativeArea":self.placemark.administrativeArea,
                                             @"latitude":@(self.placemark.location.coordinate.latitude),
                                             @"longitude":@(self.placemark.location.coordinate.longitude),
                                             @"areacode":areaCode};
                [[NSUserDefaults standardUserDefaults] setObject:curLocDict forKey:YAYILocationKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSDictionary *locDcit = [[NSUserDefaults standardUserDefaults] dictionaryForKey:YAYILocationKey];
                //YAYILog(@"locDcit:%@", locDcit);
            }
        }
    }];
     */
   
}


- (void)monitorNetworking
{
    
    // 检测网络连接的单例,网络变化时的回调方法
    __weak typeof(self) weakself = self;
    [[AFNetworkReachabilityManager sharedManager]
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         // 进入移动网络
         if (status == 1 ) {
             //YAYILog(@"网络状态：移动网络");
         }
         
         //判断网络是否连接
         if(! (status ==AFNetworkReachabilityStatusReachableViaWWAN ||
               status == AFNetworkReachabilityStatusReachableViaWiFi)) {
             
             //[SVProgressHUD showImage:nil status:@"请检查你的网络连接"];
             //YAYILog(@"网络状态：网络连接失败");
         }else{
             
             //YAYILog(@"网络状态：网络连接正常");
             /** 网络连接由无法连接变为正常连接 */
             if (weakself.netState > -2 && _netState <= 0) {
                 
                 //YAYILog(@"网络状态：网络连接变为正常");
                 // 发送通知
                 NSNotification *not = [NSNotification notificationWithName:YAYINetStateChanged object:nil];
                 [[NSNotificationCenter defaultCenter] postNotification:not];
             }
         }
         
         weakself.netState = status;
     }];
     [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    
}


@end
