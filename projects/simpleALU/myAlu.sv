module myAlu (
    input logic [7:0] a, 
    input logic [7:0] b, 
    input logic [2:0] coo, // cod of operation
    output logic [7:0] result,
    output bit zero,
    output bit overflow
);
    logic [7:0] res;
    always_comb begin 
        case (coo)
            3'b000: res = a + b;
            3'b001: res = a - b;        
            3'b010: res = a & b;        
            3'b011: res = a | b;        
            3'b100: res = a ^ b;       
            3'b101: res = ~a;           
            3'b110: res = a + 1;        
            3'b111: res = a - 1;    
            default: res = 8'b0;
        endcase
    end

    assign result = res;
    assign zero = (result === 8'b0);
    assign overflow = (coo == 3'b0) && (a[7] == b[7]) && (res[7] != a[7]);


endmodule