//
//  Grocery_List.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Grocery_List : NSManagedObject

@property (nonatomic, retain) NSSet *listIngredients;
@end

@interface Grocery_List (CoreDataGeneratedAccessors)

- (void)addListIngredientsObject:(NSManagedObject *)value;
- (void)removeListIngredientsObject:(NSManagedObject *)value;
- (void)addListIngredients:(NSSet *)values;
- (void)removeListIngredients:(NSSet *)values;

@end
