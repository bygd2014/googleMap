//
//  ViewController.m
//  googleMap
//
//  Created by kingdomrain on 2018/1/2.
//  Copyright © 2018年 yuzhifei. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate>
{
    
    GMSMapView *_googleMapView;
    CLLocationManager *_loacationManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self loadView];
    [self createMapView];
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width, 100)];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(pressFun) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

-(void)pressFun{
//    NSString *urlString = [[NSString stringWithFormat:@"comgooglemapsurl://www.google.com/maps/preview/@%lf,%lf,6z",endCoor.latitude, endCoor.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)loadView {
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:1.285
//                                                            longitude:103.848
//                                                                 zoom:12];
//    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    self.view = mapView;
//}

- (void)createMapView{
    /*
     地图初始化
     **/
    _googleMapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _googleMapView.delegate = self;
    _googleMapView.indoorEnabled = NO;
    _googleMapView.settings.rotateGestures = NO;
    _googleMapView.settings.tiltGestures = NO;
    _googleMapView.settings.myLocationButton = YES;
    _googleMapView.myLocationEnabled = YES;
    _loacationManager = [[CLLocationManager alloc] init];
    _loacationManager.delegate  = self;
    [_loacationManager requestWhenInUseAuthorization];
    [self.view addSubview:_googleMapView];
    
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    /**
     *    拿到授权发起定位请求
     */
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_loacationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /**
     * 位置更新时调用
     */
    CLLocation *currentLocation = locations.firstObject;
    _googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:currentLocation.coordinate zoom:18 bearing:0 viewingAngle:0];
    [_loacationManager stopUpdatingLocation];
}

@end
