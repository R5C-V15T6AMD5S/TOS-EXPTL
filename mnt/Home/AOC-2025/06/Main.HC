

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#define INP_CAP 1024*2
#else
#define INPUT_FILE "input.TXT"
#define INP_CAP 1024*10
#endif

I64 nums[INP_CAP][INP_CAP];
U8 oper[INP_CAP][1];

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SVline;
    I64 i = 0, h = 0, w = 0, oc = 0;

    while(sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      
      I64 sz = line.size;
     
      while(i < sz) {
        if(IsDigit(line.begin[0])) 
	  {nums[h][w] = SVChopI64(&line); SVChopLeft(&line); w++;
	    "%d ", nums[h][w]; }
        
	if(line.begin[0] == '+' || line.begin[0] == '*') 
	  { oper[oc][0] = line.begin[0]; SVChopLeft(&line); oc++; 
   	    "%c ", oper[oc][0]; }

	if(IsSpace(line.begin[0])) SVChopLeft(&line);

	i++; 
      } h++;
    } 

    Free(saved_begin);
}

U0 Part2() {
}

Part1;
//Part2;

