//
//  SudokuGenerator.m
//  Sudoko
//
//  Created by Paige Garratt on 7/22/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "SudokuGenerator.h"
#import "Solver.h"

@implementation SudokuGenerator{
    Solver* solve;
}

-(id) init{
    self = [super init];
    if (self) {
        solve = [[Solver alloc] init];
    }
    return self;
}

-(GridLogic*) generateGrid{
    NSMutableArray* grid = [[NSMutableArray alloc] init];
    for (int i=0; i<81; i++) {
        [grid addObject:[NSNumber numberWithInt:0]];
    }
    GridLogic* theLogic = [[GridLogic alloc] initWithGrid:grid];
    if([self fillNextSpace:theLogic andIndex:0]){
        return [self makeGrid:theLogic];
    }
    else
        return nil;
}

-(BOOL) fillNextSpace: (GridLogic*) gModel andIndex: (int) index{
    
    //Base Case
    if (index>=81) {
        return TRUE;
    }
    
    //Generate a random sequence of numbers to chose from
    NSMutableArray* randomSet = [self randomSet:1 andLength:9];
    for (NSNumber* n in randomSet){
        if ([gModel checkConsistency:[NSNumber numberWithInt:index] andNumber:[n intValue]]) {
            [gModel addToGrid:[NSNumber numberWithInt:index] value:[n intValue]];
            index++;
            if ([self fillNextSpace:gModel andIndex:index]) {
                return TRUE;
            }
        }
    }
    [gModel setToBlank:[NSNumber numberWithInt:index]];
    return FALSE;
}

-(GridLogic*) makeGrid: (GridLogic*) gModel{
    NSMutableArray* randomSet = [self randomSet:0 andLength:80];
    for (int i=0; i<81; i++){
        if ([self canBlank:gModel cell:[[randomSet objectAtIndex:i] intValue]])
            [gModel addToGrid:[randomSet objectAtIndex:i] value:0];
    }
    return gModel;
}

-(BOOL) canBlank: (GridLogic*) gModel cell: (int) cellNum{
    GridLogic*  copyGrid = [[GridLogic alloc] initWithGrid:[gModel getGrid]];
    int value = [gModel getCellValue:[NSNumber numberWithInt:cellNum]];
    for (int i = 1; i<10; i++) {
        if (i!=value && [gModel checkConsistency:[NSNumber numberWithInt:cellNum] andNumber:i]) {
            [copyGrid addToGrid:[NSNumber numberWithInt:cellNum] value:i];
            int temp = [solve solvable:copyGrid];
            if (temp==1 || temp==0) {
                return NO;
            }
        }
    }
    return YES;
}

-(NSMutableArray*) randomSet: (int) start andLength: (int) length{
    NSMutableArray* orderedSet = [[NSMutableArray alloc] init];
    for (int i=start; i<=length; i++) {
        [orderedSet addObject:[NSNumber numberWithInt:i]];
    }
    NSMutableArray* randomSet = [[NSMutableArray alloc] init];
    while (orderedSet.count>0) {
        int rand = arc4random()%orderedSet.count;
        [randomSet addObject:[orderedSet objectAtIndex:rand]];
        [orderedSet removeObjectAtIndex:rand];
    }
    return randomSet;
}

@end
