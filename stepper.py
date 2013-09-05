#!/usr/bin/env python

# On the Rasberry Pi, this needs to be run as root.

import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)

# Do we want this?  We want to be able to read this easily.
GPIO.setmode(GPIO.BCM)

DELAY_SECS = 0.003
ENABLE_PIN = 18

coil_A_1_pin = 4
coil_A_2_pin = 17

coil_B_1_pin = 23
coil_B_2_pin = 24

GPIO.setup(ENABLE_PIN, GPIO.OUT)
GPIO.setup(coil_A_1_pin, GPIO.OUT)
GPIO.setup(coil_A_2_pin, GPIO.OUT)
GPIO.setup(coil_B_1_pin, GPIO.OUT)
GPIO.setup(coil_B_2_pin, GPIO.OUT)

# Enable the appropriate driver on the L292D IC.
GPIO.output(ENABLE_PIN, 1)

def forward(steps): 
    for i in range(0, steps):
        setStep(1, 0, 1, 0)
        setStep(0, 1, 1, 0)
        setStep(0, 1, 0, 1)
        setStep(1, 0, 0, 1)

def backwards(steps): 
    for i in range(0, steps):
        setStep(1, 0, 0, 1)
        setStep(0, 1, 0, 1)
        setStep(0, 1, 1, 0)
        setStep(1, 0, 1, 0)

def setStep(w1, w2, w3, w4):
    GPIO.output(coil_A_1_pin, w1)
    GPIO.output(coil_A_2_pin, w2)
    GPIO.output(coil_B_1_pin, w3)
    GPIO.output(coil_B_2_pin, w4)
    time.sleep(DELAY_SECS)

while True:
    #delay = raw_input("Delay between steps (milliseconds)?")
    steps = raw_input("How many steps forward? ")
    forward(int(steps))
    steps = raw_input("How many steps backwards? ")
    backwards(int(steps))
