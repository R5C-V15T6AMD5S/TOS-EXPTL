

Cd(__DIR__);
#include "~/AOC-2024/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

#define MR 1024

I64 levels[MR];

Bool is_safe(I64 *levels, I64 count) {
  if(count <2) return 0;

  I64 i, diff = 0;
  Bool incr = (levels[1]>levels[0]), cons = 1;

  for(i=1; i<count; ++i){
    diff = levels[i] - levels[i-1];

    if(Abs(diff) < 1 ||Abs(diff)>3){ cons = 0; break; }
    if((incr &&diff<0)|| (!incr&&diff>0)) { cons = 0; break; }
  } 

  return cons;
}

Bool found_safe(I64 *levels, I64 count) {
  Bool found_safe = 0;
  I64 i, j;

  for(i=0; i<count; ++i) {
    I64 tmp_levels[MR], tmp_count = 0;
   
    for(j=0; j<count; ++j) if(j != i) tmp_levels[tmp_count++] = levels[j];

    if(is_safe(tmp_levels, tmp_count)) {
      found_safe = 1;
      break;
    }
  }

  return found_safe;
}

U0 Part1() {
    SV sv, line;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    I64 count, safe_cnt = 0;

    while(sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      count = 0;

      while(line.size > 1) levels[count++] = SVChopI64(&line);

      if(is_safe(levels, count)) safe_cnt++;
    }

    "\nPart 1:%d\n", safe_cnt;

    Free(saved_begin);
}

U0 Part2() {
    SV sv, line;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    I64 count, safe_cnt = 0;

    while(sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      count = 0;

      while(line.size > 1) levels[count++] = SVChopI64(&line);

      if(found_safe(levels, count)) safe_cnt++;
    }   

    "\nPart 2: %d\n\n", safe_cnt;

    Free(saved_begin);
}

Part1;
Part2;

