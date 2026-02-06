/*

Copyright (c) 2014-2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * FPGA core logic
 */
module fpga_core
(
    /*
     * Clock: 156.25MHz
     * Synchronous reset
     */
    input  wire        clk,
    input  wire        rst,

    /*
     * GPIO
     */
    input  wire [3:0]  JA_FPGA_IN,
    output wire [3:0]  JA_FPGA_OUT,
    input  wire [1:0]  btn,
    output wire [1:0]  sfp_1_led,
    output wire [1:0]  sfp_2_led,
    output wire [1:0]  sfp_3_led,
    output wire [1:0]  sfp_4_led,
    output wire [1:0]  led,

    /*
     * I2C
     */
    input  wire        i2c_scl_i,
    output wire        i2c_scl_o,
    output wire        i2c_scl_t,
    input  wire        i2c_sda_i,
    output wire        i2c_sda_o,
    output wire        i2c_sda_t,

    /*
     * Ethernet: SFP+
     */
    input  wire        sfp_1_tx_clk,
    input  wire        sfp_1_tx_rst,
    output wire [63:0] sfp_1_txd,
    output wire [7:0]  sfp_1_txc,
    input  wire        sfp_1_rx_clk,
    input  wire        sfp_1_rx_rst,
    input  wire [63:0] sfp_1_rxd,
    input  wire [7:0]  sfp_1_rxc,
    input  wire        sfp_2_tx_clk,
    input  wire        sfp_2_tx_rst,
    output wire [63:0] sfp_2_txd,
    output wire [7:0]  sfp_2_txc,
    input  wire        sfp_2_rx_clk,
    input  wire        sfp_2_rx_rst,
    input  wire [63:0] sfp_2_rxd,
    input  wire [7:0]  sfp_2_rxc,
    input  wire        sfp_3_tx_clk,
    input  wire        sfp_3_tx_rst,
    output wire [63:0] sfp_3_txd,
    output wire [7:0]  sfp_3_txc,
    input  wire        sfp_3_rx_clk,
    input  wire        sfp_3_rx_rst,
    input  wire [63:0] sfp_3_rxd,
    input  wire [7:0]  sfp_3_rxc,
    input  wire        sfp_4_tx_clk,
    input  wire        sfp_4_tx_rst,
    output wire [63:0] sfp_4_txd,
    output wire [7:0]  sfp_4_txc,
    input  wire        sfp_4_rx_clk,
    input  wire        sfp_4_rx_rst,
    input  wire [63:0] sfp_4_rxd,
    input  wire [7:0]  sfp_4_rxc
);

// AXI between MAC and Ethernet modules
wire [63:0] rx_axis_tdata;
wire [7:0] rx_axis_tkeep;
wire rx_axis_tvalid;
wire rx_axis_tready;
wire rx_axis_tlast;
wire rx_axis_tuser;

wire [63:0] tx_axis_tdata;
wire [7:0] tx_axis_tkeep;
wire tx_axis_tvalid;
wire tx_axis_tready;
wire tx_axis_tlast;
wire tx_axis_tuser;

// Ethernet frame between Ethernet modules and UDP stack
wire rx_eth_hdr_ready;
wire rx_eth_hdr_valid;
wire [47:0] rx_eth_dest_mac;
wire [47:0] rx_eth_src_mac;
wire [15:0] rx_eth_type;
wire [63:0] rx_eth_payload_axis_tdata;
wire [7:0] rx_eth_payload_axis_tkeep;
wire rx_eth_payload_axis_tvalid;
wire rx_eth_payload_axis_tready;
wire rx_eth_payload_axis_tlast;
wire rx_eth_payload_axis_tuser;

wire tx_eth_hdr_ready;
wire tx_eth_hdr_valid;
wire [47:0] tx_eth_dest_mac;
wire [47:0] tx_eth_src_mac;
wire [15:0] tx_eth_type;
wire [63:0] tx_eth_payload_axis_tdata;
wire [7:0] tx_eth_payload_axis_tkeep;
wire tx_eth_payload_axis_tvalid;
wire tx_eth_payload_axis_tready;
wire tx_eth_payload_axis_tlast;
wire tx_eth_payload_axis_tuser;

// IP frame connections
wire rx_ip_hdr_valid;
wire rx_ip_hdr_ready;
wire [47:0] rx_ip_eth_dest_mac;
wire [47:0] rx_ip_eth_src_mac;
wire [15:0] rx_ip_eth_type;
wire [3:0] rx_ip_version;
wire [3:0] rx_ip_ihl;
wire [5:0] rx_ip_dscp;
wire [1:0] rx_ip_ecn;
wire [15:0] rx_ip_length;
wire [15:0] rx_ip_identification;
wire [2:0] rx_ip_flags;
wire [12:0] rx_ip_fragment_offset;
wire [7:0] rx_ip_ttl;
wire [7:0] rx_ip_protocol;
wire [15:0] rx_ip_header_checksum;
wire [31:0] rx_ip_source_ip;
wire [31:0] rx_ip_dest_ip;
wire [63:0] rx_ip_payload_axis_tdata;
wire [7:0] rx_ip_payload_axis_tkeep;
wire rx_ip_payload_axis_tvalid;
wire rx_ip_payload_axis_tready;
wire rx_ip_payload_axis_tlast;
wire rx_ip_payload_axis_tuser;

wire tx_ip_hdr_valid;
wire tx_ip_hdr_ready;
wire [5:0] tx_ip_dscp;
wire [1:0] tx_ip_ecn;
wire [15:0] tx_ip_length;
wire [7:0] tx_ip_ttl;
wire [7:0] tx_ip_protocol;
wire [31:0] tx_ip_source_ip;
wire [31:0] tx_ip_dest_ip;
wire [63:0] tx_ip_payload_axis_tdata;
wire [7:0] tx_ip_payload_axis_tkeep;
wire tx_ip_payload_axis_tvalid;
wire tx_ip_payload_axis_tready;
wire tx_ip_payload_axis_tlast;
wire tx_ip_payload_axis_tuser;

