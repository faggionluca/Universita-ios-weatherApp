//
//  WeatherHeaderView.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherHeaderView.h"
#import "WeatherAppModel.h"
#import <RZViewActions/UIView+RZViewActions.h>
#import "UIView+WeatherViewCategory.h"

@interface WeatherHeaderView()
@property (strong, nonatomic) IBOutlet UIView *content;
@property (strong, nonatomic) IBOutlet UILabel *Temperature;
@property (strong, nonatomic) IBOutlet UILabel *TemperatureDesc;
@property (strong, nonatomic) IBOutlet UILabel *TemperatureSymbol;
@property (strong, nonatomic) IBOutlet UIImageView *WeatherIcon;
@property (strong, nonatomic) IBOutlet UILabel *CityName;
@property (strong, nonatomic) NSString* segueIdentifier;
@property (strong, nonatomic) NSNumber* city_ID;
@property (weak, nonatomic) UIViewController* segueController;
@end

@implementation WeatherHeaderView

-(instancetype) init{
    self = [super init];
    if(self){
        _segueIdentifier = @"";
        _segueController = nil;
    }
    return self;
}

-(instancetype) initWithSegueIdentifier:(NSString*)segueIdentifier ofController:(UIViewController*)controller{
    self = [super init];
    if(self){
        _segueIdentifier = segueIdentifier;
        _segueController = controller;
    }
    return self;
}

- (void)initView {
    [self initViewFromNib:@"WeatherHeaderView"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.content.bounds.size.height].active = true;
    UITapGestureRecognizer *tapGR;
    tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGR];
}

-(void) updateView:(CityWeather *)cityWeather{
    self.Temperature.text = [NSString stringWithFormat:@"%.00f",[cityWeather.current.mainTemp floatValue]];
    self.TemperatureDesc.text = cityWeather.current.weatherDescription;
    self.CityName.text = cityWeather.name;
    self.WeatherIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@", cityWeather.current.weatherIcon]];
    self.city_ID = cityWeather.ID;
}

-(void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        BOOL isFav = [[[WeatherAppModel sharedModel] getDatabase] getIsFavoriteCity:self.city_ID];
        if(self.segueController && isFav){
            [self.segueController performSegueWithIdentifier:self.segueIdentifier sender:self];
        }
    }
}

@end
