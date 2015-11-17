;wm johnson
;oh for a thousand tongues to sing

<CsoundSynthesizer>

<CsOptions>
-o oforathousand.wav
</CsOptions>

<CsInstruments>
sr        =         48000
kr        =         480
ksmps     =         100
nchnls    = 		2

;instruments

garev	init	0
gif1	init	0.1
gif2	init	0.1
gif3	init	0.1
gif4	init	0.1
gaenv 	init	0	

instr 1			;reverb
				denorm 		garev
arevl, arevr	freeverb	garev, garev, 0.999, 0.1, sr
				out			arevl*p4, arevr*p4	
garev			=			0
endin
		
instr 2		;chords based on ratios
kharm	linseg	1, p3*0.3, p8, 20, p8
	
if (p9 == 1) then
	itime	=		p3*.2
	kf1		expseg	gif1, itime, p4*.25, 20, p4*.25
	kf2		expseg	gif2, itime, p4*p5, 20, p4*p5
	kf3		expseg  gif3, itime, p4*p6, 20, p4*p6
	kf4		expseg	gif4, itime, p4*p7, 20, p4*p7

else
	kf1 = p4*.25
	kf2 = p4*p5
	kf3 = p4*p6
	kf4 = p4*p7
	
endif

a1		buzz	7000, kf1, kharm, 1
a2		oscil	7000, kf2
a3		oscil	7000, kf3
a4		oscil	7000, kf4
gif1	=		p4*.25
gif2	=		p4*p5
gif3	=		p4*p6
gif4 	=		p4*p7
amix 	= 		a1*gaenv+a2*gaenv+a3*gaenv+a4*gaenv
		out		amix, amix
garev	=		garev+amix
endin

instr 3		;asr envelope
aenv   	expseg	0.0001, p3*0.3, p4, p3*0.4, p4*.9, p3*0.3, 0.0001
gaenv	=		aenv
endin

</CsInstruments>


<CsScore>
;tempo
t 0 8

;ftables
f	1	0	8192	10 		3.2

;score key: a=220s
i	1	0	65	1

;	i	t	l	root		i1			i2			i3			dest		port
;==================================================================================================================
i	2	0	2	330			1 			2	 	 	2	    	1			0	;root e: 220 * [3/2] = 330
i	.	+	1	275			[6/5] 		[12/5]  	[16/5]		.			.	;root c: 220 * [5/4] = 275
i	.	.	.	220			2	 		[10/4]  	4			2			.
i	.	.	2	330			[5/4]	 	2		  	[6/2]		1			.
i	.	.	.	.			.		 	.		  	.			2			.
i	.	.	.	.			[13/10]		.			[28/9]		1			.	;qt
i	.	.	1	440			1			[3/2]		[10/4]		.			1
i	.	.	.	330			[13/10]		[35/18]		[28/9]		.			0	;qt
i 	.	.	.	.			[5/4]		[16/9]		[6/2]		.			1
i	.	.	.	[220*[5/3]]	[6/5]		[14/9]		[10/4]		.			0	;qt
i	.	.	2	[220*[5/3]]	[6/5]		[3/2]		[12/5]		.			1	;root f#: 220 * [5/3] = 366.6(r)
i	.	.	.	330			[5/4]	 	2		  	[6/2]		.			0
i	.	.	1	440			1			[3/2]		[10/4]		.			.
i	.	.	.	.			.			.			.			.			.
i	.	.	2	412.5		[6/5]		[8/5]		[14/5]		.			.	
i	.	.	.	.			[9/8]		.			[11/8]		4			.	;qt
i	.	.	.	440			1			[3/2]		[10/4]		>			.
i	.	.	.	.			[35/36]		.			[14/6]		.			1	;qt
i	.	.	4	330			[5/4]		2			[6/2]		7			0

; phrase 2	
i	.	.	2	.			[3/2]		[10/4]		4			.			.		
i	.	.	1	440			[5/4]		2			[6/2]		1			.
i	.	.	.	440			[9/8]		.			[18/8]		.			.	;qt
i	.	.	.	.			1			[3/2]		[10/4]		.			.
i	.	.	2	.			.			.			.			2			.
i	.	.	.	275			[8/5]		[6/5]		[16/5]		1			.	
i 	.	.	1	[220*[4/3]]	[3/2]		[10/4]		[6/2]		.			.	;root of d: 220*[4/3] = 293.3(r) 
i	.	.	.	.			.			[9/8]		[11/8]		.			.	;qt
i	.	.	.	.			.			2			[10/4]		.			.
i	.	.	2	.			.			.			.			.			.
i	.	.	1	.			.			[10/4]		[6/2]		.			.
i	.	.	.	.			.			2			[10/4]		.			.
i	.	.	.	330			[4/3]		[5/3]		2			5			.
i	.	.	.	.			.			.			[8/3]		>			.
i	.	.	2	.			.			.			.			.			.
i	.	.	.	.			[13/10]		[7/4]		[14/5]		.			1	;qt
i	.	.	.	.			[5/4]		[16/9]		[6/2]		.			.	
i	.	.	8	220			2			[10/4]		4			12			0


;enveloping
i	3	0	2	0.2
i 	.	+	1	)
i 	.	.	.	)
i 	.	.	2	)
i 	.	.	.	)
i 	.	.	.	0.6
i 	.	.	1	)
i 	.	.	.	)
i 	.	.	.	)
i 	.	.	.	)
i 	.	.	2	0.2
i 	.	.	.	)
i 	.	.	1	)
i 	.	.	.	)
i 	.	.	2	)
i 	.	.	.	)
;i 	.	.	.	)
;i 	.	.	.	)
i 	.	.	4	)
i 	.	.	4	0.1

;phrase 2
i	.	.	2	0.1
i 	.	.	1	)
i 	.	.	.	)
i 	.	.	.	)
i 	.	.	2	0.5
i 	.	.	.	)
i 	.	.	1	)
i 	.	.	.	0.3
i 	.	.	.	)
;i 	.	.	3	0.3
i 	.	.	2	)
i 	.	.	1	)
i 	.	.	.	)
i 	.	.	.	)
i 	.	.	.	)
i 	.	.	2	1
;i 	.	.	.	)
;i 	.	.	.	)
i 	.	.	4	)
i	.	.	8	0.2

e ;end

</CsScore>

</CsoundSynthesizer>
