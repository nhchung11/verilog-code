`include "env.sv"

program testcase(intf_i2c intf);
    environment env = new(intf);
    initial begin
        fork
            env.mntr.START_CHECK();
            env.mntr.ADDRESS_CHECK();
            // env.mntr.DATA_WRITE_CHECK();
            env.mntr.STOP_CHECK();
        begin
            env.drvr.RESET();
            env.drvr.WRITE(8, 8, 7'b001_0000, 1);
        end
        join_any
    end
endprogram