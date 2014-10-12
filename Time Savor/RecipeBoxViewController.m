//
//  RecipeBoxViewController.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/18/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "RecipeBoxViewController.h"
#import "Recipe.h"
#import "PendingRecipeTableViewCell.h"
#import "ConfirmedRecipesTableViewCell.h"
#import "TimeSavorAppDelegate.h"
#import "TimeSavorViewController.h"

@interface RecipeBoxViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RecipeBoxViewController

TimeSavorAppDelegate *appDelegate;
NSUserDefaults *prefs;

#define NUMBER_OF_SECTIONS  2

#define RECIPES_TO_BE_ADDED_SECTION 0
#define FAVORITED_RECIPES_SECTION   1


-(NSMutableArray *) favoritedRecipes{
    if (!_favoritedRecipes) _favoritedRecipes=[[NSMutableArray alloc] init];
    return _favoritedRecipes;
}


- (IBAction)addRecipe:(UIButton *)sender {

    
    PendingRecipeTableViewCell *cell=sender.superview.superview.superview;
    
    NSIndexPath *path=[self.tableView indexPathForCell:cell];
    
    Recipe *recipe=cell.recipe;
    
    [self makeRecipeAFavorite:recipe withIndexPath:path];
    
}


- (IBAction)removeRecipe:(UIButton *)sender {
    
    PendingRecipeTableViewCell *cell=sender.superview.superview.superview;
    
    NSIndexPath *path=[self.tableView indexPathForCell:cell];
    
    Recipe *recipe=cell.recipe;
    
    [self deletePendingRecipe:recipe withIndexPath:path];
}

-(void)updateUserPreferences{
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *favoritedRecipeArray=[[NSMutableArray alloc] init];
    NSMutableArray *recipesToBeDecidedOnArray=[[NSMutableArray alloc] init];
    
    for (Recipe *favoritedRecipe in self.favoritedRecipes){
        [favoritedRecipeArray addObject:favoritedRecipe.title];
    }
    
    for (Recipe *recipeToBeDecidedOn in self.recipesToBeDecidedOn){
        [recipesToBeDecidedOnArray addObject:recipeToBeDecidedOn.title];
    }
    
    [prefs setObject:favoritedRecipeArray forKey:@"favoritedRecipes"];
    [prefs synchronize];
    
    
    [prefs setObject:recipesToBeDecidedOnArray forKey:@"recipesToBeDecidedOn"];
    [prefs synchronize];
    
}


