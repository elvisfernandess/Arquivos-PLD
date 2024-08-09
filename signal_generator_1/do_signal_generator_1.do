#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom signal_generator_1.vhd signal_generator_1_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.signal_generator_1_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave /dut/pr_state1
add wave -radix uns  /out1
add wave -radix uns  /out2


#Simula até um 100000ns
run 230

wave zoomfull
write wave wave.ps