

Cd(__DIR__);
#include "~/AOC-2024/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

#define MR 1024
#define MP 1024

I64 rules[MR];
I64 pages[MP];

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line, num1, num2, num3;
    I64 i, count = 0, index = 0, middle_cnt = 0;
    Bool rule_proc = 1;

    while (sv.size > 1) {
        SVChopByDelim(&sv, '\n', &line);

        if (line.size == 0) rule_proc = 0;

        if (rule_proc) {
            while (line.size > 0) {
                SVChopByDelim(&line, '|', &num1);
                rules[count++] = SVChopI64(&num1);

                if (line.size > 0) {
                    SVChopByDelim(&line, '\n', &num2);
                    rules[count++] = SVChopI64(&num2);
                }
            }
        } else {
	    index = 0;
            while (line.size > 0) {
                if (SVChopByDelim(&line, ',', &num3)) {
                    pages[index++] = SVChopI64(&num3);
                }
		
		//PreccessPages(rules, count, pages, index);
            }
        }
    }

    "\nPart 1:%d\n", middle_cnt++; 

    Free(saved_begin);
}

Part1;
