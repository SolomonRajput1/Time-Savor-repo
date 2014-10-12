//
//  Recipe_Box.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Recipe_Box : NSManagedObject

@property (nonatomic, retain) NSSet *boxRecipes;
@end

@interface Recipe_Box (CoreDataGeneratedAccessors)

- (void)addBoxRecipesObject:(Recipe *)value;
- (void)removeBoxRecipesObject:(Recipe *)value;
- (void)addBoxRecipes:(NSSet *)values;
- (void)removeBoxRecipes:(NSSet *)values;

@end
