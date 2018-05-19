
if ! test $USER = "root"; then


#  mount all media to Medien

# to much resoources!
#    if ! test -d "$HOME/Medien"; then
#       mkdir -p "$HOME/Medien"
#    fi

    MEDIEN="Medien"
    if test -d "$HOME/$MEDIEN"; then
       if mount|grep -q -v $HOME/$MEDIEN; then    
          djmount "$HOME/$MEDIEN"
       fi
     fi



#
#  start local mediaserver
#

  if test -d $HOME/MeineMedien; then
    if ! test "$USER" = "guest"; then
       rygel --replace --title="MediaExport:@REALNAME@" &
    else
       rygel --replace --title="MediaExport:@PRETTY_HOSTNAME@" &
    fi
  if

#
#  start local webserver (incl. avahi)
#

    PORT="80"
    PFAD="$HOME/.config/public_html"

    if test -d $PFAD; then 

      if ! test -l "$HOME/public_html"; then
        mkdir -p "$HOME/public_html"
      fi
 
      if echo $USER|grep -q "[G|g]uest.*"; then
         NAME="%h"
      else
         NAME=$USER
      fi

      if nmap -p $PORT localhost|grep -q -v $PORT; then
         /usr/share/bin/amxa-webfs-service $NAME $PORT $PFAD/ $USER
      fi

   fi     #pfad

fi #not root
