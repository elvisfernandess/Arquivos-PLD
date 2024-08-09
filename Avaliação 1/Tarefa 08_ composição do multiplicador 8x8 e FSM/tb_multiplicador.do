#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom adder.vhd
vcom counter.vhd
vcom mult_control.vhd
vcom mult4x4.vhd
vcom mux_sel.vhd
vcom mux_when.vhd
vcom reg16.vhd
vcom seven_segment_cntrl.vhd
vcom shifter.vhd
vcom multiplicador8x8.vhd 
vcom multiplicador8x8_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim  -voptargs="+acc" -t ns work.multiplicador8x8_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary -label clk /clk
add wave -radix binary -label rst /reset_a
add wave -radix bin  -label start  /start
add wave /dut/mult_control_inst/state
add wave -radix uns -label dataa /dataa
add wave -radix uns -label datab /datab
add wave -radix binary  -label done /done_flag
add wave -radix uns  -label poduct /product8x8_out
add wave -radix binary -label segs /segs
#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps