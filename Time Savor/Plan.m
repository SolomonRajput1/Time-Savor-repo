//
//  Plan.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/18/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "Plan.h"
#import "Recipe.h"

@implementation Plan

-(void)createPlan{
    
    
    
    //cycle through the number of recipes to choose from
        //cycle through all of the cuisine preferences in the array of submitted cuisine preferences
            //cycle through all of the recipes in the master list
                //Declare BOOL *matchesAllDietaryRestrictions
                //cycle through all of the dietary restrictions
                    //If the recipe dietary restriction array includes the current dietary restriction
                        //BOOL=yes
                    //ELSE
                        //BOOL=NO
                //If the recipe category matches the cuisine preference && if *matchesAllDietaryRestrictions
                    //add the recipe to the array of applicable recipes

    //THEN.
    
    //Cycle through the number of recipes to choose from
        //pick a number at random in the range of the length of the array of applicable recipes
        //insert the recipe at that index into our chosen recipe array
    

    
    
    NSMutableArray *selectedRecipes=[[NSMutableArray alloc] init];
    NSMutableArray *allApplicableRecipesToChoseFrom= [[NSMutableArray alloc] init];
    
        for (NSString *selectedCuisine in self.cuisinePreferences){
            
            for (Recipe *recipe in self.masterRecipeList){
                
                BOOL matchesAllDietaryRestrictions;
                
                if ([self.dietaryRestrictions count]){
                    
                    matchesAllDietaryRestrictions=NO;
                
                    for (NSString *dietaryRestrictionPreference in self.dietaryRestrictions){
                    
                        if ([recipe.dietaryRestrictions containsObject:dietaryRestrictionPreference]){
                            matchesAllDietaryRestrictions=YES;
                        }
                        else{
                            matchesAllDietaryRestrictions=NO;
                            break;
                        }
                    
                    }
                    
                }else {
                    matchesAllDietaryRestrictions=YES;
                }

                if ([recipe.cuisine isEqualToString:selectedCuisine] && matchesAllDietaryRestrictions){
                        [allApplicableRecipesToChoseFrom addObject:recipe];
                   
                }
                    
            }
            
        }
        

    
    
    
    NSMutableArray *shuffledApplicableRecipes = [[NSMutableArray alloc] initWithArray:allApplicableRecipesToChoseFrom];
    NSUInteger count = [shuffledApplicableRecipes count];
    for (NSUInteger i = 0; i < count; i++) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [shuffledApplicableRecipes exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    
    self.otherRecipesThatMatchPreferences= [[NSMutableArray alloc] initWithArray:allApplicableRecipesToChoseFrom];
    
    for (int i=0; i<[self.numberOfRecipesToPlan intValue]; i++){

        if (i<[shuffledApplicableRecipes count]){
            [selectedRecipes addObject:shuffledApplicableRecipes[i]];
            
            [self.otherRecipesThatMatchPreferences removeObject:shuffledApplicableRecipes[i]];

            
        }
        

        
    }
    
    
    self.chosenRecipes=selectedRecipes;
    
}










@end
