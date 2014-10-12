//
//  SwitchWithFavoriteViewController.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/19/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchWithFavoriteViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *favoritedRecipes;     // of Recipe
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *requestingCellIndexPath;


@end
