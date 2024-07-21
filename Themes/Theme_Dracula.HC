// Stolen from https://draculatheme.com/contribute
public CBGR48 gr_palette_dracula[COLORS_NUM]={
  0x1e1e20202c2c, // BLACK+
  0x62627272a4a4, // BLUE+
  0x5050fafa7b7b, // GREEN+
  0x8b8be9e9fdfd, // CYAN+
  0xffff55555555, // RED+
  0xbdbd9393f9f9, // PURPLE+
  0xffffb8b86c6c, // BROWN+
  0x545457576b6b, // LTGRAY+
  0x444447475a5a, // DKGRAY+
  0x73738484b7b7, // LTBLUE+
  0x9494ffff4646, // LTGREEN+
  0xccccf6f6ffff, // LTCYAN+
  0xffff80807a7a, // LTRED+
  0xcfcfb0b0ffff, // LTPURPLE+
  0xf1f1fafa8c8c, // YELLOW+
  0xf8f8f8f8f2f2  // WHITE+
};

GrPaletteSet(gr_palette_dracula);

// NOTE: for whatever reason when you Abort&Exit (Shift+Esc)
// a User Task (usually a terminal) the theme may reset to
// gr_palette_std. I could not figure out why and how to fix that.
MemCpy(gr_palette_std, gr_palette_dracula, sizeof(gr_palette_dracula));
