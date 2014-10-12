//
//  PlanViewController.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/18/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "PlanViewController.h"
#import "Plan.h"
#import "PlanTableViewCell.h"
#import "Recipe.h"
#import "TimeSavorAppDelegate.h"
#import "Ingredient.h"
#import "TimeSavorViewController.h"
#import "SwitchWithFavoriteViewController.h"
#import "RecipeBoxTableViewCell.h"
#import "GroceryListViewController.h"


@interface PlanViewController ()

@property (strong, nonatomic) Plan *plan;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PlanViewController

NSUserDefaults *prefs;
TimeSavorAppDelegate *appDelegate;

- (IBAction)updateGroceryList:(UIButton *)sender {
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    
    NSArray *titlesOfFavoritedRecipes=[prefs arrayForKey:@"favoritedRecipes"];

    
    for (Recipe *recipe in self.plan.chosenRecipes){
        if (![appDelegate.userAllChosenRecipes containsObject:(recipe)]){
            if (![titlesOfFavoritedRecipes containsObject:(recipe.title)]){
                 [appDelegate.userAllChosenRecipes addObject:recipe];
            }
        }
    }
    
    appDelegate.userChosenRecipes=self.plan.chosenRecipes;
    
    [self updateUserDefaults];
    
    
   // [appDelegate.userAllChosenRecipes addObjectsFromArray:self.plan.chosenRecipes];
    
    /*
    if (![appDelegate.userAllChosenRecipes count]){
        [appDelegate.userAllChosenRecipes initWithArray:self.plan.chosenRecipes];
    }else if ([appDelegate.userAllChosenRecipes count]){
        [appDelegate.userAllChosenRecipes addObjectsFromArray:self.plan.chosenRecipes];
    }
     */
    
    appDelegate.newRecipesPicked=YES;
    
    self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:2];
    
    
}


#define PLAN_SECTION    0


- (IBAction)switchButtonAction:(UIButton *)sender {
    
    
    
    PlanTableViewCell *cell=sender.superview.superview.superview;
    
    Recipe *oldRecipe=cell.recipe;
    
    Recipe *newRecipe =[self switchOutRecipe:oldRecipe];
    
    NSString *recipeTitle=cell.titleLabel.text;
    
    cell.recipe=newRecipe;
    
}

- (IBAction)selectedFavorite:(UIStoryboardSegue *)segue{
    
    SwitchWithFavoriteViewController *favoritesViewController = (SwitchWithFavoriteViewController *)segue.sourceViewController;
    
    RecipeBoxTableViewCell *chosenRecipeCell=[favoritesViewController.tableView cellForRowAtIndexPath:favoritesViewController.tableView.indexPathForSelectedRow];
    
    if (chosenRecipeCell){
    
        PlanTableViewCell *planCell=[self.tableView cellForRowAtIndexPath:favoritesViewController.requestingCellIndexPath];
        
        NSUInteger oldPlanIndex=[self.plan.chosenRecipes indexOfObject:planCell.recipe];
        
        
        NSMutableArray *titlesInChosenRecipes=[[NSMutableArray alloc] init];
        NSMutableArray *titlesInOtherRecipesThatMatchPreferences=[[NSMutableArray alloc] init];
        
        for (Recipe *recipe in self.plan.chosenRecipes){
            [titlesInChosenRecipes addObject:recipe.title];
        }

        
        for (Recipe *recipe in self.plan.otherRecipesThatMatchPreferences){
            [titlesInOtherRecipesThatMatchPreferences addObject:recipe.title];
        }
        
        
        if (![titlesInChosenRecipes containsObject:chosenRecipeCell.recipe.title]){
          
            [self.plan.otherRecipesThatMatchPreferences addObject:planCell.recipe];
            
            [self.plan.chosenRecipes replaceObjectAtIndex:oldPlanIndex withObject:chosenRecipeCell.recipe];
            
            
            if ([titlesInOtherRecipesThatMatchPreferences containsObject:chosenRecipeCell.recipe.title])
            {
                
                int i = [self.plan.otherRecipesThatMatchPreferences indexOfObjectPassingTest:^BOOL(id obj,NSUInteger idx,BOOL *stop)
                         {
                             Recipe *recipe=obj;
                             
                             if ([recipe.title isEqualToString:chosenRecipeCell.recipe.title]) {
                                 *stop = YES;
                                 return YES;
                             }
                             return NO;
                         }];

                
                
                [self.plan.otherRecipesThatMatchPreferences removeObjectAtIndex:i];
            }

            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:oldPlanIndex   inSection:PLAN_SECTION];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
            [self updateUserDefaults];
        
            
            
        } else if ([titlesInChosenRecipes containsObject:chosenRecipeCell.recipe.title]){
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"That recipe is already in your plan!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            
            [alert show];
            
        }
    }else if (!chosenRecipeCell){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You didn't pick a recipe!"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
        
        
    }
    
    
}

