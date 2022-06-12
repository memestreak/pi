#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <pigpio.h>

/*
For API see:
 See https://github.com/joan2937/pigpio/blob/master/pigpio.h

Buid with:
  gcc -o pwm pwm.c -lpigpio -lrt -lpthread
  sudo ./pwm

*/

#define PIN 16

int main(int argc, char *argv[])
{
  if (gpioInitialise() < 0) {
    printf("Failed to initialize with gpioInitialise\n");
    return 1;
  }

  gpioPWM(PIN, /* dutyCycle=*/ 50);
  sleep(1);
  printf("gpioGetPWMdutycycle:  %d\n"
         "gpioGetPWMfrequency:  %d\n"
         "gpioGetPWMrange    :  %d\n",
         gpioGetPWMdutycycle(PIN),
         gpioGetPWMfrequency(PIN),
         gpioGetPWMrange(PIN)
         );
        
  gpioSetPWMfrequency(PIN, 800);
  sleep(1);

  gpioSetPWMfrequency(PIN, 1600);
  sleep(1);

  gpioSetPWMfrequency(PIN, 3200);
  sleep(1);

  gpioSetPWMfrequency(PIN, 6400);
  sleep(1);  

  gpioPWM(PIN, 0);
  gpioTerminate();
}
