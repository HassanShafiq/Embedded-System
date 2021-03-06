;#define GPIO_PORTF_DATA_R       (*((volatile unsigned long *)0x400253FC))
;#define GPIO_PORTF_DIR_R        (*((volatile unsigned long *)0x40025400))
;#define GPIO_PORTF_AFSEL_R      (*((volatile unsigned long *)0x40025420))
;#define GPIO_PORTF_PUR_R        (*((volatile unsigned long *)0x40025510))
;#define GPIO_PORTF_DEN_R        (*((volatile unsigned long *)0x4002551C))
;#define GPIO_PORTF_LOCK_R       (*((volatile unsigned long *)0x40025520))
;#define GPIO_PORTF_CR_R         (*((volatile unsigned long *)0x40025524))
;#define GPIO_PORTF_AMSEL_R      (*((volatile unsigned long *)0x40025528))
;#define GPIO_PORTF_PCTL_R       (*((volatile unsigned long *)0x4002552C))
;#define GPIO_PORTF_DR2R_R       (*((volatile unsigned long *)0x40025500))
;#define GPIO_PORTF_DR4R_R       (*((volatile unsigned long *)0x40025504))
;#define GPIO_PORTF_DR8R_R       (*((volatile unsigned long *)0x40025508))
;#define GPIO_LOCK_KEY           0x4C4F434B  // Unlocks the GPIO_CR register
;#define SYSCTL_RCGC2_R          (*((volatile unsigned long *)0x400FE108))

SYSCTL_RCGCGPIO_R		EQU		0X400FE608
GPIO_PORTF_DIR_R		EQU		0X40025400
GPIO_PORTF_DEN_R		EQU		0X4002551C
GPIO_PORTF_DATA_R		EQU		0X400253FC


				AREA	|.text|,CODE,READONLY,ALIGN=2
				THUMB
				EXPORT	MAIN

MAIN
		BL		GPIOF_Init

LOOP	
		BL		LIGHT_ON
		B		LOOP

GPIOF_Init								; ACTIVATING THE GPIOF CLOCK THROUGH RCGCGPIO REGISTER INSTEAD OF LEGACY RCGC2 REGISTER
		LDR R1, =SYSCTL_RCGCGPIO_R		; R1 POINTING TO THE SYSTEM CONTROL REGISTER RCGC
		LDR R0, [R1] 					; INDEXED ADDRESSING TO LOAD THE RESET VALUE OF RCGCGPIO INTO R0
		ORR R0, R0, #0x20
		STR R0, [R1]
		
		LDR R1,=GPIO_PORTF_DIR_R		; CONFIGURING PORTF DIRECTION REGISTER
		MOV R0, #0x02
		STR R0, [R1]
		
		LDR R1, =GPIO_PORTF_DEN_R		; CONFIGURING DIRECTION REGISTER
		MOV R0, #0x02
		STR R0, [R1]
		
		; SUBROUTINE COMPLETES
		BX	LR
		
LIGHT_ON
		LDR R1, =GPIO_PORTF_DATA_R
		MOV R0, #0x02
		STR R0, [R1]
		BX 	LR
		
		ALIGN
		END
		
		
		
		
		
;SYSCTL_RCGCGPIO_R		EQU		0X400F.E608		; USING EQU DIRECTIVE FOR SYMBOLIC CONSTANT FOR RCGCGPIO ADDRESS (BASE + OFFSET)
