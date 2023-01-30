#!/bin/bash
# Source: http://askubuntu.com/a/450136

URGENT_VALUE=2

PREV_TOTAL=0
PREV_IDLE=0

cpuFile="/tmp/.cpu"

if [[ -f "${cpuFile}" ]]; then
  fileCont=$(cat "${cpuFile}")
  PREV_TOTAL=$(echo "${fileCont}" | head -n 1)
  PREV_IDLE=$(echo "${fileCont}" | tail -n 1)
fi

CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0

for VALUE in "${CPU[@]:0:4}"; do
  let "TOTAL=$TOTAL+$VALUE"
done

if [[ "${PREV_TOTAL}" != "" ]] && [[ "${PREV_IDLE}" != "" ]]; then
  # Calculate the CPU usage since we last checked.
  let "DIFF_IDLE=$IDLE-$PREV_IDLE"
  let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
  let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

  colorb="#ffffff00"

  if [ $((10#$DIFF_USAGE)) -ge $((10#70)) ]; then
      symbol="|■■■|";
      color="#ff0000"
  elif [ $((10#$DIFF_USAGE)) -ge $((10#50)) ]; then
      symbol="|■■ |";
      color="#ddaa00"
  elif [ $((10#$DIFF_USAGE)) -ge $((10#20)) ]; then
      symbol="|■  |";
      color="#ffff00"
  else
      symbol="|   |";
      color="#00ff00"
  fi

  echo -e "<span color='$color' bgcolor='$colorb' background_alpha='1'> CPU $symbol ${DIFF_USAGE}% </span>"
  echo -e "<span color='$color' bgcolor='$colorb' background_alpha='1'> CPU ${DIFF_USAGE}% </span>"
  echo "$color"
  echo "$color"
  echo "$color"
else
  echo "CPU ???"
  echo "CPU ???"
  echo "#1f1f1f"
fi

# Remember the total and idle CPU times for the next check.
echo "${TOTAL}" > "${cpuFile}"
echo "${IDLE}" >> "${cpuFile}"

