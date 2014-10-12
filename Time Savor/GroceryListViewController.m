//
//  GroceryListViewController.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/15/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//




#import "GroceryListViewController.h"
#import "Ingredient.h"
#import "TimeSavorAppDelegate.h"
#import "Recipe.h"
#import "GroceryList.h"

@interface GroceryListViewController () <UITextFieldDelegate>


//the following properties are all arrays of Ingredient objects
@property (strong, nonatomic)NSMutableArray *userAddedItems;
@property (strong, nonatomic)NSMutableArray *produceItems;
@property (strong, nonatomic)NSMutableArray *proteinItems;
@property (strong, nonatomic)NSMutableArray *dairyAndEggItems;
@property (strong, nonatomic)NSMutableArray *grainItems;
@property (strong, nonatomic)NSMutableArray *packagedGoodsItems;
@property (strong, nonatomic)NSMutableArray *internationalItems;
@property (strong, nonatomic)NSMutableArray *commonHouseholdItems;
@property (strong, nonatomic)NSMutableArray *recipeTitles;


@property (strong, nonatomic) NSNumber *desiredServingSize;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *addedItemTextField;


@property (strong, nonatomic) Recipe *recipe;


@end

@implementation GroceryListViewController

TimeSavorAppDelegate *appDelegate;
NSUserDefaults *prefs;



// table's section indexes
#define USER_ADDED_SECTION      0
#define RECIPES_TITLES_IN_LIST_SECTION  1
#define PRODUCE_SECTION     2
#define MEAT_SEAFOOD_AND_OTHER_PROTEINS_SECTION      3
#define DAIRY_AND_EGGS_SECTION     4
#define GRAINS_SECTION     5
#define CANNED_OR_PACKAGED_GOODS_SECTION    6
#define INTERNATIONAL_ITEMS_SECTION    7
#define ITEMS_YOU_MAY_HAVE_AT_HOME_SECTION      8

#define NUMBER_OF_SECTIONS 9


-(NSMutableArray *) userAddedItems{
    if (!_userAddedItems) _userAddedItems=[[NSMutableArray alloc] init];
    return _userAddedItems;
}

/*

-(Ingredient *)createIngredientWithName:(NSString *) name{
    
    TimeSavorAppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [appDelegate managedObjectContext];

    Ingredient *ingredient;
    
    ingredient=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [ingredient setValue: name forKey:@"name"];
 
    NSError *error;
    [context save:&error];
    
    return ingredient;
}
 */


- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSDictionary *addedIngredient = @{
                                        @"name" : textField.text
                                        };
    [self.userAddedItems addObject: addedIngredient];
    
    //NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:USER_ADDED_SECTION];
    
    //[self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
    
    [prefs setObject:self.userAddedItems forKey:@"userAddedItems"];
    [prefs synchronize];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:[self.userAddedItems count]-1   inSection:USER_ADDED_SECTION];
    [self.tableView insertRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:[self.userAddedItems count]-1   inSection:USER_ADDED_SECTION];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath2] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
    
    
    

    
    
    
    textField.text=@"";

    return YES;
}

-(void)dismissKeyboard {
    [self.addedItemTextField resignFirstResponder];
}






- (IBAction)clearAddedItemsButton:(UIButton *)sender {
    
    [self.userAddedItems removeAllObjects];
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:USER_ADDED_SECTION];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];

    [prefs setObject:self.userAddedItems forKey:@"userAddedItems"];
    [prefs synchronize];
    
}





-(void) getIngredientsFromList: (GroceryList*) groceryList{
    self.produceItems=groceryList.produceIngredients;
    self.proteinItems=groceryList.proteinIngredients;
    self.commonHouseholdItems=groceryList.homeIngredients;
    self.packagedGoodsItems=groceryList.packagedIngredients;
    self.internationalItems=groceryList.internationalIngredients;
    self.dairyAndEggItems=groceryList.dairyAndEggIngredients;
    self.grainItems=groceryList.grainIngredients;
    self.recipeTitles=groceryList.passedRecipeTitles;
}




#pragma mark- Table Configuration





