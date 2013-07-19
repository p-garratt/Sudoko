//
//  Grid.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "Grid.h"
#import "GridCell.h"

@implementation Grid{
    id target;
    SEL selector;
    NSMutableArray* cells;
}

- (id)initWithFrame:(CGRect)frame andArray: (NSArray*) theGrid;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        cells = [[NSMutableArray alloc] init];
        [self createCells: theGrid];
    }
    return self;
}

-(void) createCells: (NSArray*) gridLayout{
    //Calculates the numbers to make the cells look nice
    CGSize gridSize = self.frame.size;
    int width = gridSize.width/12;
    int height = gridSize.height/12;
    
    //Counter to give each cell a unique cellNumber
    int count = 0;
    
    //For loops create the cells, with x and y Offset making sure the spacing is right
    int yOffset = 10;
    
    for (int i=0; i<9; i++) {
        
        int xOffset = 10;
        if (i%3==0)
            yOffset += 10;
        
        for (int j=0; j<9; j++) {
            
            if (j%3==0)
                xOffset += 10;
            
            //Checks against the initial grid to know if cell is initial
            BOOL initial = NO;
            if ([gridLayout[count] intValue] != 0) {
                initial = YES;
            }
            
            //Creates cell and sets all properties
            CGRect cellSize = CGRectMake((width+10)*j+xOffset, (height+10)*i+yOffset, width, height);
            GridCell* cell = [[GridCell alloc] initWithFrame:cellSize andInitial:initial];
            [cell addTarget:self action:@selector(cellTouched:)];
            cell.cellNum = count;
            if ([gridLayout[count] intValue]!=0) {
                [cell setLabel:[gridLayout [count] intValue]];
            }
            
            count++;
            [cells addObject:cell];
            [self addSubview:cell];
        }
    }
}

//target method for if one of the grid cells is tapped, passes on tap to view controller
-(void) cellTouched: (NSNumber*) cellNum{
    [target performSelector:selector withObject:cellNum];
}

//Allows view controller to register as a target
-(void) addTarget: (id) targ action:(SEL)action{
    target = targ;
    selector = action;
}

//Passes through any changes to a cell label
-(void) setCell: (int) cellNum withInt: (int) newNum{
    GridCell* temp = cells[cellNum];
    [temp setLabel:newNum];
}

@end
