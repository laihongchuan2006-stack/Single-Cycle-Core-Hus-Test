#!/bin/bash
set -e

echo "=================================================="
echo "1. Chay Testbench Main Control (Thanh vien 1)..."
echo "=================================================="
iverilog -o sim_ctrl.vvp \
  "Main Modules Designs/Main_control_unit/main_control.v" \
  "Main Modules Designs/Main_control_unit/tb_main_control.v"
vvp sim_ctrl.vvp

echo ""
echo "=================================================="
echo "2. Chay Testbench ALU & ALU Decoder (Thanh vien 2 & 3)..."
echo "=================================================="
iverilog -o sim_alu.vvp \
  "Main Modules Designs/Alu Core/alu.v" \
  "Main Modules Designs/Alu Core/alu_decoder.v" \
  "Main Modules Designs/Alu Core/tb_alu.v"
vvp sim_alu.vvp

echo ""
echo "=================================================="
echo "3. Chay Testbench Datapath Helpers (Thanh vien 4)..."
echo "=================================================="
iverilog -o sim_helpers.vvp \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/adder.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/flopr.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/mux2.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/signext.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/sl2.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/tb_helpers.v"
vvp sim_helpers.vvp

echo ""
echo "=================================================="
echo "4. Chay Testbench Datapath Interconnect (Thanh vien 4)..."
echo "=================================================="
iverilog -o sim_dp.vvp \
  "Main Modules Designs/Datapath_Interconnect/datapath.v" \
  "Main Modules Designs/Datapath_Interconnect/regfile.v" \
  "Main Modules Designs/Alu Core/alu.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/adder.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/flopr.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/mux2.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/signext.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/sl2.v" \
  "Main Modules Designs/Datapath_Interconnect/tb_datapath.v"
vvp sim_dp.vvp

echo ""
echo "=================================================="
echo "5. Chay Testbench Top-Level MIPS CPU (Thanh vien 5 & 6)..."
echo "=================================================="
iverilog -o sim_top.vvp \
  "Main Modules Designs/Top_Level/tb_mips_top.v" \
  "Main Modules Designs/Top_Level/mips_top.v" \
  "Main Modules Designs/Top_Level/imem.v" \
  "Main Modules Designs/Top_Level/dmem.v" \
  "Main Modules Designs/Main_control_unit/main_control.v" \
  "Main Modules Designs/Alu Core/alu_decoder.v" \
  "Main Modules Designs/Alu Core/alu.v" \
  "Main Modules Designs/Datapath_Interconnect/datapath.v" \
  "Main Modules Designs/Datapath_Interconnect/regfile.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/adder.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/flopr.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/mux2.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/signext.v" \
  "Main Modules Designs/Datapath_Interconnect/Datapath_Helpers/sl2.v"
vvp sim_top.vvp
