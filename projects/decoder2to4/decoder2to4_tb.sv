module Decoder2to4_tb;

    logic [1:0] in;
    logic en;
    logic [3:0] out;

    Decoder2to4 dut (.in(in), .en(en), .out(out));

    // Запись волн
    initial begin
        $dumpfile("Decoder2to4.vcd");
        $dumpvars(0, Decoder2to4_tb);
    end

    // Мониторинг
    initial begin
        $monitor("Time=%0t | en=%b in=%b | out=%b", $time, en, in, out);
    end

    // Тесты
    initial begin
        // Тест 1: en=0 → все выходы 0
        en = 0; in = 2'b00; #10;
        if (out === 4'b0000) $display(" Тест 1 passed (en=0)");
        else $error(" Тест 1 failed");

        // Тест 2: en=1, in=00 → out=0001
        en = 1; in = 2'b00; #10;
        if (out === 4'b0001) $display(" Тест 2 passed (in=00)");
        else $error(" Тест 2 failed");

        // Тест 3: en=1, in=01 → out=0010
        en = 1; in = 2'b01; #10;
        if (out === 4'b0010) $display("Тест 3 passed (in=01)");
        else $error(" Тест 3 failed");

        // Тест 4: en=1, in=10 → out=0100
        en = 1; in = 2'b10; #10;
        if (out === 4'b0100) $display(" Тест 4 passed (in=10)");
        else $error("Tест 4 failed");

        // Тест 5: en=1, in=11 → out=1000
        en = 1; in = 2'b11; #10;
        if (out === 4'b1000) $display("Тест 5 passed (in=11)");
        else $error("Тест 5 failed");

        $display("\n=== ВСЕ ТЕСТЫ DECODER ЗАВЕРШЕНЫ ===");
        #10 $finish;
    end

endmodule