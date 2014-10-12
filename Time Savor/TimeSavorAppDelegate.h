//
//  TimeSavorAppDelegate.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSavorAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSNumber *userRequestedNumberOfRecipes;
@property (strong, nonatomic) NSNumber *userRequestedServingSize;

@property (strong, nonatomic) NSMutableArray *userRequestedCuisineChoices;
@property (strong, nonatomic) NSMutableArray *userRequestedDietaryRestrictions;

@property (strong, nonatomic) NSMutableArray *userChosenRecipes;

@property (strong, nonatomic) NSMutableArray *userAllChosenRecipes;

@property (strong, nonatomic) NSMutableArray *userFavoriteRecipes;


@property (nonatomic) BOOL newPlanGenerated;
@property (nonatomic) BOOL newRecipesPicked;


//@property (strong, nonatomic)

-(NSURL *) applicationDocumentsDirectory;



@end
