onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /picoMIPS_tb/fastclk
add wave -noupdate -radix binary -childformat {{{/picoMIPS_tb/SW[9]} -radix binary} {{/picoMIPS_tb/SW[8]} -radix binary} {{/picoMIPS_tb/SW[7]} -radix binary} {{/picoMIPS_tb/SW[6]} -radix binary} {{/picoMIPS_tb/SW[5]} -radix binary} {{/picoMIPS_tb/SW[4]} -radix binary} {{/picoMIPS_tb/SW[3]} -radix binary} {{/picoMIPS_tb/SW[2]} -radix binary} {{/picoMIPS_tb/SW[1]} -radix binary} {{/picoMIPS_tb/SW[0]} -radix binary}} -subitemconfig {{/picoMIPS_tb/SW[9]} {-radix binary} {/picoMIPS_tb/SW[8]} {-radix binary} {/picoMIPS_tb/SW[7]} {-radix binary} {/picoMIPS_tb/SW[6]} {-radix binary} {/picoMIPS_tb/SW[5]} {-radix binary} {/picoMIPS_tb/SW[4]} {-radix binary} {/picoMIPS_tb/SW[3]} {-radix binary} {/picoMIPS_tb/SW[2]} {-radix binary} {/picoMIPS_tb/SW[1]} {-radix binary} {/picoMIPS_tb/SW[0]} {-radix binary}} /picoMIPS_tb/SW
add wave -noupdate -radix binary -childformat {{{/picoMIPS_tb/LED[7]} -radix binary} {{/picoMIPS_tb/LED[6]} -radix binary} {{/picoMIPS_tb/LED[5]} -radix binary} {{/picoMIPS_tb/LED[4]} -radix binary} {{/picoMIPS_tb/LED[3]} -radix binary} {{/picoMIPS_tb/LED[2]} -radix binary} {{/picoMIPS_tb/LED[1]} -radix binary} {{/picoMIPS_tb/LED[0]} -radix binary}} -subitemconfig {{/picoMIPS_tb/LED[7]} {-height 15 -radix binary} {/picoMIPS_tb/LED[6]} {-height 15 -radix binary} {/picoMIPS_tb/LED[5]} {-height 15 -radix binary} {/picoMIPS_tb/LED[4]} {-height 15 -radix binary} {/picoMIPS_tb/LED[3]} {-height 15 -radix binary} {/picoMIPS_tb/LED[2]} {-height 15 -radix binary} {/picoMIPS_tb/LED[1]} {-height 15 -radix binary} {/picoMIPS_tb/LED[0]} {-height 15 -radix binary}} /picoMIPS_tb/LED
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1575 ns}
