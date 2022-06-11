#!/bin/bash

source pig_gpio_utils.sh || { echo "Failed to source pig_gpio_utils.sh"; exit 1; }


# Pull low to clear.                                        10
SRCLR_PIN=21  # black

# Clock
# Positive-edge triggered.                                  11
SRCLK_PIN=20  # white

# Positive-edge triggered.
# Shift-register data is stored in the storage register     12
RCLK_PIN=16 

# Output enable (Low)                                       13
OE_PIN=12  # red

# Low to write when clock is high                           14
SER_PIN=25  # blue


# Get started


action=""
while [[ "$action" != "x" ]]; do

  # Get state
  srclr_val=$(read_pin $SRCLR_PIN)
  srclk_val=$(read_pin $SRCLK_PIN)
  rclk_val=$(read_pin  $RCLK_PIN)
  oe_val=$(read_pin  $OE_PIN)
  ser_val=$(read_pin  $SER_PIN)

  echo
  echo "-------------------------------------------------------------"
  echo "SRCLR   : $srclr_val"
  echo "SRCLK   : $srclk_val"
  echo "RCLK    : $rclk_val"
  echo "OE      : $oe_val"e
  echo "SER     : $ser_val"
  echo "-------------------------------------------------------------"
  echo
  echo "ser clear     : X"
  echo "ser clock     : c"
  echo "reg clock     : r"
  echo "both clocks   : C"
  echo "output enable : o"
  echo "serial input  : s"
  echo "Exit  : x"
  echo
  read -p "Choice: " action

  case $action in
    X) toggle_pin $SRCLR_PIN
      ;;
    c) toggle_pin $SRCLK_PIN
    ;;
    r) toggle_pin $RCLK_PIN
      ;;
    C)
      toggle_pin $SRCLK_PIN
      toggle_pin $RCLK_PIN
      ;;
    o) toggle_pin $OE_PIN
      ;;
    s) toggle_pin $SER_PIN
      ;;
    x)
    ;;
    *)
      echo "I don't understand choice $action"
  esac
done

echo "All done."
