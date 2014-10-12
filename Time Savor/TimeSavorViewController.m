//
//  TimeSavorViewController.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "TimeSavorViewController.h"
#import "TimeSavorAppDelegate.h"
#import "Ingredient.h"
#import "InstructionTableViewCell.h"
#import "DynamicHeightTableViewCell.h"

@interface TimeSavorViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *ingredients;

@property (strong, nonatomic)NSMutableArray *name;
@property (strong, nonatomic)NSMutableArray *phone;

@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) InstructionTableViewCell *prototypeCell;
@property (nonatomic, strong) DynamicHeightTableViewCell *dynamicPrototypeCell;

@end

@implementation TimeSavorViewController





- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setUpIngredients];
    
    [self setUpUI];
    
}

#pragma mark- setUp


- (InstructionTableViewCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"InstructionsCell"];
    }
    return _prototypeCell;
}


- (DynamicHeightTableViewCell *)dynamicPrototypeCell
{
    if (!_dynamicPrototypeCell)
    {
        _dynamicPrototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"DynamicHeightCell"];
    }
    return _dynamicPrototypeCell;
}





-(void) setUpUI
{
    
    self.navigationItem.title = self.recipe.title;
    
    self.timeLabel.textAlignment=NSTextAlignmentCenter;
    self.timeLabel.text=[NSString stringWithFormat:@"%@ minutes", self.recipe.time];
    
    self.recipeImage.contentMode=UIViewContentModeScaleAspectFit;
    
    
    
    NSString *imageNameJPG= [NSString stringWithFormat:@"%@.jpg",self.recipe.imageDescription];
    NSString *imageNameJPEG= [NSString stringWithFormat:@"%@.jpeg",self.recipe.imageDescription];
    
    if ([UIImage imageNamed:imageNameJPG]){
        self.recipeImage.image=[UIImage imageNamed:imageNameJPG];
    }
    else if ([UIImage imageNamed:imageNameJPEG]){
        self.recipeImage.image=[UIImage imageNamed:imageNameJPEG];
    }

}


-(void) setUpIngredients {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedIngredients = [[NSMutableArray alloc] initWithArray:[self.recipe.ingredients allObjects]];
	[sortedIngredients sortUsingDescriptors:sortDescriptors];
	self.ingredients = sortedIngredients;
    
    [self.tableView reloadData];
}


#pragma mark- Table Configuration

