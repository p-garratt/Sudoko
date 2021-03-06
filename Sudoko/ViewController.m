//
//  ViewController.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "ViewController.h"
#import "Grid.h"
#import "NumPad.h"
#import "GridGenerator.h"
#import "GridLogic.h"
#import "SudokuGenerator.h"
#import "UserLayer.h"

@interface ViewController ()

@end

@implementation ViewController{
    CGSize winSize;
    Grid* sudokuGrid;
    NumPad* sudokuPad;
    GridLogic* logic;
}

//This is the initialization of all needed objects
- (void)viewDidLoad
{
    [super viewDidLoad];
//    GridGenerator* generator = [[GridGenerator alloc] init];
//    NSMutableArray* grid = [[NSMutableArray alloc] initWithArray:[generator getGrid]];
//    logic = [[GridLogic alloc] initWithGrid:grid];
    SudokuGenerator* generator = [[SudokuGenerator alloc] init];
    CGRect theRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*.05);
    UserLayer* user = [[UserLayer alloc] initWithFrame:theRect];
    [user setTarget:self andAction:@selector(clearAll)];
    [self.view addSubview:user];
    logic = [generator generateGrid];
    winSize = self.view.frame.size;
    [self createGrid];
    [self createNumPad];
}

-(void) createGrid {
    CGRect gridSize = CGRectMake(winSize.width*.125, winSize.height*.1, winSize.width*0.75, winSize.width*0.75);
	sudokuGrid = [[Grid alloc] initWithFrame:gridSize andArray:[logic getGrid]];
    [sudokuGrid addTarget:self action:@selector(cellTap:)];
    [self.view addSubview:sudokuGrid];
}

-(void) createNumPad{
    CGRect padSize = CGRectMake(winSize.width*.05, winSize.height*.8, winSize.width*.9, winSize.height*.1);
    sudokuPad = [[NumPad alloc] initWithFrame:padSize];
    [self.view addSubview:sudokuPad];
}

//If a gridCell is tapped this method gets the number to be inserted from numPad,
//changes the currentGrid, and passes the new cell value to the grid
-(void) cellTap: (NSNumber*) cellNum {
    int newNum = [sudokuPad currentNum];
    [sudokuGrid setCell: cellNum.intValue withInt: newNum andCorrect:[logic checkConsistency:cellNum andNumber:newNum]];
    [logic addToGrid:cellNum value:newNum];
    if ([logic gridFull]) {
        NSLog(@"Grid Full");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) clearAll{
    [sudokuGrid clearAll];
}

@end
