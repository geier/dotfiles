#!/bin/sh
#
# mailto-mutt -- wrapper to be able to use mutt as mailto handler from firefox
#
# To use, surf to Firefox's about:config page and configure the following
# three values:
#   network.protocol-handler.external.mailto boolean true
#   network.protocol-handler.app.mailto string '/path/to/handler'
#   network.protocol-handler.warn-external.mailto boolean false
#
# Copyright © martin f. krafft <madduck@madduck.net>
# Released under the terms of the Artistic Licence 2.0
# 
# Revision: $Id: mailto-mutt 498 2007-05-12 12:02:10Z madduck $
# Modified: christian geier 2012
# 


MAILHOST=brutus.lostpackets.de

set -eu

case "${1:-}" in
  -d) debug=1; shift;;
  '') exit 0;;
  *) :;;
esac

url_unescape()
{
  perl -e 'use URI::Escape; while(<>) { print uri_unescape($_); }'
}

MAILTO="${@%%\?*}"
ARGS="${@#*\?}"
[ "$ARGS" = "$MAILTO" ] && unset ARGS
MAILTO="$(echo "${MAILTO#mailto:}" | url_unescape)"

subject=
cc=
bcc=
body=
mutt_commands=

IFS_store="$IFS"
IFS='&'

for arg in ${ARGS:-}; do
  value="$(echo "${arg#*=}" | url_unescape | sed -e "s,',\',")"

  case "${arg%%=*}" in
    subject|Subject|SUBJECT) subject="$value";;
    cc|Cc|CC) cc="$value";;
    bcc|Bcc|BCC) bcc="$value";;
    body|Body|BODY) body="$value";;
    *)
      mutt_commands="${mutt_commands:+${mutt_commands}
        }-e\"my_hdr ${arg%%=*}: $value\""
      ;;
  esac
done

IFS="$IFS_store"

break_at_commas()
{
  local atom
  for i; do
    atom="${atom:+$atom }$i"
    case "${atom:-}" in
      *,) echo "${atom%,}"; unset atom;;
    esac
  done
  [ -n "${atom:-}" ] && echo "${atom%,}"
}

get_addr_args()
{
  local type
  case "$1" in
    -*) type="$1"; shift;;
    *) unset type;;
  esac

  break_at_commas "$@" | while read addr; do
    echo -n "${type:-}\"$addr\" "
  done
}

if [ -n "$mutt_commands" ]; then
  mutt_args="${mutt_args:+$mutt_args }$mutt_commands"
fi

if [ -n "$subject" ]; then
  mutt_args="${mutt_args:+$mutt_args }-s\"$subject\""
fi

mutt_args="${mutt_args:+$mutt_args }$(get_addr_args -c $cc)"
mutt_args="${mutt_args:+$mutt_args }$(get_addr_args -b $bcc)"
mutt_args="${mutt_args:+$mutt_args }$(get_addr_args $MAILTO)"

run()
{
  if [ ${debug:-0} -eq 1 ]; then
    echo "$@"
  else
    eval "$@"
  fi
}

if [ -n "$body" ]; then
  TMPFILE="$(tempfile -p mailto -d /tmp)"
  echo "contains a body, this doesn't work ATM, bye"
  exit
  echo "$body" > $TMPFILE
  trap "rm -f $TMPFILE" 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
  run x-terminal-emulator -e mutt${mutt_args:+ $mutt_args} -i $TMPFILE
  ret=$?
  rm -f $TMPFILE
  trap - 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
  exit $ret
else
  ssh $MAILHOST "tmux new-window -t mail; tmux send-keys \"mutt${mutt_args:+ $mutt_args}\"  C-m;";
  x-terminal-emulator -e ssh $MAILHOST -t tmux attach -t mail
fi
sleep 5

