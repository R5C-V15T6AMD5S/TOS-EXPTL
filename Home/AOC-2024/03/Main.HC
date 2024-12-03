

Cd(__DIR__);
#include "~/AOC-2024/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    U8 *parents = "([{<>}])";
    
    I64 multips = 0, val1, val2;
    SV line, num1, num2;

    while (sv.size > 1) {
      SVChopByDelim(&sv, 'm', &line);
      //SVPrint(&line);

      if(line.size>= 4 &&line.begin[0] == 'u'&& 
	line.begin[1] == 'l'&&line.begin[2] == parents[0]){
	
	line.begin += 3;
	line.size  -= 3;

	SVChopByDelim(&line, ',', &num1); 

	SVChopByDelim(&line, parents[7], &num2);

	val1 = SVChopI64(&num1);
	val2 = SVChopI64(&num2);
	multips += val1*val2;
      }
     
    }

    "\nPart 1:%d\n", multips;

    Free(saved_begin);
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;
    U8 *parents = "([{<>}])";

    I64 multips = 0, val1, val2;
    Bool isMulEnabled = 1;
    SV line, num1, num2, keyword;

    while(sv.size > 1) {
        SVChopByDelim(&sv, 'm', &line);
        SVTrimLeft(&line);

        if(line.size >= 2 && line.begin[0] == 'd') {
            SVChopWord(&line, &keyword);
            if(SVEqCstr(&keyword, "do")) {
                isMulEnabled = 1; 
            } else if(SVEqCstr(&keyword, "don't")) {
                isMulEnabled = 0;
            }
        }
        else if(isMulEnabled && line.size >= 4 &&
	    line.begin[0] == 'u' && line.begin[1] == 'l' &&
            line.begin[2] == parents[0]) {
          
	  SVChopLeft(&line, 3); 
          SVChopByDelim(&line, ',', &num1); 
          SVChopByDelim(&line, parents[7], &num2);

          val1 = SVChopI64(&num1);
          val2 = SVChopI64(&num2);
          multips += val1 * val2;
        }
    }

    "\nPart 2: %d\n\n", multips;

    Free(saved_begin);
}

Part1;
Part2;

