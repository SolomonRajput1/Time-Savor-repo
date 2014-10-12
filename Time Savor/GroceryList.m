//
//  GroceryList.m
//  Time Savor
//
//  Created by Hinnah Rajput on 7/15/14.
//  Copyright (c) 2014 Time Savor. All rights reserved.
//

#import "GroceryList.h"
#import "Recipe.h"
#import "Ingredient.h"


@interface GroceryList ()



@end

@implementation GroceryList

-(NSMutableArray *) ingredientsFromFileParsing{
    if (!_ingredientsFromFileParsing)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"IngredientsSorting" ofType:@"txt"];
            NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            NSArray *lines = [content componentsSeparatedByString:@"\n"];
            
            //Produce; Canned or Packaged Goods; Grains; Dairy and Eggs; Meat, Seafood, and other proteins; Items You May Have at Home; International Items
            
            NSMutableArray *produceParsedArray=[[NSMutableArray alloc] init];
            NSMutableArray *cannedParsedArray=[[NSMutableArray alloc] init];
            NSMutableArray *grainsParsedArray=[[NSMutableArray alloc] init];
            NSMutableArray *dairyParsedArray=[[NSMutableArray alloc] init];
            NSMutableArray *meatParsedArray=[[NSMutableArray alloc] init];
            NSMutableArray *homeParsedArray=[[NSMutableArray alloc] init];
            NSMutableArray *internationalParsedArray=[[NSMutableArray alloc] init];
            
            NSMutableArray *categoriesParsedArray=[[NSMutableArray alloc] init];
            categoriesParsedArray[0]=produceParsedArray;
            categoriesParsedArray[1]=cannedParsedArray;
            categoriesParsedArray[2]=grainsParsedArray;
            categoriesParsedArray[3]=dairyParsedArray;
            categoriesParsedArray[4]=meatParsedArray;
            categoriesParsedArray[5]=homeParsedArray;
            categoriesParsedArray[6]=internationalParsedArray;
            
            
            
            for (NSString *line in lines){
                
                NSString *numberString;
                NSScanner *numberScanner = [NSScanner scannerWithString:line];
                NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456"];
                NSCharacterSet *colon=[NSCharacterSet characterSetWithCharactersInString:@":"];
                
                NSString *ingredientString;
                
                [numberScanner scanUpToCharactersFromSet:colon intoString:&ingredientString];
                [numberScanner scanUpToCharactersFromSet:numbers intoString:NULL];
                [numberScanner scanCharactersFromSet:numbers intoString:&numberString];
                
                int number = [numberString intValue];
                
                /*
                 NSScanner *ingredientScanner = [NSScanner scannerWithString:line];
                 [ingredientScanner scanUpToCharactersFromSet:colon intoString:&ingredientString];
                 */
                
                [categoriesParsedArray[number] addObject:ingredientString];
            }

            
            _ingredientsFromFileParsing=categoriesParsedArray;
        }
    return _ingredientsFromFileParsing;
}

-(NSMutableArray *) produceIngredients{
    if (!_produceIngredients) _produceIngredients=[[NSMutableArray alloc] init];
    return _produceIngredients;
}
-(NSMutableArray *) proteinIngredients{
    if (!_proteinIngredients) _proteinIngredients=[[NSMutableArray alloc] init];
    return _proteinIngredients;
}
-(NSMutableArray *) grainIngredients{
    if (!_grainIngredients) _grainIngredients=[[NSMutableArray alloc] init];
    return _grainIngredients;
}
-(NSMutableArray *) dairyAndEggIngredients{
    if (!_dairyAndEggIngredients) _dairyAndEggIngredients=[[NSMutableArray alloc] init];
    return _dairyAndEggIngredients;
}
-(NSMutableArray *) packagedIngredients{
    if (!_packagedIngredients) _packagedIngredients=[[NSMutableArray alloc] init];
    return _packagedIngredients;
}
-(NSMutableArray *) internationalIngredients{
    if (!_internationalIngredients) _internationalIngredients=[[NSMutableArray alloc] init];
    return _internationalIngredients;
}
-(NSMutableArray *) homeIngredients{
    if (!_homeIngredients) _homeIngredients=[[NSMutableArray alloc] init];
    return _homeIngredients;
}
-(NSMutableArray *) passedRecipeTitles{
    if (!_passedRecipeTitles) _passedRecipeTitles=[[NSMutableArray alloc] init];
    return _passedRecipeTitles;
}











