include 'emu8086.inc'
JMP START

DATA SEGMENT 
    TOTAL          DW 20
    IDS1           DW 0000H,0001H,0002H,0003H,0004H,0005H,0006H,0007H,0008H,0009H
    IDS2           DW 000AH,000BH,000CH,000DH,000EH,000FH,0010H,0011H,0012H,0013H 
    PASSWORDS1     DB   00H,  01H,  02H,  03H,  04H,  05H,  06H,  07H,  08H,  09H
    PASSWORDS2     DB   0AH,  0BH,  0CH,  0DH,  0EH,  0FH,  01H,  02H,  03H,  04H
    DATA1          DB 0DH,0AH,'WELCOME TO ATM MACHINE SYSTEM',0
    DATA2          DB 0DH,0AH,'ENTER YOUR ID: ',0
    DATA3          DB 0DH,0AH,'ENTER YOUR PASSWORD: ',0 
    DATA4          DB 0DH,0AH,'     DENIED  ',0  
    DATA5          DB 0DH,0AH,'     ALLOWED ',0 
    DATA6          DB 0DH,0AH,'   WELCOME BACK     ',0
    DATA7          DB 0DH,0AH,'DO YOU WANT TO: ',0
    DATA8          DB '1. DEPOSIT MONEY', 0
    DATA9          DB '2. WITHDRAW MONEY', 0
    DATA10         DB '3. TRANSFER FUNDS', 0
    DATA11         DB 0DH,0AH,'ENTER YOUR CHOICE: ',0
    DATA12         DB 0DH,0AH,'ENTER AMOUNT: $', 0
    DATA13         DB 0DH,0AH,'REMAINING BALANCE: $', 0
    DATA14         DB 0DH,0AH,'DENIED ACCESS DUE TO MULTIPLE WRONG PASSWORD/USER ATTEMPTS.', 0
    DATA15         DB '7. LEAVE ', 0
    DATA16         DB 0DH,0AH,'ACCOUNT NUMBER:  ', 0
    DATA17         DB 0DH,0AH,'INSUFFICIENT FUNDS FOR TRANSFER.  ', 0
    DATA18         DB 0DH,0AH,'WRONG PASSWORD TRY AGAIN! ',0
    DATA19         DB '4. BALANCE ENQUIRY ', 0
    DATA20         DB 0DH,0AH,'YOUR CURRENT BALANCE IS: $', 0
    DATA21         DB 0DH,0AH,'USER NAME DOES NOT EXIST!', 0
    DATA22         DB 0DH,0AH,'1. LOGIN', 0
    DATA23         DB 0DH,0AH,'2. SIGNUP', 0
    DATA24         DB 0DH,0AH,'WOULD YOU LIKE TO: ', 0
    DATA25         DB 0DH,0AH,'USER FOR SINGUP: ',0
    DATA26         DB 0DH,0AH,'ENTER YOUR PASSWORD: ',0 
    DATA27         DB '5. ABOUT US', 0 
    DATA28         DB '6. REFRENCES OF PROJECT', 0
    DATA29         DB 0DH,0AH,'MUSHARIB ',0DH,0AH,' AWAIS ',0DH,0AH,' RIZWAN ',0DH,0AH,' ABDULLAH ',0DH,0AH,' HUZAIFA ',0DH,0AH,' UMAIR ',0
    DATA30         DB 0DH,0AH,'https://github.com',0DH,0AH, 'https://stackoverflow.com/',0
    DATA31         DB 0DH,0AH,'    GOOD BYE !    ',0
    DATA32         DB 0DH,0AH,'     WELCOME     ',0
    DATA33         DB 0DH,0AH,'      LOGIN     ',0
    DATA34         DB 0DH,0AH,'YOU DONT HAVE ENOUGH BALANCE',0
    ACCOUNT_BALANCE DW 1000  ; Initial account balanc
    IDINPUT        DW 1 DUP (?)
    PASSINPUT      DB 1 DUP (?)
    TRIES_LEFT     DB 3   ; Number of password attempts allowed
DATA ENDS

CODE SEGMENT

START:
    MOV  AX,@DATA
    MOV  DS,AX  

    ; User registration or login section
    LEA  SI,DATA1
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA24
    CALL PRINT_STRING
    LEA  SI,DATA22
    CALL PRINT_STRING
    LEA  SI,DATA23
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA11
    CALL PRINT_STRING
    CALL SCAN_NUM
    CMP  CX, 1
    JE   LOGIN
    CMP  CX, 2
    JE   SIGNUP
    JMP  START
 

AGAIN:
    LEA  SI,DATA33
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA2
    CALL PRINT_STRING
    MOV  SI,-1

    CALL SCAN_NUM
    MOV  IDINPUT,CX
    MOV  AX,CX
    MOV  CX,0 
L1:   
    INC  CX
    CMP  CX,TOTAL
    JE   ERROR
    INC  SI
    MOV  DX,SI
    CMP  IDS1[SI],AX
    JE   PASS1
    CMP  IDS2[SI],AX
    JE   PASS2
    JMP  L1


    
SIGNUP:
    ; Perform user signup logic
    LEA  SI,DATA32
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA25
    CALL PRINT_STRING
    CALL SCAN_NUM
    MOV  IDINPUT, CX ; Store the entered account number
    LEA  SI,DATA26
    CALL PRINT_STRING
    CALL SCAN_NUM
    MOV  PASSINPUT, CL ; Store the entered password

