Cd(__DIR__);
#include "~/AOC-2025/Common.HC"


#if 0
#define INPUT_FILE "sample.TXT"
#define INP_CAP 1024*2
#else
#define INPUT_FILE "input.TXT"
#define INP_CAP 1024*6
#endif

class Coord {
  I64 x, y;
};

I64 FindMaxRect(Coord *coords, I64 count) {
  I64 i, j, maxRect = 0;
    
  for(i = 0; i < count; i++) {
    for(j = i + 1; j < count; j++) {
      I64 x1 = coords[i].x, y1 = coords[i].y;
      I64 x2 = coords[j].x, y2 = coords[j].y;
           
      I64 width = Abs(x2 - x1)+1;
      I64 height = Abs(y2 - y1) +1;
      I64 area = width * height;
          
      if(area > maxRect) maxRect = area;
    }
  }
    
  return maxRect;
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line; 
    Coord *coords = MAlloc(sizeof(Coord) * INP_CAP);
    I64 count = 0;
 
    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);

      while(line.size > 0){
        I64 x = SVChopI64(&line); SVChopLeft(&line);
        I64 y = SVChopI64(&line); SVChopLeft(&line);
 
        coords[count].x = x;
        coords[count].y = y;
        count++;
      }  
    }

    Free(saved_begin);

    "Part 1: %d\n", FindMaxRect(coords, count);

    Free(coords);
}

Bool IsOnBoundary(I64 x, I64 y, I64 x1, I64 y1, I64 x2, I64 y2) {
  if (y1 == y2) { 
      return y == y1 && x >= Min(x1, x2) && x <= Max(x1, x2);
  } else if (x1 == x2) { 
      return x == x1 && y >= Min(y1, y2) && y <= Max(y1, y2);
  }

  return FALSE;
}

Bool IsInsidePolygon(I64 x, I64 y, Coord *coords, I64 count) {
  I64 i, intersections = 0;

  for(i = 0; i < count; i++) {
    I64 next = (i + 1) % count;
    I64 x1 = coords[i].x, y1 = coords[i].y;
    I64 x2 = coords[next].x, y2 = coords[next].y;

    if(y1 > y2) {
      SwapI64(&x1, &x2);
      SwapI64(&y1, &y2);
    }

    if(IsOnBoundary(x, y, x1, y1, x2, y2)) return TRUE;

    if(y1 == y2) goto skip_iter;

    if(y >= y1 && y < y2 && x < x1) intersections++;
       
    skip_iter:
  }

  return (intersections % 2) == 1;
}

I64 FindMaxGreenRect(Coord *coords, I64 count) {
  I64 i, j, maxRect = 0;

  for(i = 0; i < count; i++) {
    for(j = i + 1; j < count; j++) {
      I64 x1 = coords[i].x, y1 = coords[i].y;
      I64 x2 = coords[j].x, y2 = coords[j].y;
           
      I64 c3_x = x1, c3_y = y2;
      I64 c4_x = x2, c4_y = y1;
           
      if(IsInsidePolygon(c3_x, c3_y, coords, count) && 
        IsInsidePolygon(c4_x, c4_y, coords, count)) {
                
        I64 area = (Abs(x2 - x1) + 1) * (Abs(y2 - y1) + 1);
        if(area > maxRect) maxRect = area;
      }
    }
  }
  
  return maxRect;
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line; 
    Coord *coords = MAlloc(sizeof(Coord) * INP_CAP);
    I64 count = 0;
 
    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      while(line.size > 0){
        coords[count].x = SVChopI64(&line); SVChopLeft(&line);
        coords[count].y = SVChopI64(&line); SVChopLeft(&line);
        count++;
      }  
    }
    Free(saved_begin);

    "Part 2: %d\n", FindMaxGreenRect(coords, count);

    Free(coords);
}

Part1;
Part2;

