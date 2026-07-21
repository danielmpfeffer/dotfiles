/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) — NOT static: netspeeds.c needs
 * external linkage to this via its own `extern` declaration */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

/*
 * function            description                     argument
 *
 * battery_perc         battery percentage              battery name
 * battery_power        battery power usage             battery name
 * battery_state        battery charging state          battery name
 * cpu_perc             cpu usage in percent            NULL
 * cpu_freq             cpu frequency in MHz            NULL
 * datetime             date and time                   format string
 * disk_perc            disk usage in percent           mountpoint path
 * ram_perc             memory usage in percent         NULL
 * vol_perc             OSS/ALSA volume in percent      NULL on Linux/ALSA
 * wifi_perc            WiFi signal in percent          interface name
 * wifi_essid           WiFi ESSID                      interface name
 * netspeed_rx          download speed                  interface name
 * netspeed_tx          upload speed                    interface name
 */
static const struct arg args[] = {
	/* function        format             argument */
	{ wifi_essid,       "%s ",             "wlp6s0" },
	{ wifi_perc,        "(%s%%) ",         "wlp6s0" },
	{ netspeed_rx,      "eth ↓%s ",        "enp3s0f0" },
	{ netspeed_tx,      "↑%s ",            "enp3s0f0" },
	{ ram_perc,         "RAM %s%% ",       NULL },
	{ cpu_perc,         "CPU %s%% ",       NULL },
	{ run_command,      "VOL %s ",         "pactl get-sink-volume @DEFAULT_SINK@ | head -n1 | awk '{print $5}'" },
	{ battery_state,    "[%s ",            "BAT0" },
	{ battery_perc,     "%s%%] ",          "BAT0" },
	{ datetime,         "%s",              "%Y-%m-%d %I:%M:%S %p" },
};
