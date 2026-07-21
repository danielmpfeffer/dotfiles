/* dwm config.h — close to vanilla defaults, 2 tags, no gaps.
 * Only deviations from stock config.def.h:
 *   - MODKEY is Mod4Mask (Super) instead of Mod1Mask (Alt) — see note above
 *   - font/colors carried over from your i3 setup
 *   - a handful of extra bindings for your own scripts + media keys,
 *     placed on keys vanilla dwm doesn't use, so nothing collides.
 * Compiles against vanilla (unpatched) dwm.
 */
#include <X11/XF86keysym.h>

/* appearance — all stock defaults except font/colors */
static const unsigned int borderpx  = 1;
static const unsigned int snap      = 32;
static const int swallowfloating    = 0; /* 1 means swallow floating windows by default */
static const int showbar            = 1;
static const int topbar             = 1;
static const char *fonts[]          = { "DejaVu Sans Mono:size=12" };
static const char dmenufont[]       = "DejaVu Sans Mono:size=12";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tags — back to stock default */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* class         instance    title       tags mask     isfloating   isterminal   noswallow   monitor */
	{ "Gimp",        NULL,       NULL,       0,            1,           0,           0,          -1 },
	{ "st-256color", NULL,       NULL,       0,            0,           1,           0,          -1 },
};

/* layout(s) — stock defaults, stock order */
static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;
static const int lockfullscreen = 1;
static const int refreshrate = 120; /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* index 0 */
	{ "><>",      NULL },    /* index 1 — floating */
	{ "[M]",      monocle }, /* index 2 */
	{ "III",      horizontal }, /* index 3 — from the horizontal patch */
};

/* key definitions */
#define MODKEY Mod4Mask   /* stock dwm default is Mod1Mask (Alt) — see note above */
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands / your existing scripts */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "/home/dan/.local/bin/dmenu-recent", "-c", "-l", "10", "-m", dmenumon, "-fn", dmenufont,
	"-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };

/* Hardcoded now that i3 is going away — i3-sensible-terminal lived in the
 * i3 package. Defaulting to st since that's what I suggested building
 * early on; if you skipped that step, swap this for "xterm" or whatever
 * terminal you actually have installed. */
static const char *termcmd[]  = { "st", NULL };

static const Key keys[] = {
	/* ---- stock dwm defaults, unchanged ---- */
	{ MODKEY,                       XK_p,                      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return,                 spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_Return,                 zoom,           {0} },
	{ MODKEY,                       XK_b,                      togglebar,      {0} },
	{ MODKEY,                       XK_j,                      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,                      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,                      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,                      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,                      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,                      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Tab,                    view,           {0} },
	{ MODKEY,                       XK_t,                      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,                      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,                      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_w,                      setlayout,      {.v = &layouts[3]} }, /* horizontal */
	{ MODKEY,                       XK_space,                  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,                  togglefloating, {0} },
	{ MODKEY,                       XK_0,                      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,                      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,                  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,                 focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,                  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                 tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_c,                      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_q,                      quit,           {0} },

	/* ---- extras: your scripts, no vanilla equivalent exists ---- */
	{ MODKEY,                       XK_o,                      spawn,          SHCMD("~/.local/bin/dmenu-open.sh") },
	{ MODKEY,                       XK_n,                      spawn,          SHCMD("~/.local/bin/dmenunote") },
	{ MODKEY,                       XK_F7,                     spawn,          SHCMD("~/.local/bin/monitor-setup.sh") },
	{ MODKEY,                       XK_F8,                     spawn,          SHCMD("xrandr --output eDP --primary --mode 1920x1080 --output HDMI-A-0 --off") },
	{ MODKEY,                       XK_F9,                     spawn,          SHCMD("xsct 2700") },
	{ MODKEY,                       XK_F10,                    spawn,          SHCMD("xsct 3500") },
	{ MODKEY,                       XK_F11,                    spawn,          SHCMD("xsct 4500") },
	{ MODKEY,                       XK_F12,                    spawn,          SHCMD("xsct 0") },

	/* media / hardware keys — dedicated keys, no modifier needed */
	{ 0,                             XF86XK_AudioRaiseVolume,  spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +10%") },
	{ 0,                             XF86XK_AudioLowerVolume,  spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -10%") },
	{ 0,                             XF86XK_AudioMute,         spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle") },
	{ 0,                             XF86XK_AudioMicMute,      spawn,          SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle") },
	{ 0,                             XF86XK_MonBrightnessUp,   spawn,          SHCMD("brightnessctl set 10%+") },
	{ 0,                             XF86XK_MonBrightnessDown, spawn,          SHCMD("brightnessctl set 10%-") },
};

/* button definitions — stock dwm defaults, unchanged */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
