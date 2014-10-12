//
//  TimeSavorAppDelegate.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/8/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "TimeSavorAppDelegate.h"
#import <HockeySDK/HockeySDK.h>

@implementation TimeSavorAppDelegate

@synthesize managedObjectContext= _managedObjectContext;
@synthesize managedObjectModel= _managedObjectModel;
@synthesize persistentStoreCoordinator= _persistentStoreCoordinator;

@synthesize userRequestedNumberOfRecipes=_userRequestedNumberOfRecipes;
@synthesize userRequestedServingSize=_userRequestedServingSize;
@synthesize userRequestedCuisineChoices=_userRequestedCuisineChoices;
@synthesize userRequestedDietaryRestrictions=_userRequestedDietaryRestrictions;

@synthesize userChosenRecipes=_userChosenRecipes;

@synthesize userAllChosenRecipes=_userAllChosenRecipes;

@synthesize userFavoriteRecipes=_userFavoriteRecipes;

@synthesize newPlanGenerated=_newPlanGenerated;
@synthesize newRecipesPicked=_newRecipesPicked;


NSUserDefaults *prefs;

-(NSMutableArray *) userAllChosenRecipes{
    if (!_userAllChosenRecipes) _userAllChosenRecipes=[[NSMutableArray alloc] init];
    return _userAllChosenRecipes;
}

-(NSMutableArray *) userFavoriteRecipes{
    if (!_userFavoriteRecipes) _userFavoriteRecipes=[[NSMutableArray alloc] init];
    return _userFavoriteRecipes;
}




#pragma mark - Core Data stack

/*
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/*
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"RecipeJSONConverter.sqlite"];
    
  
    NSError *error=nil;
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
    
    
    
    /*
     Set up the store.
     For the sake of illustration, provide a pre-populated default store.
     */
 
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]]) {
        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"RecipeJSONConverter" withExtension:@"sqlite"];
        if (defaultStoreURL) {
            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
        }
    }
     

    
    _persistentStoreCoordinator= [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


#pragma mark - Application's documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}







#pragma mark- Methods that came with the app delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"73fd437ea9991cfb30b135322b60713b"];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator
     authenticateInstallation];
     
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    double servingSize=[prefs doubleForKey:@"servingSize"];

    
    self.userFavoriteRecipes;
    
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
