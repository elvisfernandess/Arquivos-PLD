#-------------------------------------------------------
#--! Tarefa 1 - ADDER - Somador
#--! Aluno: Elvis Fernandes
#--! Data: 13/03/2024
#--! Arquivo: tb.do
#-------------------------------------------------------
#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom adder.vhd testbench_adder.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.testbench_adder

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# add wave -radix dec  /clk
add wave -radix dec  /dataa
add wave -radix dec  /datab
add wave -radix dec  /sum

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps