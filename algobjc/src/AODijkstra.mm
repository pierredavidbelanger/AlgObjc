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

#import "AODijkstra.h"

#import "AOGraph.h"
#import "AOGraph+Private.h"

#include "dijkstra.h"

@interface AODijkstraResult ()
{
    AOGraphIndex _count;
    AOGraphVertex *_path;
}

+ (instancetype)dijkstraResultWithCount:(AOGraphIndex)count andPath:(AOGraphVertex *)path;

- (instancetype)initWithCount:(AOGraphIndex)count andPath:(AOGraphVertex *)path;

@end

@interface AODijkstra ()
{
    AOGraph *_graph;
    AOGraphVertex _source;
    alg::HashTable<int32_t, int32_t> *_result;
}

@end

@implementation AODijkstraResult

+ (instancetype)dijkstraResultWithCount:(AOGraphIndex)count andPath:(AOGraphVertex *)path
{
    return [[self alloc] initWithCount:count andPath:path];
}

- (instancetype)initWithCount:(AOGraphIndex)count andPath:(AOGraphVertex *)path
{
    if (self = [super init]) {
        _count = count;
        _path = path;
    }
    return self;
}

- (void)dealloc
{
    delete [] _path;
    _path = NULL;
}

- (AOGraphIndex)vertexCount
{
    return _count;
}

- (AOGraphVertex)vertexAtIndex:(AOGraphIndex)index
{
    return _path[index];
}

@end

@implementation AODijkstra

+ (instancetype)dijkstraWithGraph:(AOGraph *)graph fromVertex:(AOGraphVertex)source
{
    return [[self alloc] initWithGraph:graph fromVertex:source];
}

- (instancetype)initWithGraph:(AOGraph *)graph fromVertex:(AOGraphVertex)source
{
    if (self = [super init]) {
        _graph = graph;
        _source = source;
        _result = alg::Dijkstra::run(*graph->_graph, source);
    }
    return self;
}

- (void)dealloc
{
    delete _result;
    _result = NULL;
}

- (AODijkstraResult *)toVertex:(AOGraphVertex)target
{
    // TODO: simplify this method
    AOGraphVertex previous = target;
    AOGraphIndex count = 0;
    BOOL found = NO;
    while (previous != alg::Dijkstra::UNDEFINED) {
        found |= previous == _source;
        count++;
        if (count > _graph->_graph->vertex_count())
            break;
        previous = (*_result)[previous];
    }
    AOGraphVertex *path;
    if (found) {
        path = new AOGraphVertex[count];
        AOGraphIndex i = count;
        previous = target;
        while (previous != alg::Dijkstra::UNDEFINED) {
            path[--i] = previous;
            previous = (*_result)[previous];
        }
    } else {
        count = 0;
        path = new AOGraphVertex[0];
    }
    return [AODijkstraResult dijkstraResultWithCount:count andPath:path];
}

@end
