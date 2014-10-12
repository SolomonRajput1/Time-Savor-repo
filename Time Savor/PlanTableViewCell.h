//
//  PlanTableViewCell.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/18/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface PlanTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) IBOutlet UIImageView *recipeImage;

@property (nonatomic, strong) Recipe *recipe;



@end
