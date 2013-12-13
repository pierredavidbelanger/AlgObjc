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

#import "AOGraph.h"

#import "AOGraph+Private.h"

#include "directed_graph.h"

@implementation AOGraph

@dynamic vertexCount;
@dynamic edgeCount;

+ (id)alloc
{
    NSAssert(self != [AOGraph class], @"AOGraph should bot be alloc'ed directly, instead use AODirectedGraph.");
    return [super alloc];
}

+ (instancetype)graphWithGraph:(alg::Graph *)graph
{
    return [[self alloc] initWithGraph:graph];
}

- (instancetype)initWithGraph:(alg::Graph *)graph
{
    if (self = [super init])
        _graph = graph;
    return self;
}

- (void)dealloc
{
    delete _graph;
    _graph = NULL;
}

- (AOGraphIndex)vertexCount
{
    return _graph->vertex_count();
}

- (AOGraphIndex)edgeCount
{
    return _graph->edge_count();
}

- (BOOL)addVertex:(AOGraphVertex)vertex
{
    return _graph->add_vertex(vertex);
}

- (void)deleteVertex:(AOGraphVertex)vertex
{
    _graph->delete_vertex(vertex);
}

- (BOOL)addEdgeFromVertex:(AOGraphVertex)source toVertex:(AOGraphVertex)target withWeight:(AOGraphWeight)weight
{
    BOOL r = NO;
    r |= [self addVertex:source];
    r |= [self addVertex:target];
    r |= _graph->add_edge(source, target, weight);
    return r;
}

- (void)deleteEdgeFromVertex:(AOGraphVertex)source toVertex:(AOGraphVertex)target
{
    _graph->delete_edge(source, target);
}

@end

@implementation AODirectedGraph

+ (instancetype)directedGraphRandomizedWithVertexCount:(AOGraphIndex)vertexCount
{
    alg::Graph *graph = alg::DirectedGraph::randgraph(vertexCount);
    return [self graphWithGraph:graph];
}

+ (instancetype)directedGraph
{
    return [[self alloc] init];
}

- (instancetype)init
{
    alg::Graph *graph = new alg::DirectedGraph;
    return [self initWithGraph:graph];
}

- (BOOL)addEdgesBetweenVertex:(AOGraphVertex)source andVertex:(AOGraphVertex)target withWeight:(AOGraphWeight)weight
{
    BOOL r = NO;
    r |= [self addVertex:source];
    r |= [self addVertex:target];
    r |= [self addEdgeFromVertex:source toVertex:target withWeight:weight];
    r |= [self addEdgeFromVertex:target toVertex:source withWeight:weight];
    return r;
}

- (void)deleteEdgesBetweenVertex:(AOGraphVertex)source andVertex:(AOGraphVertex)target
{
    [self deleteEdgeFromVertex:source toVertex:target];
    [self deleteEdgeFromVertex:target toVertex:source];
}

@end
