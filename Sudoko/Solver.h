//
//  Solver.h
//  Sudoko
//
//  Created by Paige Garratt on 7/23/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridLogic.h"

@interface Solver : NSObject

-(id) init;
-(int) solvable: (GridLogic*) gModel;

@end
