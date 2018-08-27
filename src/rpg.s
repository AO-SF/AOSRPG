requireend std/io/fput.s
requireend std/proc/exit.s

requireend draw.s
requireend level.s
requireend load.s
requireend tiles.s

db startLevelPath 'intro.lvl',0
db errorStrLevelLoad 'could not load level\n',0

; Load level
mov r0 startLevelPath
call loadLevel
cmp r0 r0 r0
skipneqz r0
jmp errorLevelLoad

; Draw level (initially we redraw everything)
call redraw

; TODO: write rest of game here (waiting for input, moving player, redrawing etc)

; Exit
label done
call tidyup
mov r0 0
call exit

; Errors
label errorLevelLoad
call tidyup
mov r0 errorStrLevelLoad
call puts0
mov r0 1
call exit

; Tidy up
label tidyup
call cursesReset
ret
