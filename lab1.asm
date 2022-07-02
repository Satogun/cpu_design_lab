       addi s1,s1,3
       lui s1,0xFFFFF
switled:                          # Test led and switch
	lw   s0,0x70(s1)          # read switch
	
	andi t3,s0,0x000000FF    #取操作数1 且保证是补码
	slli t3,t3,24
	srai t3,t3,24
	
        srli t4,s0,8
        andi t4,t4,0x000000FF    #取操作数2 且保证是补码
        slli t4,t4,24
	srai t4,t4,24
	
        srli t5,s0,21
        andi t5,t5,0x00000007    #取运算指令
        
        #匹配运算指令
	addi x1,x0,1
	beq t5,x1,ADD
	addi x1,x1,1
	beq t5,x1,SUB
	addi x1,x1,1
	beq t5,x1,AND
	addi x1,x1,1
	beq t5,x1,OR
	addi x1,x1,1
	beq t5,x1,SLL
	addi x1,x1,1
	beq t5,x1,SRL
	addi x1,x1,1
	beq t5,x1,MUL
    jal switled

ADD:
        add  x2,t3,t4
        andi x2,x2,0xFF
        jal DISPLAY
SUB:
        sub x2,t3,t4
        andi x2,x2,0xFF
        jal DISPLAY

AND:
       and x2,t3,t4
       andi x2,x2,0xFF
       jal DISPLAY    
       
OR: 
        or x2,t3,t4
        andi x2,x2,0xFF
        jal DISPLAY
SLL:
        sll x2,t3,t4
        andi x2,x2,0xFF
        jal DISPLAY
SRL:
        sra x2,,t3,t4
        andi x2,x2,0xFF
        jal DISPLAY
        
MUL:
                 addi x7,x0,8    #计数  需要计算8次
        not x3,t3
        addi x3,x3,1
        andi x4,t4,0x00000001   #拿出最后一位作为减数，用被减数减减数
        addi a0,x0,0 		#计数
        blt x0,x4,BASE          #第一次特殊对待   小于0则跳入BASE否则保持0
        addi x2,x0,0
 LOOP:
        addi a0,a0,1
        addi x6,x4,0            #获得当前前位，在下一次计算作被减数
        srli t4,t4,1            #右移获取前位作减数
        andi x4,t4,0x00000001
        blt x6,x4,LESS 		#小于则+[-x]补
        bgt x6,x4,GREATER  	#大于则+[x]补
        EQULE:
            beq a0,x7,DISPLAY2
            slli x2,x2,16    #保证补码右移补1
            srai x2,x2,17
            jal LOOP
        BASE:
           add x8,x0,x3
           slli x8,x8,8
           add x2,x0,x8     #x2是最后结果
           slli x2,x2,16    #保证补码右移补1
           srai x2,x2,17
           jal LOOP
        GREATER:  		#大于则+[x]补
           add x8,x0,t3
           slli x8,x8,8
           add x2,x2,x8
           beq a0,x7,DISPLAY2         #最后一次不移位
           slli x2,x2,16
           srai x2,x2,17
           jal LOOP
        LESS:  		#小于则+[-x]补
           add x8,x0,x3
           slli x8,x8,8
           add x2,x2,x8
           beq a0,x7,DISPLAY2        #最后一次不移位
           slli x2,x2,16
           srai x2,x2,17
           jal LOOP
     
           
DISPLAY:        
        sw   x2,0x60(s1)          # write led
        sw   x2,0x00(s1)	
        jal switled
DISPLAY2:
        addi s10,x2,0           #取后十六位
        andi x2,x2,0x000000FF
        srli s10,s10,8
        andi s10,s10,0x000000FF
        slli s10,s10,8
        add s10,s10,x2   
        sw   s10,0x60(s1)          # write led
        sw   s10,0x00(s1)	
        j switled
