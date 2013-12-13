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

#import "AOAStar.h"

#import "AOGrid.h"
#import "AOGrid+Private.h"

#include "astar.h"

const AOGridValue AOGridValueWall = 0xFF;

@interface AOAStarResult ()
{
    alg::AStar::AStarResult *_result;
}

+ (instancetype)aStarResultWithResult:(alg::AStar::AStarResult *)result;

- (instancetype)initWithResult:(alg::AStar::AStarResult *)result;

@end

@interface AOAStar ()
{
    AOGrid *_grid;
    alg::AStar *_astar;
}

@end

@implementation AOAStarResult

@dynamic cellCount;

+ (instancetype)aStarResultWithResult:(alg::AStar::AStarResult *)result
{
    return [[self alloc] initWithResult:result];
}

- (instancetype)initWithResult:(alg::AStar::AStarResult *)result
{
    if (self = [super init])
        _result = result;
    return self;
}

- (void)dealloc
{
    delete _result;
    _result = NULL;
}

- (AOGridIndex)cellCount
{
    return _result->num_nodes;
}

- (AOGridCell)cellAtIndex:(AOGridIndex)index
{
    index = _result->num_nodes - index - 1;
    return AOGridCellMake(_result->path[index * 2 + 1], _result->path[index * 2]);
}

@end

@implementation AOAStar

+ (instancetype)aStarWithGrid:(AOGrid *)grid
{
    return [[self alloc] initWithGrid:grid];
}

- (instancetype)initWithGrid:(AOGrid *)grid
{
    if (self = [super init]) {
        _grid = grid;
        _astar = new alg::AStar(*grid->_grid);
    }
    return self;
}

- (void)dealloc
{
    delete _astar;
    _astar = NULL;
}

- (AOAStarResult *)runFromCell:(AOGridCell)fromCell toCell:(AOGridCell)toCell
{
    alg::AStar::AStarResult *result = _astar->run(fromCell.col, fromCell.row, toCell.col, toCell.row);
    return [AOAStarResult aStarResultWithResult:result];
}

@end
