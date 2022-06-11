#!/bin/bash

# Utility functions for updating GPIO pins
#
# Requires:
#   * An installed pigpio library
#   * A running pigpiod process. Ex: sudo pigpiod -g

# Development notes
#
# Ex:
# pigs write 22 1 mils 1000 w 22 0

# Write: pigs w 22 1
# pl - pulse length (1-100) with us.

# R/READ g - Read GPIO level;
# This reads the current level of GPIO g.

# W/WRITE g L - Write GPIO level
# This command sets GPIO g to level L.  The level may be 0 (low, off, clear) or 1 (high, on, set).

# MICS v Microseconds delay
# MILS v Milliseconds delay


# param $1 : the pin to pulse
function pulse_pin() {
  local pin=$1
  toggle_pin $pin
  sleep 0.1
  toggle_pin $pin
}

# Returns the value of a pin (0 or 1) and dies on failure
# param $1 : the pin to read
function read_pin() {
  local pin=$1
  value=$(pigs read $pin 2>/dev/null)
  if [ $value -lt 0 ]; then
    exit $?
  fi  
  echo $value
}

# Writes a value to a pin and dies on failure
# param $1 : output pin
# param $2 : value
function write_pin() {
  local pin=$1
  local value=$1
  pigs write $pin $value || echo trouble && exit 1
}

# Changes the value of a pin and dies on failure
# param $1 : The pin to change
function toggle_pin() {
  local pin=$1
  value=$(read_pin $pin)

  if [ $value -lt 0 ]; then
    echo "Something horrible happened reading pin $pin"
    exit $value
  fi

  local new_value=0
  if [ $value -eq 0 ]; then
    new_value=1
  fi

  pigs write $pin $new_value
  if [ $? -ne 0 ]; then
    echo "Something horrible happened writing pin $pin"
    exit 1
  fi
}
