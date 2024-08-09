-------------------------------------------------------
--! Tarefa 4 - SHIFTER - Deslocador
--! Aluno: Elvis Fernandes
--! Data: 23 /03/2024
--! Arquivo: tb.do
-------------------------------------------------------

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom shifter.vhd testbench_left_shifter.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns -voptargs="+acc" work.testbench_left_shifter

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /input
add wave -radix uns     /shift_cntrl
add wave -radix binary  /shift_out

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps