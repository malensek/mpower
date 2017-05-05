#!/usr/bin/env bash

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

if [[ -n "${1}" ]]; then
    host="${1}"
fi

now_utc=$(date -u '+%Y-%m-%d %H:%M:%S')

ssh "${ssh_opts}" "ubnt@${host}" "date -u -s '${now_utc}'; ${script}"
