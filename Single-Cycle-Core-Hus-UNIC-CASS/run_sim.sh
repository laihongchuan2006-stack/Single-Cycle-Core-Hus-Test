#!/bin/bash
set -e
echo "Bien dich va mo phong kiem tra 13 file RTL trong src/..."
iverilog -o sim_top.vvp sim/tb_mips_top.v src/*.v
vvp sim_top.vvp
