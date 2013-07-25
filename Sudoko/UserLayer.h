//
//  UserLayer.h
//  Sudoko
//
//  Created by Paige Garratt on 7/22/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLayer : UIView

-(id)initWithFrame:(CGRect)frame;
-(void) setTarget: (id) targ andAction: (SEL) action;

@end
