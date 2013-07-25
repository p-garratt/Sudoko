//
//  SudokuGenerator.h
//  Sudoko
//
//  Created by Paige Garratt on 7/22/13.
//  Copyright (c) 2013 Paige Garratt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridLogic.h"

@interface SudokuGenerator : NSObject

-(id) init;
-(GridLogic*) generateGrid;


@end
