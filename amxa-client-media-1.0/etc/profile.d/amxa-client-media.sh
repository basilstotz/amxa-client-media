#
#  mount all media to Medien
#
if ! test -d "$HOME/Medien"; then
    mkdir -p "$HOME/Medien"
fi
if test -d "$HOME/Medien"; then
   if mount|grep -q -v djmount; then    
       djmount "$HOME/Medien"
   fi
fi
#
#  start local mediaserver
#
if ! test "$USER" = "guest"; then
    rygel --replace --title="MediaExport:@REALNAME@" &
else
    rygel --replace --title="MediaExport:@PRETTY_HOSTNAME@" &
fi
#
#  start local webserver (incl. avahi)
#
PORT="8080"
PFAD=".config/public_html"

if ! test -d "$HOME/$PFAD"; then
    mkdir -p "$HOME/$PFAD"
fi

ln -s $HOME/Musik $HOME/$PFAD/Musik
ln -s $HOME/Dokumente $HOME/$PFAD/Dokumente
ln -s $HOME/Videos $HOME/$PFAD/Videos
ln -s $HOME/Bilder $HOME/$PFAD/Bilder

if echo $USER|grep -v "[G|guest.*"; then
    NAME="%h"
else
    NAME=$USER
fi

if test -d "$HOME/.config/public_html"; then
    if nmap -p $PORT localhost|grep -q -v $PORT; then
       amxa-webfs-service $NAME $PORT $HOME/$PFAD/ $USER
    fi
fi

       
