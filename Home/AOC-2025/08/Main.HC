

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#define MAX_BOXES 1024*2
#define TARGET 10
#else
#define INPUT_FILE "input.TXT"
#define MAX_BOXES 1024*6
#define TARGET 1000
#endif

class Point {
  I64 x, y, z;
};

class Edge {
  I64 box1, box2, distance;
};

class DisjointSet {
  I64 parent, rank, size;
};

U0 init_dsu(DisjointSet *dsu, I64 n) {
  I64 i; 

  for(i = 0; i < n; i++) {
      dsu[i].parent = i;
      dsu[i].rank = 0;
      dsu[i].size = 1;
  }
}

I64 find(DisjointSet *dsu, I64 x) {
  if(dsu[x].parent != x) dsu[x].parent = find(dsu, dsu[x].parent);

  return dsu[x].parent;
}

I64 union_sets(DisjointSet *dsu, I64 x, I64 y) {
  I64 root_x = find(dsu, x);
  I64 root_y = find(dsu, y);
    
  if(root_x == root_y) return 0;
    
  if(dsu[root_x].rank < dsu[root_y].rank) {
      dsu[root_x].parent = root_y;
      dsu[root_y].size += dsu[root_x].size;
  } else if(dsu[root_x].rank > dsu[root_y].rank) {
      dsu[root_y].parent = root_x;
      dsu[root_x].size += dsu[root_y].size;
  } else {
      dsu[root_y].parent = root_x;
      dsu[root_x].size += dsu[root_y].size;
      dsu[root_x].rank++;
  }
  
  return 1;
}

I64 calc_distance(Point *p1, Point *p2) {
  I64 dx = p1->x - p2->x;
  I64 dy = p1->y - p2->y;
  I64 dz = p1->z - p2->z;
    
  return dx*dx + dy*dy + dz*dz;
}

I64 compare_edges(Edge *a, Edge *b) {
  if(a->distance < b->distance) return -1;
  if(a->distance > b->distance) return 1;

  return 0;
}

I64 compare_I64_desc(I64 *a, I64 *b) {
  return (*b - *a);
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    Point boxes[MAX_BOXES];
    I64 num_boxes = 0;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);

      while(line.size>0) {
        boxes[num_boxes].x = SVChopI64(&line); SVChopLeft(&line);
        boxes[num_boxes].y = SVChopI64(&line); SVChopLeft(&line);
        boxes[num_boxes].z = SVChopI64(&line); SVChopLeft(&line);
      } num_boxes++;
    }

    Free(saved_begin);

    I64 max_edges = num_boxes * (num_boxes - 1) / 2;
    Edge *edges = MAlloc(max_edges * sizeof(Edge));
    I64 i, j, edge_count = 0;
    
    for(i = 0; i < num_boxes; i++) {
      for(j = i + 1; j < num_boxes; j++) {
        edges[edge_count].box1 = i;
          edges[edge_count].box2 = j;
          edges[edge_count].distance = calc_distance(&boxes[i], &boxes[j]);
          edge_count++;
      }
    }
    
    QSort(edges, edge_count, sizeof(Edge), &compare_edges);
    
    DisjointSet *dsu = MAlloc(num_boxes * sizeof(DisjointSet));
    init_dsu(dsu, num_boxes);
    
    I64 edges_processed = 0, successful_unions = 0;
    
    for(i = 0; i < edge_count && edges_processed < TARGET; i++) {
      if(union_sets(dsu, edges[i].box1, edges[i].box2)) {
          successful_unions++;
      } edges_processed++;
    }
    
    I64 circuit_sizes[MAX_BOXES], num_circuits = 0;
    I64 visited[MAX_BOXES];
    MemSetI64(visited, 0, MAX_BOXES);
    
    for(i = 0; i < num_boxes; i++) {
      I64 root = find(dsu, i);
      if(!visited[root]) {
        visited[root] = 1;
        circuit_sizes[num_circuits++] = dsu[root].size;
      }
    }
    
    QSort(circuit_sizes, num_circuits, sizeof(I64), &compare_I64_desc);
    
    if(num_circuits >= 3) {
      I64 result = circuit_sizes[0] * circuit_sizes[1] * circuit_sizes[2];
      "Part 1: %d\n", result;
    }
    
    Free(edges);
    Free(dsu);
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    Point boxes[MAX_BOXES];
    I64 num_boxes = 0;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);

      while(line.size>0) {
        boxes[num_boxes].x = SVChopI64(&line); SVChopLeft(&line);
        boxes[num_boxes].y = SVChopI64(&line); SVChopLeft(&line);
        boxes[num_boxes].z = SVChopI64(&line); SVChopLeft(&line);
      } num_boxes++;
    }

    Free(saved_begin);

    I64 max_edges = num_boxes * (num_boxes - 1) / 2;
    Edge *edges = MAlloc(max_edges * sizeof(Edge));
    I64 i, j, edge_count = 0;
    
    for(i = 0; i < num_boxes; i++) {
      for(j = i + 1; j < num_boxes; j++) {
        edges[edge_count].box1 = i;
          edges[edge_count].box2 = j;
          edges[edge_count].distance = calc_distance(&boxes[i], &boxes[j]);
          edge_count++;
      }
    }
    
    QSort(edges, edge_count, sizeof(Edge), &compare_edges);
    
    DisjointSet *dsu = MAlloc(num_boxes * sizeof(DisjointSet));
    init_dsu(dsu, num_boxes);

    I64 edges_processed = 0, successful_unions = 0;
    
    for(i = 0; i < edge_count && edges_processed < TARGET; i++) {
      if(union_sets(dsu, edges[i].box1, edges[i].box2)) {
          successful_unions++;
      } edges_processed++;
    }
    
    init_dsu(dsu, num_boxes);

    I64 last_box1 = -1, last_box2 = -1, unions_made = 0;

    for(i = 0; i < edge_count; i++) {
      if(union_sets(dsu, edges[i].box1, edges[i].box2)) {
	last_box1 = edges[i].box1;
	last_box2 = edges[i].box2;
	unions_made++;

        I64 root = find(dsu, 0);
	if(dsu[root].size == num_boxes) break;
      }
    }

    "Part 2:%d\n", (boxes[last_box1].x * boxes[last_box2].x);
      
    Free(edges);
    Free(dsu);
}

Part1;
Part2;
