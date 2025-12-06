

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;;
    I64 pos = 50, count_zero = 0;

    while (sv.size > 0) {
        SVTrimLeft(&sv);
        if(sv.size <= 0) break;

        U8 dir = sv.begin[0];
        SVChopLeft(&sv, 1);

        I64 amount = SVChopI64(&sv);

        if(dir == 'L') pos = (pos - amount) % 100;
        else pos = (pos + amount) % 100;

        if(pos < 0) pos += 100;

        if(pos == 0) count_zero++;

        while (sv.size > 0 && sv.begin[0] != '\n')
            SVChopLeft(&sv, 1);
        if (sv.size > 0 && sv.begin[0] == '\n')
            SVChopLeft(&sv, 1);
    }
     
    Free(saved_begin);


    Print("Part 1: %d\n", count_zero);

}

I64 CountZeroCrossings(I64 current, U8 direction, I64 distance){
  I64 crossings = 0, pos = current, i;

  for(i = 0; i< distance; ++i){
    if(direction == 'L') pos = (pos +99) %100;
    else pos = (pos +1) %100;

    if(pos == 0) crossings++;
  }

  return crossings;
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    I64 pos = 50, count_zero = 0;

    while (sv.size > 0) {
        SVTrimLeft(&sv);
        if(sv.size <= 0) break;

        U8 dir = sv.begin[0];
        SVChopLeft(&sv, 1);

        I64 amount = SVChopI64(&sv);
        count_zero += CountZeroCrossings(pos, dir, amount);

        if(dir == 'L') pos = (pos - amount) % 100;
        else pos = (pos + amount) % 100;

        if(pos < 0) pos += 100;

        while (sv.size > 0 && sv.begin[0] != '\n')
            SVChopLeft(&sv, 1);
        if (sv.size > 0 && sv.begin[0] == '\n')
            SVChopLeft(&sv, 1);
    }
     
    Free(saved_begin);

    Print("Part 2: %d\n", count_zero);
}

Part1;
Part2;

