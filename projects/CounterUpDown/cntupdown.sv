module CounterUpDown (
    input  logic clk,
    input  logic rst,
    input  logic load,
    input  logic en,
    input  logic up_down,
    input  logic [7:0] data_in,
    output logic [7:0] count,
    output logic overflow,
    output logic underflow
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 8'b0;
        end
        else if (load) begin
            count <= data_in;
        end
        else if (en) begin
            if (up_down) begin
                count <= count + 1;
            end
            else begin
                count <= count - 1;
            end
        end
    end

    assign overflow = (count == 8'd255) && en && up_down;
    assign underflow = (count == 8'd0) && en && !up_down;

endmodule