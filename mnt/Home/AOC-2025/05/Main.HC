

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#define RNG 1024*2
#else
#define INPUT_FILE "input.TXT"
#define RNG 1024*6
#endif

class Range {
  I64 s, e;
};

Range rg[RNG];

I64 IsFresh(I64 id, I64 rg_size){
  I64 i;

  for(i = 0; i < rg_size; i++) {
    if(id >= rg[i].s && id <= rg[i].e) return 1;
  } 

  return 0;
}

I64 OldRangeOfFreshId(I64 rg_size) {
  I64 i, id, range = 0, fresh[RNG];
  MemSetI64(fresh, 0, RNG);

  for(i = 0; i < rg_size; i++) {
    I64 ids = rg[i].s, ide = rg[i].e;

    for(id = ids; id <= ide; id++) {
      if(!fresh[id]) { fresh[id] = 1; range++; }
    } 
  }

  return range;

}

I64 ComparRanges(Range *a, Range *b) {
    if(a->s < b->s) return -1;
    if(a->s > b->s) return 1;
    return 0;
}

I64 RangeOfFreshId(I64 rg_size) {
    I64 i, total_range = 0, merged_count = 0;
    Range merged[RNG];
     
    //QSortI64(rg, rg_size, &ComparRanges);
    QSort(rg, rg_size, sizeof(Range), &ComparRanges);
    
    merged[0].s = rg[0].s;
    merged[0].e = rg[0].e;
    merged_count = 1;
    
    for(i = 1; i < rg_size; i++) {
      I64 last_idx = merged_count - 1;
        
      if(rg[i].s <= merged[last_idx].e + 1) {
        if(rg[i].e > merged[last_idx].e) {
           merged[last_idx].e = rg[i].e;
        }
      } else {
        merged[merged_count].s = rg[i].s;
        merged[merged_count].e = rg[i].e;
        merged_count++;
      }
    }
    
    for(i = 0; i < merged_count; i++) {
      total_range += merged[i].e - merged[i].s + 1;
    }
    
    return total_range;
}

U0 Part1And2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    I64 rg_size = 0, fresh = 0;

    while(sv.size > 0 &&sv.begin[0] != '\n') {
      I64 id_a = SVChopI64(&sv); SVChopLeft(&sv);
      I64 id_b = SVChopI64(&sv); SVChopLeft(&sv);
      rg[rg_size].s = id_a;
      rg[rg_size].e = id_b; rg_size++;
    }
    
    while(sv.size >1) {
      I64 id = SVChopI64(&sv); SVChopLeft(&sv);
      fresh += IsFresh(id, rg_size);
    }

    Free(saved_begin);

    "Part 1:%d\n", fresh;
    "Part 2: %d\n", RangeOfFreshId(rg_size);
    //"Part 2:%d\n", OldRangeOfFreshId(rg_size);
}

Part1And2;


