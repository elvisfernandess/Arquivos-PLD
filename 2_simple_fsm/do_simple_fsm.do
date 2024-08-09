#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom simple_fsm.vhd simple_fsm_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.simple_fsm_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /rst
add wave -radix binary  /d
add wave -radix binary  /a
add wave -radix binary  /b
add wave /dut/pr_state
add wave -radix binary  /x



#Simula até um 100000ns
run 150

wave zoomfull
write wave wave.ps