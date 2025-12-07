

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#define INCAP 1024*2
#else
#define INPUT_FILE "input.TXT"
#define INCAP1024*10
#endif

U8 **manifold = MAlloc(sizeof(U8)*INCAP *INCAP);
I64 **memo = MAlloc(sizeof(I64)*INCAP *INCAP);

U0 PrintManifold(I64 h, I64 w) {
  I64 i, j;

  for(i = 0; i < h; i++){
    for(j = 0; j < w; j++){
      "%c ", manifold[i*INCAP +j];
    } '\n';  
  } '\n';
}

I64 NumberOfSplits(I64 h, I64 w) {
  I64 i, j, total_splits = 0;

  for(i = 0; i < h; i++){
    for(j = 0; j < w; j++){
      if(manifold[i*INCAP +j] == 'S'|| 
        (i>0 && manifold[(i-1)*INCAP +j] == '|' &&manifold[i*INCAP +j] == '.')) { 
        manifold[(i+1)*INCAP +j] = '|';
      }

      if(i > 0&& manifold[(i-1)*INCAP +j] == '|' && manifold[i*INCAP + j] == '^') { 
        if(j>0) manifold[(i+1)*INCAP +(j-1)] = '|';
        if(j< w-1) manifold[(i+1)*INCAP+(j+1)] = '|';
        total_splits++; 
      }
    }   
  }

  //PrintManifold(h, w);

  return total_splits;
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    I64 i, w = 0, h = 0;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);

      w = line.size;
      for(i = 0; i <w; i++) {
        manifold[h*INCAP +i] = line.begin[0];
        SVChopLeft(&line);
      } h++;
        
    }

    Free(saved_begin);

    //PrintManifold(h, w);

    "Part 1:%d\n", NumberOfSplits(h, w);
}

I64 CountTimelines(I64 i, I64 j, I64 h, I64 w) {
    I64 sum_timelines;

    if(i >= h || j < 0 || j >= w) return 1;
    
    if(memo[i*INCAP + j] != -1) return memo[i*INCAP + j];
    
    if(manifold[i*INCAP + j] == '^') {
      I64 left_timelines = CountTimelines(i+1, j-1, h, w);
      I64 right_timelines = CountTimelines(i+1, j+1, h, w);
        sum_timelines = left_timelines + right_timelines;
    } else {
      sum_timelines = CountTimelines(i+1, j, h, w);
    }
    
    memo[i*INCAP + j] = sum_timelines;
    
    return sum_timelines;
}

I64 NumberOfAlternatedTimelines(I64 h, I64 w) {
    I64 i, j, start_i = -1, start_j = -1;
    
    for(i = 0; i < h; i++) {
      for(j = 0; j < w; j++) {
        memo[i*INCAP + j] = -1;
      }
    }
    
    for(i = 0; i < h; i++) {
      for(j = 0; j < w; j++) {
        if(manifold[i*INCAP + j] == 'S') {
          start_i = i, start_j = j;
          break;
        }
      }
      if(start_i != -1) break;
    }
    
    I64 alt_timelines = CountTimelines(start_i+1, start_j, h, w);

    Free(memo);
    
    return alt_timelines;
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    I64 i, w = 0, h = 0;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);

      w = line.size;
      for(i = 0; i <w; i++) {
        manifold[h*INCAP +i] = line.begin[0];
        SVChopLeft(&line);
      } h++;
        
    }

    Free(saved_begin);

    //PrintManifold(h, w);

    "Part 2:%d\n", NumberOfAlternatedTimelines(h, w);
}


Part1;
Part2;

