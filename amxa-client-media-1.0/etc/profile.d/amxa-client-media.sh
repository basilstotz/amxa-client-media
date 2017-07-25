if test $USER = "root"; then
    echo "not for root..."
    exit 1
fi
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
PORT="80"
PFAD=".config/public_html"

if ! test -d "$HOME/$PFAD"; then
    mkdir -p "$HOME/$PFAD"
fi

mklink(){
    if test -d $HOME/$1; then
	if ! test -h $HOME/$PFAD/$1; then
            ln -s $HOME/$1 $HOME/$PFAD/$1
	fi
   fi
}

mklink Videos
mklink Dokumente
mklink Videos
mklink Bilder

if echo $USER|grep -v "[G|g]uest.*"; then
    NAME="%h"
else
    NAME=$USER
fi

if test -d "$HOME/.config/public_html"; then
    if nmap -p $PORT localhost|grep -q -v $PORT; then
        /usr/share/bin/amxa-webfs-service $NAME $PORT $HOME/$PFAD/ $USER
    fi
fi

       
