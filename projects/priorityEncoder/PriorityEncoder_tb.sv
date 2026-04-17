module PriorityEncoder_tb;

    // Сигналы
    logic [3:0] in;
    logic [1:0] out;
    logic valid;

    // Подключение DUT
    PriorityEncoder dut (
        .in(in),
        .out(out),
        .valid(valid)
    );

    // Запись волн
    initial begin
        $dumpfile("PriorityEncoder.vcd");
        $dumpvars(0, PriorityEncoder_tb);
    end

    // Мониторинг
    initial begin
        $monitor("Time=%0t | in=%b | out=%b valid=%b", 
                 $time, in, out, valid);
    end

    // Тесты
    initial begin
        $display("\n=== ТЕСТЫ PRIORITY ENCODER ===");

        // Тест 1: Все входы 0
        in = 4'b0000; #10;
        if (out === 2'b00 && valid === 1'b0)
            $display("PASS: Тест 1 (все 0)");
        else
            $error("FAIL: Тест 1 (ожидал out=00, valid=0)");

        // Тест 2: Только бит 0 активен
        in = 4'b0001; #10;
        if (out === 2'b00 && valid === 1'b1)
            $display("PASS: Тест 2 (бит 0)");
        else
            $error("FAIL: Тест 2 (ожидал out=00, valid=1)");

        // Тест 3: Только бит 1 активен
        in = 4'b0010; #10;
        if (out === 2'b01 && valid === 1'b1)
            $display("PASS: Тест 3 (бит 1)");
        else
            $error("FAIL: Тест 3 (ожидал out=01, valid=1)");

        // Тест 4: Только бит 2 активен
        in = 4'b0100; #10;
        if (out === 2'b10 && valid === 1'b1)
            $display("PASS: Тест 4 (бит 2)");
        else
            $error("FAIL: Тест 4 (ожидал out=10, valid=1)");

        // Тест 5: Только бит 3 активен
        in = 4'b1000; #10;
        if (out === 2'b11 && valid === 1'b1)
            $display("PASS: Тест 5 (бит 3)");
        else
            $error("FAIL: Тест 5 (ожидал out=11, valid=1)");

        // Тест 6: ПРИОРИТЕТ - биты 0 и 3 активны одновременно
        in = 4'b1001; #10;
        if (out === 2'b11 && valid === 1'b1)
            $display("PASS: Тест 6 (приоритет: 0+3 -> 3)");
        else
            $error("FAIL: Тест 6 (ожидал out=11, valid=1)");

        // Тест 7: ПРИОРИТЕТ - биты 1 и 2 активны одновременно
        in = 4'b0110; #10;
        if (out === 2'b10 && valid === 1'b1)
            $display("PASS: Тест 7 (приоритет: 1+2 -> 2)");
        else
            $error("FAIL: Тест 7 (ожидал out=10, valid=1)");

        // Тест 8: ПРИОРИТЕТ - все биты активны
        in = 4'b1111; #10;
        if (out === 2'b11 && valid === 1'b1)
            $display("PASS: Тест 8 (приоритет: все -> 3)");
        else
            $error("FAIL: Тест 8 (ожидал out=11, valid=1)");

        // Тест 9: ПРИОРИТЕТ - биты 0, 1, 2 активны
        in = 4'b0111; #10;
        if (out === 2'b10 && valid === 1'b1)
            $display("PASS: Тест 9 (приоритет: 0+1+2 -> 2)");
        else
            $error("FAIL: Тест 9 (ожидал out=10, valid=1)");

        $display("\n=== ВСЕ ТЕСТЫ ЗАВЕРШЕНЫ ===");
        #10 $finish;
    end

endmodule