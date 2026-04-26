module FSM (
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic ack,
    output logic [1:0] state_out,
    output logic read_en,
    output logic process_en,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        READ    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Status register (sequential)
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Logic of the next state (combinational)
    always_comb begin
        next_state = current_state;  

        case (current_state)
            IDLE: begin
                if (start)
                    next_state = READ;
            end

            READ: begin
                next_state = PROCESS;
            end

            PROCESS: begin
                next_state = DONE;
            end

            DONE: begin
                if (ack)
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // output logic (combinational)
    always_comb begin
        
        read_en = 1'b0;
        process_en = 1'b0;
        done = 1'b0;
        state_out = current_state;

        case (current_state)
            IDLE: begin
            end
            READ: begin
                read_en = 1'b1;
            end
            PROCESS: begin
                process_en = 1'b1;
            end
            DONE: begin
                done = 1'b1;
            end
        endcase
    end

endmodule