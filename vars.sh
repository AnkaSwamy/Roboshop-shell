#special variables
#echo script name - $0
#echo first argument  - $1
#echo all arguments - $*
#echo no of arguments  - $#

print_arguments() {
  echo first argument $1
  echo second argument $1
  echo all  argument $*
  echo no of arguments $#
  }
  print_arguments
