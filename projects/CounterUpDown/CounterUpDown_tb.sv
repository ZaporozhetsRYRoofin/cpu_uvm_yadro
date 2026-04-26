module CounterUpDown_tb;

    logic clk;
    logic rst;
    logic load;
    logic en;
    logic up_down;
    logic [7:0] data_in;
    logic [7:0] count;
    logic overflow;
    logic underflow;

    CounterUpDown dut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .en(en),
        .up_down(up_down),
        .data_in(data_in),
        .count(count),
        .overflow(overflow),
        .underflow(underflow)
    );

    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    
    initial begin
        $dumpfile("CounterUpDown.vcd");
        $dumpvars(0, CounterUpDown_tb);
    end


    initial begin
        $monitor("Time=%0t | rst=%b load=%b en=%b up=%b | count=%3d ovf=%b und=%b", 
                 $time, rst, load, en, up_down, count, overflow, underflow);
    end

    initial begin
    
        rst = 0; load = 0; en = 0; up_down = 1; data_in = 0;

        // test 1: reset
        rst = 1; #10;
        rst = 0; #10;
        if (count === 0) $display("PASS: reset");
        else $error("FAIL: reset, count=%d", count);

        // test 2: Count up
        en = 1; up_down = 1; #30;
        if (count === 3) $display("PASS: Count up (count=3)");
        else $error("FAIL: Count up, count=%d", count);

        // test 3: load data
        load = 1; data_in = 100; #10;
        load = 0;
        if (count === 100) $display("PASS: Загрузка 100");
        else $error("FAIL: Загрузка, count=%d", count);

        // test 4: Count down
        up_down = 0; #20;
        if (count === 98) $display("PASS: Count down (count=98)");
        else $error("FAIL: Count down, count=%d", count);

        //test 5: (en=0)
        en = 0; #10;
        if (count === 98) $display("PASS: pause (count=98)");
        else $error("FAIL: pause, count=%d", count);

        // Тест 6: overflow (255 -> 0)
        en = 1; up_down = 1;
        load = 1; data_in = 254; #10;
        load = 0;
        #10; // 255
        #10; // 0 (overflow)
        if (count === 0) $display("PASS: overflow (255->0)");
        else $error("FAIL: overflow, count=%d", count);

        // Тест 7: (0 -> 255)
        up_down = 0; #10;
        if (count === 255) $display("PASS: Подтверждение (0->255)");
        else $error("FAIL: Подтверждение, count=%d", count);

        // Test 8: overflow
        load = 1; data_in = 255; #10;
        load = 0;
        en = 1; up_down = 1; #10;
        if (overflow === 1) $display("PASS: overflow");
        else $error("FAIL: overflow");

        // test 9:  underflow
        load = 1; data_in = 0; #10;  
        load = 0;                     
        if (underflow === 0) $display("PASS: underflow=0 en=0");
        else $error("FAIL: underflow must be 0");

        en = 1; up_down = 0; 
        #1;  
        if (underflow === 1) $display("PASS: underflow");
        else $error("FAIL: underflow=%b, count=%d", underflow, count);

        #9;  
        if (count === 255) $display("PASS: 0 -> 255 (underflow)");
        else $error("FAIL: count=%d ", count);

        $display("DONE");
        #20 $finish;
    end

endmodule