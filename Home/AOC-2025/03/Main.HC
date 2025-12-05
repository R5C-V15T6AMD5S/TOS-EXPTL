

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

I64 GetJoltage(SV *line) {
  I64 i, j, jolmax = -1;
  I64 len = line->size;

  for(i = 0; i <len; i++) {
    for(j = i+1; j < len; j++) {
      if(!IsDigit(line->begin[i])) break;
      if(!IsDigit(line->begin[j])) break;
	
      I64 fd = line->begin[i] - '0';
      I64 sd = line->begin[j] - '0';
      I64 val = (fd * 10) + sd;

      if(val > jolmax) jolmax = val;
    }
  }  

  return jolmax;
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    I64 joltage = 0;

    while(sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      joltage += GetJoltage(&line);        
    }

    Free(saved_begin);

    "Part 1:%d\n", joltage;
}


U64 GetJoltage12(SV *line) {
    U64 jolmax = 0;
    I64 len = line->size;
    I64 needed = 12, pos = 0;      
    
    while(needed > 0 && pos < len) {
        I64 search_limit = pos +(len - pos - needed + 1); 
        I64 i, best_digit = -1, best_pos = -1;
        
        for(i = pos; i < search_limit && i < len; i++) {
            if(!IsDigit(line->begin[i])) break;
            
            I64 digit = line->begin[i] - '0';
            if(digit > best_digit) {
                best_digit = digit;
                best_pos = i;
            }
        }
        
        if (best_pos == -1) break;  
        
        jolmax = (jolmax * 10) + best_digit;
        pos = best_pos + 1;  
        needed--;
    }
    
    return jolmax;
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    U64 joltage = 0;

    while(sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      joltage += GetJoltage12(&line);        
    }

    Free(saved_begin);

    "Part 2:%u\n", joltage;
}


Part1;
Part2;