-(NSMutableSet *) produceSet{
    if (!_produceSet) _produceSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[0]];
    return _produceSet;
}
-(NSMutableSet *) packagedSet{
    if (!_packagedSet) _packagedSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[1]];
    return _packagedSet;
}

-(NSMutableSet *) grainSet{
    if (!_grainSet) _grainSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[2]];
    return _grainSet;
}

-(NSMutableSet *) dairyAndEggSet{
    if (!_dairyAndEggSet) {
        _dairyAndEggSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[3]];
    }
    return _dairyAndEggSet;
}

-(NSMutableSet *) proteinSet{
    if (!_proteinSet) {
        _proteinSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[4]];
    }
    return _proteinSet;
}

-(NSMutableSet *) homeSet{
    if (!_homeSet) {
        _homeSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[5]];
    }
    return _homeSet;
}


-(NSMutableSet *) internationalSet{
    if (!_internationalSet) {
        _internationalSet=[[NSMutableSet alloc] initWithArray:self.ingredientsFromFileParsing[6]];
    }
    return _internationalSet;
}

-(NSArray *) allIngredientSets{
    if (!_allIngredientSets) {
        _allIngredientSets=[[NSArray alloc] initWithObjects:self.produceSet, self.packagedSet, self.grainSet,self.dairyAndEggSet,self.proteinSet, self.homeSet,  nil];
    }
    return _allIngredientSets;
}
























-(void) addIngredientsToListWithDesiredServings:(NSNumber*) servings{

    
    for (Recipe *recipe in self.recipeList){
        
        
        [self.passedRecipeTitles addObject:recipe.title];
        
        NSNumber *scalefactor = @([servings floatValue] / [recipe.servingSize floatValue]);
        NSMutableArray *ingredientsArray = [[NSMutableArray alloc] initWithArray:[recipe.ingredients allObjects]];
        for (Ingredient *ingredient in ingredientsArray){
            [self ingredientCategorization:ingredient UsingScaleFactor:scalefactor];
        }
    }
    
}

