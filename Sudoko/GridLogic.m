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

-(BOOL) checkConsistency: (NSNumber*) cellNum andNumber: (int) newNum{
    int colNum = [self calcColumnNum:cellNum.intValue];
    int rowNum = [self calcRowNum:cellNum.intValue];
    NSLog(@"Cell %i, col: %i, row: %i", cellNum.intValue, colNum, rowNum);
    if ([self checkColConsistent:colNum andNumber:newNum] &&
        [self checkRowConsistent:rowNum andNumber:newNum] &&
        [self checkBlockConsistent:rowNum andCol:colNum andNumber:newNum]) {
        [grid replaceObjectAtIndex:cellNum.intValue withObject:[NSNumber numberWithInt:newNum]];
        return YES;
    }
    return NO;
}

-(BOOL) checkColConsistent: (int) col andNumber: (int) newNum{
    for (int i=0; i<80; i++) {
        if (i%9 == col) {
            NSNumber* temp = grid[i];
            if (temp.intValue==newNum)
                return NO;
        }
    }
    return YES;
}

-(BOOL) checkRowConsistent: (int) row andNumber: (int) newNum{
    for (int i=0; i<80; i++) {
        if ((int)floorf(i/9)==row) {
            NSNumber* temp = grid[i];
            if (temp.intValue==newNum) {
                return NO;
            }
        }
    }
    return YES;
}

-(BOOL) checkBlockConsistent: (int) row andCol: (int) col andNumber: (int) newNum{
    int leftTopCorner = (row%3)*9 +col%3*3;
    NSLog(@"corner: %i", leftTopCorner);
    int currentLoc = leftTopCorner;
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            NSNumber* temp = grid[currentLoc];
            if (temp.intValue==newNum) {
                return NO;
            }
            currentLoc++;
        }
        currentLoc +=9;
    }
    return YES;
}

-(int) calcColumnNum: (int) cellNum{
    return cellNum%9;
}

-(int) calcRowNum: (int) cellNum{
    return (int)floorf(cellNum/9);
}

-(BOOL) gridFull{
    for (int i=0; i<grid.count; i++) {
        NSNumber* temp = grid[i];
        if (temp.intValue==0) {
            return NO;
        }
    }
    return YES;
}

@end
