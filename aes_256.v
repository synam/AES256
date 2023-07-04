
/*
 * Copyright Tran Sy Nam <transynam1989@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */




module aes_256 (clk, reset, state, key, key_expand_start, key_expand_valid, out);
    input          clk;
	 input          reset;
    input  [127:0] state;
    input  [255:0] key;
	 input key_expand_start;
	 output key_expand_valid;	 
    output [127:0] out;
	  
	  
	 
	 wire   [127:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14;
	 reg    [127:0] s0;
    wire   [127:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13;
	 
	key_expand
		key_expand_inst (clk, reset, key, key_expand_start, key_expand_valid, k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14); 
	  
    always @ (posedge clk)
      begin
        s0 <= state ^ k0;
      end

	 one_round
         r1 (clk, s0, k1, s1),
         r2 (clk, s1, k2, s2),
         r3 (clk, s2, k3, s3),
         r4 (clk, s3, k4, s4),
         r5 (clk, s4, k5, s5),
         r6 (clk, s5, k6, s6),
         r7 (clk, s6, k7, s7),
         r8 (clk, s7, k8, s8),
         r9 (clk, s8, k9, s9),
        r10 (clk, s9, k10, s10),
        r11 (clk, s10, k11, s11),
        r12 (clk, s11, k12, s12),
        r13 (clk, s12, k13, s13);

    final_round
        rf (clk, s13, k14, out);	 


endmodule



module key_expand (clk, reset, key, start, valid, k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14);
    input clk;
	 input reset;
    input  [255:0] key;
	 input  start;
	 output reg valid;
    output reg [127:0] k0;
    output reg [127:0] k1;
    output reg [127:0] k2;
    output reg [127:0] k3;
    output reg [127:0] k4;
    output reg [127:0] k5;
    output reg [127:0] k6;
    output reg [127:0] k7;
    output reg [127:0] k8;
    output reg [127:0] k9;
    output reg [127:0] k10;
    output reg [127:0] k11;
    output reg [127:0] k12;
    output reg [127:0] k13;
    output reg [127:0] k14;
	 

	 localparam NUM_STATE = 7;
	 
	 localparam KEY_EXPAND_IDLE 			= 0;	
	 localparam KEY_EXPAND_K1_WAIT   	= 1;		 	 	 
	 localparam KEY_EXPAND_K1_WAIT_1 	= 2;	
	 localparam KEY_EXPAND_K1   			= 3;			 
	 localparam KEY_EXPAND_K2_WAIT   	= 4;		 	 	 
	 localparam KEY_EXPAND_K2_WAIT_1 	= 5;		
	 localparam KEY_EXPAND_K2   			= 6;		 
	 localparam KEY_EXPAND_K3_WAIT   	= 7;		 	 	 
	 localparam KEY_EXPAND_K3_WAIT_1 	= 8;		
	 localparam KEY_EXPAND_K3   			= 9;		 
	 localparam KEY_EXPAND_K4_WAIT   	= 10;		 	 	 
	 localparam KEY_EXPAND_K4_WAIT_1 	= 11;		
	 localparam KEY_EXPAND_K4   			= 12;		 
	 localparam KEY_EXPAND_K5_WAIT   	= 13;		 	 	 
	 localparam KEY_EXPAND_K5_WAIT_1 	= 14;		
	 localparam KEY_EXPAND_K5   			= 15;	
	 localparam KEY_EXPAND_K6_WAIT   	= 16;		 	 	 
	 localparam KEY_EXPAND_K6_WAIT_1 	= 17;		
	 localparam KEY_EXPAND_K6   			= 18;	
	 localparam KEY_EXPAND_K7_WAIT   	= 19;		 	 	 
	 localparam KEY_EXPAND_K7_WAIT_1 	= 20;		
	 localparam KEY_EXPAND_K7   			= 21;	
	 localparam KEY_EXPAND_K8_WAIT   	= 22;		 	 	 
	 localparam KEY_EXPAND_K8_WAIT_1 	= 23;		
	 localparam KEY_EXPAND_K8   			= 24;	
	 localparam KEY_EXPAND_K9_WAIT   	= 25;		 	 	 
	 localparam KEY_EXPAND_K9_WAIT_1 	= 26;		
	 localparam KEY_EXPAND_K9   			= 27;		 
	 localparam KEY_EXPAND_K10_WAIT   	= 28;		 	 	 
	 localparam KEY_EXPAND_K10_WAIT_1 	= 29;		
	 localparam KEY_EXPAND_K10   			= 30;		 
	 localparam KEY_EXPAND_K11_WAIT   	= 31;		 	 	 
	 localparam KEY_EXPAND_K11_WAIT_1 	= 32;		
	 localparam KEY_EXPAND_K11   			= 33;		 
	 localparam KEY_EXPAND_K12_WAIT   	= 34;		 	 	 
	 localparam KEY_EXPAND_K12_WAIT_1 	= 35;		
	 localparam KEY_EXPAND_K12   			= 36;	
	 localparam KEY_EXPAND_K13_WAIT   	= 37;		 	 	 
	 localparam KEY_EXPAND_K13_WAIT_1 	= 38;		
	 localparam KEY_EXPAND_K13   			= 39;	
	 localparam KEY_EXPAND_WAIT_LUT_VALID 	 = 40;		
	 localparam KEY_EXPAND_WAIT_LUT_VALID_1 = 41;	
	 
	 
    reg [NUM_STATE-1 :0]     state, state_next;	 	
	 reg [255:0] key_A, key_A_next;
	 reg [255:0] key_B, key_B_next;
	 reg [7:0] key_const_in_A, key_const_in_A_next;
	 wire [255:0] key_A_out_1, key_B_out_1;    
	 wire [127:0] key_A_out_2, key_B_out_2;
	 
	 reg [127:0] key_0_reg; 
	 
	 
	 reg 	k1_valid, k2_valid, k3_valid, k4_valid, k5_valid, k6_valid, k7_valid,
			k8_valid, k9_valid, k10_valid, k11_valid, k12_valid, k13_valid;

	 
    expand_key_type_A_256
        A (clk, key_A, key_const_in_A, key_A_out_1, key_A_out_2);

    expand_key_type_B_256
        B (clk, key_B, key_B_out_1, key_B_out_2);

	 
    always@(*) begin
      state_next = state;
		key_A_next = key_A;
		key_B_next = key_B;	
		key_const_in_A_next = key_const_in_A;
		
		k1_valid = 0;
		k2_valid = 0;
		k3_valid = 0;
		k4_valid = 0;
		k5_valid = 0;
		k6_valid = 0;
		k7_valid = 0;	
		k8_valid = 0;
		k9_valid = 0;
		k10_valid = 0;
		k11_valid = 0;
		k12_valid = 0;
		k13_valid = 0;
	
		
		
      case(state)
        KEY_EXPAND_IDLE: begin
           if(start) begin
					key_A_next = key;
					key_const_in_A_next = 8'h1;	
					state_next = KEY_EXPAND_K1_WAIT;					
           end
        end
		  
        KEY_EXPAND_K1_WAIT: begin	
					state_next = KEY_EXPAND_K1_WAIT_1;			
		  end
		 
        KEY_EXPAND_K1_WAIT_1: begin
					state_next = KEY_EXPAND_K1;					
        end
		  
        KEY_EXPAND_K1: begin	
					k1_valid = 1;
					key_B_next = key_A_out_1;
					state_next = KEY_EXPAND_K2_WAIT;			
		  end
		  
        KEY_EXPAND_K2_WAIT: begin
					state_next = KEY_EXPAND_K2_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K2_WAIT_1: begin
					state_next = KEY_EXPAND_K2;					
        end		 
        KEY_EXPAND_K2: begin	
					k2_valid = 1;
					key_A_next = key_B_out_1;
					key_const_in_A_next = 8'h2;						
					state_next = KEY_EXPAND_K3_WAIT;			
		  end		  
        KEY_EXPAND_K3_WAIT: begin
					state_next = KEY_EXPAND_K3_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K3_WAIT_1: begin
					state_next = KEY_EXPAND_K3;					
        end		 		  
        KEY_EXPAND_K3: begin	
					k3_valid = 1;
					key_B_next = key_A_out_1;					
					state_next = KEY_EXPAND_K4_WAIT;			
		  end				 
        KEY_EXPAND_K4_WAIT: begin
					state_next = KEY_EXPAND_K4_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K4_WAIT_1: begin
					state_next = KEY_EXPAND_K4;					
        end			 
        KEY_EXPAND_K4: begin	
					k4_valid = 1;
					key_A_next = key_B_out_1;	
					key_const_in_A_next = 8'h4;						
					state_next = KEY_EXPAND_K5_WAIT;			
		  end		
        KEY_EXPAND_K5_WAIT: begin
					state_next = KEY_EXPAND_K5_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K5_WAIT_1: begin
					state_next = KEY_EXPAND_K5;					
        end					  
        KEY_EXPAND_K5: begin	
					k5_valid = 1;
					key_B_next = key_A_out_1;						
					state_next = KEY_EXPAND_K6_WAIT;			
		  end			  
        KEY_EXPAND_K6_WAIT: begin
					state_next = KEY_EXPAND_K6_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K6_WAIT_1: begin
					state_next = KEY_EXPAND_K6;					
        end		
        KEY_EXPAND_K6: begin	
					k6_valid = 1;
					key_A_next = key_B_out_1;	
					key_const_in_A_next = 8'h8;						
					state_next = KEY_EXPAND_K7_WAIT;			
		  end		
        KEY_EXPAND_K7_WAIT: begin
					state_next = KEY_EXPAND_K7_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K7_WAIT_1: begin
					state_next = KEY_EXPAND_K7;					
        end		
        KEY_EXPAND_K7: begin	
					k7_valid = 1;
					key_B_next = key_A_out_1;						
					state_next = KEY_EXPAND_K8_WAIT;			
		  end	
        KEY_EXPAND_K8_WAIT: begin
					state_next = KEY_EXPAND_K8_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K8_WAIT_1: begin
					state_next = KEY_EXPAND_K8;					
        end		
        KEY_EXPAND_K8: begin	
					k8_valid = 1;
					key_A_next = key_B_out_1;	
					key_const_in_A_next = 8'h10;						
					state_next = KEY_EXPAND_K9_WAIT;			
		  end			  
        KEY_EXPAND_K9_WAIT: begin
					state_next = KEY_EXPAND_K9_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K9_WAIT_1: begin
					state_next = KEY_EXPAND_K9;					
        end				  
        KEY_EXPAND_K9: begin	
					k9_valid = 1;
					key_B_next = key_A_out_1;						
					state_next = KEY_EXPAND_K10_WAIT;			
		  end			  
        KEY_EXPAND_K10_WAIT: begin
					state_next = KEY_EXPAND_K10_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K10_WAIT_1: begin
					state_next = KEY_EXPAND_K10;					
        end				  
        KEY_EXPAND_K10: begin	
					k10_valid = 1;
					key_A_next = key_B_out_1;	
					key_const_in_A_next = 8'h20;						
					state_next = KEY_EXPAND_K11_WAIT;			
		  end		
        KEY_EXPAND_K11_WAIT: begin
					state_next = KEY_EXPAND_K11_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K11_WAIT_1: begin
					state_next = KEY_EXPAND_K11;					
        end	
        KEY_EXPAND_K11: begin	
					k11_valid = 1;
					key_B_next = key_A_out_1;						
					state_next = KEY_EXPAND_K12_WAIT;			
		  end	
        KEY_EXPAND_K12_WAIT: begin
					state_next = KEY_EXPAND_K12_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K12_WAIT_1: begin
					state_next = KEY_EXPAND_K12;					
        end	
        KEY_EXPAND_K12: begin	
					k12_valid = 1;
					key_A_next = key_B_out_1;	
					key_const_in_A_next = 8'h40;						
					state_next = KEY_EXPAND_K13_WAIT;			
		  end		
        KEY_EXPAND_K13_WAIT: begin
					state_next = KEY_EXPAND_K13_WAIT_1;		
        end		 		
		  
        KEY_EXPAND_K13_WAIT_1: begin
					state_next = KEY_EXPAND_K13;					
        end	
        KEY_EXPAND_K13: begin	
					k13_valid = 1;				
					state_next = KEY_EXPAND_WAIT_LUT_VALID;			
		  end		
        KEY_EXPAND_WAIT_LUT_VALID: begin
					state_next = KEY_EXPAND_WAIT_LUT_VALID_1;		
        end		 		
		  
        KEY_EXPAND_WAIT_LUT_VALID_1: begin
					state_next = KEY_EXPAND_IDLE;					
        end			  
		endcase   
		

	 end 	
	 
	   always @(posedge clk) begin
      if(reset) begin
         state <= KEY_EXPAND_IDLE;
	      key_A <= 0;
	      key_B <= 0;	
			key_const_in_A	 <= 0;		

		end
		else begin
			state <= state_next; 
			key_A <= key_A_next;
			key_const_in_A <= key_const_in_A_next;
			key_B <= key_B_next;			
		end
		
   end
		 
  always @(posedge clk) begin
      if(reset) begin
         state <= KEY_EXPAND_IDLE;
	      key_A <= 0;
	      key_B <= 0;	
			key_const_in_A	 <= 0;					
			valid <= 0;
			k0 <= 128'h0;
			k1 <= 128'h0;
			k2 <= 128'h0;
			k3 <= 128'h0;	
			k4 <= 128'h0;
			k5 <= 128'h0;
			k6 <= 128'h0;
			k7 <= 128'h0;	
			k8 <= 128'h0;
			k9 <= 128'h0;
			k10 <= 128'h0;
			k11 <= 128'h0;	
			k12 <= 128'h0;
			k13 <= 128'h0;
			k14 <= 128'h0;	
			
      end	
		else begin
			state <= state_next; 
			key_A <= key_A_next;
			key_const_in_A <= key_const_in_A_next;
			key_B <= key_B_next;		
							
			if(start) begin
				k0 <= key[255:128];
				k1 <= key[127:0];
				valid <= 0;
			end		
			if(k1_valid) begin
				k2 <= key_A_out_2;
			end	
			if(k2_valid) begin
				k3 <= key_B_out_2;
			end				
			if(k3_valid) begin
				k4 <= key_A_out_2;
			end	
			if(k4_valid) begin
				k5 <= key_B_out_2;
			end	
			if(k5_valid) begin
				k6 <= key_A_out_2;
			end	
			if(k6_valid) begin
				k7 <= key_B_out_2;
			end
			if(k7_valid) begin
				k8 <= key_A_out_2;
			end	
			if(k8_valid) begin
				k9 <= key_B_out_2;
			end
			if(k9_valid) begin
				k10 <= key_A_out_2;
			end
			if(k10_valid) begin
				k11 <= key_B_out_2;
			end	
			if(k11_valid) begin
				k12 <= key_A_out_2;
			end	
			if(k12_valid) begin
				k13 <= key_B_out_2;
			end				
			if(k13_valid) begin
				k14 <= key_A_out_2;
				valid <= 1;
			end			
		
		end
   end
	
endmodule	 



module expand_key_type_A_256 (clk, in, rcon, out_1, out_2);
    input              clk;
    input      [255:0] in;
    input      [7:0]   rcon;
    output reg [255:0] out_1;
    output     [127:0] out_2;
    wire       [31:0]  k0, k1, k2, k3, k4, k5, k6, k7,
                       v0, v1, v2, v3;
    reg        [31:0]  k0a, k1a, k2a, k3a, k4a, k5a, k6a, k7a;
    wire       [31:0]  k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b, k8a;

    assign {k0, k1, k2, k3, k4, k5, k6, k7} = in;
    
    assign v0 = {k0[31:24] ^ rcon, k0[23:0]};
    assign v1 = v0 ^ k1;
    assign v2 = v1 ^ k2;
    assign v3 = v2 ^ k3;

    always @ (posedge clk)
        {k0a, k1a, k2a, k3a, k4a, k5a, k6a, k7a} <= {v0, v1, v2, v3, k4, k5, k6, k7};

    S4
        S4_0 (clk, {k7[23:0], k7[31:24]}, k8a);

    assign k0b = k0a ^ k8a;
    assign k1b = k1a ^ k8a;
    assign k2b = k2a ^ k8a;
    assign k3b = k3a ^ k8a;
    assign {k4b, k5b, k6b, k7b} = {k4a, k5a, k6a, k7a};

    always @ (posedge clk)
        out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b};

    assign out_2 = {k0b, k1b, k2b, k3b};
endmodule


module expand_key_type_B_256 (clk, in, out_1, out_2);
    input              clk;
    input      [255:0] in;
    output reg [255:0] out_1;
    output     [127:0] out_2;
    wire       [31:0]  k0, k1, k2, k3, k4, k5, k6, k7,
                       v5, v6, v7;
    reg        [31:0]  k0a, k1a, k2a, k3a, k4a, k5a, k6a, k7a;
    wire       [31:0]  k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b, k8a;

    assign {k0, k1, k2, k3, k4, k5, k6, k7} = in;
    
    assign v5 = k4 ^ k5;
    assign v6 = v5 ^ k6;
    assign v7 = v6 ^ k7;

    always @ (posedge clk)
        {k0a, k1a, k2a, k3a, k4a, k5a, k6a, k7a} <= {k0, k1, k2, k3, k4, v5, v6, v7};

    S4
        S4_0 (clk, k3, k8a);

    assign {k0b, k1b, k2b, k3b} = {k0a, k1a, k2a, k3a};
    assign k4b = k4a ^ k8a;
    assign k5b = k5a ^ k8a;
    assign k6b = k6a ^ k8a;
    assign k7b = k7a ^ k8a;

    always @ (posedge clk)
        out_1 <= {k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b};

    assign out_2 = {k4b, k5b, k6b, k7b};
endmodule




