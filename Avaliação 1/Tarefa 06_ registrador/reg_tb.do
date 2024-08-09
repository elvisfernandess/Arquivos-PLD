-------------------------------------------------------
--! Tarefa 06: Registrador de 16 bits
--! Aluno: Elvis Fernandes
--! Data: 23/03/2022
--! Arquivo: reg_tb.do
-------------------------------------------------------

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom reg16.vhd testbench_reg16.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns -voptargs="+acc" work.testbench_reg16

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /sclr_n
add wave -radix binary  /clk_ena
add wave -radix hex /datain
add wave -radix hex /reg_out

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps