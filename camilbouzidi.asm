;Camil Bouzidi, ID #40099611, SOEN 228 Section U Assembly Language Assignment, April 10th 2019
section .data



number db  5	; This is the number to be tested, 5 was given to us, but any works. 
answer db  1    ;  1 means number is prime, 0 means number is not prime
section .bss
 ;No unitialized data was needed in this particular program.
section .text
        global _start

_start:
       mov esi, number ; get the offset of number into esi  
keith: mov eax, 0      ; clear the entire eax register
       mov al, [esi]   ; get the number from memory into al
       mov dl, al      ; put it inside dl as well
       mov bl, 2       ; bl holds each divisor starting from 2
loopy: div bl          ; ax / bl  with quot in al and rem in ah
       and ax, 1111111100000000b   ;  isolate the rem in ah with a  AND mask
                       ; to determine whether the remainder is 0
       cmp ah,0        ; compares the value of the remainder ah to 0
       je  change      ; if the remainder is equal to 0, got to change
       inc bl          ; increment the counter if the remainder is not equal to 0
       mov eax, 0      ; clear the entire eax register
       mov al, [esi]   ; get the number from memory into al
       cmp bl,dl       ; check if the counter is less than the number
       jl loopy        ; if the counter is less than the number, you can divide the number again
       jmp finished    ; if this point is reached, then it means that the counter is equal to the number and
		       ; that the answer is now final
       
change: mov [answer], byte 0; Confirm that the number is not prime. since the space allocated to answer is 1 byte,
			    ; 1 byte of value 0 is moved to it.



finished:
       mov ecx, [answer] ; for debugging purposes only. Used to verify the value of answer quickly.
       mov eax,1         ; beginning of the steps to close the program.
       mov ebx,0	 ; intermediate step to end the program.
       int 0x80		 ; interrupt signal to end the program.
