

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#define INP_CAP 1024*2
#else
#define INPUT_FILE "input.TXT"
#define INP_CAP 1024*10
#endif

I64 *nums = MAlloc(sizeof(I64)*INP_CAP *INP_CAP);
U8 *oper = MAlloc(sizeof(U8)*INP_CAP);

I64 TotalSum(I64 h, I64 w) {
  I64 i, j, total_sum = 0;

  for(j = 0; j < w; j++) {
    I64 sum = nums[0*INP_CAP +j];

    for(i = 1; i < h; i++) {
      if(oper[j] == '*') sum *= nums[i*INP_CAP +j];
      if(oper[j] == '+') sum += nums[i*INP_CAP +j];
    }

    total_sum += sum;
  }

  return total_sum;
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    I64 col, h = 0, w = 0;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line); 
      SVTrimLeft(&line);

      if(line.size > 0 &&IsDigit(line.begin[0])) {
        col = 0;

        while(line.size>0) {
	  if(line.size>0 &&IsDigit(line.begin[0])) {
	    nums[h* INP_CAP +col] = SVChopI64(&line); col++;  
          } else if(IsSpace(line.begin[0])) SVChopLeft(&line);
	    else break;
        } if(h == 0) w = col; h++;
      } else if(line.size > 0 &&(line.begin[0] == '+' || line.begin[0] == '*')) { 
          col = 0;

	  while(line.size>0) {
	    SVTrimLeft(&line);

	    if(line.size>0 &&(line.begin[0] == '+' || line.begin[0] == '*')) {
	      oper[col] = line.begin[0]; col++; 
	      SVChopLeft(&line);  
            } else break;
          }
      }  
    }

    Free(nums);
    Free(oper);
    Free(saved_begin);

    "Part 1:%d\n", TotalSum(h, w);

}

U0 Part2() {
  SV sv;
  sv.begin = FileRead(INPUT_FILE, &sv.size);
  U8 *saved_begin = sv.begin;

  U8 *lines[INP_CAP];
  I64 line_lens[INP_CAP], i, h = 0, max_len = 0;
  
  SV line, temp_sv;
  temp_sv.begin = sv.begin;
  temp_sv.size = sv.size;
  
  while(temp_sv.size > 1) {
    SVChopByDelim(&temp_sv, '\n', &line);
    
    Bool has_digit = FALSE;    
    for(i = 0; i < line.size; i++) {
      if(IsDigit(line.begin[i])) {
        has_digit = TRUE;
        break;
      }
    }
    
    if(has_digit) {
      lines[h] = line.begin;
      line_lens[h] = line.size;
      if(line.size > max_len) max_len = line.size;
      h++;
    }
  }
  
  I64 oper_count = 0;
  temp_sv.begin = sv.begin;
  temp_sv.size = sv.size;
  
  while(temp_sv.size > 1) {
    SVChopByDelim(&temp_sv, '\n', &line);
    for(i = 0; i < line.size; i++) {
      if(line.begin[i] == '+' || line.begin[i] == '*') {
        oper[oper_count++] = line.begin[i];
      }
    }
  }
  
  I64 problems[INP_CAP][INP_CAP];
  I64 prob_count = 0;
  I64 curr_prob_digits = 0;
  I64 row, col, p;
  
  for(col = max_len - 1; col >= 0; col--) {
    Bool has_any_digit = FALSE;
    Bool all_spaces = TRUE;
    
    for(row = 0; row < h; row++) {
      if(col < line_lens[row]) {
        U8 ch = lines[row][col];

        if(IsDigit(ch)) {
          has_any_digit = TRUE;
          all_spaces = FALSE;
        } else if(ch != ' ') {
          all_spaces = FALSE;
        }
      }
    }
    
    if(all_spaces && curr_prob_digits > 0) {
      prob_count++;
      curr_prob_digits = 0;
    } else if(has_any_digit) {
      if(curr_prob_digits == 0) {
        for(row = 0; row < h; row++) {
          problems[prob_count][row] = 0;
        }
      }
      
      for(row = 0; row < h; row++) {
        if(col < line_lens[row] && IsDigit(lines[row][col])) {
          problems[prob_count][row] = problems[prob_count][row] * 10 + (lines[row][col] - '0');
        }
      } curr_prob_digits++;
    }
  } if(curr_prob_digits > 0) prob_count++;
  
  I64 grand_total = 0;
  for(p = 0; p < prob_count; p++) {
    I64 result = problems[p][0];
    for(row = 1; row < h; row++) {
      if(oper[p] == '+') result += problems[p][row];
      else result *= problems[p][row];
    } grand_total += result;
  }
  
  Free(saved_begin);

  "Part 2: %d\n", grand_total;
}

Part1;
Part2;
