
( №3)
( 0 - нечетное, 1 - четное)
( number -- parity)
: parity 2 % if 0 else 1 then ;

( №4,5)
( 0 - составное, 1 - простое)
( number -- prime)
: prime 
	dup 1 > 
	if dup 4 <  ( check if it is too small to be comp)
		if drop 1 allot dup 1 swap ! ( save)
		else dup parity  ( if the number is even and > 3, it is not a prime one)
			if drop 1 allot dup 0 swap !  ( save)
			else 2 repeat ( 2 is the first divisor)
				over over swap < not 
					if 1 1 ( go away if a divisor more than a number and save 1 as 'prime')
					else over over % not ( check if it is a divisor of a number)
						if 0 1 ( go away if it is a real divisor and save 0 as 'not prime')
						else 1 + 0 ( increment divisor)
						then 
					then
				until 
			rot rot drop drop ( remove number and divisor) 1 allot dup >r ! r> 
			then 
		then 
    else 1 allot dup 0 swap ! ( <=1)
	then  ; 
 
( №7)
( target_addr str_addr -- target_addr+str_len)
: copy1 ( target_addr, str_addr)
	repeat
 		dup c@ dup >r rot dup >r c! ( save symbol)
		1 + r> 1 + ( get the next symbol and get the next addr to save)
		r> rot swap not ( is it null-terminator?)
	until 
	drop ; 

( str1 str2 -- cat_str)
: cat 	
	dup count ( 1st len)
	rot dup count ( 2nd len)
	rot + ( sum)
	heap-alloc dup >r ( save target addr)
	rot >r ( save 2nd addr)
	swap  ( t_addr, s_addr)
	copy1
	1 - ( minus addr of the null-terminator)
	r> copy1 
    r> swap drop ; ( get addr of concatenated str)

( №7a)
( number -- seq)
: collatz 
	repeat 
		dup dup 2 % 
		if 3 * 1 + ( if not an even one)
		else 2 / 
		then dup 1 = ( if we are done)
		if 1 
		else 0 
		then 
	until ; 


