module dff_tb;
    logic clk, rst, d, q;

    dff dut(
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );

    initial begin
        $dumpfile("dff.vcd"); // creating file for wave
        $dumpvars(0, dff_tb); // writing all signals
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; d = 0;
        #15; rst = 0; /// Checking reset
        #10; d = 1;
        #20; d = 0;
        #20; d = 1;
        #20; rst = 1; /// asynchronous reset
        #10; rst = 0;
        #20; $finish;
    end

    initial begin
        $monitor("Time = %0t | clk = %b rst = %b d = %b | q = %b", $time, clk, rst, d, q);
    end


endmodule