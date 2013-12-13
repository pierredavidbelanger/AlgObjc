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

typedef unsigned int AOGraphIndex;

typedef unsigned int AOGraphVertex;

typedef int AOGraphWeight;

@interface AOGraph : NSObject

@property (readonly) AOGraphIndex vertexCount;
@property (readonly) AOGraphIndex edgeCount;

- (BOOL)addVertex:(AOGraphVertex)vertex;
- (void)deleteVertex:(AOGraphVertex)vertex;

- (BOOL)addEdgeFromVertex:(AOGraphVertex)source toVertex:(AOGraphVertex)target withWeight:(AOGraphWeight)weight;
- (void)deleteEdgeFromVertex:(AOGraphVertex)source toVertex:(AOGraphVertex)target;

@end

@interface AODirectedGraph : AOGraph

+ (instancetype)directedGraphRandomizedWithVertexCount:(AOGraphIndex)vertexCount;

+ (instancetype)directedGraph;

- (instancetype)init;

- (BOOL)addEdgesBetweenVertex:(AOGraphVertex)source andVertex:(AOGraphVertex)target withWeight:(AOGraphWeight)weight;
- (void)deleteEdgesBetweenVertex:(AOGraphVertex)source andVertex:(AOGraphVertex)target;

@end
