#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom mult_control.vhd testbench_mult_control.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench_mult_control

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /reset_a
add wave -radix binary  /start
add wave -radix binary  /count
add wave -radix binary  /input_sel
add wave -radix binary  /shift_sel
add wave -radix binary  /state_out
add wave -radix binary  /done
add wave -radix binary  /clk_ena
add wave -radix binary  /sclr_n
add wave /dut/state

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps