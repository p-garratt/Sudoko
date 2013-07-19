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

@interface ViewController ()

@end

@implementation ViewController{
    CGSize winSize;
    Grid* sudokuGrid;
    NumPad* sudokuPad;
    NSMutableArray* grid;
    GridLogic* logic;
}

//This is the initialization of all needed objects
- (void)viewDidLoad
{
    [super viewDidLoad];
    GridGenerator* generator = [[GridGenerator alloc] init];
    grid = [[NSMutableArray alloc] initWithArray:[generator getGrid]];
    logic = [[GridLogic alloc] initWithGrid:grid];
    winSize = self.view.frame.size;
    [self createGrid];
    [self createNumPad];
}

-(void) createGrid {
    CGRect gridSize = CGRectMake(winSize.width*.125, winSize.height*.1, winSize.width*0.75, winSize.width*0.75);
	sudokuGrid = [[Grid alloc] initWithFrame:gridSize andArray:grid];
    [sudokuGrid addTarget:self action:@selector(cellTap:)];
    [self.view addSubview:sudokuGrid];
}

-(void) createNumPad{
    CGRect padSize = CGRectMake(winSize.width*.125, winSize.height*.8, winSize.width*.75, winSize.height*.1);
    sudokuPad = [[NumPad alloc] initWithFrame:padSize];
    [self.view addSubview:sudokuPad];
}

//If a gridCell is tapped this method gets the number to be inserted from numPad,
//changes the currentGrid, and passes the new cell value to the grid
-(void) cellTap: (NSNumber*) cellNum {
    int newNum = [sudokuPad currentNum];
    if ([logic checkConsistency:cellNum andNumber:newNum])
        [sudokuGrid setCell: cellNum.intValue withInt: newNum];
    if ([logic gridFull]) {
        UILabel* winLabel = [[UILabel alloc] initWithFrame:self.view.frame];
        winLabel.text = @"You Won!!";
        winLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
        winLabel.backgroundColor = [UIColor redColor];
        winLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:winLabel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
