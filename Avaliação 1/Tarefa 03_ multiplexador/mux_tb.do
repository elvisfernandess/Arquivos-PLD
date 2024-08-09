-------------------------------------------------------
--! Tarefa 03: multiplexador
--! Aluno: Elvis Fernandes
--! Data: 19/03/2024
--! Arquivo: mux_when.do
-------------------------------------------------------
#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom mux_when.vhd testbench_mux_when.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench_mux_when
#vsim -voptargs="+acc" -t ns work.testbench_mux_when

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#add wave -radix uns  /mux_in_a
#add wave -radix uns  /mux_in_b
#add wave -radix uns  /mux_out
add wave -radix bin  /mux_in_a
add wave -radix bin  /mux_in_b
add wave -radix bin  /mux_out
add wave -radix bin  /mux_sel


#Simula até um 500ns
run 1000ns

wave zoomfull
write wave wave.ps