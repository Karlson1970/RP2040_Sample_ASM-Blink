.section .text
.global main

.equ    IO_BANK0_BASE,      0x40014000
.equ    GPIO0_CTRL,         0x04
.equ    SIO_BASE,           0xd0000000
.equ    GPIO_OUT_SET_REG,   0x14
.equ    GPIO_OUT_CLR_REG,   0x18
.equ    GPIO_OE_REG,        0x20
.equ    DELAY_NUM,          0x01000000

main:
    // Инициализация GPIO 0
    ldr r0, =IO_BANK0_BASE          // Базовый адрес
    mov r1, #5                      // Режим SIO
    str r1, [r0, #GPIO0_CTRL]       // Включим режим SIO для GPIO0
 
    ldr r0, =SIO_BASE               // базовый адрес SIO
    mov r1, #1                      // GPIO0 
//  lsl r1, r1, #25                 // Для настройки лубого другого порта на выход можно использовать эту команду, где 25 номер GPIO     
    str r1, [r0, #GPIO_OE_REG]      // Настроим GPIO0 как выход
                                    // биты 0-29 соответствуют портам GPIO0-29 установка каждого бита устанавливает соответствующий GPIO как выход    
led_loop:
    str r1, [r0, #GPIO_OUT_SET_REG] // GPIO0 HIGH Level
    bl  delay                       // вызовем функцию задержки

    str r1,[r0, #GPIO_OUT_CLR_REG]  // GPIO0 LOW Level
    bl  delay                       // вызовем функцию задержки
    b   led_loop

delay:
    ldr r3, =DELAY_NUM              // количество отсчетов для функции delay
delay_loop:
    sub r3, #1
    bne delay_loop
    bx  lr
