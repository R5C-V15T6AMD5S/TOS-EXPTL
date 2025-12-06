

Cd(__DIR__);
#include "~/AOC-2024/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

#define MIS 1024

U8* search[MIS][MIS];

I64 directions[8][2] = {
    {0, 1},  // Right
    {1, 0},  // Down
    {0, -1}, // Left
    {-1, 0}, // Up
    {1, 1},  // Down-Right
    {1, -1}, // Down-Left
    {-1, 1}, // Up-Right
    {-1, -1} // Up-Left
};

Bool CheckWord(U8*search, I64 row, I64 col, I64 rows, I64 cols, U8 *word, I64 dir) {
    I64 word_len = StrLen(word), k;
    for(k=0; k<word_len; ++k) {
        I64 new_row = row + k * directions[dir][0];
        I64 new_col = col + k * directions[dir][1];
        if((new_row<0 || new_row>=rows) || (new_col<0 || new_col>=cols)) return FALSE;
        if(search[new_row][new_col] != word[k]) return FALSE;
    }
    return TRUE;
}

I64 CountWord(U8 *search, I64 rows, I64 cols, U8 *word) {
    I64 row, col, dir, count = 0;
    for(row = 0; row < rows; ++row) {
        for(col = 0; col < cols; ++col) {
            for(dir = 0; dir < 8; ++dir) {
                if (CheckWord(search, row, col, rows, cols, word, dir)) count++;
            }
        }
    }

    return count;
}

U0 Part1() {
    SV sv, line;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    I64 row = 0, col, rows = 0, cols = 0;

    while(sv.size > 1) {
        SVChopByDelim(&sv, '\n', &line);
        
        if(row >= MIS) break; 
        cols = line.size;      
        
        for(col = 0; col < cols; ++col) {
            search[row][col] = &line.begin[col];
        } row++;
    } rows = row;

    I64 xmas_count = CountWord(search, rows, cols, (U8 *)"XMAS");

    "\nPart 1: %d\n", xmas_count;

    Free(saved_begin);
}

Part1;
//Part2;
