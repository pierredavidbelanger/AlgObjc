# AlgObjc

Objective-C wrapper for [xtaci/algorithms](https://github.com/xtaci/algorithms)'s Grid/AStar and Graph/Dijkstra.

AlgObjc is available under the MIT license. See the LICENSE file for more info.

## Install

Clone this repository.

The code for this project compile to a static library for iOS or OS X.

The easiest way to add this library to a project is by using the [_Xcode_ sub-project method](http://www.cocoanetics.com/2011/12/sub-projects-in-xcode/):

 - From the _Finder_, drag the `algobjc.xcodeproj` _Xcode_ project file into your project `Frameworks` group in _Xcode_.
 - Into the _Build Phases Target Dependencies_ of your project target: add the target `algobjc-[ios or osx]`.
 - Into the _Build Phases Link Binary With Libraries_ of your project target: add the lib `libalgobjc-[ios or osx].a` and `libc++.dylib`.
 - Into the _Build Settings User Header Search Path_ of your project target: add the relative path to this project's `algobjc/include` folder.

## Usage

### Grid (2D array) structure and A* (AStar) algorithms

```objc
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
```

### Graph (DirectedGraph) structure and Dijkstra algorithms

![image](http://upload.wikimedia.org/wikipedia/commons/5/57/Dijkstra_Animation.gif)

_Image soure: [Dijkstra's algorithm on Wikipedia](http://en.wikipedia.org/wiki/Dijkstra's_algorithm)_

```objc
- (void)testGraphAndDijkstraUsage
{
    // This example came from Wikipedia Dijkstra's algorithm page
    // http://en.wikipedia.org/wiki/Dijkstra's_algorithm
    
    // Create the digraph
    AODirectedGraph *graph = [AODirectedGraph directedGraph];
    
    // Add the bidirectional edges (vertices are added automatically when needed)
    [graph addEdgesBetweenVertex:1 andVertex:2 withWeight:7];
    [graph addEdgesBetweenVertex:1 andVertex:3 withWeight:9];
    [graph addEdgesBetweenVertex:1 andVertex:6 withWeight:14];
    [graph addEdgesBetweenVertex:2 andVertex:3 withWeight:10];
    [graph addEdgesBetweenVertex:2 andVertex:4 withWeight:15];
    [graph addEdgesBetweenVertex:3 andVertex:6 withWeight:2];
    [graph addEdgesBetweenVertex:3 andVertex:4 withWeight:11];
    [graph addEdgesBetweenVertex:4 andVertex:5 withWeight:6];
    [graph addEdgesBetweenVertex:5 andVertex:6 withWeight:9];
    
    // Init the Dijkstra algorithm using the digraph and starting from vertex 1
    AODijkstra *dijkstra = [AODijkstra dijkstraWithGraph:graph fromVertex:1];
    
    // Get the path to vertex 5
    AODijkstraResult *result = [dijkstra toVertex:5];
    
    // Assert that the solution is a 4 vertices path and go from vertex 1 to 3 to 6 than to 5
    STAssertEquals(result.vertexCount, (AOGraphIndex)4, @"Solution should have a path of 4 vertices");
    STAssertEquals([result vertexAtIndex:0], (AOGraphVertex)1, @"Solution's vertex 0 should be 1");
    STAssertEquals([result vertexAtIndex:1], (AOGraphVertex)3, @"Solution's vertex 1 should be 3");
    STAssertEquals([result vertexAtIndex:2], (AOGraphVertex)6, @"Solution's vertex 2 should be 6");
    STAssertEquals([result vertexAtIndex:3], (AOGraphVertex)5, @"Solution's vertex 3 should be 5");
}
```

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
