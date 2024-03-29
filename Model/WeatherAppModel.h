//
//  WeatherAppModel.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherData.h"
#import "SQLManager.h"
#import "WeatherBackgroundPresets.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherAppModel : NSObject

+(instancetype) sharedModel;

-(DBManager*) getDatabase;
-(WeatherData*) getWeatherData;
-(AppDelegate*) getAppDelegate;
-(WeatherBackgroundPresets*) getWeatherBackgroundPreset;
-(void) setAnimatedBackground:(AnimatedBackground*)background;
-(AnimatedBackground*) getCurrentAnimatedBackground;
+(void) displayToastWithMessage:(NSString*)message andDuration:(CGFloat)duration from:(UIViewController*)view;
@end

NS_ASSUME_NONNULL_END
