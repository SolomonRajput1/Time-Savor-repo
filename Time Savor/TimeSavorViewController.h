//
//  TimeSavorViewController.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Recipe.h"

@interface TimeSavorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Recipe *recipe;

@end
