#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
  {
  char c = fgetc(stdin);
  pid_t pid = getpid();
  while(c != EOF)
    {
    if(c == '\n') printf("[%d]", pid);
    fputc(c, stdout);
    c = fgetc(stdin);
    }
  printf("exit[%d]\n", pid);
  }
