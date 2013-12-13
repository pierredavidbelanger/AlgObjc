# AlgObjc

Objective-C wrapper for [xtaci/algorithms](https://github.com/xtaci/algorithms)'s Grid/AStar and Graph/Dijkstra.

AlgObjc is available under the MIT license. See the LICENSE file for more info.

## Usage

### Grid (2D array) structure and A* (AStar) algorithms

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

## License

AlgObjc

Created by Pierre-David Bélanger <pierredavidbelanger@gmail.com>
Copyright (c) 2013 PjEr.ca. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
