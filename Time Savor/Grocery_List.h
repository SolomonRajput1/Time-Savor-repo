//
//  Grocery_List.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ingredient;

@interface Grocery_List : NSManagedObject

@property (nonatomic, retain) NSSet *listIngredients;
@end

@interface Grocery_List (CoreDataGeneratedAccessors)

- (void)addListIngredientsObject:(Ingredient *)value;
- (void)removeListIngredientsObject:(Ingredient *)value;
- (void)addListIngredients:(NSSet *)values;
- (void)removeListIngredients:(NSSet *)values;

@end
