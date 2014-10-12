//
//  PreferencesViewController.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/19/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *userCuisinePreferences;
@property (nonatomic, strong) NSMutableArray *userDietaryRestrictions;

@property (nonatomic, strong) NSNumber *requestedRecipeCount;
@property (nonatomic, strong) NSNumber *requestedServingSize;



@end


