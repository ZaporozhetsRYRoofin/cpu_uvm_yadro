module mux2 (
    input logic a,
    input logic b,
    input logic c, // celector
    output logic out
);
    assign out = c ? b : a;
endmodule