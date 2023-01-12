# SYNOPSIS
#   kill-on-port [OPTION]...
#
# USAGE
#   Options
#       -l, --list     List processes using the specified ports (does not kill)
#       -r, --root     Attempts to kill the process as root
#       -f, --force    Does not ask for confirmation
#       -p, --port     The port to to look at (one or more required)
#       -h, --help     Prints usage

function init -a path --on-event init_kill-on-port

end

function kill-on-port -d "Kills a process that is using the given port"
  set -l force 0
  set -l list 0
  set -l root ""
  set -l ports

  for i in (echo $argv | sed 's|--*|\\'\n'|g' | grep -v '^$')
    echo $i | read -l option value

    switch $option
      case f force
        set force 1
      case r rot
        set root "sudo "
      case l list
        set list 1
      case p port
        set ports $ports $value
      case h
        __kill-on-port.print-usage
        return
      case \*
        echo -e "Unknown option $option\n"
        __kill-on-port.print-usage
        return
    end
  end

  if test (count $ports) = 0
    echo -e "One or more ports must be specified\n"
    __kill-on-port.print-usage
  else
    for port in $ports
      set -l process (lsof -n -i -P | grep $port)
      if test -n "$process"
        set -l name (echo $process | awk '{print $1}')
        set -l pid (echo $process | awk '{print $2}')
        echo "Found process named $name with process id $pid using port $port"
        if test $list = 0
          if test $force = 1
            eval "$root kill -9 $pid"
            echo "Successfully killed $pid"
          else
            echo "Continue (y/n):"
            read -l choice
            switch $choice
              case y yes Y YES
                eval "$root kill -9 $pid"
                echo "Successfully killed $pid"
              case n no N NO
                echo "Not killing $pid"
              case '*'
                echo "Unrecognized choice: $choice"
            end
          end
        end

      else
        echo "Couldn't find a process to kill on port $port"
      end
    end
  end
end

function uninstall --on-event uninstall_kill-on-port

end
