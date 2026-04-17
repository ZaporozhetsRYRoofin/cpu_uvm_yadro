module Decoder2to4 (
    input  logic [1:0] in,       // 2-bit
    input  logic en,             // Enable (разрешение)
    output logic [3:0] out       // 4-bit
);

    always_comb begin
        if (!en) begin
            // if en = 0 ——— out = 0
            out = 4'b0000;
        end
        else begin
            ///: first out = 1, other = 0
            case (in)
                2'b00: out = 4'b0001;  // Бит 0 активен
                2'b01: out = 4'b0010;  // Бит 1 активен
                2'b10: out = 4'b0100;  // Бит 2 активен
                2'b11: out = 4'b1000;  // Бит 3 активен
                default: out = 4'b0000;
            endcase
        end
    end

endmodule