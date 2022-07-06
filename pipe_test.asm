     lui t6 0xFFFFF
     addi s2,x0,1
     addi s3,x0,2
     addi s4,x0,3
     addi s5,x0,4
     addi s6,x0,5
     addi s7,x0,6
     addi s8,x0,7
     addi s9,x0,-4
     addi s10,x0,-1
     addi s11,x0,16
     add a0,s2,s3  #3
     sub s1,s4,s2  #2
     and a6,s4,s2  #1
     or  a1,s5,s3  #6
     xor a2,s6,s3  #7
     sll a3,s5,s3  #16
     srl a4,s7,s2, #3
     sra a5,s9,s3 #-1
     bne a0,s4,FAIL
     bne s1,s3,FAIL
     bne a6,s2,FAIL
     bne a1,s7,FAIL
     bne a2,s8,FAIL 
     bne a3,s11,FAIL
     bne a4,s4,FAIL
     bne a5,s10,FAIL
     andi s3,s3,5 #0
     ori  s4,s4,4 #7
     xori s5,s5,2 #7
     slli s10,s10,2 #-4
     srli s6,s6,1 #2
     srai s9,s9,2 #-1
     bne  s3,x0,FAIL
     bne  s4,s8,FAIL
     bge s5,s4,FAIL
     beq s10,s4,FAIL
     blt s6,s10,FAIL
     bne s9,a5,FAIL
     addi s1,s1,0
     addi s2,s2,0
     addi s3,s3,0
     sw s2,0x60(t6)
FAIL:
     
     
     
     
