set_param general.maxThreads 16
set_param synth.maxThreads 8
set_param place.maxThreads 16
set_param route.maxThreads 16
open_project fpga.xpr
reset_run synth_1
launch_runs -jobs 16 synth_1
wait_on_run synth_1
