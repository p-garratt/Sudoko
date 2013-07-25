//
//  NumCell.h
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumCell : UIView

@property(nonatomic, assign) BOOL highlighted;
@property(nonatomic) int num;

-(id)initWithFrame:(CGRect)frame andNum: (int) num andText: (NSString*) text;
-(void) setTarget: (id) targ action: (SEL) select;

@end
