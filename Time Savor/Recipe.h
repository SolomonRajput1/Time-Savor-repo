//
//  Recipe.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/26/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ingredient;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * cuisine;
@property (nonatomic, retain) NSArray * dietaryRestrictions;
@property (nonatomic, retain) NSString * imageDescription;
@property (nonatomic, retain) NSArray * instructions;
@property (nonatomic, retain) NSNumber * servingSize;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *ingredients;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;

@end
