#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom string_detector.vhd string_detector_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.string_detector_tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
add wave -radix binary  /clk
add wave -radix binary  /rst
add wave -radix uns  /d
add wave -radix uns  /q
add wave /dut/pr_state

#Simula até um 220ns
run 220

wave zoomfull
write wave wave.ps