-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == RECIPES_TITLES_IN_LIST_SECTION){
        
    cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.recipeTitles[indexPath.row];
    cell.detailTextLabel.text=nil;
        
    }
    
    
    else {
    
    
        NSDictionary *ingredientDictionary=nil;
        
        if (indexPath.section == USER_ADDED_SECTION) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
            
            ingredientDictionary = [self.userAddedItems objectAtIndex:indexPath.row];
            
            cell.textLabel.text = ingredientDictionary[@"name"];
            cell.detailTextLabel.text =nil;
            
        }else {
            
            if (indexPath.section == PRODUCE_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.produceItems objectAtIndex:indexPath.row];
                
                
            }else if (indexPath.section == MEAT_SEAFOOD_AND_OTHER_PROTEINS_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.proteinItems objectAtIndex:indexPath.row];
                
            }else if (indexPath.section == DAIRY_AND_EGGS_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.dairyAndEggItems objectAtIndex:indexPath.row];
                
            }else if (indexPath.section == GRAINS_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.grainItems objectAtIndex:indexPath.row];
                
            }else if (indexPath.section == CANNED_OR_PACKAGED_GOODS_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.packagedGoodsItems objectAtIndex:indexPath.row];
                
            }else if (indexPath.section == INTERNATIONAL_ITEMS_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.internationalItems objectAtIndex:indexPath.row];
                
            }else if (indexPath.section == ITEMS_YOU_MAY_HAVE_AT_HOME_SECTION){
                
                cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
                
                ingredientDictionary = [self.commonHouseholdItems objectAtIndex:indexPath.row];
                
            }
            
            cell.textLabel.text = ingredientDictionary[@"name"];
            
            if (ingredientDictionary[@"quantityAndUnits"]){
                cell.detailTextLabel.text = ingredientDictionary[@"quantityAndUnits"];
            }
            
            if (ingredientDictionary[@"measurementDescription"]){
                cell.detailTextLabel.text = ingredientDictionary[@"measurementDescription"];
            }

        }
        
        
        
        
    }
    return cell;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)sender{

    return NUMBER_OF_SECTIONS;
    }

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == RECIPES_TITLES_IN_LIST_SECTION){
        cell.backgroundColor=[UIColor orangeColor];
    }
    else {
        cell.backgroundColor=[UIColor whiteColor];
    }
    
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    

    if (section==RECIPES_TITLES_IN_LIST_SECTION) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        rowToSelect = nil;
    }
    
	return rowToSelect;
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    
    switch (section){
        case USER_ADDED_SECTION:
            if ([self.userAddedItems count]>0){
                title = @"Your Added Items";
            }
            break;
            
        case RECIPES_TITLES_IN_LIST_SECTION:
            if ([self.recipeTitles count]>0){
                title = [NSString stringWithFormat:@"Chosen Recipes (requested serving size:%@)", self.desiredServingSize];
            }
            break;
            
        case PRODUCE_SECTION:
            if ([self.produceItems count]>0){
                title = @"Produce";
            }
            break;
    
        case MEAT_SEAFOOD_AND_OTHER_PROTEINS_SECTION:
            if ([self.proteinItems count]>0){
                title = @"Meat, Seafood, and other Proteins";
            }
            break;
    
        case DAIRY_AND_EGGS_SECTION:
          if ([self.dairyAndEggItems count]>0){
                title = @"Dairy and Eggs";
            }
            break;
            
        case GRAINS_SECTION:
            if ([self.grainItems count]>0){
                title = @"Grains";
            }
            break;
    
        case CANNED_OR_PACKAGED_GOODS_SECTION:
           if ([self.packagedGoodsItems count]>0){
                title = @"Canned and Packaged Goods";
            }
            break;
    
        case INTERNATIONAL_ITEMS_SECTION:
            if ([self.internationalItems count]>0){
                title = @"International Items";
            }
            break;
            
        case ITEMS_YOU_MAY_HAVE_AT_HOME_SECTION:
            if ([self.commonHouseholdItems count]>0){
                title = @"Items You Might Have at Home";
            }
            break;

        default:
            break;
    }
    
    return title;
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i=0;
    
    switch (section){
        case USER_ADDED_SECTION:
            if ([self.userAddedItems count]){
                i = [self.userAddedItems count];
            }
            break;
            
        case RECIPES_TITLES_IN_LIST_SECTION:
            if ([self.recipeTitles count]){
                i = [self.recipeTitles count];
            }
            break;
            
        case PRODUCE_SECTION:
            if ([self.produceItems count]){
                i = [self.produceItems count];
            }
            break;
            
        case MEAT_SEAFOOD_AND_OTHER_PROTEINS_SECTION:
            if ([self.proteinItems count]){
                i = [self.proteinItems count];
            }
            break;
            
        case DAIRY_AND_EGGS_SECTION:
            if ([self.dairyAndEggItems count]){
                i = [self.dairyAndEggItems count];
            }
            break;
            
        case GRAINS_SECTION:
            if ([self.grainItems count]){
                i = [self.grainItems count];
            }
            break;
            
        case CANNED_OR_PACKAGED_GOODS_SECTION:
            if ([self.packagedGoodsItems count]){
                i = [self.packagedGoodsItems count];
            }
            break;
            
        case INTERNATIONAL_ITEMS_SECTION:
            if ([self.internationalItems count]){
                i = [self.internationalItems count];
            }
            break;
            
        case ITEMS_YOU_MAY_HAVE_AT_HOME_SECTION:
            if ([self.commonHouseholdItems count]){
                i = [self.commonHouseholdItems count];
            }
            break;
            
        default:
            break;
    }
    
    return i;

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];

    

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    self.tableView.allowsMultipleSelection=YES;
    
    
    
    
    
    
    
    TimeSavorAppDelegate *testAppDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [testAppDelegate managedObjectContext];
    
    
    NSError *error;
    [context save:&error];
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    prefs = [NSUserDefaults standardUserDefaults];
    NSArray *chosenRecipeTitlesFromUserDefaults=[prefs arrayForKey:@"chosenRecipes"];
    NSMutableArray *chosenRecipeTitlesToRecipes=[[NSMutableArray alloc] init];
    
    
    for (Recipe *recipe in fetchedObjects) {
        if ([chosenRecipeTitlesFromUserDefaults containsObject:recipe.title]){
            [chosenRecipeTitlesToRecipes addObject:recipe];
        }
        
    }
    
    
    
    
    GroceryList *groceryList=[[GroceryList alloc] init];
    
    if (chosenRecipeTitlesToRecipes){
        groceryList.recipeList=[[NSMutableArray alloc] initWithArray:chosenRecipeTitlesToRecipes];
    }
    
    prefs = [NSUserDefaults standardUserDefaults];
    double servingSize=[prefs doubleForKey:@"chosenServingSize"];
    
    self.desiredServingSize=[[NSNumber alloc ]initWithDouble:servingSize];
    
    [groceryList addIngredientsToListWithDesiredServings:self.desiredServingSize];
    [self getIngredientsFromList:groceryList];
    
    
    
    

    
    NSMutableArray* previousUserAddedItems=[prefs objectForKey:@"userAddedItems"];
    self.userAddedItems=previousUserAddedItems;
    

    
    [self.tableView reloadData];

    






    

    
}



