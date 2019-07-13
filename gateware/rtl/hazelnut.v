//
//  Hazelnut SDR
//
// (C) Steve Haynal KF7O 2019


module hazelnut(

  // Ethernet PHY
  (* useioff = 1 *) output  [1:0]   phy_tx,
  (* useioff = 1 *) output          phy_tx_en,
  (* useioff = 1 *) input   [1:0]   phy_rx,
  (* useioff = 1 *) input           phy_rx_dv,
  input           phy_clk,
  inout           phy_mdio,
  output          phy_mdc
);

localparam       MAC = {8'h00,8'h1c,8'hc0,8'ha5,8'h13,8'hdd};
localparam       IP = {8'd0,8'd0,8'd0,8'd0};

logic           clk_ctrl;

logic [5:0]     phy_clk_div = 5'b00000;
logic           phy_clk_div4;

logic [7:0]     phy_tx_data;
logic           phy_tx_valid;

logic [7:0]     phy_rx_data;
logic           phy_rx_valid;


logic [15:0]    reset_counter = 16'h0000;


/////////////////////////////////////////////////////
// Clocks


always @(posedge phy_clk) begin
  phy_clk_div <= phy_clk_div + 2'b01;
end

assign phy_clk_div4 = phy_clk_div[1];

assign clk_ctrl = phy_clk_div[4]; //50.0/32


always @(posedge clk_ctrl) begin
  if (~reset_counter[15]) reset_counter <= reset_counter + 16'h01;
end



/////////////////////////////////////////////////////
// Network


network network_inst(

  .clock_2_5MHz(clk_ctrl),
  .delay_start(~reset_counter[15]),

  .tx_clock(phy_clk_div4),
  .udp_tx_request(1'b0),
  .udp_tx_length(16'h0000),
  .udp_tx_data(8'h00),
  .udp_tx_enable(),
  .run(1'b0),
  .port_id(8'h00),

  .rx_clock(phy_clk_div4),
  .to_port(),
  .udp_rx_data(),
  .udp_rx_active(),
  .broadcast(),
  .dst_unreachable(),

  .static_ip(IP),
  .local_mac(MAC),
  .network_state_dhcp(),
  .network_state_fixedip(),
  .network_speed(),

  .phy_tx_data(phy_tx_data),
  .phy_tx_valid(phy_tx_valid),
  .phy_rx_data(phy_rx_data),
  .phy_rx_valid(phy_rx_valid),
    
  .PHY_MDIO(phy_mdio),
  .PHY_MDC(phy_mdc),

  .debug()
);

rmii_send rmii_send_i (
    .clk(phy_clk),
    .clk_div4(phy_clk_div4),
    .phy_tx_data(phy_tx_data),
    .phy_tx_valid(phy_tx_valid),
    .phy_tx(phy_tx),
    .phy_tx_en(phy_tx_en)
);

rmii_recv rmii_recv_i (
    .clk(phy_clk),
    .clk_div4(phy_clk_div4),
    .phy_rx_data(phy_rx_data),
    .phy_rx_valid(phy_rx_valid),
    .phy_rx(phy_rx),
    .phy_dv(phy_rx_dv)
);


endmodule
