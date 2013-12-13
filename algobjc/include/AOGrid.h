//
//  AlgObjc
//
//  Created by Pierre-David Bélanger <pierredavidbelanger@gmail.com>
//  Copyright (c) 2013 PjEr.ca. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

typedef unsigned char AOGridValue;

typedef unsigned int AOGridIndex;

typedef struct {
    AOGridIndex row;
    AOGridIndex col;
} AOGridCell;

typedef AOGridCell AOGridSize;

static inline AOGridCell AOGridCellMake(AOGridIndex row, AOGridIndex col)
{
    AOGridCell v; v.row = row; v.col = col; return v;
}

static inline AOGridSize AOGridSizeMake(AOGridIndex row, AOGridIndex col)
{
    AOGridSize v; v.row = row; v.col = col; return v;
}

@interface AOGrid : NSObject

@property (readonly) AOGridSize size;

+ (instancetype)gridWithSize:(AOGridSize)size;

- (instancetype)initWithSize:(AOGridSize)size;

- (void)clearWithValue:(AOGridValue)value;

- (AOGridValue)valueAtCell:(AOGridCell)cell;

- (void)setValue:(AOGridValue)value atCell:(AOGridCell)cell;

@end