// UDP frame connections
wire rx_udp_hdr_valid;
wire rx_udp_hdr_ready;
wire [47:0] rx_udp_eth_dest_mac;
wire [47:0] rx_udp_eth_src_mac;
wire [15:0] rx_udp_eth_type;
wire [3:0] rx_udp_ip_version;
wire [3:0] rx_udp_ip_ihl;
wire [5:0] rx_udp_ip_dscp;
wire [1:0] rx_udp_ip_ecn;
wire [15:0] rx_udp_ip_length;
wire [15:0] rx_udp_ip_identification;
wire [2:0] rx_udp_ip_flags;
wire [12:0] rx_udp_ip_fragment_offset;
wire [7:0] rx_udp_ip_ttl;
wire [7:0] rx_udp_ip_protocol;
wire [15:0] rx_udp_ip_header_checksum;
wire [31:0] rx_udp_ip_source_ip;
wire [31:0] rx_udp_ip_dest_ip;
wire [15:0] rx_udp_source_port;
wire [15:0] rx_udp_dest_port;
wire [15:0] rx_udp_length;
wire [15:0] rx_udp_checksum;
wire [63:0] rx_udp_payload_axis_tdata;
wire [7:0] rx_udp_payload_axis_tkeep;
wire rx_udp_payload_axis_tvalid;
wire rx_udp_payload_axis_tready;
wire rx_udp_payload_axis_tlast;
wire rx_udp_payload_axis_tuser;

wire tx_udp_hdr_valid;
wire tx_udp_hdr_ready;
wire [5:0] tx_udp_ip_dscp;
wire [1:0] tx_udp_ip_ecn;
wire [7:0] tx_udp_ip_ttl;
wire [31:0] tx_udp_ip_source_ip;
//wire [31:0] tx_udp_ip_dest_ip;
//wire [15:0] tx_udp_source_port;
//wire [15:0] tx_udp_dest_port;
reg [15:0] tx_udp_length;
wire [15:0] tx_udp_checksum;
wire [63:0] tx_udp_payload_axis_tdata;
wire [7:0] tx_udp_payload_axis_tkeep;
wire tx_udp_payload_axis_tvalid;
wire tx_udp_payload_axis_tready;
wire tx_udp_payload_axis_tlast;
wire tx_udp_payload_axis_tuser;

wire [63:0] rx_fifo_udp_payload_axis_tdata;
wire [7:0] rx_fifo_udp_payload_axis_tkeep;
wire rx_fifo_udp_payload_axis_tvalid;
wire rx_fifo_udp_payload_axis_tready;
wire rx_fifo_udp_payload_axis_tlast;
wire rx_fifo_udp_payload_axis_tuser;

wire [63:0] tx_fifo_udp_payload_axis_tdata;
wire [7:0] tx_fifo_udp_payload_axis_tkeep;
wire tx_fifo_udp_payload_axis_tvalid;
wire tx_fifo_udp_payload_axis_tready;
wire tx_fifo_udp_payload_axis_tlast;
wire tx_fifo_udp_payload_axis_tuser;

// Configuration
reg [47:0] local_mac   = 48'h02_00_00_00_00_00;
reg [31:0] local_ip    = {8'd192, 8'd168, 8'd1,   8'd128};
reg [31:0] gateway_ip  = {8'd192, 8'd168, 8'd1,   8'd1};
reg [31:0] subnet_mask = {8'd255, 8'd255, 8'd255, 8'd0};

// IP ports not used
assign rx_ip_hdr_ready = 1;
assign rx_ip_payload_axis_tready = 1;

assign tx_ip_hdr_valid = 0;
assign tx_ip_dscp = 0;
assign tx_ip_ecn = 0;
assign tx_ip_length = 0;
assign tx_ip_ttl = 0;
assign tx_ip_protocol = 0;
assign tx_ip_source_ip = 0;
assign tx_ip_dest_ip = 0;
assign tx_ip_payload_axis_tdata = 0;
assign tx_ip_payload_axis_tkeep = 0;
assign tx_ip_payload_axis_tvalid = 0;
assign tx_ip_payload_axis_tlast = 0;
assign tx_ip_payload_axis_tuser = 0;

wire [63:0] reg_fifo_udp_payload_axis_tdata;
wire [7:0] reg_fifo_udp_payload_axis_tkeep;
wire reg_fifo_udp_payload_axis_tvalid;
wire reg_fifo_udp_payload_axis_tready;
wire reg_fifo_udp_payload_axis_tlast;
wire reg_fifo_udp_payload_axis_tuser;


///rx data and pulse trigger//////////////////////////////////////
reg valid_last_reg = 0;
reg [63:0] rx_reg = 64'd0; 
reg pulse_trigg = 0;

