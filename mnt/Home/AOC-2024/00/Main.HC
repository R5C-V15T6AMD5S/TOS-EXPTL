

Cd(__DIR__);
#include "~/AOC-2024/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif


U0 Part1() {
  SV sv, word;
  sv.begin = FileRead(INPUT_FILE, &sv.size);
  U8 *saved_begin = sv.begin;
  I64 x, pos = 0, depth = 0;
  
  while (sv.size > 1) {
    SVTrimLeft(&sv);
    SVChopWord(&sv, &word);
    x = SVChopI64(&sv);

    switch(word.size) {
       case 2: // up
          depth -= x;
          break;

       case 4: // down
          depth += x;
          break;

       case 7: // forward
          pos += x;
          break;

       default:
          "Unreachable:%d\n", sv.size;
          return;
    }
  }

  Free(saved_begin);

  "\nPart 1: %d\n", pos *depth;
}

U0 Part2() {
  SV sv, word;
  sv.begin = FileRead(INPUT_FILE, &sv.size);
  U8 *saved_begin = sv.begin;
  I64 x, pos = 0, depth = 0, aim = 0;
  
  while (sv.size > 1) {
    SVTrimLeft(&sv);
    SVChopWord(&sv, &word);
    x = SVChopI64(&sv);

    switch(word.size) {
       case 2: // up
          aim -= x;
          break;

       case 4: // down
          aim += x;
          break;

       case 7: // forward
          pos += x;
          depth += aim * x;
          break;

       default:
          "Unreachable:%d\n", sv.size;
          return;
    }
  }

  Free(saved_begin);

  "\nPart 2: %d\n\n", pos *depth;
}

Part1;
Part2;

