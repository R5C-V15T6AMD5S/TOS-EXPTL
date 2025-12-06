

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

#define KINDS_CNT 4

Bool IsOpen(U8 x, I64 *kind)
{
  U8 *parens = "([{<)]}>";
  I64 i=0;
  while (i<8 && parens[i] != x) i++;
  *kind = i%KINDS_CNT;
  return i<KINDS_CNT;
}

I64 CorruptedCharScore[KINDS_CNT] = {3, 57, 1197, 25137};

#define STACK_CAP 1024

I64 stack[STACK_CAP];
I64 stack_cnt;

I64 CorruptedLineScore(SV *line)
{
  I64 i, kind;
  stack_cnt=0;
  for (i=0; i<line->size; ++i) {
    if (IsOpen(line->begin[i], &kind)) {
      stack[stack_cnt++] = kind;
    } else {
      if (stack_cnt <= 0 || stack[stack_cnt-1] != kind) {
        return CorruptedCharScore[kind];
      } else {
        stack_cnt--;
      }
    }
  }
  return 0;
}

U0 Part1(){
  SV sv;
  sv.begin = FileRead(INPUT_FILE, &sv.size);
  U8 *saved_begin = sv.begin;
  I64 answer = 0, score;

  SV line;
  while (sv.size >1) {
    SVChopByDelim(&sv, '\n', &line);
    score = CorruptedLineScore(&line);
    answer += score;
  }

  "Part 1: %d\n", answer;

  Free(saved_begin);
}

I64 IncompleteLineScore(SV *line)
{
  I64 i, kind;
  stack_cnt=0;
  for (i=0; i<line->size; ++i) {
    if (IsOpen(line->begin[i], &kind)) {
      stack[stack_cnt++] = kind;
    } else {
      if (stack_cnt <= 0 || stack[stack_cnt-1] != kind) {
        return 0;
      } else {
        stack_cnt--;
      }
    }
  }

  I64 result = 0;

  while (stack_cnt > 0){
    result *= 5;
    result += stack[--stack_cnt]+1;
  }

  return result;
}

#define SCORES_CAP 1024
I64 scores[SCORES_CAP];
I64 scores_cnt;

I64 ScoreCompare(I64 a, I64 b)
{
  return a - b;
}

U0Part2() {
  SV sv;
  sv.begin = FileRead(INPUT_FILE, &sv.size);
  U8 *saved_begin = sv.begin;
  I64 score;

  SV line;
  scores_cnt=0;
  while (sv.size >1) {
    SVChopByDelim(&sv, '\n', &line);
    score = IncompleteLineScore(&line);
    if (score >0) {
      scores[scores_cnt++] = score;
    }
  }

  QSortI64(scores, scores_cnt, &ScoreCompare);

  "Part 2: %d\n", scores[scores_cnt/2];

  Free(saved_begin);
}

Part1;
Part2;

