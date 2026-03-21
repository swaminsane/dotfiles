# Start X automatically on TTY1 or TTY2
if [ -z "$DISPLAY" ]; then
    case "$(tty)" in
        /dev/tty1)
            # Default: dwm
            exec startx
            ;;
        /dev/tty2)
            # Plasma session on TTY2
            exec startx ~/.xinitrc.xfce
            ;;
        *)
            # Other TTYs do nothing
            ;;
    esac
fi
