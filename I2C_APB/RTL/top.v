module top_level
    #(parameter data_size = 8,parameter address_size = 3)  
    (
        // Inputs
        input                           PCLK,
        input                           PRESETn,
        input                           PENABLE,
        input                           PSELx,
        input                           PWRITE,
        input [7:0]                     PADDR,
        input [data_size - 1:0]         PWDATA,
        
        input                           sda_in,
        input                           core_clk,

        output [data_size - 1:0]        PRDATA,
        output                          PREADY,
        output                          scl_out,
        output                          sda_out
    );
    // Internal register
    wire [data_size - 1:0]              prescale_reg;
    wire [data_size - 1:0]              command_reg;
    wire [data_size - 1:0]              status_reg;
    wire [data_size - 1:0]              transmit_reg;
    wire [data_size - 1:0]              receive_reg;
    wire [data_size - 1:0]              address_reg;    

    // FIFO inputs and outputs
    wire [data_size - 1:0]              TX;
    wire [data_size - 1:0]              RX;
    wire [data_size - 1:0]              APB_RX;
    wire                                i2c_clk_gen;

    assign command_reg [4:0]        =   0;
    assign status_reg [3:0]         =   0;
    

    // FIFO TX
    FIFO_top #(data_size, address_size) fifo_tx
    (
        .write_data                     (transmit_reg),
        .write_enable                   (command_reg[7]),
        .write_clk                      (PCLK),
        .write_reset_n                  (command_reg[6]),
        
        .read_enable                    (command_reg[7]),
        .read_clk                       (core_clk),
        .read_reset_n                   (command_reg[6]),

        .read_data                      (TX),
        .write_full                     (status_reg[7]),
        .read_empty                     (status_reg[5])
    );

    // FIFO RX
    FIFO_top #(data_size, address_size) fifo_rx
    (
        .write_data                     (RX),
        .write_enable                   (command_reg[7]),
        .write_clk                      (core_clk),
        .write_reset_n                  (command_reg[6]),
        
        .read_enable                    (command_reg[7]),
        .read_clk                       (PCLK),
        .read_reset_n                   (command_reg[6]),

        .read_data                      (APB_RX),
        .write_full                     (status_reg[4]),
        .read_empty                     (status_reg[6])
    );

    // APB INTERFACE
    apb apb
    (
        .PCLK                           (PCLK),
        .PRESETn                        (PRESETn),
        .PENABLE                        (PENABLE),
        .PSELx                          (PSELx),
        .PWRITE                         (PWRITE),
        .PADDR                          (PADDR),
        .PWDATA                         (PWDATA),
        .PREADY                         (PREADY),
        .PRDATA                         (PRDATA),
        
        .prescale_reg                   (prescale_reg),
        .command_reg                    (command_reg),
        .status_reg                     (status_reg),
        .transmit_reg                   (transmit_reg),
        .receive_reg                    (APB_RX),
        .address_reg                    (address_reg)
    );

    i2c_controller i2c_controller
    (
        .core_clk                       (core_clk),
        .i2c_clk                        (i2c_clk_gen),
        .rst_n                          (command_reg[6]),
        .enable                         (command_reg[7]),
        .slave_address                  (address_reg),
        .data_in                        (TX),
        .repeated_start_cond            (command_reg[5]),
        .sda_in                         (sda_in),
        .sda_out                        (sda_out),
        .scl_out                        (scl_out)
    );

    BitToByteConverter bit_to_byte_converter
    (
        .clk                            (core_clk),
        .rst_n                          (command_reg[4]),
        .in                             (sda_in),
        .enable                         (command_reg[7]),
        .out                            (RX)
    );
    ClockGenerator clock_gen
    (
        .core_clk                       (core_clk),
        .prescale                       (prescale_reg),
        .rst_n                          (command_reg[6]),
        .i2c_clk                        (i2c_clk_gen)
    );
endmodule