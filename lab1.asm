       addi s1,s1,3
       lui s1,0xFFFFF
switled:                          # Test led and switch
	lw   s0,0x70(s1)          # read switch
	
	andi t3,s0,0x000000FF    #ȡ������1 �ұ�֤�ǲ���
	slli t3,t3,24
	srai t3,t3,24
	
        srli t4,s0,8
        andi t4,t4,0x000000FF    #ȡ������2 �ұ�֤�ǲ���
        slli t4,t4,24
	srai t4,t4,24
	
        srli t5,s0,21
        andi t5,t5,0x00000007    #ȡ����ָ��
        
        #ƥ������ָ��
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
                 addi x7,x0,8    #����  ��Ҫ����8��
        not x3,t3
        addi x3,x3,1
        andi x4,t4,0x00000001   #�ó����һλ��Ϊ�������ñ�����������
        addi a0,x0,0 		#����
        blt x0,x4,BASE          #��һ������Դ�   С��0������BASE���򱣳�0
        addi x2,x0,0
 LOOP:
        addi a0,a0,1
        addi x6,x4,0            #��õ�ǰǰλ������һ�μ�����������
        srli t4,t4,1            #���ƻ�ȡǰλ������
        andi x4,t4,0x00000001
        blt x6,x4,LESS 		#С����+[-x]��
        bgt x6,x4,GREATER  	#������+[x]��
        EQULE:
            beq a0,x7,DISPLAY2
            slli x2,x2,16    #��֤�������Ʋ�1
            srai x2,x2,17
            jal LOOP
        BASE:
           add x8,x0,x3
           slli x8,x8,8
           add x2,x0,x8     #x2�������
           slli x2,x2,16    #��֤�������Ʋ�1
           srai x2,x2,17
           jal LOOP
        GREATER:  		#������+[x]��
           add x8,x0,t3
           slli x8,x8,8
           add x2,x2,x8
           beq a0,x7,DISPLAY2         #���һ�β���λ
           slli x2,x2,16
           srai x2,x2,17
           jal LOOP
        LESS:  		#С����+[-x]��
           add x8,x0,x3
           slli x8,x8,8
           add x2,x2,x8
           beq a0,x7,DISPLAY2        #���һ�β���λ
           slli x2,x2,16
           srai x2,x2,17
           jal LOOP
     
           
DISPLAY:        
        sw   x2,0x60(s1)          # write led
        sw   x2,0x00(s1)	
        jal switled
DISPLAY2:
        addi s10,x2,0           #ȡ��ʮ��λ
        andi x2,x2,0x000000FF
        srli s10,s10,8
        andi s10,s10,0x000000FF
        slli s10,s10,8
        add s10,s10,x2   
        sw   s10,0x60(s1)          # write led
        sw   s10,0x00(s1)	
        j switled
