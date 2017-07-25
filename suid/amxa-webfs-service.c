#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

char cmd[100];

int main( int argc, char **argv)
{
  if(argc==1){
    system("echo usage: amxa-webfs-service Name Port Pfad $USER");
     return 1;
  }
  setuid(0);
  system("cp /etc/avahi/webfsd.template /etc/avahi/webfsd.service");
  sprintf(cmd,"sed -e's/@NAME@/%s/g' -i /etc/avahi/webfsd.service",argv[1]);
  system(cmd);
  sprintf(cmd,"sed -e's/@PORT@/%s/g' -i /etc/avahi/webfsd.service",argv[2]);
  system(cmd);
  system("mv /etc/avahi/webfsd.service /etc/avahi/services/webfsd.service");
  //system("sleep 1");
  sprintf(cmd,"webfsd -f index.html -p %s -r %s -u %s -g nobody",argv[2],argv[3],argv[4]);
  system(cmd);
  system("echo ok");
  return 0;
}
