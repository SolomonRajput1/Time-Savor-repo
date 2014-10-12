//
//  Ingredient.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Grocery_List, Recipe;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSString * foodType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) Recipe *inRecipe;
@property (nonatomic, retain) Grocery_List *inList;

@end
