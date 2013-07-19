//
//  Grid.h
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Grid : UIView

-(id)initWithFrame:(CGRect)frame andArray: (NSArray*) theGrid;
-(void) addTarget: (id) targ action:(SEL)action;
-(void) setCell: (int) cellNum withInt: (int) newNum;

@end
