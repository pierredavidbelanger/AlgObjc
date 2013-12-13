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

@interface AlgObjcTests : SenTestCase

@end

@implementation AlgObjcTests

- (void)testGridAndAStarUsage
{
    // Make a 2 row x 3 col grid.
    // All cells will be initialized to a weight of 1, except:
    // - cell (0,1) have a weight of 3
    // - cell (1,2) have a wall (infinity weight)
    //
    //   | 0 | 1 | 2 |
    // --+---+---+---+
    // 0 | 1 | 3 | 1 |
    // --+---+---+---+
    // 1 | 1 | 1 | W |
    // --+---+---+---+
    //
    // Search a path from (0,0) to (0,2):
    //
    //   | 0 | 1 | 2 |
    // --+---+---+---+
    // 0 |(1)| 3 |(1)|
    // --+---+---+---+
    // 1 | 1 | 1 | W |
    // --+---+---+---+
    //
    // Will find this solution (0,0) -> (1,1) -> (0,2):
    //
    //   | 0 | 1 | 2 |
    // --+---+---+---+
    // 0 |(1)| 3 |(1)|
    // --+---+---+---+
    // 1 | 1 |(1)| W |
    // --+---+---+---+
    //
    
    // Create the 2 row x 3 col grid
    AOGrid *grid = [AOGrid gridWithSize:AOGridSizeMake(2, 3)];
    
    // Clear all grid's cells to a weight of 1
    [grid clearWithValue:1];
    
    // Set cell (0,1) to a weight of 3
    [grid setValue:3 atCell:AOGridCellMake(0, 1)];
    
    // Set cell (1,2) to a wall (infinity weight)
    [grid setValue:AOGridValueWall atCell:AOGridCellMake(1, 2)];
    
    // Init the A* algorithm using the grid
    AOAStar *astar = [AOAStar aStarWithGrid:grid];
    
    // Search a path from (0,0) to (0,2)
    AOAStarResult *result = [astar runFromCell:AOGridCellMake(0, 0) toCell:AOGridCellMake(0, 2)];
    
    // Assert that the solution is a 3 cells path and go from (0,0) to (1,1) than to (0,2)
    STAssertEquals(result.cellCount, (AOGraphIndex)3, @"Solution should have a path of 3 cells");
    STAssertEquals([result cellAtIndex:0], AOGridCellMake(0, 0), @"Solution's cell 0 should be (0,0)");
    STAssertEquals([result cellAtIndex:1], AOGridCellMake(1, 1), @"Solution's cell 1 should be (1,1)");
    STAssertEquals([result cellAtIndex:2], AOGridCellMake(0, 2), @"Solution's cell 2 should be (0,2)");
}

- (void)test_Grid_init
{
    AOGrid *grid = [AOGrid gridWithSize:AOGridSizeMake(2, 100)];
    [grid clearWithValue:1];
    [grid setValue:2 atCell:AOGridCellMake(0, 0)];
    [grid setValue:AOGridValueWall atCell:AOGridCellMake(1, 1)];
    STAssertEquals(grid.size, AOGridSizeMake(2, 100), @"Size should be 2,100");
    STAssertEquals([grid valueAtCell:AOGridCellMake(0, 0)], (AOGridValue)2, @"Value at 0,0 should be 2");
    STAssertEquals([grid valueAtCell:AOGridCellMake(1, 1)], AOGridValueWall, @"Value at 1,1 should be AOGridValueWall");
    STAssertEquals([grid valueAtCell:AOGridCellMake(1, 2)], (AOGridValue)1, @"Value at 1,2 should be 1");
    AOAStar *astar = [AOAStar aStarWithGrid:grid];
    AOAStarResult *result = [astar runFromCell:AOGridCellMake(0, 0) toCell:AOGridCellMake(1, 99)];
    for (AOGridIndex r = 0; r < result.cellCount; r++) {
        AOGridCell cell = [result cellAtIndex:r];
        NSLog(@"cell row:%d col:%d", cell.row, cell.col);
    }
}

- (void)test_Graph_init
{
    AOGraph *graph = [AODirectedGraph directedGraph];
    [graph addVertex:1];
    [graph addVertex:2];
    [graph addVertex:3];
    [graph addVertex:4];
    [graph addVertex:5];
    [graph addEdgeFromVertex:1 toVertex:2 withWeight:1];
    [graph addEdgeFromVertex:2 toVertex:3 withWeight:1];
    [graph addEdgeFromVertex:3 toVertex:4 withWeight:1];
    [graph addEdgeFromVertex:4 toVertex:3 withWeight:2];
    [graph addEdgeFromVertex:4 toVertex:5 withWeight:1];
    [graph addEdgeFromVertex:5 toVertex:4 withWeight:2];
    [graph addEdgeFromVertex:5 toVertex:1 withWeight:1];
    AODijkstra *dijkstra = [AODijkstra dijkstraWithGraph:graph fromVertex:2];
    AODijkstraResult *result = [dijkstra toVertex:4];
    for (AOGraphIndex v = 0; v < [result vertexCount]; v++) {
        NSLog(@"%d", [result vertexAtIndex:v]);
    }
}

@end
