
set_time_format -unit ns -decimal_places 3


create_clock -name phy_clk -period 20.000 [get_ports phy_clk]


create_generated_clock -source [get_ports {phy_clk}] -divide_by 4 -duty_cycle 50.00 -name phy_clk_div4 [get_keepers {phy_clk_div[1]}]

create_generated_clock -source [get_ports {phy_clk}] -divide_by 32 -duty_cycle 50.00 -name clk_ctrl [get_keepers {phy_clk_div[4]}]

derive_clock_uncertainty

#PHY PHY_MDIO Data in +/- 10nS setup and hold
set_input_delay  10  -clock clk_ctrl -reference_pin [get_ports phy_mdc] {phy_mdio}

#PHY (2.5MHz)
set_output_delay  10 -clock clk_ctrl -reference_pin [get_ports phy_mdc] {phy_mdio}


set_false_path -to [get_ports {phy_mdc}]



