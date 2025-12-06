// Stolenc From https://www.nordtheme.com/docs/colors-and-palettes
public CBGR48 gr_palette_nord[COLORS_NUM]={
  0x3e3e34344040, // Black.
  0x5e5e8181acac, // Blue.
  0xa3a3bebe8c8c, // Green.
  0x8888c0c0d0d0, // Cyan.
  0xbfbf61616a6a, // Red.
  0xb4b48e8eadad, // Purple.
  0xd0d087877070, // Brown.
  0x91919c9cb3b3, // Ltgray.  
  0x7f7f8a8aa0a0, // Dkgray.
  0x8181a1a1c1c1, // Ltblue.
  0x8f8fbcbcbbbb, // Ltgreen.
  0xb4b4eeeefefe, // Ltcyan.
  0xcdcd6d6d7676, // Ltred.
  0xc7c7a0a0c0c0, // Ltpurple.
  0xebebcbcb8b8b, // Yellow.
  0xe5e5e9e9f0f0  // White.
};

GrPaletteSet(gr_palette_nord);

// NOTE: for whatever reason when you Abort&Exit (Shift+Esc)
// a User Task (usually a terminal) the theme may reset to
// gr_palette_std. I could not figure out why and how to fix that.
MemCpy(gr_palette_std, gr_palette_nord, sizeof(gr_palette_nord));