-(void) makeRecipeAFavorite: (Recipe *) recipe withIndexPath:(NSIndexPath*) path{
    
    



    [self.recipesToBeDecidedOn removeObject:recipe];

    [appDelegate.userAllChosenRecipes removeObject:recipe];
    
    [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

    

    [self.favoritedRecipes insertObject:recipe atIndex:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0   inSection:FAVORITED_RECIPES_SECTION];
    [self.tableView insertRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationNone];
    
    appDelegate.userFavoriteRecipes=self.favoritedRecipes;
    
    [self updateUserPreferences];
    



    
    
    
}

-(void) deletePendingRecipe: (Recipe *) recipe withIndexPath:(NSIndexPath*) path{
    
    
    [self.recipesToBeDecidedOn removeObject:recipe];
    [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    
    [appDelegate.userAllChosenRecipes removeObject:recipe];
    
    [self updateUserPreferences];
}








- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell;
    
    RecipeBoxTableViewCell *recipeBoxCell;
    
    if (indexPath.section==RECIPES_TO_BE_ADDED_SECTION){
        
        Recipe *recipe = self.recipesToBeDecidedOn[indexPath.row];
        
        
        PendingRecipeTableViewCell *pendingRecipeCell = [tableView dequeueReusableCellWithIdentifier:@"PendingRecipeCell"];
        
        recipeBoxCell=pendingRecipeCell;
        
        recipeBoxCell.recipe=recipe;
    
        
        
    }else if (indexPath.section==FAVORITED_RECIPES_SECTION){
        
        Recipe *recipe = self.favoritedRecipes[indexPath.row];
        
        ConfirmedRecipesTableViewCell *confirmedRecipeCell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmedRecipeCell"];
        
        recipeBoxCell=confirmedRecipeCell;
        recipeBoxCell.recipe=recipe;
    }
    
    
    
    recipeBoxCell.titleLabel.text = recipeBoxCell.recipe.title;
    recipeBoxCell.timeLabel.text = [NSString stringWithFormat:@"%@ Minutes", recipeBoxCell.recipe.time];
    
    
    NSString *imageNameJPG= [NSString stringWithFormat:@"%@.jpg",recipeBoxCell.recipe.imageDescription];
    NSString *imageNameJPEG= [NSString stringWithFormat:@"%@.jpeg",recipeBoxCell.recipe.imageDescription];
    
    if ([UIImage imageNamed:imageNameJPG]){
       recipeBoxCell.recipeImageView.image=[UIImage imageNamed:imageNameJPG];
    }
    else if ([UIImage imageNamed:imageNameJPEG]){
        recipeBoxCell.recipeImageView.image=[UIImage imageNamed:imageNameJPEG];
    }

    
    cell=recipeBoxCell;
    
    return cell;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int i;
    
    if (section==RECIPES_TO_BE_ADDED_SECTION){
        
         i=[self.recipesToBeDecidedOn count];
        
        
        
    }else if (section==FAVORITED_RECIPES_SECTION){
        
        i=[self.favoritedRecipes count];
        
    }
    
    return i;

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)sender{
    
    return NUMBER_OF_SECTIONS;
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    
    switch (section){
        case RECIPES_TO_BE_ADDED_SECTION:
            if ([self.recipesToBeDecidedOn count]>0){
                title = @"Recipes recently added to grocery list";
            }
            break;
            
        case FAVORITED_RECIPES_SECTION:
            if ([self.favoritedRecipes count]>0){
                title = [NSString stringWithFormat:@"Favorites"];
            }
            break;
    }

    return title;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    TimeSavorAppDelegate *testingAppDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [testingAppDelegate managedObjectContext];
    
    /*
    Recipe *testRecipe;
    
    
    
    testRecipe= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe setValue: @"Baked Ziti and Summer Veggies!" forKey:@"title"];
    [testRecipe setValue: [UIImage imageNamed:@"Baked Ziti and Summer Veggies.jpg"] forKey:@"image"];
    [testRecipe setValue: @25 forKey:@"time"];
    [testRecipe setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe setValue: @4 forKey:@"servingSize"];
    [testRecipe setValue: @"Asian" forKey:@"cuisine"];
    [testRecipe setValue: @[@"Vegan", @"Gluten-Free"] forKey:@"dietaryRestrictions"];
    
    
    
    
    Recipe *testRecipe2;
    
    
    testRecipe2= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe2 setValue: @"Mexican Dish!" forKey:@"title"];
    [testRecipe2 setValue: [UIImage imageNamed:@"dice.jpg"] forKey:@"image"];
    [testRecipe2 setValue: @25 forKey:@"time"];
    [testRecipe2 setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe2 setValue: @4 forKey:@"servingSize"];
    [testRecipe2 setValue: @"Mexican" forKey:@"cuisine"];
    [testRecipe2 setValue: @[@"Vegan"] forKey:@"dietaryRestrictions"];
    
    Recipe *testRecipe3;
    
    testRecipe3= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe3 setValue: @"Mediterranean Dish!" forKey:@"title"];
    [testRecipe3 setValue: [UIImage imageNamed:@"Baked Ziti and Summer Veggies.jpg"] forKey:@"image"];
    [testRecipe3 setValue: @25 forKey:@"time"];
    [testRecipe3 setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe3 setValue: @4 forKey:@"servingSize"];
    [testRecipe3 setValue: @"Mediterranean" forKey:@"cuisine"];
    [testRecipe3 setValue: @[@"Vegan"] forKey:@"dietaryRestrictions"];
    
    
    
    
    
    
    
    self.favoritedRecipes=[[NSMutableArray alloc] initWithObjects:testRecipe, nil];
    self.recipesToBeDecidedOn=[[NSMutableArray alloc] initWithObjects:testRecipe2, testRecipe3, nil];

    */
    
    NSError *error;
    [context save:&error];
     
    
    //NEED THIS METHOD SOMEWHERE PERMANENTLY; IT SUCKS THAT IT'S A MAGIC NUMBER BUT WHAT CAN YOU DO
    //CHANGE THIS FROM THE VALUE PRESENTED ON THE STORYBOARD AS NEED BE
    self.tableView.rowHeight=89;

    
    prefs = [NSUserDefaults standardUserDefaults];
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    NSArray *titlesOfRecipesToBeDecidedOnFromUserDefaults=[prefs arrayForKey:@"recipesToBeDecidedOn"];
    NSArray *titlesOfFavoritedRecipes=[prefs arrayForKey:@"favoritedRecipes"];
    
    NSMutableArray *decidingOnRecipesTitlesToRecipes=[[NSMutableArray alloc] init];
    NSMutableArray *favoritedRecipesTitlesToRecipes=[[NSMutableArray alloc] init];
    
    for (Recipe *recipe in fetchedObjects) {
        if ([titlesOfRecipesToBeDecidedOnFromUserDefaults containsObject:recipe.title]){
            [decidingOnRecipesTitlesToRecipes addObject:recipe];
        }
        if ([titlesOfFavoritedRecipes containsObject:recipe.title]){
            [favoritedRecipesTitlesToRecipes addObject:recipe];
        }
    
    }
    
    
    self.recipesToBeDecidedOn=decidingOnRecipesTitlesToRecipes;
    appDelegate.userAllChosenRecipes=self.recipesToBeDecidedOn;
     
    
    self.favoritedRecipes=favoritedRecipesTitlesToRecipes;
    
    self.navigationController.navigationBarHidden=YES;
    
    //appDelegate.userFavoriteRecipes=favoritedRecipesTitlesToRecipes;
    
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (![self.recipesToBeDecidedOn count]){
        self.tableView.hidden=YES;
    }
    
    if ([self.recipesToBeDecidedOn count]  || [self.favoritedRecipes count]){
        self.tableView.hidden=NO;
    }

    self.recipesToBeDecidedOn= appDelegate.userAllChosenRecipes;
    
    [self.tableView reloadData];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"RecipeDescription"]) {
        
        if ([sender isKindOfClass:[RecipeBoxTableViewCell class]]) {
            
            RecipeBoxTableViewCell *recipeCell=sender;
            
            
            if ([segue.destinationViewController isKindOfClass:[TimeSavorViewController class]]) {
                TimeSavorViewController *recipeDescriptionController = (TimeSavorViewController *)segue.destinationViewController;
                
                
                recipeDescriptionController.recipe = recipeCell.recipe;
            }
            
        }
        
    }
    
}









- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
