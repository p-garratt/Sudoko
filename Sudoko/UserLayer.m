//
//  UserLayer.m
//  Sudoko
//
//  Created by Paige Garratt on 7/22/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import "UserLayer.h"

@implementation UserLayer{
    id target;
    SEL selector;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Clear All Button
        CGRect rect = CGRectMake(10, 10, self.frame.size.width/6, self.frame.size.height);
        UIButton* clear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        clear.frame = rect;
        [clear setTitle:@"Clear All" forState:UIControlStateNormal];
        [clear addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clear];
    }
    return self;
}

-(void) buttonPress{
    [target performSelector:selector];
}

-(void) setTarget: (id) targ andAction: (SEL) action{
    target = targ;
    selector = action;
}



@end