-(void) ingredientCategorization: (Ingredient*) ingredient UsingScaleFactor:(NSNumber*)scaleFactor{
    
   // NSLog(@"entered ingredientCategorization method");
    //See if ingredient belongs to this category
    // NSLog (@"GroceryList produceSet: %@", [GroceryList produceSet]);
   // NSLog(@"Ingredient name: %@", ingredient.name);
    
    /*
    NSDictionary *ingredientDictionary=[[NSDictionary alloc] init]
    
    
    

    
    

    
    
    
    
    for (NSSet* ingredientSet in [GroceryList allIngredientSets]){
        
        if ([ingredientSet member:ingredient.name]){
            
            NSMutableArray* correspondingArray= [self correspondingArrayToSet:ingredientSet];
                
            BOOL found=NO;
                
            for (NSMutableDictionary *arrayIngredient in correspondingArray){
                    
                if([arrayIngredient[@"name"] isEqualToString:ingredient.name]){
                    
                    NSNumber *newQuantity = @([ingredient.quantity floatValue] * [scaleFactor floatValue]);
                    
                    arrayIngredient[@"quantityAndUnits"]=[arrayIngredient[@"quantityAndUnits"] stringByAppendingFormat:@" + %@ %@", newQuantity, ingredient.units];
                    found=YES;
                    break;
                    
                    }

                }
                if (!found){
                    
                    NSNumber *newQuantity = @([ingredient.quantity floatValue] * [scaleFactor floatValue]);
                    
                    NSString *quantityAndUnits=[[NSString alloc] initWithFormat:@"%@ %@", newQuantity, ingredient.units];
                    NSMutableDictionary *ingredientDescriptor =[NSMutableDictionary
                                                                dictionaryWithDictionary:@{
                                                                                           @"name" : ingredient.name,
                                                                                           @"quantityAndUnits" : quantityAndUnits
                                                                                           }];
     
                    [correspondingArray addObject:ingredientDescriptor];
                }
            
            
        }
        
    }
     
     */
    
    
    
    for (NSSet* ingredientSet in self.allIngredientSets){
        
        if ([ingredientSet member:ingredient.name]){
            
            NSMutableArray* correspondingArray= [self correspondingArrayToSet:ingredientSet];
            
            BOOL found=NO;
            
            for (NSMutableDictionary *arrayIngredient in correspondingArray){
                
                if([arrayIngredient[@"name"] isEqualToString:ingredient.name]){
                    
                    
                    NSNumber *newQuantity = @([ingredient.quantity floatValue] * [scaleFactor floatValue]);
                    
                    
                    //Purposefully circumventing the case where there are two ingredients with the same name but one doesn't have a numerical value
                    //and the other does.  For example, one recipe had Kosher salt "to taste", while the other one had Kosher salt "0.25 Tsp".
                    //Now, it'll just show up as "O.25 Tsp", which isn't a very good solution but oh well, not much time right now.
                    
                    if(arrayIngredient[@"quantityAndUnits"]){
                    
                        if (ingredient.units){
                            arrayIngredient[@"quantityAndUnits"]=[arrayIngredient[@"quantityAndUnits"] stringByAppendingFormat:@" + %@ %@", newQuantity, ingredient.units];
                        } else if (!ingredient.units){
                             arrayIngredient[@"quantityAndUnits"]=[arrayIngredient[@"quantityAndUnits"] stringByAppendingFormat:@" + %@", newQuantity];
                        }
                        
                    }
                    
                    found=YES;
                    break;
                    
                }
                
            }
            if (!found){
                
                NSNumber *newQuantity = @([ingredient.quantity floatValue] * [scaleFactor floatValue]);
                
                NSString *quantityAndUnits;

                if (!ingredient.usageDescription){
                    if (ingredient.units){
                        quantityAndUnits=[[NSString alloc] initWithFormat:@"%@ %@", newQuantity, ingredient.units];
                    }else if (!ingredient.units){
                        quantityAndUnits=[[NSString alloc] initWithFormat:@"%@", newQuantity];
                    }
                    
                    NSMutableDictionary *ingredientDescriptor =[NSMutableDictionary
                                                                dictionaryWithDictionary:@{
                                                                                           @"name" : ingredient.name,
                                                                                           @"quantityAndUnits" : quantityAndUnits
                                                                                           }];
                    [correspondingArray addObject:ingredientDescriptor];
                    
                }else {
                    
                    
                    NSMutableDictionary *ingredientDescriptorWithoutQuantity =[NSMutableDictionary
                                                                dictionaryWithDictionary:@{
                                                                                           @"name" : ingredient.name,
                                                                                           @"measurementDescription" : ingredient.usageDescription
                                                                                           }];
                    [correspondingArray addObject:ingredientDescriptorWithoutQuantity];
                }
                
                
            }
            
            
        }
        
    }

    
    
}


-(NSMutableArray *) correspondingArrayToSet:(NSSet*) ingredientSet{
    
    NSMutableArray *array;
    
    if ([ingredientSet isEqualToSet: self.produceSet]){
        array= self.produceIngredients;
    }
    
    if ([ingredientSet isEqualToSet: self.proteinSet]){
        array=  self.proteinIngredients;
    }
    
    if ([ingredientSet isEqualToSet: self.packagedSet]){
        array= self.packagedIngredients;
    }
    
    if ([ingredientSet isEqualToSet: self.grainSet]){
        array= self.grainIngredients;
    }
    
    if ([ingredientSet isEqualToSet: self.dairyAndEggSet]){
        array= self.dairyAndEggIngredients;
    }
    
    if ([ingredientSet isEqualToSet: self.internationalSet]){
        array= self.internationalIngredients;
    }
    
    if ([ingredientSet isEqualToSet: self.homeSet]){
        array= self.homeIngredients;
    }
    
    return array;
    
}





