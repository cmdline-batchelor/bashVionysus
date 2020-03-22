#/bin/bash   

   plugOtions() {
     case "$1" in
       uninstall )
          unsPlug "$1"
         ;;
       upgrade   )
          upPlug "$1" "$2"
         ;;
       install   )
          getPlug "$1" "$2"
         ;;
               * )
          usage
          notify
     esac
    }

   plugOptions "$1" :
