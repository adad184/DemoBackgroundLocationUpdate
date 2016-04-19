//
//  Example1Controller.m
//  DemoBackgroundLocationUpdate
//
//  Created by Ralph Li on 7/20/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "Example1Controller.h"
#import "MMLocationManager.h"
#import <Masonry/Masonry.h>
@import MapKit;

@interface Example1Controller ()

@property (nonatomic,strong) MKMapView *mapView;

@end

@implementation Example1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView = [MKMapView new];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    [[MMLocationManager sharedManager] requestAlwaysAuthorization];
#endif
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
    [[MMLocationManager sharedManager] setAllowsBackgroundLocationUpdates:YES];
#endif
    
    [[MMLocationManager sharedManager] startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
