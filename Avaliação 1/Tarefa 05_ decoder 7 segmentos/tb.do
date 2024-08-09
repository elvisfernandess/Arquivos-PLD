-------------------------------------------------------
--! Tarefa 05: decodificador de 7-segmentos utilizando a instrução case.
--! Aluno: Elvis Fernandes
--! Data: 23/03/2022
--! Arquivo: tb.do
-------------------------------------------------------


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom seven_segment_cntrl.vhd testbench_seven.vhd

#Simula (work é o diretorio, testbench_seven é o nome da entity)
vsim -voptargs="+acc" -t ns work.testbench_seven

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /input
add wave -radix binary  /segs


#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps