//
//  Recipe.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Plan, Recipe_Box;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) UNKNOWN_TYPE photoData;
@property (nonatomic, retain) NSSet *recipeIngredients;
@property (nonatomic, retain) Recipe_Box *inBox;
@property (nonatomic, retain) Plan *inPlan;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addRecipeIngredientsObject:(NSManagedObject *)value;
- (void)removeRecipeIngredientsObject:(NSManagedObject *)value;
- (void)addRecipeIngredients:(NSSet *)values;
- (void)removeRecipeIngredients:(NSSet *)values;

@end
