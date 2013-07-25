//
//  Solver.m
//  Sudoko
//
//  Created by Paige Garratt on 7/23/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "Solver.h"

@implementation Solver

-(id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/*
 -1 = NO
 0 = MAYBE
 1 = YES
 */
-(int) solvable: (GridLogic*) copyGrid{
    //GridLogic* copyGrid = [[GridLogic alloc] initWithGrid:[gModel getGrid]];
    int found1 = 0;
    int found2 = 0;
    do {
        found1 = [self heuristic1:copyGrid];
        found2 = [self heuristic2:copyGrid];
        if (found1<0 || found2<0) {
            return -1;
        }
    } while ((found1+found2) > 0);
    if ([copyGrid gridFull]) 
        return 1;
    else
        return 0;
}

-(int) heuristic1: (GridLogic*) gModel{
    int found = 0;
    for (int i=0; i<81; i++) {
        if ([gModel getCellValue:[NSNumber numberWithInt:i]]==0) {
            NSMutableArray* options = [self options:gModel forCell:i];
            if (options.count==0)
                return -1;
            else if (options.count==1){
                found++;
                [gModel addToGrid:[NSNumber numberWithInt:i] value:[[options objectAtIndex:0] intValue]];
            }
        }
    }
    return found;
}

-(NSMutableArray*) options:(GridLogic*) gModel forCell: (int) cellNum{
    NSMutableArray* option = [[NSMutableArray alloc] init];
    for (int i=1; i<10; i++) {
        if ([gModel checkConsistency:[NSNumber numberWithInt:cellNum] andNumber:i]) {
            [option addObject:[NSNumber numberWithInt:i]];
        }
    }
    return option;
}

-(int) heuristic2: (GridLogic*) gModel{
    int found = 0;
    int count = 1;
    for (int i=0; i<81; i+=3) {
        NSMutableArray* block = [gModel getBLock:[NSNumber numberWithInt:i]];
        NSMutableArray* empty = [[NSMutableArray alloc] init];
        for (int k=0; k<block.count; k++){
            if ([gModel getCellValue:block[k]]==0) {
                [empty addObject:block[k]];
            }
        }
        for (int j=1; j<=9; j++) {
            NSMutableArray* copy = [[NSMutableArray alloc] initWithArray:empty copyItems:YES];
            for (int l=0; l<copy.count; l++) {
                if (![gModel checkConsistency:copy[l] andNumber:j]) {
                    [copy removeObjectAtIndex:l];
                }
            }
            if (copy.count==0)
                return -1;
            else if (copy.count==1) {
                [gModel addToGrid:copy[0] value:j];
                [empty removeObject:copy[0]];
                found++;
            }
        }
        if (count%3==0) {
            i += 21;
        }
        count++;
    }
    return found;
}

@end
