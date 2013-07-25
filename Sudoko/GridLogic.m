//
//  GridLogic.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "GridLogic.h"

@implementation GridLogic{
    NSMutableArray* grid;
}

-(id) initWithGrid: (NSMutableArray*) newGrid{
    self = [super init];
    if (self) {
        grid = [[NSMutableArray alloc] initWithArray:newGrid];
    }
    return self;
}

//The overarching check consistency method
-(BOOL) checkConsistency: (NSNumber*) cellNum andNumber: (int) newNum{
    int colNum = [self calcColumnNum:cellNum.intValue];
    int rowNum = [self calcRowNum:cellNum.intValue];
    if ([self checkColConsistent:colNum andNumber:newNum] &&
        [self checkRowConsistent:rowNum andNumber:newNum] &&
        [self checkBlockConsistent: cellNum andNumber:newNum]) {
        return YES;
    }
    return NO;
}

//Helper function to check consistency to check the columns
-(BOOL) checkColConsistent: (int) col andNumber: (int) newNum{
    //Finds all cells that have the same %9 as the current cell
    for (int i=0; i<grid.count; i++) {
        if (i%9 == col) {
            NSNumber* temp = grid[i];
            if (temp.intValue==newNum)
                return NO;
        }
    }
    return YES;
}

//Helper function to check consistency in the rows
-(BOOL) checkRowConsistent: (int) row andNumber: (int) newNum{
    for (int i=0; i<9; i++) {
        NSNumber* temp = grid[row*9+i];
        if (temp.intValue==newNum) {
            return NO;
            
        }
    }
    return YES;
}

//Helper function to check the blocks
-(BOOL) checkBlockConsistent: (NSNumber*) cellNum andNumber: (int) newNum{
    NSMutableArray* block = [self getBLock:cellNum];
    for (int i=0; i<block.count; i++) {
        NSNumber* temp = block[i];
        if (temp.intValue==newNum) {
            return NO;
        }
    }
    return YES;
}

//Helper function to calculate the column
-(int) calcColumnNum: (int) cellNum{
    return cellNum%9;
}

//Helper function to calculate the row
-(int) calcRowNum: (int) cellNum{
    return (int)floorf(cellNum/9);
}

//Checks if the grid is full, if there are any more 0s
-(BOOL) gridFull{
    for (int i=0; i<grid.count; i++) {
        NSNumber* temp = grid[i];
        if (temp.intValue==0) {
            return NO;
        }
    }
    return YES;
}

-(void) setToBlank: (NSNumber*) cellNum{
    [grid replaceObjectAtIndex:[cellNum intValue] withObject:[NSNumber numberWithInt:0]];
}

-(NSMutableArray*) getGrid{
    return grid;
}

-(int) getCellValue: (NSNumber*) cellNum{
    NSAssert(cellNum.intValue>=0 && cellNum.intValue<81, @"getCellValue out of range");
    return [[grid objectAtIndex:cellNum.intValue] intValue];
}

-(void) addToGrid: (NSNumber*) cellNum value: (int) newNum{
    [grid replaceObjectAtIndex:cellNum.intValue withObject:[NSNumber numberWithInt:newNum]];
}

-(NSMutableArray*) getBLock: (NSNumber* ) cellNum{
    NSMutableArray* theBlock = [[NSMutableArray alloc] init];
    int row = [self calcRowNum:cellNum.intValue];
    int col = [self calcColumnNum:cellNum.intValue];
    int leftTopCorner = (row/3)*27 + (col/3)*3;
    int currentLoc = leftTopCorner;
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            [theBlock addObject:[grid objectAtIndex:currentLoc]];
            currentLoc++;
        }
        currentLoc +=6;
    }
    return theBlock;
}

@end
