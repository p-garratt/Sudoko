//
//  GridCell.h
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCell : UIView

@property(nonatomic) int cellNum;

- (id)initWithFrame:(CGRect)frame andInitial: (BOOL) initialTerm;
-(void) setLabel: (int) newNum;
-(void) addTarget: (id) targ action:(SEL)action;

@end
