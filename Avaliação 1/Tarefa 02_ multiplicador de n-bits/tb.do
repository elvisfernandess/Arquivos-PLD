#-------------------------------------------------------
#--! Tarefa 02: multiplicador de n-bits
#--! Aluno: Elvis Fernandes
#--! Data: 19/03/2024
#--! Arquivo: tb.do
#-------------------------------------------------------
#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom mult4x4.vhd testbench_mult4x4.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench_mult4x4
#vsim -voptargs="+acc" -t ns work.testbench_mult4x4

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix uns  /dataa
add wave -radix uns  /datab
add wave -radix uns  /product
add wave -radix bin  /dataa
add wave -radix bin  /datab
add wave -radix bin  /product

#Simula até um 500ns
run 1000ns

wave zoomfull
write wave wave.ps