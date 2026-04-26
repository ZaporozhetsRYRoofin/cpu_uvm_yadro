module FSM_tb;

    logic clk;
    logic rst;
    logic start;
    logic ack;
    logic [1:0] state_out;
    logic read_en;
    logic process_en;
    logic done;

    FSM dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .ack(ack),
        .state_out(state_out),
        .read_en(read_en),
        .process_en(process_en),
        .done(done)
    );

   
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

   
    initial begin
        $dumpfile("FSM_Controller.vcd");
        $dumpvars(0, FSM_tb);
    end

   
    initial begin
        $monitor("Time=%0t | state=%b start=%b ack=%b | read=%b proc=%b done=%b", 
                 $time, state_out, start, ack, read_en, process_en, done);
    end


    initial begin
      

        
        rst = 0; start = 0; ack = 0;

        // TEST 1: reset
        rst = 1; #10;
        rst = 0; #10;
        if (state_out === 2'b00) $display("PASS: reset at IDLE");
        else $error("FAIL: reset, state=%b", state_out);

        // TEST 2: start (IDLE -> READ)
        start = 1; #10;
        start = 0;
        #10;
        if (state_out === 2'b01) $display("PASS: move to READ");
        else $error("FAIL: READ, state=%b", state_out);

        // TEST 3: autonatic transition  (READ -> PROCESS)
        #10;
        if (state_out === 2'b10) $display("PASS: Move to PROCESS");
        else $error("FAIL: PROCESS, state=%b", state_out);

        // TEST 4: autonatic transition (PROCESS -> DONE)
        #10;
        if (state_out === 2'b11) $display("PASS: move to DONE");
        else $error("FAIL: DONE, state=%b", state_out);

        // TEST 5: (DONE -> IDLE)
        ack = 1; #10;
        ack = 0;
        #10;
        if (state_out === 2'b00) $display("PASS: return IDLE");
        else $error("FAIL: IDLE, state=%b", state_out);

        // TEST 6: full cycle again
        start = 1; #10;
        start = 0;
        #40;
        ack = 1; #10;
        ack = 0;
        #10;
        if (state_out === 2'b00) $display("PASS: full cycle 2");
        else $error("FAIL: full cycle 2");

        // TEST 7: start during operation (ignoring)
        start = 1; #10;
        start = 0;
        #10;  // in PROCESS
        start = 1; #10;  // try to launch again
        start = 0;
        #10;
        if (state_out === 2'b11) $display("PASS: start ignore");
        else $error("FAIL: start ignor, state=%b", state_out);

        #20 $finish;
    end

endmodule