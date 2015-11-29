# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.cache/wt [current_project]
set_property parent.project_path /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files -quiet /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.runs/framebuffer_synth_1/framebuffer.dcp
set_property used_in_implementation false [get_files /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.runs/framebuffer_synth_1/framebuffer.dcp]
read_verilog -library xil_defaultlib {
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/sources_1/imports/vga_timing.v
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/sources_1/imports/linedraw.v
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/software/software.v
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/sources_1/imports/ee178_fall2015_lab8/vga_example.v
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/sources_1/imports/ee178_fall2015_lab8/kcpsm6.v
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/sources_1/imports/quad_seven_seg.v
  /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/sources_1/imports/ee178_fall2015_lab8/project.v
}
read_xdc /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/constrs_1/imports/ee178_fall2015_lab8/project.xdc
set_property used_in_implementation false [get_files /home/adnan/Documents/School/EE178/fpga_video_game/latest_fpga_video_game/latest_fpga_video_game.srcs/constrs_1/imports/ee178_fall2015_lab8/project.xdc]

synth_design -top project -part xc7a35tcpg236-1
write_checkpoint -noxdef project.dcp
catch { report_utilization -file project_utilization_synth.rpt -pb project_utilization_synth.pb }
