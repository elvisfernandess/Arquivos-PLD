#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom counter.vhd counter_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.counter_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /rst
add wave -radix binary  /count
add wave /dut/pr_state

#Simula até um 220ns
run 220

wave zoomfull
write wave wave.ps