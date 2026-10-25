# Single-Cycle-Core-Hus
Đồ án Thiết kế Vi xử lý MIPS 32-bit Đơn chu kỳ (Single-Cycle MIPS Processor) - HUS.

## Cấu trúc thư mục chuẩn hóa
```text
Single-Cycle-Core-Hus/
├── README.md
├── memfile.dat                  # Chương trình máy kiểm thử toàn bộ tập lệnh MIPS
├── run_sim.sh                   # Script tự động chạy toàn bộ 4 Testbench trên WSL/Linux
└── Main Modules Designs/
    ├── Main_control_unit/      
    │   ├── main_control.v
    │   └── tb_main_control.v
    ├── Alu Core/                
    │   ├── alu_decoder.v
    │   ├── alu.v
    │   └── tb_alu.v
    ├── Datapath_Interconnect/   
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
    └── Top_Level/               
        ├── imem.v
        ├── dmem.v
        ├── mips_top.v
        ├── tb_mips_top.v
        └── memfile.dat
```
