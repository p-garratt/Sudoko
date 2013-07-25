//
//  GridCell.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "GridCell.h"

@implementation GridCell{
    UILabel* numDisplay;
    id target;
    SEL selector;
}

- (id)initWithFrame:(CGRect)frame andInitial: (BOOL) initialTerm
{
    self = [super initWithFrame:frame];
    if (self) {
        self.initial = initialTerm;
        self.backgroundColor = [UIColor whiteColor];
        CGRect labelSize = CGRectMake(0, 0, frame.size.width, frame.size.height+1);
        numDisplay = [[UILabel alloc] initWithFrame:labelSize];
        numDisplay.text = [NSString stringWithFormat:@""];
        numDisplay.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numDisplay];
    }
    return self;
}

//If the cell is an initial cell, a touch does nothing, otherwise selector is performed
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.initial) {
        [target performSelector:selector withObject:[NSNumber numberWithInt: self.cellNum]];
    }
}

//controls label for the initial values
-(void) setLabel: (int) newNum{
    numDisplay.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    numDisplay.text = [NSString stringWithFormat:@"%i", newNum];
    if (newNum==0) {
        numDisplay.text = [NSString stringWithFormat:@""];
    }
}

-(void) setLabel:(int)newNum andCorrect: (BOOL) correct{
    numDisplay.font = [UIFont fontWithName:@"Helvetica" size:20];
    if (correct) 
        numDisplay.textColor = [UIColor blackColor];
    else
        numDisplay.textColor = [UIColor redColor];
    
    numDisplay.text = [NSString stringWithFormat:@"%i", newNum];
}

//Allows a class to register as the target for cells
-(void) addTarget: (id) targ action:(SEL)action{
    target= targ;
    selector = action;
}

@end
