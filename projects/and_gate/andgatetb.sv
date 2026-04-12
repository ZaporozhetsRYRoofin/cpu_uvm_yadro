module angatetb;
    logic a, b, out;

    or_gate dut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        a = 0;
        b = 0;
        #10;

        a = 0;
        b = 1;
        #10;

        a = 1;
        b = 0;
        #10;

        a = 1;
        b = 1;
        #10;

        $finish;
    end
    initial begin
        $monitor("time = %0t | a = %b b = %b | out = %b", $time, a,b,out);
    end


endmodule