## Cấu trúc thư mục
```text
Single-Cycle-Core-Hus-UNIC-CASS/
├── config.json          # File cấu hình chuẩn cho LibreLane / OpenLane (UNIC-CASS)
├── run_sim.sh           # Script kiểm tra nhanh mô phỏng RTL trước khi tổng hợp
├── README.md            # Hướng dẫn chạy Full Flow
├── src/                 # Chứa ĐÚNG 13 file RTL thuần (Không chứa testbench, không dấu cách)
│   ├── mips_top.v
│   ├── main_control.v
│   ├── alu_decoder.v
│   ├── alu.v
│   ├── datapath.v
│   ├── regfile.v
│   ├── imem.v           # Đã chuyển sang mạch ROM tổ hợp (không dùng $readmemh)
│   ├── dmem.v           # Đã tối ưu 32 words (giảm 50% Flip-Flop chống nghẽn routing)
│   ├── adder.v
│   ├── flopr.v
│   ├── mux2.v
│   ├── signext.v
│   └── sl2.v
└── sim/                 # Tách biệt hoàn toàn Testbench ra khỏi thư mục src/
    └── tb_mips_top.v
```

