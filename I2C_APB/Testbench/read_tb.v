module read_tb;
    reg             PCLK;
    reg             PRESETn;
    reg             PENABLE;
    reg             PSELx;
    reg             PWRITE;
    reg [7:0]       PADDR;
    reg [7:0]       PWDATA;

    reg             sda_in;
    reg             scl_in;
    reg             core_clk;

    wire [7:0]      PRDATA;
    wire            PREADY;
    wire            sda_out;
    wire            scl_out;

    top_level dut
    (
        .PCLK       (PCLK),
        .PRESETn    (PRESETn),
        .PSELx      (PSELx),
        .PWRITE     (PWRITE),
        .PENABLE    (PENABLE),
        .PADDR      (PADDR),
        .PWDATA     (PWDATA),
        .sda_in     (sda_in),
        .scl_in     (scl_in),
        .core_clk   (core_clk),

        .PREADY     (PREADY),
        .PRDATA     (PRDATA),
        .sda_out    (sda_out),
        .scl_out    (scl_out)
    );

    
    always #20 core_clk= ~core_clk;

	always #5 PCLK= ~PCLK;

    initial begin
        core_clk = 1;
        PCLK = 1;
        PRESETn = 0;
        PWRITE = 0;
        PSELx = 0;
        PENABLE = 0;
        sda_in = 1;
        scl_in = 1;

        #100;
        PRESETn = 1;

        // Prescale reg = 1
        #10;
        PADDR = 8'b00100000;
        PWRITE = 1;
        PSELx = 1;
        PENABLE = 0;
        PWDATA = 8'd4;
        #10;
        PENABLE = 1;

        // Address reg = 2
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b01000000;
        PWRITE = 1;
        PSELx = 1;
        PWDATA = 8'b11110001;
        PENABLE = 0;    
        #10;
        PENABLE = 1; 

        // Status reg = 3
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b01100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Command reg = 5;
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b11000000;
        PWRITE = 1;
        PSELx = 1;
        PENABLE = 0; 
        PWDATA = 8'b10010000;
        #10;
        PENABLE = 1;
        #10;
        PSELx = 0;
        #3380;
        
        // READ DATA 1
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;

        // ACK DATA 1
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #160;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #160;
        sda_in = 1;
        #160;
        sda_in = 0;
        // READ DATA 3
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 1;

        // READ DATA 4
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;

        // READ DATA 5
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;

        // READ DATA 6
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 1;
        #320;
        sda_in = 0;

        // READ DATA 7
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 1;
        #320;
        sda_in = 1;

        // READ DATA 8
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 1;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;
        #320;
        sda_in = 0;

        // Command reg = 6;
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b11000000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        PWDATA = 8'b10110000;
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 1
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 2
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 3
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 4
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 5
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 6
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        // Receive reg = 5 data 7
        #10;
        PSELx = 0;
        #10;
        PADDR = 8'b10100000;
        PWRITE = 0;
        PSELx = 1;
        PENABLE = 0; 
        #10;
        PENABLE = 1;

        #5000;
        $finish;

    end
endmodule