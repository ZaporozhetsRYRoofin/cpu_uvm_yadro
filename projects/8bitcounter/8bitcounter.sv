module bitcounter (
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    input logic load,
    output logic [7:0] count
);
 always_ff @( posedge clk or negedge reset ) begin
    if (reset) begin
        count <= 8'b0;
    end
    else if (load) begin
        count <= data_in;
    end
    else begin
        count <= count + 1;
    end
 end

endmodule