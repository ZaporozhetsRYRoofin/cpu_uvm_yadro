module bitcounter_tb;
    logic clk, reset, load;
    logic [7:0] data_in;
    logic [7:0] count;

    bitcounter dut(
        .clk(clk),
        .reset(reset),
        .load(load),
        .data_in(data_in),
        .count(count)
    ); 

    initial begin
        $dumpfile("8bit.vcd");
        $dumpvars(0, bitcounter_tb);
    end

    initial begin
        $monitor("time = %0t | reset = %b | load = %b | data_in = %3d | count = %3d",
        $time, reset, load, data_in, count);
    end

    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Период = 20 единиц
    end

    initial begin
        // Инициализация
        reset = 0;
        load = 0;
        data_in = 0;

        // ТЕСТ 1: RESET
        reset = 1;
        #20;
        if (count === 0)
            $display("Rabotaet - RESET");
        else
            $display(" EROR - RESET");
        
        reset = 0;
        #20;
        if (count === 1)
            $display("Rapotaet - SCHET");
        
        // ТЕСТ 2: LOAD 100
        load = 1;
        data_in = 100;
        #20;
        load = 0;  // ← Снимаем load!
        if (count === 100)
            $display("Zagruzka - RABOTAET");
        else
            $display("EROR --- ZAGRYZKA = %d", count);

        // ТЕСТ 3: ПЕРЕПОЛНЕНИЕ (254 → 255 → 0)
        load = 1;
        data_in = 254;
        #20;
        load = 0;  // ← КРИТИЧНО! Снимаем load перед счётом!
        
        if (count === 254)
            $display("Zagruzka 254 = %d", count);
        else
            $display("EROR 254 = %d", count);
        
        #20;  // Такт 1: 254 → 255
        if (count === 255)
            $display("GOOD - doschital do 255");
        else
            $display("BAD - ne 255, a %d", count);
        
        #20;  // Такт 2: 255 → 0 (ПЕРЕПОЛНЕНИЕ!)
        if (count === 0)
            $display("YRA rabotaet - perepolnenie!");
        else
            $display("BLIN ne 0, a %d", count);
        
        // ТЕСТ 4: ASYNC RESET
        #40;
        reset = 1;
        #20;  // half
        if (count === 0)
            $display("Rabotaet assync reset");
        else
            $display("Slonali reset async");
        
        $finish;
    end
endmodule