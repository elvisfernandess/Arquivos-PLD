#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom signal_gen.vhd signal_gen_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.signal_gen_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave /dut/pr_state1
add wave /dut/pr_state2
add wave -radix uns  /outp


#Simula até um 100000ns
run 150

wave zoomfull
write wave wave.ps