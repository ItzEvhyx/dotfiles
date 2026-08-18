#!/bin/bash
sleep 4
sudo modprobe -r i2c_hid_acpi i2c_hid
sleep 2
sudo modprobe i2c_hid i2c_hid_acpi