always @ (posedge clk) begin
	if (rst) begin
	rx_reg <= 64'd0;
	pulse_trigg <= 0;
	end else begin
	    valid_last_reg <= reg_fifo_udp_payload_axis_tvalid;
		if (reg_fifo_udp_payload_axis_tvalid  & ~valid_last_reg) begin
			rx_reg <= reg_fifo_udp_payload_axis_tdata;
		end else if (rx_reg[63:0] == 64'h5F52454747495254) begin // "TRIGGER_" little endian
		    pulse_trigg <= 1;
			rx_reg <= 64'd0;
		end	else begin
		    rx_reg <= rx_reg;
		    pulse_trigg <= 0;
		end
	end
end

//loopback command //////////////////////////

reg rx_loopb = 0;

always @(posedge clk) begin
    if (rst) begin
        rx_loopb <= 0;
    end else begin
        if (rx_reg[55:0] == 56'h5F4B42504F4F4C) begin  // "LOOPBK_" en little-endian
            case (rx_reg[63:56])
                8'h44: begin  // "LOOPBK_D" en ASCII little-endian
                    rx_loopb <= 0; // disable loopback
                end
                8'h45: begin  // "LOOPBK_E" en ASCII  little-endian
                    rx_loopb <= 1; // enable loopback
                end
                default: begin
                    rx_loopb <= rx_loopb; // mantiene estado
                end
            endcase
        end
        // Si no es "LOOPBK_", mantiene el estado actual
    end
end

//ramdom command //////////////////////////

reg rx_random;

always @(posedge clk) begin
    if (rst) begin
        rx_random <= 0;
    end else begin
        if (rx_reg[55:0] == 56'h5F4D4F444E4152) begin  // "RANDOM_" en little-endian
            case (rx_reg[63:56])
                8'h44: begin  // "RANDOM_D" en ASCII little-endian
                    rx_random <= 0; // disable random
                end
                8'h45: begin  // "RANDOM_E" en ASCII  little-endian
                    rx_random <= 1; // enable random
                end
                default: begin
                    rx_random <= rx_random; // mantiene estado
                end
            endcase
        end
        // Si no es "RANDOM_", mantiene el estado actual
    end
end

//start, stop //////////////////////////

reg rx_trigger;

always @(posedge clk) begin
    if (rst) begin
        rx_trigger <= 0;
    end else begin
        if (rx_reg[31:0] == 32'h2E2E2E2E) begin  // "...." en little-endian
            case (rx_reg[63:32])
                32'h494E4946: begin  // "FINI" en ASCII little-endian
                    rx_trigger <= 0; // stop measurement
                end
                32'h54494E49: begin  // "INIT" en ASCII  little-endian
                    rx_trigger <= 1; // start measurement
                end
                default: begin
                    rx_trigger <= rx_trigger; // mantiene estado
                end
            endcase
        end
        // Si no es "....", mantiene el estado actual
    end
end

//pack number //////////////////////////

reg [31:0] pkt_n; //por defecto ~1MB por cada pulso recibido de datos (128*8192)B = 1048576B

always @(posedge clk) begin
    if (rst) begin
        pkt_n <= 32'd128;
    end else begin
        if (rx_reg[31:0] == 32'h23544B50) begin  // "PKT#" en little-endian
           // Invertir el orden de los bytes
           pkt_n <= {rx_reg[39:32], rx_reg[47:40], rx_reg[55:48], rx_reg[63:56]};
        end
        // Si no es "#TKP", mantiene el estado actual
    end
end

//error test message number ////////////////////////// introduce 8 bytes de error cada e mensajes

reg [31:0] pkt_e; //por defecto sin mensaje de test, ya que el conteo comienza desde 1

always @(posedge clk) begin
    if (rst) begin
        pkt_e <= 32'd0;
    end else begin
        if (rx_reg[31:0] == 32'h23525245) begin  // "ERR#" en little-endian
           // Invertir el orden de los bytes
           pkt_e <= {rx_reg[39:32], rx_reg[47:40], rx_reg[55:48], rx_reg[63:56]};
        end
        // Si no es "#RRE", mantiene el estado actual
    end
end

//error test message number position ////////////////////////// posición de los 8 bytes de error en el mensaje de error

reg [15:0] pkt_e_p; //por defecto en la posición 128

always @(posedge clk) begin
    if (rst) begin
        pkt_e_p <= 16'd128;
    end else begin
        if (rx_reg[47:0] == 48'h23505F525245) begin  // "ERR_P#" en little-endian
           // Invertir el orden de los bytes
           pkt_e_p <= {rx_reg[55:48], rx_reg[63:56]};
        end
        // Si no es "#RRE", mantiene el estado actual
    end
end

//message length variable////////////////////////// selecciona el la longitud de bytes del mensaje udp

reg [15:0] tx_udp_length; //defaul 8192+8 bytes JUMBO frames

always @(posedge clk) begin
    if (rst) begin
        tx_udp_length <= 16'd8200;
    end else begin
        if (rx_reg[47:0] == 48'h4854474E454C) begin  // "LENGTH" en little-endian
           // Invertir el orden de los bytes
           tx_udp_length <= {rx_reg[55:48], rx_reg[63:56]};
        end
        // Si no es "HTGNEL", mantiene el estado actual
    end
end

//64 words number ////////////////////////// selecciona numero de palabras de 64 bits por mensaje

reg [15:0] n_bytes; // 1024 palabras de 64 bits = 8192 bytes

always @(posedge clk) begin
    if (rst) begin
        n_bytes <= 16'd1024; 
    end else begin
        if (rx_reg[47:0] == 48'h235344524F57) begin  // "WORDS#" en little-endian
           // Invertir el orden de los bytes
           n_bytes <= {rx_reg[55:48], rx_reg[63:56]};
        end
        // Si no es "#SDROW", mantiene el estado actual
    end
end

//transmision de paquetes de bytes

reg [10:0] cont_reg = 11'd0;

reg [31:0] cont_err_reg = 32'd0;

reg [63:0] tx_fifo_axis_tdata = 64'd0;
reg [63:0] tx_fifo_axis_tdata_reg = 64'd0;
reg [63:0] tx_axis_tdata_test = 64'h0A2E545345542E0A; //"\n.TEST.\n" en little-endian
reg [7:0] tx_fifo_axis_tkeep = 8'hFF;
reg tx_fifo_axis_tvalid = 0;
wire tx_fifo_axis_tready;
reg tx_fifo_axis_tlast = 0;
reg tx_fifo_axis_tuser = 0;

reg [4:0] off_cycles = 5'd20; // ciclos de reoloj de separacion entre paquetes, 20 ciclos no hay error en tx_ready
reg [4:0] off_cycles_reg = 5'd0;

reg [31:0] pkt_n_reg = 32'd0;
reg [2:0] state = 3'd0;
reg ocupado;

reg [63:0] random_data;
// Linear-feedback shift register de 64 bits usando polinomio máximo x^64 + x^63 + x^61 + x^60 + 1
reg [63:0] lfsr;

wire feedback;

reg [63:0] time_stamp;

// Feedback para polinomio máximo de 64 bits
assign feedback = lfsr[63] ^ lfsr[62] ^ lfsr[60] ^ lfsr[59];

// maquina de estados para trasnmision 
always @(posedge clk) begin

    if (rst) begin
        lfsr <= 64'h0123456789ABCDEF; // Semilla inicial (no todos ceros)
    end else begin
        // Generar nuevo valor cada ciclo de reloj
        lfsr[63:0] <= {lfsr[62:0], feedback};
        random_data <= lfsr;
    end

    if (rst) begin
        time_stamp <= 64'd0; // Semilla inicial (no todos ceros)
    end else begin
        // Generar nuevo valor cada ciclo de reloj
        time_stamp <= time_stamp + 64'd1;
    end

    if (rst) begin
        state <=  3'd0;
        tx_fifo_axis_tdata <= 64'd0;
        tx_fifo_axis_tdata_reg <= 64'd0;
        tx_fifo_axis_tvalid <= 0;
        cont_reg <= 0;
        tx_fifo_axis_tlast <= 0;
        pkt_n_reg <= 0;
        off_cycles_reg <= 5'd0;
        ocupado <= 0; 
    end else begin
       // Estado 0: Esperando pulso
        if (state == 3'd0) begin
        
            if ((rx_trigger && pulse_trigg && ~rx_loopb) || ocupado) begin
                ocupado <= 1; //empieza el envio de los paquetes
                state <= 3'd1;
                tx_fifo_axis_tvalid <= 1; //tvalid 1 en el siguiente ciclo
                tx_fifo_axis_tdata <= time_stamp; // primera palabra del mensaje
            end
        end 
        // Estado 1: Enviando primera palabra del mensaje
        else if (state == 3'd1) begin
 
            if (tx_fifo_axis_tready) begin
                state <= 3'd2;
                // Primer dato aceptado y ligiendo segunda palabra
                tx_fifo_axis_tdata <= {pkt_n_reg, (pkt_n - 32'd1)}; //esto se aplicara en el siguiente ciclo, sera la segunda palabra enviada
                cont_reg <= cont_reg + 1;
            end

        end 
        // Estado 2: Enviando segunda palabra y el resto
        else if (state == 3'd2) begin
        
            if (tx_fifo_axis_tready) begin
                cont_reg <= cont_reg + 1;
                if (cont_reg == (n_bytes - 2)) begin
                    state <= 3'd3;
                    tx_fifo_axis_tdata <= time_stamp; //eligiendo ultima palabra
                    tx_fifo_axis_tlast <= 1;
                    pkt_n_reg <= pkt_n_reg + 1;
                end else if ( (pkt_e != 0) && (((pkt_n_reg + 1) % pkt_e == 0) && (cont_reg == pkt_e_p[10:0]))) begin // si se eligio el dato pkt_e_p < n_bytes - 1 de cada pkt_e mensajes 
                    tx_fifo_axis_tdata <= tx_axis_tdata_test; // 8 bytes de error
                end else if(rx_random) begin
                    tx_fifo_axis_tdata <= random_data;
                end else begin
                    tx_fifo_axis_tdata <= tx_fifo_axis_tdata_reg;
                    tx_fifo_axis_tdata_reg <= tx_fifo_axis_tdata_reg + 64'd1;
                end
            end

        end
        // Estado 3: Último dato del paquete
        else if (state == 3'd3) begin
        
            if (pkt_n_reg == (pkt_n) || ~rx_trigger) begin
                cont_reg <= 0;
                pkt_n_reg <= 0;
                tx_fifo_axis_tdata_reg <= 64'd0;
                off_cycles_reg <= 5'd0;
                ocupado <= 0; //fin ocupado para volver a estado 0 y esperar otro triger
                state <= 3'd0; //si se llego al numero de mensajes volver a estado 0 para esperar otro pulso
                tx_fifo_axis_tlast <= 0;//bajar last en el siguiente ciclo
                tx_fifo_axis_tvalid <= 0;//bajar tvalid
            end else begin
                state <= 3'd4; //si no se llego al numero de mensaje ir al estado 4 para esperar a que baje tready
                tx_fifo_axis_tlast <= 0;//bajar last en el siguiente ciclo
                tx_fifo_axis_tvalid <= 0;//bajar tvalid
                cont_reg <= 0; //resetear cont_reg
            end
        end
         // Estado 4: esperando que tready baje para enviar otro mensaje
        else if (state == 3'd4) begin
        
            if (~tx_fifo_axis_tready) begin 
                state <= 3'd5; //cuando baje tready ir al estado 5 para esperas ciclos de separacion
            end
        end
         // Estado 5: esperando ciclos de separacion para enviar el siguiente mensaje
        else if (state == 3'd5) begin
        
            if (off_cycles_reg == (off_cycles - 1)) begin 
                state <= 3'd0; //volver al estado 0 con ocupado en 1 para seguir enviando datos
                off_cycles_reg <= 0; //reiniciando off_cycles_reg
            end else begin
                off_cycles_reg <= off_cycles_reg + 1; 
            end

        end
    end
end

// Loop back UDP
wire match_cond = rx_udp_dest_port == 1234;
wire no_match = ~match_cond;

reg match_cond_reg = 0;
reg no_match_reg = 0;

always @(posedge clk) begin
    if (rst) begin
        match_cond_reg <= 0;
        no_match_reg <= 0;
    end else begin
        if (rx_udp_payload_axis_tvalid) begin
            if ((~match_cond_reg & ~no_match_reg) |
                (rx_udp_payload_axis_tvalid & rx_udp_payload_axis_tready & rx_udp_payload_axis_tlast)) begin
                match_cond_reg <= match_cond;
                no_match_reg <= no_match;
            end
        end else begin
            match_cond_reg <= 0;
            no_match_reg <= 0;
        end
    end
end

assign tx_udp_hdr_valid = rx_loopb ? (rx_udp_hdr_valid & match_cond) : (tx_udp_payload_axis_tvalid && tx_udp_hdr_ready);

assign rx_udp_hdr_ready = rx_loopb ? ((tx_udp_hdr_ready & match_cond) | no_match) : (match_cond | no_match);

assign tx_udp_ip_dscp = 0;
assign tx_udp_ip_ecn = 0;
assign tx_udp_ip_ttl = 64;
assign tx_udp_ip_source_ip = local_ip;
//assign tx_udp_ip_dest_ip = rx_udp_ip_source_ip;
//assign tx_udp_source_port = rx_udp_dest_port;
//assign tx_udp_dest_port = rx_udp_source_port;
//assign tx_udp_length = 16'd8200;  // 8192 byte de payload;
assign tx_udp_checksum = 0;

//-------------------------------------------------------------------------------------

/*
//con fifo
assign tx_udp_payload_axis_tdata = rx_loopb ? reg_fifo_udp_payload_axis_tdata : tx_fifo_udp_payload_axis_tdata;
assign tx_udp_payload_axis_tkeep = rx_loopb ? reg_fifo_udp_payload_axis_tkeep : tx_fifo_udp_payload_axis_tkeep;
assign tx_udp_payload_axis_tvalid = rx_loopb ? reg_fifo_udp_payload_axis_tvalid : tx_fifo_udp_payload_axis_tvalid;

assign tx_fifo_udp_payload_axis_tready = rx_loopb ? 1'b1 : tx_udp_payload_axis_tready;
assign reg_fifo_udp_payload_axis_tready = rx_loopb ? tx_udp_payload_axis_tready : 1'b1;

assign tx_udp_payload_axis_tlast = rx_loopb ? reg_fifo_udp_payload_axis_tlast : tx_fifo_udp_payload_axis_tlast;
assign tx_udp_payload_axis_tuser = rx_loopb ? reg_fifo_udp_payload_axis_tuser : tx_fifo_udp_payload_axis_tuser;
*/


//sin fifo en tx peor con fifo en rx
assign tx_udp_payload_axis_tdata = rx_loopb ? reg_fifo_udp_payload_axis_tdata : tx_fifo_axis_tdata;
assign tx_udp_payload_axis_tkeep = rx_loopb ? reg_fifo_udp_payload_axis_tkeep : tx_fifo_axis_tkeep;
assign tx_udp_payload_axis_tvalid = rx_loopb ? reg_fifo_udp_payload_axis_tvalid : tx_fifo_axis_tvalid;
assign tx_fifo_axis_tready = tx_udp_payload_axis_tready;
assign reg_fifo_udp_payload_axis_tready = rx_loopb ? tx_udp_payload_axis_tready : 1'b1;
assign tx_udp_payload_axis_tlast = rx_loopb ? reg_fifo_udp_payload_axis_tlast : tx_fifo_axis_tlast;
assign tx_udp_payload_axis_tuser = rx_loopb ? reg_fifo_udp_payload_axis_tuser : tx_fifo_axis_tuser;


//---------------------------------------------------------------------------------

assign rx_fifo_udp_payload_axis_tdata = rx_udp_payload_axis_tdata;
assign rx_fifo_udp_payload_axis_tkeep = rx_udp_payload_axis_tkeep;
assign rx_fifo_udp_payload_axis_tvalid = rx_udp_payload_axis_tvalid & match_cond_reg;
assign rx_udp_payload_axis_tready = (rx_fifo_udp_payload_axis_tready & match_cond_reg) | no_match_reg;
assign rx_fifo_udp_payload_axis_tlast = rx_udp_payload_axis_tlast;
assign rx_fifo_udp_payload_axis_tuser = rx_udp_payload_axis_tuser;



//optener ip

reg [31:0] tx_udp_ip_dest_ip = {8'd192, 8'd168, 8'd1,   8'd100};
reg [15:0] tx_udp_source_port = 16'd1234;
reg [15:0] tx_udp_dest_port = 16'd9999;

always @(posedge clk) begin
    if (rst) begin
				tx_udp_ip_dest_ip <= {8'd192, 8'd168, 8'd1,   8'd100};
    end else begin
        if (match_cond_reg) begin
				tx_udp_ip_dest_ip <= rx_udp_ip_source_ip;
        end else begin
				tx_udp_ip_dest_ip <= tx_udp_ip_dest_ip;
        end
    end
end

// Place first payload byte onto LEDs
reg valid_last = 0;
reg [7:0] led_reg = 0;

always @(posedge clk) begin
    if (rst) begin
        led_reg <= 0;
    end else begin
        valid_last <= tx_udp_payload_axis_tvalid;
        if (tx_udp_payload_axis_tvalid & ~valid_last) begin
            led_reg <= tx_udp_payload_axis_tdata;
        end
    end
end

//debug signals //////////////////////////

assign led[1] = rx_trigger;
assign led[0] = rx_loopb;
//assign JA_FPGA[0] = 1'b0;
//assign JA_FPGA[1] = 1'b0;
//assign JA_FPGA[2] = 1'b0;
//assign JA_FPGA[3] = 1'b0;

/*
assign JA_FPGA[4] = tx_fifo_axis_tvalid;
assign JA_FPGA[5] = tx_fifo_axis_tready;
assign JA_FPGA[6] = tx_fifo_axis_tlast;
assign JA_FPGA[7] = rx_loopb;
*/

reg [15:0] debug_signals = 16'h9654;

wire udp_tx_busy;
wire udp_rx_busy;

always @(posedge clk) begin
    if (rst) begin
        debug_signals <= 16'h9654;
    end else begin
        if (rx_reg[47:0] == 48'h5F4755424544) begin  // "DEBUG_" en little-endian  9=rx_loopb, 6=tlast, 5=tready, 4=tvalid
           // Invertir el orden de los bytes
           debug_signals <= {rx_reg[55:48], rx_reg[63:56]};
        end
        // Si no es "DEBUG_", mantiene el estado actual
    end
end

// Multiplexor para JA_FPGA_OUT basado en debug_signals
assign JA_FPGA_OUT[0] = (debug_signals[3:0] == 4'd0) ? tx_udp_hdr_valid :
                    (debug_signals[3:0] == 4'd1) ? tx_udp_hdr_ready :
                    (debug_signals[3:0] == 4'd2) ? rx_udp_hdr_valid :
                    (debug_signals[3:0] == 4'd3) ? rx_udp_hdr_ready :
                    (debug_signals[3:0] == 4'd4) ? tx_udp_payload_axis_tvalid : // valor inicial en 4
                    (debug_signals[3:0] == 4'd5) ? tx_fifo_axis_tready :
                    (debug_signals[3:0] == 4'd6) ? tx_udp_payload_axis_tlast :
                    (debug_signals[3:0] == 4'd7) ? udp_tx_busy :
                    (debug_signals[3:0] == 4'd8) ? udp_rx_busy :
                    (debug_signals[3:0] == 4'd9) ? rx_loopb :
                    (debug_signals[3:0] == 4'd10) ? JA_FPGA_IN[0] :
                    (debug_signals[3:0] == 4'd11) ? JA_FPGA_IN[1] :
                    (debug_signals[3:0] == 4'd12) ? JA_FPGA_IN[2] :
                    (debug_signals[3:0] == 4'd13) ? JA_FPGA_IN[3] : rx_trigger;

assign JA_FPGA_OUT[1] = (debug_signals[7:4] == 4'd0) ? tx_udp_hdr_valid :
                    (debug_signals[7:4] == 4'd1) ? tx_udp_hdr_ready :
                    (debug_signals[7:4] == 4'd2) ? rx_udp_hdr_valid :
                    (debug_signals[7:4] == 4'd3) ? rx_udp_hdr_ready :
                    (debug_signals[7:4] == 4'd4) ? tx_udp_payload_axis_tvalid :
                    (debug_signals[7:4] == 4'd5) ? tx_fifo_axis_tready :        // valor inicial en 5
                    (debug_signals[7:4] == 4'd6) ? tx_udp_payload_axis_tlast :
                    (debug_signals[7:4] == 4'd7) ? udp_tx_busy :
                    (debug_signals[7:4] == 4'd8) ? udp_rx_busy :
                    (debug_signals[7:4] == 4'd9) ? rx_loopb :
                    (debug_signals[7:4] == 4'd10) ? JA_FPGA_IN[0] :
                    (debug_signals[7:4] == 4'd11) ? JA_FPGA_IN[1] :
                    (debug_signals[7:4] == 4'd12) ? JA_FPGA_IN[2] :
                    (debug_signals[7:4] == 4'd13) ? JA_FPGA_IN[3] : rx_trigger;

assign JA_FPGA_OUT[2] = (debug_signals[11:8] == 4'd0) ? tx_udp_hdr_valid :
                    (debug_signals[11:8] == 4'd1) ? tx_udp_hdr_ready :
                    (debug_signals[11:8] == 4'd2) ? rx_udp_hdr_valid :
                    (debug_signals[11:8] == 4'd3) ? rx_udp_hdr_ready :
                    (debug_signals[11:8] == 4'd4) ? tx_udp_payload_axis_tvalid :
                    (debug_signals[11:8] == 4'd5) ? tx_fifo_axis_tready :
                    (debug_signals[11:8] == 4'd6) ? tx_udp_payload_axis_tlast : // valor inicial en 6
                    (debug_signals[11:8] == 4'd7) ? udp_tx_busy :
                    (debug_signals[11:8] == 4'd8) ? udp_rx_busy :
                    (debug_signals[11:8] == 4'd9) ? rx_loopb :
                    (debug_signals[11:8] == 4'd10) ? JA_FPGA_IN[0] :
                    (debug_signals[11:8] == 4'd11) ? JA_FPGA_IN[1] :
                    (debug_signals[11:8] == 4'd12) ? JA_FPGA_IN[2] :
                    (debug_signals[11:8] == 4'd13) ? JA_FPGA_IN[3] : rx_trigger;

assign JA_FPGA_OUT[3] = (debug_signals[15:12] == 4'd0) ? tx_udp_hdr_valid :
                    (debug_signals[15:12] == 4'd1) ? tx_udp_hdr_ready :
                    (debug_signals[15:12] == 4'd2) ? rx_udp_hdr_valid :
                    (debug_signals[15:12] == 4'd3) ? rx_udp_hdr_ready :
                    (debug_signals[15:12] == 4'd4) ? tx_udp_payload_axis_tvalid :
                    (debug_signals[15:12] == 4'd5) ? tx_fifo_axis_tready :
                    (debug_signals[15:12] == 4'd6) ? tx_udp_payload_axis_tlast :
                    (debug_signals[15:12] == 4'd7) ? udp_tx_busy :
                    (debug_signals[15:12] == 4'd8) ? udp_rx_busy :
                    (debug_signals[15:12] == 4'd9) ? rx_loopb :     // loop valor inicial en 7
                    (debug_signals[15:12] == 4'd10) ? JA_FPGA_IN[0] :
                    (debug_signals[15:12] == 4'd11) ? JA_FPGA_IN[1] :
                    (debug_signals[15:12] == 4'd12) ? JA_FPGA_IN[2] :
                    (debug_signals[15:12] == 4'd13) ? JA_FPGA_IN[3] : rx_trigger;

assign sfp_2_txd = 64'h0707070707070707;
assign sfp_2_txc = 8'hff;
assign sfp_3_txd = 64'h0707070707070707;
assign sfp_3_txc = 8'hff;
assign sfp_4_txd = 64'h0707070707070707;
assign sfp_4_txc = 8'hff;

eth_mac_10g_fifo #(
    .DATA_WIDTH(64),
    .ENABLE_PADDING(1),
    .ENABLE_DIC(1),
    .MIN_FRAME_LENGTH(64), //payload minimo
    .TX_FIFO_DEPTH(9000),
    .TX_FRAME_FIFO(1),
    .RX_FIFO_DEPTH(9000),
    .RX_FRAME_FIFO(1)
)
eth_mac_10g_fifo_inst (
    .rx_clk(sfp_1_rx_clk),
    .rx_rst(sfp_1_rx_rst),
    .tx_clk(sfp_1_tx_clk),
    .tx_rst(sfp_1_tx_rst),
    .logic_clk(clk),
    .logic_rst(rst),

    .tx_axis_tdata(tx_axis_tdata),
    .tx_axis_tkeep(tx_axis_tkeep),
    .tx_axis_tvalid(tx_axis_tvalid),
    .tx_axis_tready(tx_axis_tready),
    .tx_axis_tlast(tx_axis_tlast),
    .tx_axis_tuser(tx_axis_tuser),

    .rx_axis_tdata(rx_axis_tdata),
    .rx_axis_tkeep(rx_axis_tkeep),
    .rx_axis_tvalid(rx_axis_tvalid),
    .rx_axis_tready(rx_axis_tready),
    .rx_axis_tlast(rx_axis_tlast),
    .rx_axis_tuser(rx_axis_tuser),

    .xgmii_rxd(sfp_1_rxd),
    .xgmii_rxc(sfp_1_rxc),
    .xgmii_txd(sfp_1_txd),
    .xgmii_txc(sfp_1_txc),

    .tx_fifo_overflow(),
    .tx_fifo_bad_frame(),
    .tx_fifo_good_frame(),
    .rx_error_bad_frame(),
    .rx_error_bad_fcs(),
    .rx_fifo_overflow(),
    .rx_fifo_bad_frame(),
    .rx_fifo_good_frame(),

    .cfg_ifg(8'd12),
    .cfg_tx_enable(1'b1),
    .cfg_rx_enable(1'b1)
);

eth_axis_rx #(
    .DATA_WIDTH(64)
)
eth_axis_rx_inst (
    .clk(clk),
    .rst(rst),
    // AXI input
    .s_axis_tdata(rx_axis_tdata),
    .s_axis_tkeep(rx_axis_tkeep),
    .s_axis_tvalid(rx_axis_tvalid),
    .s_axis_tready(rx_axis_tready),
    .s_axis_tlast(rx_axis_tlast),
    .s_axis_tuser(rx_axis_tuser),
    // Ethernet frame output
    .m_eth_hdr_valid(rx_eth_hdr_valid),
    .m_eth_hdr_ready(rx_eth_hdr_ready),
    .m_eth_dest_mac(rx_eth_dest_mac),
    .m_eth_src_mac(rx_eth_src_mac),
    .m_eth_type(rx_eth_type),
    .m_eth_payload_axis_tdata(rx_eth_payload_axis_tdata),
    .m_eth_payload_axis_tkeep(rx_eth_payload_axis_tkeep),
    .m_eth_payload_axis_tvalid(rx_eth_payload_axis_tvalid),
    .m_eth_payload_axis_tready(rx_eth_payload_axis_tready),
    .m_eth_payload_axis_tlast(rx_eth_payload_axis_tlast),
    .m_eth_payload_axis_tuser(rx_eth_payload_axis_tuser),
    // Status signals
    .busy(),
    .error_header_early_termination()
);

eth_axis_tx #(
    .DATA_WIDTH(64)
)
eth_axis_tx_inst (
    .clk(clk),
    .rst(rst),
    // Ethernet frame input
    .s_eth_hdr_valid(tx_eth_hdr_valid),
    .s_eth_hdr_ready(tx_eth_hdr_ready),
    .s_eth_dest_mac(tx_eth_dest_mac),
    .s_eth_src_mac(tx_eth_src_mac),
    .s_eth_type(tx_eth_type),
    .s_eth_payload_axis_tdata(tx_eth_payload_axis_tdata),
    .s_eth_payload_axis_tkeep(tx_eth_payload_axis_tkeep),
    .s_eth_payload_axis_tvalid(tx_eth_payload_axis_tvalid),
    .s_eth_payload_axis_tready(tx_eth_payload_axis_tready),
    .s_eth_payload_axis_tlast(tx_eth_payload_axis_tlast),
    .s_eth_payload_axis_tuser(tx_eth_payload_axis_tuser),
    // AXI output
    .m_axis_tdata(tx_axis_tdata),
    .m_axis_tkeep(tx_axis_tkeep),
    .m_axis_tvalid(tx_axis_tvalid),
    .m_axis_tready(tx_axis_tready),
    .m_axis_tlast(tx_axis_tlast),
    .m_axis_tuser(tx_axis_tuser),
    // Status signals
    .busy()
);

udp_complete_64
udp_complete_inst (
    .clk(clk),
    .rst(rst),
    // Ethernet frame input
    .s_eth_hdr_valid(rx_eth_hdr_valid),
    .s_eth_hdr_ready(rx_eth_hdr_ready),
    .s_eth_dest_mac(rx_eth_dest_mac),
    .s_eth_src_mac(rx_eth_src_mac),
    .s_eth_type(rx_eth_type),
    .s_eth_payload_axis_tdata(rx_eth_payload_axis_tdata),
    .s_eth_payload_axis_tkeep(rx_eth_payload_axis_tkeep),
    .s_eth_payload_axis_tvalid(rx_eth_payload_axis_tvalid),
    .s_eth_payload_axis_tready(rx_eth_payload_axis_tready),
    .s_eth_payload_axis_tlast(rx_eth_payload_axis_tlast),
    .s_eth_payload_axis_tuser(rx_eth_payload_axis_tuser),
    // Ethernet frame output
    .m_eth_hdr_valid(tx_eth_hdr_valid),
    .m_eth_hdr_ready(tx_eth_hdr_ready),
    .m_eth_dest_mac(tx_eth_dest_mac),
    .m_eth_src_mac(tx_eth_src_mac),
    .m_eth_type(tx_eth_type),
    .m_eth_payload_axis_tdata(tx_eth_payload_axis_tdata),
    .m_eth_payload_axis_tkeep(tx_eth_payload_axis_tkeep),
    .m_eth_payload_axis_tvalid(tx_eth_payload_axis_tvalid),
    .m_eth_payload_axis_tready(tx_eth_payload_axis_tready),
    .m_eth_payload_axis_tlast(tx_eth_payload_axis_tlast),
    .m_eth_payload_axis_tuser(tx_eth_payload_axis_tuser),
    // IP frame input
    .s_ip_hdr_valid(tx_ip_hdr_valid),
    .s_ip_hdr_ready(tx_ip_hdr_ready),
    .s_ip_dscp(tx_ip_dscp),
    .s_ip_ecn(tx_ip_ecn),
    .s_ip_length(tx_ip_length),
    .s_ip_ttl(tx_ip_ttl),
    .s_ip_protocol(tx_ip_protocol),
    .s_ip_source_ip(tx_ip_source_ip),
    .s_ip_dest_ip(tx_ip_dest_ip),
    .s_ip_payload_axis_tdata(tx_ip_payload_axis_tdata),
    .s_ip_payload_axis_tkeep(tx_ip_payload_axis_tkeep),
    .s_ip_payload_axis_tvalid(tx_ip_payload_axis_tvalid),
    .s_ip_payload_axis_tready(tx_ip_payload_axis_tready),
    .s_ip_payload_axis_tlast(tx_ip_payload_axis_tlast),
    .s_ip_payload_axis_tuser(tx_ip_payload_axis_tuser),
    // IP frame output
    .m_ip_hdr_valid(rx_ip_hdr_valid),
    .m_ip_hdr_ready(rx_ip_hdr_ready),
    .m_ip_eth_dest_mac(rx_ip_eth_dest_mac),
    .m_ip_eth_src_mac(rx_ip_eth_src_mac),
    .m_ip_eth_type(rx_ip_eth_type),
    .m_ip_version(rx_ip_version),
    .m_ip_ihl(rx_ip_ihl),
    .m_ip_dscp(rx_ip_dscp),
    .m_ip_ecn(rx_ip_ecn),
    .m_ip_length(rx_ip_length),
    .m_ip_identification(rx_ip_identification),
    .m_ip_flags(rx_ip_flags),
    .m_ip_fragment_offset(rx_ip_fragment_offset),
    .m_ip_ttl(rx_ip_ttl),
    .m_ip_protocol(rx_ip_protocol),
    .m_ip_header_checksum(rx_ip_header_checksum),
    .m_ip_source_ip(rx_ip_source_ip),
    .m_ip_dest_ip(rx_ip_dest_ip),
    .m_ip_payload_axis_tdata(rx_ip_payload_axis_tdata),
    .m_ip_payload_axis_tkeep(rx_ip_payload_axis_tkeep),
    .m_ip_payload_axis_tvalid(rx_ip_payload_axis_tvalid),
    .m_ip_payload_axis_tready(rx_ip_payload_axis_tready),
    .m_ip_payload_axis_tlast(rx_ip_payload_axis_tlast),
    .m_ip_payload_axis_tuser(rx_ip_payload_axis_tuser),
    // UDP frame input
    .s_udp_hdr_valid(tx_udp_hdr_valid),
    .s_udp_hdr_ready(tx_udp_hdr_ready),
    .s_udp_ip_dscp(tx_udp_ip_dscp),
    .s_udp_ip_ecn(tx_udp_ip_ecn),
    .s_udp_ip_ttl(tx_udp_ip_ttl),
    .s_udp_ip_source_ip(tx_udp_ip_source_ip),
    .s_udp_ip_dest_ip(tx_udp_ip_dest_ip),
    .s_udp_source_port(tx_udp_source_port),
    .s_udp_dest_port(tx_udp_dest_port),
    .s_udp_length(tx_udp_length),
    .s_udp_checksum(tx_udp_checksum),
    .s_udp_payload_axis_tdata(tx_udp_payload_axis_tdata),
    .s_udp_payload_axis_tkeep(tx_udp_payload_axis_tkeep),
    .s_udp_payload_axis_tvalid(tx_udp_payload_axis_tvalid),
    .s_udp_payload_axis_tready(tx_udp_payload_axis_tready),
    .s_udp_payload_axis_tlast(tx_udp_payload_axis_tlast),
    .s_udp_payload_axis_tuser(tx_udp_payload_axis_tuser),
    // UDP frame output
    .m_udp_hdr_valid(rx_udp_hdr_valid),
    .m_udp_hdr_ready(rx_udp_hdr_ready),
    .m_udp_eth_dest_mac(rx_udp_eth_dest_mac),
    .m_udp_eth_src_mac(rx_udp_eth_src_mac),
    .m_udp_eth_type(rx_udp_eth_type),
    .m_udp_ip_version(rx_udp_ip_version),
    .m_udp_ip_ihl(rx_udp_ip_ihl),
    .m_udp_ip_dscp(rx_udp_ip_dscp),
    .m_udp_ip_ecn(rx_udp_ip_ecn),
    .m_udp_ip_length(rx_udp_ip_length),
    .m_udp_ip_identification(rx_udp_ip_identification),
    .m_udp_ip_flags(rx_udp_ip_flags),
    .m_udp_ip_fragment_offset(rx_udp_ip_fragment_offset),
    .m_udp_ip_ttl(rx_udp_ip_ttl),
    .m_udp_ip_protocol(rx_udp_ip_protocol),
    .m_udp_ip_header_checksum(rx_udp_ip_header_checksum),
    .m_udp_ip_source_ip(rx_udp_ip_source_ip),
    .m_udp_ip_dest_ip(rx_udp_ip_dest_ip),
    .m_udp_source_port(rx_udp_source_port),
    .m_udp_dest_port(rx_udp_dest_port),
    .m_udp_length(rx_udp_length),
    .m_udp_checksum(rx_udp_checksum),
    .m_udp_payload_axis_tdata(rx_udp_payload_axis_tdata),
    .m_udp_payload_axis_tkeep(rx_udp_payload_axis_tkeep),
    .m_udp_payload_axis_tvalid(rx_udp_payload_axis_tvalid),
    .m_udp_payload_axis_tready(rx_udp_payload_axis_tready),
    .m_udp_payload_axis_tlast(rx_udp_payload_axis_tlast),
    .m_udp_payload_axis_tuser(rx_udp_payload_axis_tuser),
    // Status signals
    .ip_rx_busy(),
    .ip_tx_busy(),
    .udp_rx_busy(udp_rx_busy),
    .udp_tx_busy(udp_tx_busy),
    .ip_rx_error_header_early_termination(),
    .ip_rx_error_payload_early_termination(),
    .ip_rx_error_invalid_header(),
    .ip_rx_error_invalid_checksum(),
    .ip_tx_error_payload_early_termination(),
    .ip_tx_error_arp_failed(),
    .udp_rx_error_header_early_termination(),
    .udp_rx_error_payload_early_termination(),
    .udp_tx_error_payload_early_termination(),
    // Configuration
    .local_mac(local_mac),
    .local_ip(local_ip),
    .gateway_ip(gateway_ip),
    .subnet_mask(subnet_mask),
    .clear_arp_cache(1'b0)
);

/*
axis_fifo #(
    .DEPTH(16384),
    .DATA_WIDTH(64),
    .KEEP_ENABLE(1),
    .KEEP_WIDTH(8),
    .ID_ENABLE(0),
    .DEST_ENABLE(0),
    .USER_ENABLE(1),
    .USER_WIDTH(1),
    .FRAME_FIFO(1)
)
tx_udp_payload_fifo (
    .clk(clk),
    .rst(rst),

    // AXI input
    .s_axis_tdata(tx_fifo_axis_tdata),
    .s_axis_tkeep(tx_fifo_axis_tkeep),
    .s_axis_tvalid(tx_fifo_axis_tvalid),
    .s_axis_tready(tx_fifo_axis_tready),
    .s_axis_tlast(tx_fifo_axis_tlast),
    .s_axis_tid(0),
    .s_axis_tdest(0),
    .s_axis_tuser(tx_fifo_axis_tuser),

    // AXI output
    .m_axis_tdata(tx_fifo_udp_payload_axis_tdata),
    .m_axis_tkeep(tx_fifo_udp_payload_axis_tkeep),
    .m_axis_tvalid(tx_fifo_udp_payload_axis_tvalid),
    .m_axis_tready(tx_fifo_udp_payload_axis_tready),
    .m_axis_tlast(tx_fifo_udp_payload_axis_tlast),
    .m_axis_tid(),
    .m_axis_tdest(),
    .m_axis_tuser(tx_fifo_udp_payload_axis_tuser),

    // Status
    .status_overflow(),
    .status_bad_frame(),
    .status_good_frame()
);
*/


axis_fifo #(
    .DEPTH(9000),
    .DATA_WIDTH(64),
    .KEEP_ENABLE(1),
    .KEEP_WIDTH(8),
    .ID_ENABLE(0),
    .DEST_ENABLE(0),
    .USER_ENABLE(1),
    .USER_WIDTH(1),
    .FRAME_FIFO(1)
)
rx_udp_payload_fifo (
    .clk(clk),
    .rst(rst),

    // AXI input
    .s_axis_tdata(rx_fifo_udp_payload_axis_tdata),
    .s_axis_tkeep(rx_fifo_udp_payload_axis_tkeep),
    .s_axis_tvalid(rx_fifo_udp_payload_axis_tvalid),
    .s_axis_tready(rx_fifo_udp_payload_axis_tready),
    .s_axis_tlast(rx_fifo_udp_payload_axis_tlast),
    .s_axis_tid(0),
    .s_axis_tdest(0),
    .s_axis_tuser(rx_fifo_udp_payload_axis_tuser),

    // AXI output
    .m_axis_tdata(reg_fifo_udp_payload_axis_tdata),
    .m_axis_tkeep(reg_fifo_udp_payload_axis_tkeep),
    .m_axis_tvalid(reg_fifo_udp_payload_axis_tvalid),
    .m_axis_tready(reg_fifo_udp_payload_axis_tready),
    .m_axis_tlast(reg_fifo_udp_payload_axis_tlast),
    .m_axis_tid(),
    .m_axis_tdest(),
    .m_axis_tuser(reg_fifo_udp_payload_axis_tuser),

    // Status
    .status_overflow(),
    .status_bad_frame(),
    .status_good_frame()
);

endmodule

`resetall
