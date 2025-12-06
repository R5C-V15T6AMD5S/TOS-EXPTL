

Cd(__DIR__);
#include "~/AOC-2024/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

#define N 1024

I64 Locations1[N];
I64 Locations2[N];

U0 AOSort(I64 *array) {
  I64 i, j, tmp;
  for(i=0; i<N; ++i) {
    for(j=i+1; j<N; ++j) {
      if(array[i]>array[j]) {
   	tmp = array[i];
	array[i] = array[j];
	array[j] = tmp;
      }
    }
  }
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    I64 i, x, y, distance = 0;
    while (sv.size > 1) {
      for(i=0; i<N; ++i) {
        x = SVChopI64(&sv); SVTrimLeft(&sv);
        y = SVChopI64(&sv); SVTrimLeft(&sv);
        //"%d  %d\n", x, y;
        
	Locations1[i] = x;
	Locations2[i] = y;
      }
     
      AOSort(&Locations1);
      AOSort(&Locations2);

      for(i=0; i<N; ++i) {
        if(Locations1[i]-Locations2[i] <0) distance += Locations2[i]-Locations1[i];
        else distance += Locations1[i] - Locations2[i];      
      }
    }

    "\nPart 1:%d\n", distance;

    Free(saved_begin);
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    I64 i, j, x, y, num, appear_num, score = 0;
    while (sv.size > 1) {
      for(i=0; i<N; ++i) {
        x = SVChopI64(&sv); SVTrimLeft(&sv);
        y = SVChopI64(&sv); SVTrimLeft(&sv);
        //"%d  %d\n", x, y;
        
	Locations1[i] = x;
	Locations2[i] = y;
      }
     
      AOSort(&Locations1);
      AOSort(&Locations2);

      for(i=0; i<N; ++i) { 
        appear_num = 0;   
        num = Locations1[i];

        for(j=0; j<N; ++j) {
          if(Locations2[j] == num) appear_num++;
        }  
        score += num *appear_num;
      }
    }

    "\nPart 2:%d\n\n", score;

    Free(saved_begin);
}

Part1;
Part2;

