//
//  Plan.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Plan : NSManagedObject

@property (nonatomic, retain) NSNumber * recipeDisplayNumber;
@property (nonatomic, retain) NSSet *planRecipes;
@end

@interface Plan (CoreDataGeneratedAccessors)

- (void)addPlanRecipesObject:(NSManagedObject *)value;
- (void)removePlanRecipesObject:(NSManagedObject *)value;
- (void)addPlanRecipes:(NSSet *)values;
- (void)removePlanRecipes:(NSSet *)values;

@end
