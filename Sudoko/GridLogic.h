//
//  GridLogic.h
//  Sudoko
//
//  Created by Paige Garratt on 7/18/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridLogic : NSObject

-(id) initWithGrid: (NSMutableArray*) newGrid;
-(BOOL) checkConsistency: (NSNumber*) cellNum andNumber: (int) newNum;
-(BOOL) gridFull;

@end
