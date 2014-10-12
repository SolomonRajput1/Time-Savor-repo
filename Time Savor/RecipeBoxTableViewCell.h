//
//  RecipeBoxTableViewCell.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/19/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeBoxTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) Recipe *recipe;

@end