-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    if (appDelegate.newRecipesPicked==YES){
        
        GroceryList *groceryList=[[GroceryList alloc] init];
        
        groceryList.recipeList= appDelegate.userChosenRecipes;
        

        double servingSize=[prefs doubleForKey:@"servingSize"];
        self.desiredServingSize=[[NSNumber alloc ]initWithDouble:servingSize];
        [groceryList addIngredientsToListWithDesiredServings:self.desiredServingSize];
        
        [prefs setDouble:servingSize forKey:@"chosenServingSize"];
        [prefs setBool:YES forKey:@"shouldGenerateGroceryList"];
        [prefs synchronize];
        
        
        [self getIngredientsFromList:groceryList];
        
        appDelegate.newRecipesPicked=NO;
        
        /*
        for (Recipe *recipe in groceryList.recipeList){
            NSLog(@"ingredients for each recipe in recipe list: %@", recipe.ingredients);

            
        }
        */
         
        [self.tableView reloadData];
        
    }
    
    BOOL shouldGenerateGroceryList=[prefs boolForKey:@"shouldGenerateGroceryList"];
    
    if (shouldGenerateGroceryList){
        self.tableView.hidden=NO;
    }
    
    if (!shouldGenerateGroceryList){
        self.tableView.hidden=YES;
    }
    
    
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
