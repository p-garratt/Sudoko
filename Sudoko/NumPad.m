//
//  NumPad.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "NumPad.h"
#import "NumCell.h"

@implementation NumPad{
    NSMutableArray* numCells;
    NumCell* currentCell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        numCells = [[NSMutableArray alloc] init];
        [self createPad];
        currentCell = numCells[0];
        self.currentNum = currentCell.num;
        currentCell.highlighted = YES;
    }
    return self;
}

-(void) createPad{
    //NumPad Cells
    int width = (self.frame.size.width-105)/12;
    for (int i=0; i<9; i++) {
        CGRect cellSize = CGRectMake((width+10)*i+10, self.frame.size.height*.1, width, self.frame.size.height*.8);
        NumCell* cell = [[NumCell alloc] initWithFrame:cellSize andNum: i+1 andText:[NSString stringWithFormat:@"%i", i+1]];
        [cell setTarget:self action:@selector(newHighlight:)];
        [self addSubview:cell];
        [numCells addObject: cell];
    }
    CGRect eraseRect = CGRectMake((width+10)*9+10, self.frame.size.height*.1, width*3, self.frame.size.height*.8);
    NumCell* erase = [[NumCell alloc] initWithFrame:eraseRect andNum:0 andText:@"ERASE"];
    [erase setTarget:self action:@selector(newHighlight:)];
    [self addSubview:erase];
    [numCells addObject:erase];
}

//When a new cell is highlighed, the last is unhilighted, the new one is highlighted and the currentNum is changed
-(void) newHighlight: (id) sender{
    currentCell.highlighted = NO;
    currentCell = sender;
    self.currentNum = currentCell.num;
    currentCell.highlighted = YES;
}

@end
