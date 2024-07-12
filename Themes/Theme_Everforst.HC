// Stolenc From https://github.com/sainnhe/everforest
public CBGR48 gr_palette_everforest[COLORS_NUM]={
  0xd3d3c6c6aaaa, // Black
  0x7f7fbbbbb3b3, // Blue
  0xa7a7c0c08080, // Green
  0x8383c0c09292, // Cyan
  0xe6e67e7e8080, // Red
  0xd6d69999b6b6, // Purple
  0xe6e698987575, // Brown
  0x7a7a84847878, // Ltgray  
  0x7a7a84847878, // Dkgray
  0xa0a0cdcdc7c7, // Ltblue
  0xbfbfd1d1a2a2, // Ltgreen
  0xb0b0d7d7baba, // Ltcyan
  0xeeeea9a9aaaa, // Ltred
  0xe5e5bdbdd0d0, // Ltpurple
  0xdbdbbcbc7f7f, // Yellow
  0x27272e2e3333  // White
};

GrPaletteSet(gr_palette_everforest);

// NOTE: for whatever reason when you Abort&Exit (Shift+Esc)
// a User Task (usually a terminal) the theme may reset to
// gr_palette_std. I could not figure out why and how to fix that.
MemCpy(gr_palette_std, gr_palette_everforest, sizeof(gr_palette_everforest));
