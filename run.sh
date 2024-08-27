#!/bin/bash

SRC_PATH="/home/nirdesh/vicharak/github-work/8-bit-cpu/src"

iverilog -o cpu_tb.vpp "$SRC_PATH/alu.v" "$SRC_PATH/control_unit.v" "$SRC_PATH/cpu_module.v" "$SRC_PATH/instruction_decoder.v" "$SRC_PATH/memory.v" "$SRC_PATH/program_counter.v" "$SRC_PATH/register.v" "/home/nirdesh/vicharak/github-work/8-bit-cpu/testbench/cpu_tb.v"
