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

#import <SenTestingKit/SenTestingKit.h>

#import "AlgObjc.h"

@interface AlgObjcMemoryTests : SenTestCase

@end

@implementation AlgObjcMemoryTests

- (void)testMemory
{
    AOGrid *grid = [[AOGrid alloc] initWithSize:AOGridSizeMake(10, 10)];
    [grid clearWithValue:0];
    AOAStar *astar = [[AOAStar alloc] initWithGrid:grid];
    [grid release];
    AOAStarResult *astarResult = [astar runFromCell:AOGridCellMake(0, 0) toCell:AOGridCellMake(9, 9)];
    [astar release];
    [astarResult cellCount];
    
    AODirectedGraph *graph = [[AODirectedGraph alloc] init];
    [graph addEdgesBetweenVertex:1 andVertex:2 withWeight:1];
    AODijkstra *dijkstra = [[AODijkstra alloc] initWithGraph:graph fromVertex:1];
    [graph release];
    AODijkstraResult *dijkstraResult = [dijkstra toVertex:2];
    [dijkstra release];
    [dijkstraResult vertexCount];
}

@end
