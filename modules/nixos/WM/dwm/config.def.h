/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 1; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const unsigned int gappx = 5;
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 1;  /* 0 means bottom bar */
static const char *fonts[] = {"CaskaydiaCoveNerdFont:size=10"};
static const char dmenufont[] = "CaskaydiaCoveNerdFont:size=10";
static const char col_second_background[] = "#FEDA99";
static const char col_front_light[] = "#754C26";
static const char col_front_dark[] = "#5A3410";
static const char col_background[] = "#FEAE00";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_front_dark, col_second_background, col_front_light},
    [SchemeSel] = {col_front_dark, col_background, col_background},
};

static const char *const autostart[] = {
    "sh",
    "/etc/screen/layout.sh",
    NULL,
    "feh",
    "--scale-down",
    "--bg-fill",
    "/etc/images/banana.png",
    NULL,
    "picom",
    "-b",
    NULL,
    NULL /* terminate */
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    {"Gimp", NULL, NULL, 0, 1, -1},
    {"Firefox", NULL, NULL, 1 << 8, 0, -1},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */

static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
#include <X11/XF86keysym.h>
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
    "dmenu_run",           "-m",  dmenumon,        "-fn", dmenufont,      "-nb",
    col_second_background, "-nf", col_front_light, "-sb", col_background, "-sf",
    col_front_dark,        NULL};
static const char *termcmd[] = {"st", NULL};
// static constneo65 char *firefox[] = {"firefox", NULL};
static const char *prtscrcmd[] = {"flameshot", "gui", NULL};
static const char *clipmd[] = {"clipmenu", "-i",
                               "-fn",      dmenufont,
                               "-nb",      col_second_background,
                               "-nf",      col_front_light,
                               "-sb",      col_background,
                               "-sf",      col_front_dark,
                               NULL};
static const char *urlcmd[] = {"clipmenu-url", NULL};
static const char *brupcmd[] = {"brightnessctl", "set", "10%+", NULL};
static const char *brdowncmd[] = {"brightnessctl", "set", "10%-", NULL};
static const char *volupcmd[] = {"pulsemixer", "--change-volume", "+10", NULL};
static const char *voldowncmd[] = {"pulsemixer", "--change-volume", "-10",
                                   NULL};
static const char *mutecmd[] = {"pulsemixer", "--toggle-mute", NULL};
static const char *mednextcmd[] = {"mpc", "next", NULL};
static const char *medprevcmd[] = {"mpc", "prev", NULL};
static const char *medplaypausecmd[] = {"txs", "music",  "&&",
                                        "mpc", "toggle", NULL};

#include "movestack.c"
static const Key keys[] = {
    /* modifier                     key        function        argument */
    {MODKEY, XK_p, spawn, {.v = dmenucmd}},
    {MODKEY | ShiftMask, XK_p, spawn, {.v = prtscrcmd}},
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_c, spawn, {.v = clipmd}},
    {MODKEY, XK_u, spawn, {.v = urlcmd}},
    {0, XF86XK_AudioMute, spawn, {.v = mutecmd}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = voldowncmd}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = volupcmd}},
    {0, XF86XK_MonBrightnessUp, spawn, {.v = brupcmd}},
    {0, XF86XK_MonBrightnessDown, spawn, {.v = brdowncmd}},
    {0, XF86XK_AudioNext, spawn, {.v = mednextcmd}},
    {0, XF86XK_AudioPrev, spawn, {.v = medprevcmd}},
    {0, XF86XK_AudioStop, spawn, {.v = medplaypausecmd}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY | ShiftMask, XK_j, movestack, {.i = +1}},
    {MODKEY | ShiftMask, XK_k, movestack, {.i = -1}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY | ShiftMask, XK_c, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_minus, setgaps, {.i = -1}},
    {MODKEY, XK_equal, setgaps, {.i = +1}},
    {MODKEY | ShiftMask, XK_equal, setgaps, {.i = 0}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
