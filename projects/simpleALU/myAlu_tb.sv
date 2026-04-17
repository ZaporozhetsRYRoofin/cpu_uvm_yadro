module myAlu_tb;
    logic [7:0] a, b, result;
    bit zero, overflow;
    logic [2:0] coo;

    myAlu dut(
        .a(a),
        .b(b),
        .result(result),
        .zero(zero),
        .overflow(overflow),
        .coo(coo)
    );

    initial begin
        $dumpfile("myALU.vcd");
        $dumpvars(0, myAlu_tb);
    end

    initial begin
        $monitor ("Time =%0t | coo = %b --- a = %d --- b = %d | result = %d --- overflow = %b ----- zero = %b",
         $time, coo, a, b, result, overflow, zero);
    end
    /// ---- Start testing ---- ///
    initial begin

        a = 10; b = 20; coo = 3'b000; #20;
        if (result === 30)
            $display("Passed -- + --");
        else
            $display("ERROR --- + ---");

        // --------------///

        a = 50; b = 20; coo = 3'b001; #10;
        if (result === 30)
            $display("Passed -");
        else
            $display("Eror minus");

        // --------------///

        a = 8'hFF; b = 8'h0F; coo = 3'b010; #10;
        if (result === 8'h0F) $display("AND passed");
        else $error(" AND failed: %h", result);

        // --------------///
        a = 8'hF0; b = 8'h0F; coo = 3'b011; #10;
        if (result === 8'hFF) $display("OR passed");
        else $error(" OR failed: %h", result);

        // --------------///
        a = 5; b = 5; coo = 3'b001; #10;
        if (zero === 1'b1) $display("ZERO flag passed");
        else $error("ZERO flag failed");

        // --------------///
        a = 8'hAA; coo = 3'b101; #10;
        if (result === 8'h55) $display("NOT passed --- its good");
        else $error("NOT failed: %h", result);

        $display("\n=== All DONE ===");
        #10 $finish;

    end

endmodule