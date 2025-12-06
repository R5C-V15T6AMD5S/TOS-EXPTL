

Cd(__DIR__);
#include "~/AOC-2025/Common.HC"

#if 0
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

#define GRID_CAP 1024
I64 h = 0, w = 0;
U8 grid[GRID_CAP][GRID_CAP];

I64 ForkliftAccessed() {
  I64 r, c, dr, dc, adj, accessed = 0;

  for(r = 0; r < h; ++r) {
    for(c = 0; c < w; ++c) {
      if(grid[r][c] != '@') goto skip1;
      adj = 0;
      
      for(dr = -1; dr <= 1; ++dr) {
	for(dc = -1; dc <= 1; ++dc) {
	  if(dr == 0 && dc == 0) goto skip2;

	  I64 nr = r + dr, nc = c +dc;
	  if(nr < 0||nr>=h&& nc <0 && nc>=w) goto skip2;
            
          if(grid[nr][nc] == '@') adj++;
	  
          skip2:

	}
      }
      if(adj < 4) accessed++; 
  
      skip1:
    } 
  }

  return accessed;
}

U0 Part1() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    I64 i;
    SV line;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      w = line.size;

      for(i = 0; i < w; ++i) {
        grid[h][i] = line.begin[i];
      } h++;
    }

    Free(saved_begin);   
    
    "Part 1: %d\n", ForkliftAccessed();
}


I64 ForkliftDeleted() {
  I64 r, c, dr, dc, removed = 0;

  while(TRUE) {
    Bool removed_any = FALSE, remove_mask[GRID_CAP][GRID_CAP];

    for(r = 0; r < h; ++r) 
      for(c = 0; c < w; ++c)
        remove_mask[r][c] = FALSE; 
        

    for(r = 0; r < h; ++r) {
      for(c = 0; c < w; ++c) {
        if(grid[r][c] == '@') { 
            I64 adj = 0;
        
            for(dr = -1; dr <= 1; ++dr) {
              for(dc = -1; dc <= 1; ++dc) {
  	  	if(dr == 0 &&dc == 0) goto skip;

                I64 nr = r + dr, nc = c +dc;
	        if(nr >= 0&&nr<h&& nc >=0 && nc<w)
                  if(grid[nr][nc] == '@') adj++;
		skip:
	      }
   	    }
   
            if(adj < 4) remove_mask[r][c] = TRUE;
	}
      } 
    }

    for(r = 0; r < h; ++r) {
      for(c = 0; c < w; ++c) {
        if(remove_mask[r][c]) {
          grid[r][c] = '.';
 	  removed++;
 	  removed_any = TRUE;
        }
      }
    }
  
    if(!removed_any) break;
   }

  return removed;
}

U0 Part2() {
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    SV line;
    I64 i, h = 0;

    while (sv.size > 1) {
      SVChopByDelim(&sv, '\n', &line);
      w = line.size;

      for(i = 0; i < w; ++i) {
        grid[h][i] = line.begin[i];
      } h++;
    }

    Free(saved_begin);   
    
    "Part 2: %d\n", ForkliftDeleted();
}

Part1;
Part2;

