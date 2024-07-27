set_units -time ns

set period 10.000
create_clock -name clk -period $period [get_ports {clk}]

#hold - min
set_clock_latency -source -min 1 clk
#setup - max
set_clock_latency -source -max 4 clk 

#500 ps
set clk_uncertainty_factor_setup 0.05
set clk_uncertainty_setup [expr $period * $clk_uncertainty_factor_setup]
#200 ps
set clk_uncertainty_factor_hold 0.02
set clk_uncertainty_hold [expr $period * $clk_uncertainty_factor_hold]
set_clock_uncertainty -setup $clk_uncertainty_setup [get_clock clk]
set_clock_uncertainty -hold $clk_uncertainty_hold [get_clock clk]

# input delay = 500 ps
set min_input_dly_factor 0.05
set max_input_dly_factor 0.05
set min_input_dly [expr $period * $min_input_dly_factor]
set max_input_dly [expr $period * $max_input_dly_factor]
set_input_delay -clock clk -min $min_input_dly [get_ports RN]
set_input_delay -clock clk -max $max_input_dly [get_ports RN]

# input transition delay = 200 ps
set min_tran_factor 0.02
set max_tran_factor 0.02
set min_tran [expr $period * $min_tran_factor]
set max_tran [expr $period * $max_tran_factor]
set_input_transition -max $min_tran [get_ports RN]
set_input_transition -min $max_tran [get_ports RN]

#output delay = 500 ps
set min_ouput_dly_factor 0.05
set max_ouput_dly_factor 0.05
set min_ouput_dly [expr $period * $min_ouput_dly_factor]
set max_ouput_dly [expr $period * $max_ouput_dly_factor]
set_output_delay -clock clk -min $min_ouput_dly [get_ports WB_OUT]
set_output_delay -clock clk -min $max_ouput_dly [get_ports WB_OUT]

