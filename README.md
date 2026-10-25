# Single-Cycle-Core-Hus
Đồ án Thiết kế Vi xử lý MIPS 32-bit Đơn chu kỳ (Single-Cycle MIPS Processor) - HUS.

## Cấu trúc thư mục chuẩn hóa
```text
Single-Cycle-Core-Hus/
├── README.md
├── memfile.dat                  # Chương trình máy kiểm thử toàn bộ tập lệnh MIPS
├── run_sim.sh                   # Script tự động chạy toàn bộ 4 Testbench trên WSL/Linux
└── Main Modules Designs/
    ├── Main_control_unit/       # [Thành viên 1] Main Control Unit
    │   ├── main_control.v
    │   └── tb_main_control.v
    ├── Alu Core/                # [Thành viên 2 & 3] ALU Decoder & ALU Core
    │   ├── alu_decoder.v
    │   ├── alu.v
    │   └── tb_alu.v
    ├── Datapath_Interconnect/   # [Thành viên 4] Datapath & Helpers
    │   ├── datapath.v
    │   ├── regfile.v
    │   ├── tb_datapath.v
    │   └── Datapath_Helpers/
    │       ├── adder.v
    │       ├── flopr.v
    │       ├── mux2.v
    │       ├── signext.v
    │       ├── sl2.v
    │       └── tb_helpers.v
    └── Top_Level/               # [Thành viên 5 & 6] Tích hợp Top-Level, Bộ nhớ & Kiểm thử hệ thống
        ├── imem.v
        ├── dmem.v
        ├── mips_top.v
        ├── tb_mips_top.v
        └── memfile.dat
```

## Hướng dẫn chạy mô phỏng ngay lập tức (WSL / Ubuntu)

Mở Terminal tại thư mục gốc `Single-Cycle-Core-Hus` và chạy lệnh:

### 1. Chạy kiểm thử toàn hệ thống (Top-Level CPU MIPS)
```bash
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
gtkwave mips_top_waveform.vcd
```

### 2. Hoặc chạy tự động tất cả 4 Testbench bằng 1 lệnh duy nhất:
```bash
bash run_sim.sh
```
