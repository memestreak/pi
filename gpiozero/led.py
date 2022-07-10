#!/usr/bin/env python3

from gpiozero import LED
from time import sleep

led = LED(16)

while True:
    led.on()
    sleep(1)
    led.off()
    sleep(1)



