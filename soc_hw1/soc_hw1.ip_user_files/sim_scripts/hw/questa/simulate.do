onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib hw_opt

do {wave.do}

view wave
view structure
view signals

do {hw.udo}

run -all

quit -force
