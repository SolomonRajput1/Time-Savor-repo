//
//  GroceryList.h
//  Time Savor
//
//  Created by Hinnah Rajput on 7/15/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroceryList : NSObject

@property (nonatomic, strong) NSMutableArray *recipeList; //of Recipe

@property (nonatomic, strong) NSMutableArray *produceIngredients;       //of Ingredient
@property (nonatomic, strong) NSMutableArray *proteinIngredients;       //of Ingredient
@property (nonatomic, strong) NSMutableArray *grainIngredients;         //of Ingredient
@property (nonatomic, strong) NSMutableArray *dairyAndEggIngredients;   //of Ingredient
@property (nonatomic, strong) NSMutableArray *packagedIngredients;      //of Ingredient
@property (nonatomic, strong) NSMutableArray *internationalIngredients; //of Ingredient
@property (nonatomic, strong) NSMutableArray *homeIngredients;          //of Ingredient
@property (nonatomic, strong) NSMutableArray *passedRecipeTitles;       //of String

@property (nonatomic,strong) NSMutableArray *ingredientsFromFileParsing; //of String

@property (nonatomic, strong) NSMutableSet *produceSet;
@property (nonatomic, strong) NSMutableSet *proteinSet;       //of Ingredient
@property (nonatomic, strong) NSMutableSet *grainSet;         //of Ingredient
@property (nonatomic, strong) NSMutableSet *dairyAndEggSet;   //of Ingredient
@property (nonatomic, strong) NSMutableSet *packagedSet;      //of Ingredient
@property (nonatomic, strong) NSMutableSet *internationalSet; //of Ingredient
@property (nonatomic, strong) NSMutableSet *homeSet;          //of Ingredient
@property (nonatomic, strong) NSArray *allIngredientSets;







-(void) addIngredientsToListWithDesiredServings:(NSNumber*) servings;

@end