/*

-(NSMutableArray *) correspondingArrayToSet:(NSSet*) ingredientSet{
    
    NSMutableArray *array;
    
    if ([ingredientSet isEqualToSet: [GroceryList produceSet]]){
        array= self.produceIngredients;
    }
    
    if ([ingredientSet isEqualToSet: [GroceryList proteinSet]]){
        array=  self.proteinIngredients;
    }
    
    if ([ingredientSet isEqualToSet: [GroceryList packagedGoodsSet]]){
        array= self.packagedIngredients;
    }
    
    if ([ingredientSet isEqualToSet: [GroceryList grainSet]]){
        array= self.grainIngredients;
    }
    
    if ([ingredientSet isEqualToSet: [GroceryList dairyAndEggsSet]]){
        array= self.dairyAndEggIngredients;
    }
    
    if ([ingredientSet isEqualToSet: [GroceryList internationalSet]]){
        array= self.internationalIngredients;
    }
    
    if ([ingredientSet isEqualToSet: [GroceryList homeSet]]){
        array= self.homeIngredients;
    }

    return array;
    
}
 */



+(NSArray *) allIngredientSets {
    
    NSArray *allIngredients=[[NSArray alloc] initWithObjects: [GroceryList produceSet], [GroceryList proteinSet], [GroceryList dairyAndEggsSet], [GroceryList grainSet], [GroceryList packagedGoodsSet], [GroceryList internationalSet], [GroceryList homeSet], nil];
    return allIngredients;
}



+ (NSSet*)produceSet {
    

    NSSet *produceIngredients=[[NSSet alloc] initWithObjects:@"Carrots", nil];
    return produceIngredients;
    
};

+ (NSSet*)proteinSet {
    
    NSSet *proteinIngredients = [[NSSet alloc] initWithObjects:@"Chicken", @"Fish", @"Tofu", @"Tilapia", nil];
    return proteinIngredients;
    
};

+ (NSSet*)dairyAndEggsSet {
    
    NSSet *dairyAndEggIngredients = [[NSSet alloc] initWithObjects:@"Cheddar", @"parmesan", @"eggs", @"cheese", nil];
    return dairyAndEggIngredients;
    
};

+ (NSSet*)grainSet {
    
    NSSet *grainIngredients = [[NSSet alloc] initWithObjects:@"pasta", @"quinoa", @"spaghetti", @"bread", nil];
    return grainIngredients;
    
};

+ (NSSet*)packagedGoodsSet {
    
    NSSet *packagedGoodsIngredients = [[NSSet alloc] initWithObjects:@"tomato sauce", @"black beans", @"pinto beans", @"cumin powder", nil];
    return packagedGoodsIngredients;
    
};

+ (NSSet*)internationalSet {
    
    NSSet *internationalIngredients = [[NSSet alloc] initWithObjects:@"soy sauce", @"fish sauce", @"curry powder", nil];
    return internationalIngredients;
    
};


+ (NSSet*)homeSet {
    
    NSSet *homeIngredients = [[NSSet alloc] initWithObjects:@"salt", @"pepper", @"olive oil", nil];
    return homeIngredients;
    
};



//properties are mutuabale arrays of all the different category types 

//passed in an array of recipes
//for each of the recipes, it gets all of the ingredients
//it checks what category each ingredient belongs to by seeing if that ingredient's name is present in that category's set
//for the category it belongs to, it checks an array dedicated to that category to see if that ingredient is already present
  //if the array has the ingredient already, then it appends that ingredient's amount to the ingredient in the array
  // if the array doesn't have the ingredient, then it adds it to the array


@end
