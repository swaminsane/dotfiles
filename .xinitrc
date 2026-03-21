

export WM="dwm"

# Source your environment
[ -f "$HOME/.profile" ] && . "$HOME/.profile"


# Start dbus only if not already running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Load background apps
[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

# Enable touchpad tapping
xinput set-prop "Synaptics TM3418-002" "libinput Tapping Enabled" 1

exec dwm
