module PriorityEncoder (
    input  logic [3:0] in,
    output logic [1:0] out,
    output logic valid
);

    // Внутренние сигналы для флагов (избегаем бит-селектов в always_comb)
    logic in3_active;
    logic in2_active;
    logic in1_active;
    logic in0_active;

    // Преобразуем биты в отдельные сигналы
    assign in3_active = in[3];
    assign in2_active = in[2];
    assign in1_active = in[1];
    assign in0_active = in[0];

    // Приоритетная логика
    always_comb begin
        // Значения по умолчанию (защита от защелок)
        out = 2'b00;
        valid = 1'b0;

        // Приоритет: старший бит имеет высший приоритет
        if (in3_active) begin
            out = 2'b11;  // 3
            valid = 1'b1;
        end
        else if (in2_active) begin
            out = 2'b10;  // 2
            valid = 1'b1;
        end
        else if (in1_active) begin
            out = 2'b01;  // 1
            valid = 1'b1;
        end
        else if (in0_active) begin
            out = 2'b00;  // 0
            valid = 1'b1;
        end
        else begin
            out = 2'b00;
            valid = 1'b0;
        end
    end

endmodule