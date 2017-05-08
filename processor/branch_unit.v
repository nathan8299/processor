`timescale 1ns / 1ps

module branch_unit(
  zero,
  less,
  greater,
  jop,
  flush,
  jump_address,
  );

  input wire zero;
  input wire less;
  input wire greater;
  input wire [`JUMP_BITS-1:0] jop;
  output reg flush;
  output reg jump_address;

  initial begin
    flush <= 0;
    jump_address <= 1;
  end

  always@(*) begin
  
    case(jop)
      `JMP_OP_NOP: flush <= 0;
      `JMP_OP_J:   flush <= 0;
      `JMP_OP_JR:  flush <= 1;

      `JMP_OP_JEQ: flush <= (zero == 1'b1);
      `JMP_OP_JNE: flush <= (zero == 1'b0);

      `JMP_OP_JL:  flush <= (less == 1'b1);
      `JMP_OP_JLE: flush <= (less == 1'b1);

      `JMP_OP_JG:  flush <= (greater == 1'b1);
      `JMP_OP_JGE: flush <= (greater == 1'b1);

      `JMP_OP_JZ:  flush <= (zero == 1'b1);
      `JMP_OP_JNZ: flush <= (zero == 1'b0);

      `JMP_OP_JO:  flush <= (zero == 1'b1);
    endcase

    if(jop == `JMP_OP_JR) begin
      jump_address <= 0;
    end else begin
      jump_address <= 1;
    end

  end

endmodule