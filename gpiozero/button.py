#!/usr/bin/env python3

from gpiozero import LED
from gpiozero import Button
from time import sleep

button = Button(26)
led = LED(16)

def on_press():
    print("got a press")
    led.on()

def on_release():
    print("got a release")
    led.off()

button.when_pressed = on_press
button.when_released = on_release

wait = input("Press Enter to exit.\n")

