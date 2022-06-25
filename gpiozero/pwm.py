#!/usr/bin/env python

from gpiozero import PWMOutputDevice


p = PWMOutputDevice(16, active_high=True, initial_value=.5, frequency=100)

wait = input("Press Enter to exit.\n")

p.close()  # Happens automatically but included here so that I remember it.



