function __kill-on-port.print-usage
  echo "Usage: kill-on-port [OPTION]... PORTS..."
  echo -e "Kills one or more processes using the given port(s).\n"
  echo "Options:"
  echo -e "\t-l, --list\t\tList processes using the specified ports (does not kill)"
  echo -e "\t-r, --root\t\tAttempts to kill the process as root"
  echo -e "\t-f, --force\t\tDoes not ask for confirmation"
  echo -e "\t-p, --port\t\tThe port to to look at (one or more required)"
  echo -e "\t-h, --help\t\tPrints usage"
end
