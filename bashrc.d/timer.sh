##########  https://arstechnica.com/information-technology/2026/05/ars-asks-share-your-shell-and-show-us-your-tricked-out-terminals/
# Adds a timer that lists out time of command execution
color_prompt=yes

if [ "$color_prompt" = yes ]; then

function timer_now_us {
    local seconds=${EPOCHREALTIME%.*}
    local micros=${EPOCHREALTIME#*.}
    micros="${micros}000000"
    REPLY="${seconds}${micros:0:6}"
}

function timer_stop {
    if [[ ${timer_command_active:-0} -ne 1 ]] || [[ -z ${timer_started_at_us:-} ]]; then
        timer_show=0us
        return
    fi

    timer_now_us
    local delta_us=$((REPLY - timer_started_at_us))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # always show 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi

    unset timer_started_at_us
    timer_command_active=0
}

#Prompt and prompt colors
function set_prompt {
  local Last_Command=${1:-$?}
  FancyX='\342\234\227'
  Checkmark='\342\234\223'
  export PS1="\n$WHITE[\t] "
  if [[ $Last_Command == 0 ]]; then
  	PS1+="\$? $GREEN$Checkmark "
  else
  	PS1+="\$? $RED$FancyX "
  fi
  timer_stop
  PS1+="$WHITE($timer_show)"
  PS1+="\n\[$HOSTCOLOR\]\u@\h\[\033[00m\]:\[\033[1;38;5;027m\]\w\[\033[00m\] \\$ "
}

function timer_prompt_command {
  local last_command=${1:-$?}
  set_prompt "$last_command"
}

PS0='${ timer_now_us; timer_started_at_us=$REPLY; timer_command_active=1; }'
PROMPT_COMMAND='timer_prompt_command'

fi
