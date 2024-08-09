#-------------------------------------------------------
#!-- Name        : do_prescaler.do
#!-- Author      : Elvis Fernandes
#!-- Version     : 0.1
#!-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
#!-- Description : Tarefa 10: Temporizador com PWM 
#!-- Date        : 12/07/2024
#-------------------------------------------------------

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom prescaler.vhd tb_prescaler.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_prescaler

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /rst
add wave -radix binary  /sel_pr
add wave -radix uns  /input_comp1
add wave -radix uns  /input_comp2
add wave -radix binary  /out_clk
add wave -radix binary  /comp_out1
add wave -radix binary  /comp_out2
add wave -radix binary  /comp_out3
add wave -radix binary  /comp_out4
add wave -radix uns  /counter


#Simula até um 100000ns
#run 99840
run 20000

wave zoomfull
write wave wave.ps