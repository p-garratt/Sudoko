//
//  GridGenerator.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "GridGenerator.h"

@implementation GridGenerator{
    NSArray* grids;
}

-(id) init{
    self = [super init];
    if (self) {
        //Finds the text.txt file with the sudoku grids in it and loads them into an array
        //Note: Grids are seperated by whitespace in the .txt file
        NSString* fileName = [NSString stringWithFormat:@"test.txt"];
        NSString* levelPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        NSError* error;
        NSString* grid = [[NSString alloc] initWithContentsOfFile:levelPath encoding:NSUTF8StringEncoding error:&error];
        grids = [grid componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return self;
}

-(NSMutableArray*) getGrid{
    //Gets a random grid out of grids in the format of a string
    int randGrid = arc4random()%grids.count;
    NSString* newGrid = grids[randGrid];
    
    //Goes through the string, replaces all periods with 0s and loads all the numbers into an NSMutableArray
    NSMutableArray* temp = [[NSMutableArray alloc] init];
    for (int i=0; i<newGrid.length; i++) {
        NSNumber* newNum;
        if ([newGrid characterAtIndex:i] == '.') {
            newNum = [NSNumber numberWithInt:0];
        }else{
            newNum = [NSNumber numberWithChar:([newGrid characterAtIndex:i]-48)];
        }
        [temp addObject:newNum];
    }
    return temp;
}

@end
