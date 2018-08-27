requireend std/io/fput.s
requireend std/proc/exit.s

requireend draw.s
requireend level.s
requireend load.s
requireend tiles.s

db startLevelPath 'intro.lvl',0
db errorStrLevelLoad 'could not load level\n',0

; signal handler labels must be within first 256 bytes of executable, so use 'trampoline' functions
jmp start
label suicideHandlerTrampoline
jmp suicideHandler
label start

; Register suicide signal handler
mov r0 1024
mov r1 3 ; suicide signal id
mov r2 suicideHandlerTrampoline
syscall

; Load level
mov r0 startLevelPath
call loadLevel
cmp r0 r0 r0
skipneqz r0
jmp errorLevelLoad

; Draw level (initially we redraw everything)
call redraw

; Main game loop
label mainloopstart
; Check for input
call cursesGetChar
mov r1 256
cmp r1 r0 r1
skipneq r1
jmp mainloopinputend
mov r1 'q'
cmp r1 r0 r1
skipneq r1
jmp done
; Unknown character
label mainloopinputend
; Loop for next tick
jmp mainloopstart

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
call cursesCursorShow
mov r0 1
call cursesSetEcho
ret

; Sucide handler
label suicideHandler
call tidyup
mov r0 0
call exit
