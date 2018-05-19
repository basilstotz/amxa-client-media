
if ! test $USER = "root"; then

    # Personal Webserver
    PORT="80"
    PUBLIC_HTML="public_html"
    # Public Media Browser
    MEDIEN="Medien"
    # Puablich Onw Media
    MEINEMEDIEN="MeineMedien"


    if echo $USER|grep -q "[G|g]uest.*"; then
         NAME="%h"
         if ! test -d $HOME/.local/$PUBLIC_HTML; then 
             mkdir -p $HOME/.local/$PUBLIC_HTML;
         fi
         if ! test -d $HOME/$MEDIEN; then mkdir -p $HOME/$MEDIEN;fi
         if ! test -d $HOME/$MEINEMEDIEN; then mkdir -p $HOME/$MEINEMEDIEN;fi
    else
         NAME=$USER
    fi


#  mount all media to Medien

    if test -d "$HOME/$MEDIEN"; then
       if mount|grep -q -v $HOME/$MEDIEN; then    
          djmount "$HOME/$MEDIEN"
       fi
     fi



#
#  start local mediaserver
#

  if test -d $HOME/$MEINEMEDIEN; then
      if ! test "$USER" = "guest"; then
         rygel --replace --uris="$HOME/$MEINEMEDIEN" --title="MediaExport:@REALNAME@" &
      else
         rygel --replace --uris="$HOME/$MEINEMEDIEN" --title="MediaExport:@PRETTY_HOSTNAME@" &
      fi
  fi

#
#  start local webserver (incl. avahi)
#

   if test -d $HOME/.local/$PUBLIC_HTML; then 

      if ! test -l $HOME/$PUBLIC_HTML; then
         ln -s $HOME/.local/$PUBLIC_HTML $HOME/$PUBLIC_HTML
      fi
 

      if nmap -p $PORT localhost|grep -q -v $PORT; then
         /usr/share/bin/amxa-webfs-service $NAME $PORT $HOME/.local/$PUBLIC_HTML/ $USER
      fi

   fi     #pfad

fi #not root