// table's section indexes
#define INGREDIENTS_SECTION      0
#define INSTRUCTIONS_SECTION     1

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == INGREDIENTS_SECTION) {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicHeightCell" forIndexPath:indexPath];
    
        Ingredient *ingredient = [self.ingredients objectAtIndex:indexPath.row];
        
        [self configureIngredientCell:cell forRowAtIndexPath:indexPath forIngredient:ingredient];
        
        /*
        cell.textLabel.text = ingredient.name;
        
        if (!ingredient.usageDescription){
            if (ingredient.units){
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", ingredient.quantity, ingredient.units];
            }
            if (!ingredient.units){
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", ingredient.quantity];
            }
            
        }else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", ingredient.usageDescription];
        }
        */
        
        
    
        
    }else if (indexPath.section == INSTRUCTIONS_SECTION){
        

        InstructionTableViewCell *instructionCell = [tableView dequeueReusableCellWithIdentifier:@"InstructionsCell" forIndexPath:indexPath];
        
        [self configureInstructionCell:instructionCell forRowAtIndexPath:indexPath];
        
        cell=instructionCell;
        
        /*NSString *instructionText = [self.recipe.instructions objectAtIndex:indexPath.row];
        
    */
    }

     return cell;
}

    
- (void)configureInstructionCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[InstructionTableViewCell class]])
    {
        InstructionTableViewCell *textCell = (InstructionTableViewCell *)cell;
        textCell.instructionCellLabel.text = [self.recipe.instructions objectAtIndex:indexPath.row];
        textCell.instructionCellLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

- (void)configureIngredientCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath forIngredient: (Ingredient*)ingredient
{
    if ([cell isKindOfClass:[DynamicHeightTableViewCell class]])
    {
        DynamicHeightTableViewCell *textCell = (DynamicHeightTableViewCell *)cell;
        
        textCell.mainTextLabel.text = ingredient.name;
        textCell.mainTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        
        if (!ingredient.usageDescription){
            if (ingredient.units){
                textCell.subTextLabel.text = [NSString stringWithFormat:@"%@ %@", ingredient.quantity, ingredient.units];
            }
            if (!ingredient.units){
               textCell.subTextLabel.text = [NSString stringWithFormat:@"%@", ingredient.quantity];
            }
            
        }else {
            textCell.subTextLabel.text = [NSString stringWithFormat:@"%@", ingredient.usageDescription];
        }
        
         textCell.subTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        
    }
}
    

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    
    Ingredient *ingredient = [self.ingredients objectAtIndex:indexPath.row];
    
    if (indexPath.section==INGREDIENTS_SECTION){
        //height=tableView.rowHeight;
        [self configureIngredientCell:self.dynamicPrototypeCell forRowAtIndexPath:indexPath forIngredient:ingredient];
        [self.dynamicPrototypeCell layoutIfNeeded];
        
        CGSize size = [self.dynamicPrototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        height= size.height+1;
        
        
        
        
    }
    
    if(indexPath.section==INSTRUCTIONS_SECTION){
        [self configureInstructionCell:self.prototypeCell forRowAtIndexPath:indexPath];
        [self.prototypeCell layoutIfNeeded];
        
        CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        height= size.height+1;
        
    }

    return height;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)sender{
    return 2;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    
    // return a title or nil as appropriate for the section
    switch (section) {
        case INGREDIENTS_SECTION:
            title = @"Ingredients";
            break;
        case INSTRUCTIONS_SECTION:
            title = [NSString stringWithFormat:@"Instructions for %@ servings", self.recipe.servingSize];
            break;
        default:
            break;
    }
    
    return title;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger i;
    
    // return a title or nil as appropriate for the section
    switch (section) {
        case INGREDIENTS_SECTION:
            i = self.recipe.ingredients.count;
            break;
        case INSTRUCTIONS_SECTION:
            i = [self.recipe.instructions count];
            break;
        default:
            break;
    }
    
    return i;

}



#pragma mark-testing


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection=YES;
    
    self.navigationController.navigationBarHidden=NO;

    /*
    TimeSavorAppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [appDelegate managedObjectContext];
    
    Recipe *testRecipe;
    
    Ingredient *testIngredient1;
    Ingredient *testIngredient2;
    Ingredient *testIngredient3;
    
    testRecipe= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [testRecipe setValue: @"Ginger Snaps!" forKey:@"title"];
    [testRecipe setValue: [UIImage imageNamed:@"dice"] forKey:@"image"];
    [testRecipe setValue: @25 forKey:@"time"];
    [testRecipe setValue: @[@"step1: cut the cheese", @"step2: eat the cheese", @"step 3: poop the cheese"] forKey:@"instructions"];
    [testRecipe setValue: @4 forKey:@"servingSize"];
   

    
    testIngredient1=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient1 setValue: @"Cheddar" forKey:@"name"];
    [testIngredient1 setValue:@34 forKey:@"quantity"];
    [testIngredient1 setValue:@"cores" forKey:@"units"];
    
    
    testIngredient2=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient2 setValue: @"Cheddar" forKey:@"name"];
    [testIngredient2 setValue:@46 forKey:@"quantity"];
    [testIngredient2 setValue:@"pits" forKey:@"units"];
    
    testIngredient3=[NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
    [testIngredient3 setValue: @"soy sauce" forKey:@"name"];
    [testIngredient3 setValue:@4 forKey:@"quantity"];
    [testIngredient3 setValue:@"berries" forKey:@"units"];
    
    
    
    NSSet *testIngredients= [[NSSet alloc] initWithObjects:testIngredient1, testIngredient2, testIngredient3, nil];
    
    testRecipe.ingredients=testIngredients;
    self.recipe=testRecipe;

    NSError *error;
    [context save:&error];
    [self.tableView reloadData];
     */
    
    

}









/*
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 
 
 self.name= [[NSMutableArray alloc] init];
 self.phone=[[NSMutableArray alloc] init];
 
 TimeSavorAppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
 NSManagedObjectContext *context= [appDelegate managedObjectContext];
 NSEntityDescription *entityDesc= [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:context];
 NSFetchRequest *request= [[NSFetchRequest alloc] init];
 [request setEntity:entityDesc];
 NSPredicate *pred= [NSPredicate predicateWithFormat:@"(title= %@)", self.recipe.title];
 [request setPredicate:pred];
 NSManagedObject *matches= nil;
 
 NSError *error;
 NSArray *objects = [context executeFetchRequest:request
 error:&error];
 
 if ([objects count]==0)
 {
 NSLog(@"No matches");
 }
 else {
 for (int i=0; i<[objects count]; i++)
 {
 matches=objects [i];
 [self.name addObject:[matches valueForKey:@"title"]];
 [self.name addObject:[matches valueForKey:@"photoData"]];
 }
 }
 
 // Do any additional setup after loading the view, typically from a nib.
 }
 
 */








/*
- (IBAction)add:(id)sender {
    TimeSavorAppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context= [appDelegate managedObjectContext];

    NSManagedObject *newContact;
    newContact= [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [newContact setValue: @"Vea Software" forKey:@"title"];
    [self.name addObject:@"Vea Software"];
    [newContact setValue:@"(555555)" forKey:@"photoData"];
    [self.phone addObject:@"(55555555)"];
    NSError *error;
    [context save:&error];
    [self.tableView reloadData];
    
    
}
 
 

#pragma Table View

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.name.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID= @"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=[self.name objectAtIndex:indexPath.row];
    return cell;
}


*/









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
