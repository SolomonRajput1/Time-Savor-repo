//
//  RecipeBoxViewController.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/18/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeBoxViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *recipesToBeDecidedOn;  //of Recipe
@property (nonatomic, strong) NSMutableArray *favoritedRecipes;     // of Recipe

@end
