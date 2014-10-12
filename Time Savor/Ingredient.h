//
//  Ingredient.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/26/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) NSString * usageDescription;
@property (nonatomic, retain) Recipe *inRecipe;

@end
