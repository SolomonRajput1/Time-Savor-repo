//
//  SwitchWithFavoriteViewController.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/19/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "SwitchWithFavoriteViewController.h"
#import "RecipeBoxTableViewCell.h"
#import "TimeSavorAppDelegate.h"

@interface SwitchWithFavoriteViewController ()



@end


@implementation SwitchWithFavoriteViewController

TimeSavorAppDelegate *appDelegate;
NSUserDefaults *prefs;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell;
        
    Recipe *recipe = self.favoritedRecipes[indexPath.row];
        
    RecipeBoxTableViewCell *favoritedRecipeCell = [tableView dequeueReusableCellWithIdentifier:@"RecipeBoxCell"];
    
    favoritedRecipeCell.recipe=recipe;
    
    favoritedRecipeCell.titleLabel.text = favoritedRecipeCell.recipe.title;
    favoritedRecipeCell.timeLabel.text = [NSString stringWithFormat:@"%@ Minutes", favoritedRecipeCell.recipe.time];
    
    NSString *imageNameJPG= [NSString stringWithFormat:@"%@.jpg",favoritedRecipeCell.recipe.imageDescription];
    NSString *imageNameJPEG= [NSString stringWithFormat:@"%@.jpeg",favoritedRecipeCell.recipe.imageDescription];
    
    if ([UIImage imageNamed:imageNameJPG]){
        favoritedRecipeCell.recipeImageView.image=[UIImage imageNamed:imageNameJPG];
    }
    else if ([UIImage imageNamed:imageNameJPEG]){
        favoritedRecipeCell.recipeImageView.image=[UIImage imageNamed:imageNameJPEG];
    }
    
    

    
    cell=favoritedRecipeCell;
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int i=[self.favoritedRecipes count];
    
    return i;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TimeSavorAppDelegate *testAppDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [testAppDelegate managedObjectContext];
    
   
    

    [self.tableView reloadData];
    
    

    

    
    
    
    
    //NEED THIS METHOD SOMEWHERE PERMANENTLY; IT SUCKS THAT IT'S A MAGIC NUMBER BUT WHAT CAN YOU DO
    //CHANGE THIS FROM THE VALUE PRESENTED ON THE STORYBOARD AS NEED BE
    self.tableView.rowHeight=89;
    

    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //self.favoritedRecipes=appDelegate.userFavoriteRecipes;
   
    /*
    prefs = [NSUserDefaults standardUserDefaults];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [appDelegate managedObjectContext];
    
    NSError *error;
    [context save:&error];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSArray *titlesOfFavoritedRecipes=[prefs arrayForKey:@"favoritedRecipes"];
    
    NSMutableArray *favoritedRecipesTitlesToRecipes=[[NSMutableArray alloc] init];
    
    for (Recipe *recipe in fetchedObjects) {
        if ([titlesOfFavoritedRecipes containsObject:recipe.title]){
            [favoritedRecipesTitlesToRecipes addObject:recipe];
        }
    }
    
    
    self.favoritedRecipes=favoritedRecipesTitlesToRecipes;
     
     */
    
    
    if (![self.favoritedRecipes count]){
        self.tableView.hidden=YES;
    }
    
    if ([self.favoritedRecipes count]){
        self.tableView.hidden=NO;
    }
    
    
    [self.tableView reloadData];
}




@end
