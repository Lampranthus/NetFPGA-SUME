set_param general.maxThreads 16
set_param synth.maxThreads 8
set_param place.maxThreads 16
set_param route.maxThreads 16
open_project fpga.xpr
reset_run impl_1
launch_runs -jobs 16 impl_1
wait_on_run impl_1
open_run impl_1
report_utilization -file fpga_utilization.rpt
report_utilization -hierarchical -file fpga_utilization_hierarchical.rpt