MENU: 
    ; Display menu options
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA6
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA7
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA8
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH 
    LEA  SI,DATA9
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA10
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA15
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA19
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA27
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA28
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH

    
      
    ; Get user choice
    LEA  SI,DATA11
    CALL PRINT_STRING
    CALL SCAN_NUM
    CMP  CX, 1
    JE   ADD_MONEY
    CMP  CX, 2
    JE   WITHDRAW_MONEY
    CMP  CX, 3
    JE   TRANSFER_MONEY
    CMP  CX, 4
    JE   CHECK_BALANCE
    CMP  CX, 5
    JE   ABOUT_US
    CMP  CX, 6
    JE   REFRENCES
    CMP  CX, 7
    JE   EXIT_PROGRAM
    JMP  MENU
      
TRANSFER_MONEY:
    LEA  SI,DATA16
    CALL PRINT_STRING
    CALL SCAN_NUM
    MOV  AX, CX  ; Transfer account number

    ; Perform the transfer logic, you may need to implement this logic based on your requirements

    LEA  SI,DATA12
    CALL PRINT_STRING
    CALL SCAN_NUM 
    CMP CX, ACCOUNT_BALANCE
    JG TRANSFER_ERROR
    
    SUB  ACCOUNT_BALANCE, CX  ; Assuming the entered amount is subtracted from the current account balance

    LEA  SI,DATA13
    CALL PRINT_STRING
    MOV  AX, ACCOUNT_BALANCE
    CALL PRINT_NUM_UNS
    PRINT 0AH
    PRINT 0DH

    JMP  MENU

ADD_MONEY:
    LEA  SI,DATA12
    CALL PRINT_STRING
    CALL SCAN_NUM
    ADD  ACCOUNT_BALANCE, CX
    JMP  SHOW_REMAINING_BALANCE

WITHDRAW_MONEY:
    LEA  SI,DATA12
    CALL PRINT_STRING
    CALL SCAN_NUM
    CMP  CX, ACCOUNT_BALANCE
    JG   WITHDRAW_ERROR
    SUB  ACCOUNT_BALANCE, CX
    JMP  SHOW_REMAINING_BALANCE

TRANSFER_ERROR:
    LEA  SI,DATA17
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    JMP  DENIED_MESSAGE

WITHDRAW_ERROR:
    LEA  SI,DATA34
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    JMP  DENIED_MESSAGE

CHECK_BALANCE:
    ; Display remaining balance
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA20
    CALL PRINT_STRING
    MOV  AX, ACCOUNT_BALANCE
    CALL PRINT_NUM_UNS
    PRINT 0AH
    PRINT 0DH
    JMP  MENU

SHOW_REMAINING_BALANCE:
    ; Display remaining balance
    LEA  SI,DATA13
    CALL PRINT_STRING
    MOV  AX, ACCOUNT_BALANCE
    CALL PRINT_NUM_UNS
    PRINT 0AH
    PRINT 0DH
    JMP  MENU
    
LOGIN:
    JMP AGAIN    

PASS1:
    LEA  SI,DATA3
    CALL PRINT_STRING        
    CALL SCAN_NUM
    MOV  PASSINPUT,CL
    MOV  AX,DX 
    MOV  DX,0002H
    DIV  DL 
    MOV  SI,AX 
    MOV  AL,CL
    MOV  AH,00H
    CMP  PASSWORDS1[SI],AL
    JNE  PASS2_TRY
    JMP  ALLOWED_MESSAGE

PASS2:
    LEA  SI,DATA3
    CALL PRINT_STRING        
    CALL SCAN_NUM
    MOV  PASSINPUT,CL
    MOV  AX,DX 
    MOV  DX,0002H
    DIV  DL 
    MOV  SI,AX 
    MOV  AL,CL
    MOV  AH,00H
    CMP  PASSWORDS2[SI],AL
    JNE  PASS2_TRY
    JMP  ALLOWED_MESSAGE

PASS2_TRY:
    ; Display a message to try again
    DEC TRIES_LEFT
    CMP TRIES_LEFT, 0
    JZ  DENY_ACCESS
    LEA SI, DATA18
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    MOV SI, 0
    JMP AGAIN

DENY_ACCESS:
    ; Display a message and exit or take appropriate action
    LEA SI, DATA14
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    JMP EXIT_PROGRAM

ERROR:
    LEA  SI,DATA21
    CALL PRINT_STRING 
    PRINT 0AH      
    PRINT 0DH
    MOV  SI,0
    JMP  AGAIN

ALLOWED_MESSAGE:
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA5
    CALL PRINT_STRING
    JMP  MENU
    
ABOUT_US:
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA29
    CALL PRINT_STRING
    JMP  MENU 
    
REFRENCES:
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA30
    CALL PRINT_STRING
    JMP  MENU

DENIED_MESSAGE:
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA4
    CALL PRINT_STRING
    PRINT 0AH      
    PRINT 0DH
    JMP  MENU


EXIT_PROGRAM:
    ; Add any additional cleanup or exit logic
    PRINT 0AH      
    PRINT 0DH
    LEA  SI,DATA31
    CALL PRINT_STRING

DEFINE_SCAN_NUM           
DEFINE_PRINT_STRING 
DEFINE_PRINT_NUM_UNS

CODE ENDS

END START
