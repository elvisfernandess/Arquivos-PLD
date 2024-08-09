-------------------------------------------------------
--! Tarefa 07: contador
--! Aluno: Elvis Fernandes
--! Data: 23/03/2022
--! Arquivo: counter_tb.vhd
-------------------------------------------------------

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom counter.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /aclr_n
add wave -radix uns  /count_out


#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps