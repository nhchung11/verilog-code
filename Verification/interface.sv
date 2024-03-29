`ifndef INTF 
`define INTF
interface intf_i2c(input pclk, core_clk);
    logic [7:0]     pwdata;
    logic [7:0]     prdata;
    logic [7:0]     paddr;
    logic           preset_n;
    logic           penable;
    logic           pselx;
    logic           pwrite;
    logic           pready;
    logic           rw;

    wire [7:0]      slave_address;
    wire [7:0]      write_data;
    wire            sda;
    wire            scl;    
endinterface 
`endif 