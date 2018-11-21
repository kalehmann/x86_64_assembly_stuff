section .data
     a          dd 4.0
     b          dd 3.0
     pi         dd 3.1415

section .text
global  v_kugel

v_kugel:
		;; This procedure calculates the volumina of a sphere
		;; It takes the radius of the sphere as only argument in xmm0
		;; The return-type is float
		movss  xmm1, [a]
		movss  xmm2, [b]
		divss  xmm1, xmm2    				; store 4/3 in xmm1
		mulss  xmm1, [pi]           ; store 4/3 * pi in xmm1
		; multiply xmm1 trice by r
		mulss  xmm1, xmm0
		mulss  xmm1, xmm0
		mulss  xmm1, xmm0

		movss  xmm0, xmm1    				; store the result in xmm0
