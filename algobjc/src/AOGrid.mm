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

#import "AOGrid.h"

#import "AOGrid+Private.h"

@implementation AOGrid

@dynamic size;

+ (instancetype)gridWithSize:(AOGridSize)size
{
    return [[self alloc] initWithSize:size];
}

- (instancetype)initWithSize:(AOGridSize)size
{
    if (self = [super init])
        _grid = new alg::Array2D<AOGridValue>(size.row, size.col);
    return self;
}

- (void)dealloc
{
    delete _grid;
    _grid = NULL;
}

- (AOGridSize)size
{
    return AOGridSizeMake(_grid->row(), _grid->col());
}

- (void)clearWithValue:(AOGridValue)value
{
    return _grid->clear(value);
}

- (AOGridValue)valueAtCell:(AOGridCell)cell
{
    return (*_grid)(cell.row, cell.col);
}

- (void)setValue:(AOGridValue)value atCell:(AOGridCell)cell
{
    (*_grid)(cell.row, cell.col) = value;
}

@end
