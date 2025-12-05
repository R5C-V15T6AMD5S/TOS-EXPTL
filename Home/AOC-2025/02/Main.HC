

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

Bool IsInvalidID(I64 num) {
    U8 buffer[32];
    StrPrint(buffer, "%d", num);
    
    I64 len = StrLen(buffer);
    if(len % 2 != 0) return 0;
    
    I64 i, half = len / 2;
    
    for(i = 0; i < half; ++i) {
      if(buffer[i] != buffer[half + i]) {
          return 0;
      }
    }
    
    return 1;
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    I64 id, total = 0;

    while (sv.size > 0) {
      SVTrimLeft(&sv);
      if(sv.size <= 0) break;

      I64 range_start = SVChopI64(&sv);
        
      if(sv.size > 0 && sv.begin[0] == '-')
          SVChopLeft(&sv, 1);
        
      I64 range_end = SVChopI64(&sv);
        
      for(id = range_start; id <= range_end; ++id) {
        if(IsInvalidID(id)) total += id;
      }
    
      while(sv.size > 0 && (sv.begin[0] == ',' || 
            sv.begin[0] == ' ' || sv.begin[0] == '\n'))
        SVChopLeft(&sv, 1);
    }
     
    Free(saved_begin);

    Print("Part 1: %d\n", total);
}

Bool IsInvalidID2(I64 num) {
    U8 buffer[32];
    StrPrint(buffer, "%d", num);
    I64 len = StrLen(buffer);
    
    I64 pattern_len;
    for(pattern_len = 1; pattern_len <= len / 2; ++pattern_len) {
      if(len % pattern_len == 0) {
          I64 repeats = len / pattern_len;
          if(repeats >= 2) {  
            Bool matches = 1;
            I64 i;
            for(i = pattern_len; i < len; ++i) {
              if(buffer[i] != buffer[i % pattern_len]) {
                matches = 0;
                break;
              }
            }
                
            if(matches) return 1;
         }
      }
    }
    
    return 0;
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    I64 id, total = 0;

    while (sv.size > 0) {
        SVTrimLeft(&sv);
        if(sv.size <= 0) break;

        I64 range_start = SVChopI64(&sv);

        if(sv.size > 0 && sv.begin[0] == '-')
            SVChopLeft(&sv, 1);

        I64 range_end = SVChopI64(&sv);

        for(id = range_start; id <= range_end; ++id) {
            if (IsInvalidID2(id)) total += id;
        }

        while(sv.size > 0 && (sv.begin[0] == ',' || 
	       sv.begin[0] == ' ' || sv.begin[0] == '\n'))
            SVChopLeft(&sv, 1);
    }

    Free(saved_begin);

    Print("Part 2: %d\n", total);
}

Part1;
Part2;

