//
//  PreferencesViewController.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/19/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "PreferencesViewController.h"
#import "PlanViewController.h"
#import "TimeSavorAppDelegate.h"

@interface PreferencesViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *preferenceButtons;


@property (weak, nonatomic) IBOutlet UILabel *servingSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealNumberLabel;
@property (weak, nonatomic) IBOutlet UIStepper *servingSizeStepper;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfMealsStepper;
@end

@implementation PreferencesViewController

TimeSavorAppDelegate *appDelegate;
NSUserDefaults *prefs;

- (IBAction)generateNewPlan:(UIButton *)sender {
    
    appDelegate.userRequestedNumberOfRecipes=self.requestedRecipeCount;
    
    appDelegate.userRequestedServingSize=self.requestedServingSize;
    
    appDelegate.userRequestedDietaryRestrictions=self.userDietaryRestrictions;
    
    appDelegate.userRequestedCuisineChoices=self.userCuisinePreferences;
    
    appDelegate.newPlanGenerated=YES;
    
    if ([self.userCuisinePreferences count]){
    
        self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:1];
        
        
        prefs = [NSUserDefaults standardUserDefaults];
        [prefs setDouble:self.servingSizeStepper.value forKey:@"chosenServingSize"];
        [prefs synchronize];
        
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"We have to know what kinds of meals you like first!"
                                                        message:@"Select some of the cuisine choices at the top of the screen."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];

    }

    
}





-(NSMutableArray *) userCuisinePreferences{
    if (!_userCuisinePreferences) _userCuisinePreferences=[[NSMutableArray alloc] init];
    return _userCuisinePreferences;
}

-(NSMutableArray *) userDietaryRestrictions{
    if (!_userDietaryRestrictions) _userDietaryRestrictions=[[NSMutableArray alloc] init];
    return _userDietaryRestrictions;
}





-(NSNumber *) requestedServingSize{
    if (!_requestedServingSize) {
        _requestedServingSize=[[NSNumber alloc] initWithInt:1];
        
        prefs = [NSUserDefaults standardUserDefaults];
        [prefs setDouble:1 forKey:@"servingSize"];
        [prefs synchronize];
        
    }
    return _requestedServingSize;
}
 
 

-(NSNumber *) requestedRecipeCount{
    if (!_requestedRecipeCount) _requestedRecipeCount=[[NSNumber alloc] initWithInt:1];
    return _requestedRecipeCount;
}



- (IBAction)servingSizeStepper:(UIStepper *)sender {
    self.servingSizeLabel.text=[NSString stringWithFormat:@"%f", sender.value];
    
    self.requestedServingSize=[[NSNumber alloc ]initWithDouble:sender.value];
    
    
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setDouble:sender.value forKey:@"servingSize"];
    [prefs synchronize];

}

- (IBAction)numberOfMealsStepper:(UIStepper *)sender {
    self.mealNumberLabel.text=[NSString stringWithFormat:@"%f", sender.value];
    
    self.requestedRecipeCount=[[NSNumber alloc ]initWithDouble:sender.value];
    
    
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setDouble:sender.value forKey:@"numberOfMeals"];
    [prefs synchronize];
    
}



- (IBAction)preferenceButton:(UIButton *)sender {
    
     sender.selected=!sender.selected;
    
    
    
    if ([sender.titleLabel.text isEqual:@"Italian"]  || [sender.titleLabel.text isEqual:@"American"] || [sender.titleLabel.text isEqual:@"Mexican"] || [sender.titleLabel.text isEqual:@"Asian"] || [sender.titleLabel.text isEqual:@"Mediterranean"] || [sender.titleLabel.text isEqual:@"Adventurous"]){
        
        if (sender.selected){
            [self.userCuisinePreferences addObject:sender.titleLabel.text];
        }
        
        if (!sender.selected){
            [self.userCuisinePreferences removeObject:sender.titleLabel.text];
        }
        
        
        prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:self.userCuisinePreferences forKey:@"cuisineChoices"];
        [prefs synchronize];
        
        
    }
    
    
    
    
    if ([sender.titleLabel.text isEqual:@"Vegetarian"]  || [sender.titleLabel.text isEqual:@"Gluten-Free"] || [sender.titleLabel.text isEqual:@"Vegan"]){
        

        
        
        if (sender.selected){
            
            [self.userDietaryRestrictions addObject:sender.titleLabel.text];

        }
        
        if (!sender.selected){
            [self.userDietaryRestrictions removeObject:sender.titleLabel.text];
        }
        
        prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:self.userDietaryRestrictions forKey:@"dietaryRestrictions"];
        [prefs synchronize];
        
    
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    prefs = [NSUserDefaults standardUserDefaults];
    double servingSize=[prefs doubleForKey:@"servingSize"];
    
    double numberOfMeals=[prefs doubleForKey:@"numberOfMeals"];
    NSArray *cuisinePreferences=[prefs arrayForKey:@"cuisineChoices"];
    NSArray *dietaryRestrictions=[prefs arrayForKey:@"dietaryRestrictions"];
    
    
    if (servingSize){
        self.requestedServingSize=[[NSNumber alloc ]initWithDouble:servingSize];
        self.servingSizeLabel.text=[NSString stringWithFormat:@"%f", servingSize];
        self.servingSizeStepper.value=servingSize;
    }
     
    
    if (numberOfMeals){
        self.requestedRecipeCount=[[NSNumber alloc] initWithDouble:numberOfMeals];
        self.mealNumberLabel.text=[NSString stringWithFormat:@"%f", numberOfMeals];
        self.numberOfMealsStepper.value=numberOfMeals;
    }
    
    if (cuisinePreferences){
        
        self.userCuisinePreferences=[[NSMutableArray alloc] initWithArray:cuisinePreferences];
        for (UIButton *button in self.preferenceButtons){
            if ([cuisinePreferences containsObject:button.titleLabel.text]){
                button.selected=YES;
            }
        }
    }
    
    if (dietaryRestrictions){
        self.userDietaryRestrictions=[[NSMutableArray alloc] initWithArray:dietaryRestrictions];
        for (UIButton *button in self.preferenceButtons){
            if ([dietaryRestrictions containsObject:button.titleLabel.text]){
                button.selected=YES;
            }
        }
    }
    
    
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
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
