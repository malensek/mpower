#!/usr/bin/env bash
################################################################################
# mpower.sh - monitors power consumption with the Ubiquiti mPower smart plug.
################################################################################

host="192.168.2.20"
ssh_opts="-oKexAlgorithms=+diffie-hellman-group1-sha1"

script=$(cat <<'EOM'
while true; do
    now=$(date +%s)
    power=$(cat /proc/power/active_pwr1)
    current=$(cat /proc/power/i_rms1)
    voltage=$(cat /proc/power/v_rms1)
    power_factor=$(cat /proc/power/pf1)

    echo "${now} ${power} ${current} ${voltage} ${power_factor}"

    sleep 1
done
EOM
)

# If a different host/IP is specified, set it here
if [[ -n "${1}" ]]; then
    host="${1}"
fi

# Grab the current time (in UTC since the device may not be configured with a
# time zone). We'll use this to try to set the device time.
now_utc=$(date -u '+%Y-%m-%d %H:%M:%S')

ssh "${ssh_opts}" "ubnt@${host}" "date -u -s '${now_utc}'; ${script}"
