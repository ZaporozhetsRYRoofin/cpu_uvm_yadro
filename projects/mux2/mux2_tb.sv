module mux2_tb;
    logic c, a, b, out;
    
    mux2 dut(
        .a(a),
        .b(b),
        .c(c),
        .out(out)
    );

    initial begin
        c = 0; a = 0; b = 0; #10;
        c = 0; a = 0; b = 1; #10;
        c = 0; a = 1; b = 0; #10;
        c = 0; a = 1; b = 1; #10;
        c = 1; a = 0; b = 0; #10;
        c = 1; a = 0; b = 1; #10;
        c = 1; a = 1; b = 0; #10;
        c = 1; a = 1; b = 1; #10;
        $finish;
    end

    initial $monitor("Time = %0t | c = %b a = %b b = %b | out = %b", $time, c, a, b, out);
endmodule