//
//  Plan.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/18/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plan : NSObject

@property (strong, nonatomic) NSNumber *numberOfRecipesToPlan;
@property (strong, nonatomic) NSArray *dietaryRestrictions;
@property (strong, nonatomic) NSArray *cuisinePreferences;

@property (strong, nonatomic) NSMutableArray *chosenRecipes; //of Recipes
@property (strong, nonatomic) NSMutableArray *otherRecipesThatMatchPreferences; //of Recipes

@property (strong, nonatomic) NSArray *masterRecipeList;

-(void) createPlan;

@end
