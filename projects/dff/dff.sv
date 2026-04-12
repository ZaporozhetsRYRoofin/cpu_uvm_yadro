module dff (
    input logic clk,
    input logic rst, // reset asynchronous
    input logic d,
    output logic q
);
    always_ff @(posedge clk or negedge rst) begin
        if(rst)
            q <= 1'b0; // When reset : q = 0
        else
            q <= d; 
    end

endmodule 