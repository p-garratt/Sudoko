//
//  NumCell.m
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "NumCell.h"

@implementation NumCell{
    UILabel* numDisplay;
    id target;
    SEL selector;
}


- (id)initWithFrame:(CGRect)frame andNum: (int) num andText: (NSString*) text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.num = num;
        self.highlighted = NO;
        CGRect labelSize = CGRectMake(0, 0, frame.size.width, frame.size.height+1);
        numDisplay = [[UILabel alloc] initWithFrame:labelSize];
        numDisplay.text = [NSString stringWithFormat:text];
        numDisplay.textAlignment = NSTextAlignmentCenter;
        numDisplay.font = [UIFont fontWithName:@"Helvetica" size:36];
        [self addSubview:numDisplay];
    }
    return self;
}

//Handles the color display
-(void) setHighlighted:(BOOL)highlighted{
    if (highlighted) 
        numDisplay.backgroundColor = [UIColor yellowColor];
    else
        numDisplay.backgroundColor = [UIColor whiteColor];
}

//When touches began, performs the registered action
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (target!=nil) 
        [target performSelector:selector withObject:self];
}

//Allows a target to register an action for later use
-(void) setTarget: (id) targ action: (SEL) select {
    target = targ;
    selector = select;
}


@end
