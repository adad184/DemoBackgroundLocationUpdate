//
//  MMLocationManager.h
//  DemoBackgroundLocationUpdate
//
//  Created by Ralph Li on 7/20/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface MMLocationManager : CLLocationManager

@property (nonatomic, strong) NSMutableArray *datas;

+ (instancetype)sharedManager;

@end