- (IBAction)cancelFavoritesModalView:(UIStoryboardSegue *)segue{
    
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"RecipeDescription"]) {
        
        if ([sender isKindOfClass:[UIButton class]]) {
            
            UIButton *buttonSender=sender;
        
            PlanTableViewCell *cell=buttonSender.superview.superview.superview.superview;
        
        
            if ([segue.destinationViewController isKindOfClass:[TimeSavorViewController class]]) {
                TimeSavorViewController *recipeDescriptionController = (TimeSavorViewController *)segue.destinationViewController;
                
            
            recipeDescriptionController.recipe = cell.recipe;
            }
            
        }
        
        
        
        
    }if ([segue.identifier isEqualToString:@"ExchangeWithFavorite"]) {
        
        if ([sender isKindOfClass:[UIButton class]]) {
            
            UIButton *buttonSender=sender;
            
            PlanTableViewCell *cell=buttonSender.superview.superview.superview.superview;
            
            NSIndexPath *sentIndexPath=[self.tableView indexPathForCell:cell];
            
            if ([segue.destinationViewController isKindOfClass:[SwitchWithFavoriteViewController class]]) {
                
                SwitchWithFavoriteViewController *switchWithFavoritesController = (SwitchWithFavoriteViewController *)segue.destinationViewController;
                
                NSMutableArray *favoritedRecipes =[self getFavoritedRecipes];
                
                switchWithFavoritesController.requestingCellIndexPath=sentIndexPath;
                
                switchWithFavoritesController.favoritedRecipes=favoritedRecipes;

                
            }
            
            
        }
    
    }
}


-(NSMutableArray *) getFavoritedRecipes{
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
    
    
    return favoritedRecipesTitlesToRecipes;
    
}


-(void) updateUserDefaults{
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *chosenRecipesArray=[[NSMutableArray alloc] init];
    NSMutableArray *otherRecipeArray=[[NSMutableArray alloc] init];
    NSMutableArray *allChosenRecipesArray=[[NSMutableArray alloc] init];
    
    for (Recipe *chosenRecipe in self.plan.chosenRecipes){
        [chosenRecipesArray addObject:chosenRecipe.title];
    }
    
    for (Recipe *otherRecipe in self.plan.otherRecipesThatMatchPreferences){
        [otherRecipeArray addObject:otherRecipe.title];
    }
    
    for (Recipe *allChosenRecipe in appDelegate.userAllChosenRecipes){
        [allChosenRecipesArray addObject:allChosenRecipe.title];
    }
    
    
    [prefs setObject:chosenRecipesArray forKey:@"chosenRecipes"];
    [prefs synchronize];
    
    
    [prefs setObject:otherRecipeArray forKey:@"otherMatchingRecipes"];
    [prefs synchronize];
    
    [prefs setObject:allChosenRecipesArray forKey:@"recipesToBeDecidedOn"];
    [prefs synchronize];

    
     
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

    Recipe *recipe = self.plan.chosenRecipes[indexPath.row];
    

    
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanRecipeCell"];
    
    cell.recipe=recipe;
    
    cell.titleLabel.text = recipe.title;
    cell.timeLabel.text = [NSString stringWithFormat:@"%@ Minutes", recipe.time];
    
    
    
    NSString *imageNameJPG= [NSString stringWithFormat:@"%@.jpg",recipe.imageDescription];
    NSString *imageNameJPEG= [NSString stringWithFormat:@"%@.jpeg",recipe.imageDescription];
    
    if ([UIImage imageNamed:imageNameJPG]){
         cell.recipeImage.image=[UIImage imageNamed:imageNameJPG];
    }
    else if ([UIImage imageNamed:imageNameJPEG]){
         cell.recipeImage.image=[UIImage imageNamed:imageNameJPEG];
    }
    
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return [self.plan.chosenRecipes count];
    
    
}




-(Recipe *)switchOutRecipe: (Recipe*) recipe {
    
    Recipe *newRecipe;
    
    int r=arc4random_uniform(self.plan.otherRecipesThatMatchPreferences.count);
    
    if (self.plan.otherRecipesThatMatchPreferences.count>0){

    newRecipe=self.plan.otherRecipesThatMatchPreferences[r];

        NSUInteger oldPlanIndex=[self.plan.chosenRecipes indexOfObject:recipe];

        [self.plan.chosenRecipes replaceObjectAtIndex:oldPlanIndex withObject:newRecipe];

        [self.plan.otherRecipesThatMatchPreferences removeObject:newRecipe];

        [self.plan.otherRecipesThatMatchPreferences addObject:recipe];

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:oldPlanIndex   inSection:PLAN_SECTION];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
        
        [self updateUserDefaults];


        
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No more recipes that meet your criteria"
                                                        message:@"Try picking more cuisines to get more options!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
        
        
        newRecipe=nil;
    }
    
    return newRecipe;
    
}







- (void)viewDidLoad
{
    [super viewDidLoad];
    // TEST STUFF STARTS


    
    TimeSavorAppDelegate *testAppDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [testAppDelegate managedObjectContext];
    
    /*
    Recipe *testRecipe;
    
    Recipe *testIngredient1=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient1 setValue: @"Cheddar" forKey:@"name"];
    [testIngredient1 setValue:@34 forKey:@"quantity"];
    [testIngredient1 setValue:@"cores" forKey:@"units"];
    
    
    Recipe *testIngredient2=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient2 setValue: @"Cheddar" forKey:@"name"];
    [testIngredient2 setValue:@46 forKey:@"quantity"];
    [testIngredient2 setValue:@"pits" forKey:@"units"];
    
    Recipe *testIngredient3=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient3 setValue: @"soy sauce" forKey:@"name"];
    [testIngredient3 setValue:@4 forKey:@"quantity"];
    [testIngredient3 setValue:@"berries" forKey:@"units"];
    
    
    
    NSSet *testIngredients= [[NSSet alloc] initWithObjects:testIngredient1, testIngredient2, testIngredient3, nil];
    
    
    testRecipe= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe setValue: @"Asian Snaps!" forKey:@"title"];
    [testRecipe setValue: [UIImage imageNamed:@"Baked Ziti and Summer Veggies.jpg"] forKey:@"image"];
    [testRecipe setValue: @25 forKey:@"time"];
    [testRecipe setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe setValue: @4 forKey:@"servingSize"];
    [testRecipe setValue: @"Asian" forKey:@"cuisine"];
    [testRecipe setValue: @[@"Vegan", @"Gluten-Free"] forKey:@"dietaryRestrictions"];
    
    testRecipe.ingredients=testIngredients;
    
    
    
    
    Recipe *testRecipe2;
    
    
    
    Recipe *testIngredient4=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient4 setValue: @"Cheddar" forKey:@"name"];
    [testIngredient4 setValue:@34 forKey:@"quantity"];
    [testIngredient4 setValue:@"cores" forKey:@"units"];
    
    
    Recipe *testIngredient5=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient5 setValue: @"Cheddar" forKey:@"name"];
    [testIngredient5 setValue:@46 forKey:@"quantity"];
    [testIngredient5 setValue:@"pits" forKey:@"units"];
    
    Recipe *testIngredient6=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient6 setValue: @"soy sauce" forKey:@"name"];
    [testIngredient6 setValue:@4 forKey:@"quantity"];
    [testIngredient6 setValue:@"berries" forKey:@"units"];
    
    
    
    NSSet *testIngredients2= [[NSSet alloc] initWithObjects:testIngredient4, testIngredient5, testIngredient6, nil];
    
    
    testRecipe2= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe2 setValue: @"Mexican Dish!" forKey:@"title"];
    [testRecipe2 setValue: [UIImage imageNamed:@"Baked Ziti and Summer Veggies.jpg"] forKey:@"image"];
    [testRecipe2 setValue: @25 forKey:@"time"];
    [testRecipe2 setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe2 setValue: @4 forKey:@"servingSize"];
    [testRecipe2 setValue: @"Mexican" forKey:@"cuisine"];
    [testRecipe2 setValue: @[@"Vegan"] forKey:@"dietaryRestrictions"];
    
    
    testRecipe2.ingredients=testIngredients2;
    
    
    
    Recipe *testRecipe3;
    
    testRecipe3= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe3 setValue: @"Mediterranean Dish!" forKey:@"title"];
    [testRecipe3 setValue: [UIImage imageNamed:@"Baked Ziti and Summer Veggies.jpg"] forKey:@"image"];
    [testRecipe3 setValue: @25 forKey:@"time"];
    [testRecipe3 setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe3 setValue: @4 forKey:@"servingSize"];
    [testRecipe3 setValue: @"Mediterranean" forKey:@"cuisine"];
    [testRecipe3 setValue: @[@"Vegan"] forKey:@"dietaryRestrictions"];
    
    Recipe *testRecipe4;
    
    testRecipe4= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe4 setValue: @"Trial Dish!" forKey:@"title"];
    [testRecipe4 setValue: @[@"Vegan"] forKey:@"dietaryRestrictions"];
    [testRecipe4 setValue: @"Mediterranean" forKey:@"cuisine"];
    
    
    Recipe *testRecipe5;
    
    testRecipe5= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe5 setValue: @"Trial Dish!" forKey:@"title"];
    
    
    Recipe *testRecipe6;
    
    testRecipe6= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe6 setValue: @"Trial Dish!" forKey:@"title"];
   
    
    
    
    
    
    
    
    */
    
    NSError *error;
    [context save:&error];
    
    
    //self.plan.masterRecipeList=[[NSMutableArray alloc] initWithObjects:testRecipe, testRecipe2, testRecipe3, testRecipe4, nil];
    
    
    //TEST STUFF ENDS
    
    

    appDelegate = [[UIApplication sharedApplication] delegate];
    
    //NEED THIS METHOD SOMEWHERE PERMANENTLY; IT SUCKS THAT IT'S A MAGIC NUMBER BUT WHAT CAN YOU DO
    //CHANGE THIS FROM THE VALUE PRESENTED ON THE STORYBOARD AS NEED BE
    self.tableView.rowHeight=288;
    
    self.navigationController.navigationBarHidden=YES;
    
    self.plan=[[Plan alloc] init];
    

    

    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    NSArray *chosenRecipeTitlesFromUserDefaults=[prefs arrayForKey:@"chosenRecipes"];
    NSArray *otherMatchingRecipeTitlesFromUserDefaults=[prefs arrayForKey:@"otherMatchingRecipes"];
    
    
    NSMutableArray *chosenRecipeTitlesToRecipes=[[NSMutableArray alloc] init];
    NSMutableArray *otherMatchingRecipes=[[NSMutableArray alloc] init];
    


    for (Recipe *recipe in fetchedObjects) {
        if ([chosenRecipeTitlesFromUserDefaults containsObject:recipe.title]){
            [chosenRecipeTitlesToRecipes addObject:recipe];
        }
        
        if ([otherMatchingRecipeTitlesFromUserDefaults containsObject:recipe.title]){
            [otherMatchingRecipes addObject:recipe];
        }

    }
    
    
    if (chosenRecipeTitlesToRecipes){
        self.plan.chosenRecipes=[[NSMutableArray alloc] initWithArray:chosenRecipeTitlesToRecipes];
    }
    
    if (otherMatchingRecipes){
        self.plan.otherRecipesThatMatchPreferences=[[NSMutableArray alloc] initWithArray:otherMatchingRecipes];
    }

    
    
    
    
    self.plan.masterRecipeList=[[NSMutableArray alloc] initWithArray:fetchedObjects];

     
    
}




-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    self.navigationController.navigationBarHidden=YES;
    
    
    if (appDelegate.newPlanGenerated==YES){
        
        self.numberOfRecipes=appDelegate.userRequestedNumberOfRecipes;
        self.plan.numberOfRecipesToPlan=self.numberOfRecipes;
        
        self.plan.cuisinePreferences=appDelegate.userRequestedCuisineChoices;
        
        self.plan.dietaryRestrictions=appDelegate.userRequestedDietaryRestrictions;
        
        [self.plan createPlan];
        
        [self updateUserDefaults];
        
        appDelegate.newPlanGenerated=NO;
        
    }
    
    if (![self.plan.chosenRecipes count]){
        self.tableView.hidden=YES;
    }
    
    if ([self.plan.chosenRecipes count]){
        self.tableView.hidden=NO;
    }
    
    
    

    [self.tableView reloadData];
    
    
    
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
