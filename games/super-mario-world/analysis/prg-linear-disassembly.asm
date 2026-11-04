; نكهة الملف: Super Mario Bros. (World).nes
; حجم PRG ROM: 32768 بايت
; نطاق التفكيك: $8000 - $FFFF
;============================================================

$8000: 78       SEI  
$8001: D8       CLD  
$8002: A9 10    LDA  #$10
$8004: 8D 00 20 STA  $2000
$8007: A2 FF    LDX  #$FF
$8009: 9A       TXS  
$800A: AD 02 20 LDA  $2002
$800D: 10 FB    BPL  $800A
$800F: AD 02 20 LDA  $2002
$8012: 10 FB    BPL  $800F
$8014: A0 FE    LDY  #$FE
$8016: A2 05    LDX  #$05
$8018: BD D7 07 LDA  $07D7,X
$801B: C9          .byte $C9  ; غير معرّف
$801C: 0A       ASL  A
$801D: B0 0C    BCS  $802B
$801F: CA       DEX  
$8020: 10 F6    BPL  $8018
$8022: AD FF 07 LDA  $07FF
$8025: C9          .byte $C9  ; غير معرّف
$8026: A5 D0    LDA  $D0
$8028: 02          .byte $02  ; غير معرّف
$8029: A0 D6    LDY  #$D6
$802B: 20 CC 90 JSR  $90CC
$802E: 8D 11 40 STA  $4011
$8031: 8D 70 07 STA  $0770
$8034: A9 A5    LDA  #$A5
$8036: 8D FF 07 STA  $07FF
$8039: 8D A7 07 STA  $07A7
$803C: A9 0F    LDA  #$0F
$803E: 8D 15 40 STA  $4015
$8041: A9 06    LDA  #$06
$8043: 8D 01 20 STA  $2001
$8046: 20 20 82 JSR  $8220
$8049: 20 19 8E JSR  $8E19
$804C: EE 74 07 INC  $0774
$804F: AD 78 07 LDA  $0778
$8052: 09 80    ORA  #$80
$8054: 20 ED 8E JSR  $8EED
$8057: 4C 57 80 JMP  $8057
$805A: 01 A4    ORA  ($A4,X)
$805C: C8       INY  
$805D: EC 10 00 CPX  $0010
$8060: 41 41    EOR  ($41,X)
$8062: 4C 34 3C JMP  $3C34
$8065: 44          .byte $44  ; غير معرّف
$8066: 54          .byte $54  ; غير معرّف
$8067: 68       PLA  
$8068: 7C          .byte $7C  ; غير معرّف
$8069: A8       TAY  
$806A: BF          .byte $BF  ; غير معرّف
$806B: DE EF 03 DEC  $03EF,X
$806E: 8C 8C 8C STY  $8C8C
$8071: 8D 03 03 STA  $0303
$8074: 03          .byte $03  ; غير معرّف
$8075: 8D 8D 8D STA  $8D8D
$8078: 8D 8D 8D STA  $8D8D
$807B: 8D 8D 8D STA  $8D8D
$807E: 8D 8D 00 STA  $008D
$8081: 40       RTI  
$8082: AD 78 07 LDA  $0778
$8085: 29 7F    AND  #$7F
$8087: 8D 78 07 STA  $0778
$808A: 29 7E    AND  #$7E
$808C: 8D 00 20 STA  $2000
$808F: AD 79 07 LDA  $0779
$8092: 29 E6    AND  #$E6
$8094: AC 74 07 LDY  $0774
$8097: D0 05    BNE  $809E
$8099: AD 79 07 LDA  $0779
$809C: 09 1E    ORA  #$1E
$809E: 8D 79 07 STA  $0779
$80A1: 29 E7    AND  #$E7
$80A3: 8D 01 20 STA  $2001
$80A6: AE 02 20 LDX  $2002
$80A9: A9 00    LDA  #$00
$80AB: 20 E6 8E JSR  $8EE6
$80AE: 8D 03 20 STA  $2003
$80B1: A9 02    LDA  #$02
$80B3: 8D 14 40 STA  $4014
$80B6: AE 73 07 LDX  $0773
$80B9: BD 5A 80 LDA  $805A,X
$80BC: 85 00    STA  $00
$80BE: BD 6D 80 LDA  $806D,X
$80C1: 85 01    STA  $01
$80C3: 20 DD 8E JSR  $8EDD
$80C6: A0 00    LDY  #$00
$80C8: AE 73 07 LDX  $0773
$80CB: E0 06    CPX  #$06
$80CD: D0 01    BNE  $80D0
$80CF: C8       INY  
$80D0: BE 80 80 LDX  $8080,Y
$80D3: A9 00    LDA  #$00
$80D5: 9D 00 03 STA  $0300,X
$80D8: 9D 01 03 STA  $0301,X
$80DB: 8D 73 07 STA  $0773
$80DE: AD 79 07 LDA  $0779
$80E1: 8D 01 20 STA  $2001
$80E4: 20 D0 F2 JSR  $F2D0
$80E7: 20 5C 8E JSR  $8E5C
$80EA: 20 82 81 JSR  $8182
$80ED: 20 97 8F JSR  $8F97
$80F0: AD 76 07 LDA  $0776
$80F3: 4A       LSR  A
$80F4: B0 25    BCS  $811B
$80F6: AD 47 07 LDA  $0747
$80F9: F0 05    BEQ  $8100
$80FB: CE 47 07 DEC  $0747
$80FE: D0 19    BNE  $8119
$8100: A2 14    LDX  #$14
$8102: CE 7F 07 DEC  $077F
$8105: 10 07    BPL  $810E
$8107: A9 14    LDA  #$14
$8109: 8D 7F 07 STA  $077F
$810C: A2 23    LDX  #$23
$810E: BD 80 07 LDA  $0780,X
$8111: F0 03    BEQ  $8116
$8113: DE 80 07 DEC  $0780,X
$8116: CA       DEX  
$8117: 10 F5    BPL  $810E
$8119: E6 09    INC  $09
$811B: A2 00    LDX  #$00
$811D: A0 07    LDY  #$07
$811F: AD A7 07 LDA  $07A7
$8122: 29 02    AND  #$02
$8124: 85 00    STA  $00
$8126: AD A8 07 LDA  $07A8
$8129: 29 02    AND  #$02
$812B: 45 00    EOR  $00
$812D: 18       CLC  
$812E: F0 01    BEQ  $8131
$8130: 38       SEC  
$8131: 7E A7 07 ROR  $07A7,X
$8134: E8       INX  
$8135: 88       DEY  
$8136: D0 F9    BNE  $8131
$8138: AD 22 07 LDA  $0722
$813B: F0 1F    BEQ  $815C
$813D: AD 02 20 LDA  $2002
$8140: 29 40    AND  #$40
$8142: D0 F9    BNE  $813D
$8144: AD 76 07 LDA  $0776
$8147: 4A       LSR  A
$8148: B0 06    BCS  $8150
$814A: 20 23 82 JSR  $8223
$814D: 20 C6 81 JSR  $81C6
$8150: AD 02 20 LDA  $2002
$8153: 29 40    AND  #$40
$8155: F0 F9    BEQ  $8150
$8157: A0 14    LDY  #$14
$8159: 88       DEY  
$815A: D0 FD    BNE  $8159
$815C: AD 3F 07 LDA  $073F
$815F: 8D 05 20 STA  $2005
$8162: AD 40 07 LDA  $0740
$8165: 8D 05 20 STA  $2005
$8168: AD 78 07 LDA  $0778
$816B: 48       PHA  
$816C: 8D 00 20 STA  $2000
$816F: AD 76 07 LDA  $0776
$8172: 4A       LSR  A
$8173: B0 03    BCS  $8178
$8175: 20 12 82 JSR  $8212
$8178: AD 02 20 LDA  $2002
$817B: 68       PLA  
$817C: 09 80    ORA  #$80
$817E: 8D 00 20 STA  $2000
$8181: 40       RTI  
$8182: AD 70 07 LDA  $0770
$8185: C9          .byte $C9  ; غير معرّف
$8186: 02          .byte $02  ; غير معرّف
$8187: F0 0B    BEQ  $8194
$8189: C9          .byte $C9  ; غير معرّف
$818A: 01 D0    ORA  ($D0,X)
$818C: 38       SEC  
$818D: AD 72 07 LDA  $0772
$8190: C9          .byte $C9  ; غير معرّف
$8191: 03          .byte $03  ; غير معرّف
$8192: D0 31    BNE  $81C5
$8194: AD 77 07 LDA  $0777
$8197: F0 04    BEQ  $819D
$8199: CE 77 07 DEC  $0777
$819C: 60       RTS  
$819D: AD FC 06 LDA  $06FC
$81A0: 29 10    AND  #$10
$81A2: F0 19    BEQ  $81BD
$81A4: AD 76 07 LDA  $0776
$81A7: 29 80    AND  #$80
$81A9: D0 1A    BNE  $81C5
$81AB: A9 2B    LDA  #$2B
$81AD: 8D 77 07 STA  $0777
$81B0: AD 76 07 LDA  $0776
$81B3: A8       TAY  
$81B4: C8       INY  
$81B5: 84 FA    STY  $FA
$81B7: 49 01    EOR  #$01
$81B9: 09 80    ORA  #$80
$81BB: D0 05    BNE  $81C2
$81BD: AD 76 07 LDA  $0776
$81C0: 29 7F    AND  #$7F
$81C2: 8D 76 07 STA  $0776
$81C5: 60       RTS  
$81C6: AC 4E 07 LDY  $074E
$81C9: A9 28    LDA  #$28
$81CB: 85 00    STA  $00
$81CD: A2 0E    LDX  #$0E
$81CF: BD E4 06 LDA  $06E4,X
$81D2: C5 00    CMP  $00
$81D4: 90 0F    BCC  $81E5
$81D6: AC E0 06 LDY  $06E0
$81D9: 18       CLC  
$81DA: 79 E1 06 ADC  $06E1,Y
$81DD: 90 03    BCC  $81E2
$81DF: 18       CLC  
$81E0: 65 00    ADC  $00
$81E2: 9D E4 06 STA  $06E4,X
$81E5: CA       DEX  
$81E6: 10 E7    BPL  $81CF
$81E8: AE E0 06 LDX  $06E0
$81EB: E8       INX  
$81EC: E0 03    CPX  #$03
$81EE: D0 02    BNE  $81F2
$81F0: A2 00    LDX  #$00
$81F2: 8E E0 06 STX  $06E0
$81F5: A2 08    LDX  #$08
$81F7: A0 02    LDY  #$02
$81F9: B9 E9 06 LDA  $06E9,Y
$81FC: 9D F1 06 STA  $06F1,X
$81FF: 18       CLC  
$8200: 69 08    ADC  #$08
$8202: 9D F2 06 STA  $06F2,X
$8205: 18       CLC  
$8206: 69 08    ADC  #$08
$8208: 9D F3 06 STA  $06F3,X
$820B: CA       DEX  
$820C: CA       DEX  
$820D: CA       DEX  
$820E: 88       DEY  
$820F: 10 E8    BPL  $81F9
$8211: 60       RTS  
$8212: AD 70 07 LDA  $0770
$8215: 20 04 8E JSR  $8E04
$8218: 31 82    AND  ($82),Y
$821A: DC          .byte $DC  ; غير معرّف
$821B: AE 8B 83 LDX  $838B
$821E: 18       CLC  
$821F: 92          .byte $92  ; غير معرّف
$8220: A0 00    LDY  #$00
$8222: 2C A0 04 BIT  $04A0
$8225: A9 F8    LDA  #$F8
$8227: 99 00 02 STA  $0200,Y
$822A: C8       INY  
$822B: C8       INY  
$822C: C8       INY  
$822D: C8       INY  
$822E: D0 F7    BNE  $8227
$8230: 60       RTS  
$8231: AD 72 07 LDA  $0772
$8234: 20 04 8E JSR  $8E04
$8237: CF          .byte $CF  ; غير معرّف
$8238: 8F          .byte $8F  ; غير معرّف
$8239: 67          .byte $67  ; غير معرّف
$823A: 85 61    STA  $61
$823C: 90 45    BCC  $8283
$823E: 82          .byte $82  ; غير معرّف
$823F: 04          .byte $04  ; غير معرّف
$8240: 20 73 01 JSR  $0173
$8243: 00       BRK  
$8244: 00       BRK  
$8245: A0 00    LDY  #$00
$8247: AD FC 06 LDA  $06FC
$824A: 0D FD 06 ORA  $06FD
$824D: C9          .byte $C9  ; غير معرّف
$824E: 10 F0    BPL  $8240
$8250: 04          .byte $04  ; غير معرّف
$8251: C9          .byte $C9  ; غير معرّف
$8252: 90 D0    BCC  $8224
$8254: 03          .byte $03  ; غير معرّف
$8255: 4C D8 82 JMP  $82D8
$8258: C9          .byte $C9  ; غير معرّف
$8259: 20 F0 1A JSR  $1AF0
$825C: AE A2 07 LDX  $07A2
$825F: D0 0B    BNE  $826C
$8261: 8D 80 07 STA  $0780
$8264: 20 6B 83 JSR  $836B
$8267: B0 60    BCS  $82C9
$8269: 4C C0 82 JMP  $82C0
$826C: AE FC 07 LDX  $07FC
$826F: F0 4A    BEQ  $82BB
$8271: C9          .byte $C9  ; غير معرّف
$8272: 40       RTI  
$8273: D0 46    BNE  $82BB
$8275: C8       INY  
$8276: AD A2 07 LDA  $07A2
$8279: F0 4E    BEQ  $82C9
$827B: A9 18    LDA  #$18
$827D: 8D A2 07 STA  $07A2
$8280: AD 80 07 LDA  $0780
$8283: D0 36    BNE  $82BB
$8285: A9 10    LDA  #$10
$8287: 8D 80 07 STA  $0780
$828A: C0 01    CPY  #$01
$828C: F0 0E    BEQ  $829C
$828E: AD 7A 07 LDA  $077A
$8291: 49 01    EOR  #$01
$8293: 8D 7A 07 STA  $077A
$8296: 20 25 83 JSR  $8325
$8299: 4C BB 82 JMP  $82BB
$829C: AE 6B 07 LDX  $076B
$829F: E8       INX  
$82A0: 8A       TXA  
$82A1: 29 07    AND  #$07
$82A3: 8D 6B 07 STA  $076B
$82A6: 20 0E 83 JSR  $830E
$82A9: BD 3F 82 LDA  $823F,X
$82AC: 9D 00 03 STA  $0300,X
$82AF: E8       INX  
$82B0: E0 06    CPX  #$06
$82B2: 30 F5    BMI  $82A9
$82B4: AC 5F 07 LDY  $075F
$82B7: C8       INY  
$82B8: 8C 04 03 STY  $0304
$82BB: A9 00    LDA  #$00
$82BD: 8D FC 06 STA  $06FC
$82C0: 20 EA AE JSR  $AEEA
$82C3: A5 0E    LDA  $0E
$82C5: C9          .byte $C9  ; غير معرّف
$82C6: 06 D0    ASL  $D0
$82C8: 44          .byte $44  ; غير معرّف
$82C9: A9 00    LDA  #$00
$82CB: 8D 70 07 STA  $0770
$82CE: 8D 72 07 STA  $0772
$82D1: 8D 22 07 STA  $0722
$82D4: EE 74 07 INC  $0774
$82D7: 60       RTS  
$82D8: AC A2 07 LDY  $07A2
$82DB: F0 EC    BEQ  $82C9
$82DD: 0A       ASL  A
$82DE: 90 06    BCC  $82E6
$82E0: AD FD 07 LDA  $07FD
$82E3: 20 0E 83 JSR  $830E
$82E6: 20 03 9C JSR  $9C03
$82E9: EE 5D 07 INC  $075D
$82EC: EE 64 07 INC  $0764
$82EF: EE 57 07 INC  $0757
$82F2: EE 70 07 INC  $0770
$82F5: AD FC 07 LDA  $07FC
$82F8: 8D 6A 07 STA  $076A
$82FB: A9 00    LDA  #$00
$82FD: 8D 72 07 STA  $0772
$8300: 8D A2 07 STA  $07A2
$8303: A2 17    LDX  #$17
$8305: A9 00    LDA  #$00
$8307: 9D DD 07 STA  $07DD,X
$830A: CA       DEX  
$830B: 10 FA    BPL  $8307
$830D: 60       RTS  
$830E: 8D 5F 07 STA  $075F
$8311: 8D 66 07 STA  $0766
$8314: A2 00    LDX  #$00
$8316: 8E 60 07 STX  $0760
$8319: 8E 67 07 STX  $0767
$831C: 60       RTS  
$831D: 07          .byte $07  ; غير معرّف
$831E: 22          .byte $22  ; غير معرّف
$831F: 49 83    EOR  #$83
$8321: CE 24 24 DEC  $2424
$8324: 00       BRK  
$8325: A0 07    LDY  #$07
$8327: B9 1D 83 LDA  $831D,Y
$832A: 99 00 03 STA  $0300,Y
$832D: 88       DEY  
$832E: 10 F7    BPL  $8327
$8330: AD 7A 07 LDA  $077A
$8333: F0 0A    BEQ  $833F
$8335: A9 24    LDA  #$24
$8337: 8D 04 03 STA  $0304
$833A: A9 CE    LDA  #$CE
$833C: 8D 06 03 STA  $0306
$833F: 60       RTS  
$8340: 01 80    ORA  ($80,X)
$8342: 02          .byte $02  ; غير معرّف
$8343: 81 41    STA  ($41,X)
$8345: 80          .byte $80  ; غير معرّف
$8346: 01 42    ORA  ($42,X)
$8348: C2          .byte $C2  ; غير معرّف
$8349: 02          .byte $02  ; غير معرّف
$834A: 80          .byte $80  ; غير معرّف
$834B: 41 C1    EOR  ($C1,X)
$834D: 41 C1    EOR  ($C1,X)
$834F: 01 C1    ORA  ($C1,X)
$8351: 01 02    ORA  ($02,X)
$8353: 80          .byte $80  ; غير معرّف
$8354: 00       BRK  
$8355: 9B          .byte $9B  ; غير معرّف
$8356: 10 18    BPL  $8370
$8358: 05 2C    ORA  $2C
$835A: 20 24 15 JSR  $1524
$835D: 5A          .byte $5A  ; غير معرّف
$835E: 10 20    BPL  $8380
$8360: 28       PLP  
$8361: 30 20    BMI  $8383
$8363: 10 80    BPL  $82E5
$8365: 20 30 30 JSR  $3030
$8368: 01 FF    ORA  ($FF,X)
$836A: 00       BRK  
$836B: AE 17 07 LDX  $0717
$836E: AD 18 07 LDA  $0718
$8371: D0 0D    BNE  $8380
$8373: E8       INX  
$8374: EE 17 07 INC  $0717
$8377: 38       SEC  
$8378: BD 54 83 LDA  $8354,X
$837B: 8D 18 07 STA  $0718
$837E: F0 0A    BEQ  $838A
$8380: BD 3F 83 LDA  $833F,X
$8383: 8D FC 06 STA  $06FC
$8386: CE 18 07 DEC  $0718
$8389: 18       CLC  
$838A: 60       RTS  
$838B: 20 A0 83 JSR  $83A0
$838E: AD 72 07 LDA  $0772
$8391: F0 07    BEQ  $839A
$8393: A2 00    LDX  #$00
$8395: 86 08    STX  $08
$8397: 20 47 C0 JSR  $C047
$839A: 20 2A F1 JSR  $F12A
$839D: 4C E9 EE JMP  $EEE9
$83A0: AD 72 07 LDA  $0772
$83A3: 20 04 8E JSR  $8E04
$83A6: EC CF B0 CPX  $B0CF
$83A9: 83          .byte $83  ; غير معرّف
$83AA: BD 83 F6 LDA  $F683,X
$83AD: 83          .byte $83  ; غير معرّف
$83AE: 61 84    ADC  ($84,X)
$83B0: AE 1B 07 LDX  $071B
$83B3: E8       INX  
$83B4: 86 34    STX  $34
$83B6: A9 08    LDA  #$08
$83B8: 85 FC    STA  $FC
$83BA: 4C 4E 87 JMP  $874E
$83BD: A0 00    LDY  #$00
$83BF: 84 35    STY  $35
$83C1: A5 6D    LDA  $6D
$83C3: C5 34    CMP  $34
$83C5: D0 06    BNE  $83CD
$83C7: A5 86    LDA  $86
$83C9: C9          .byte $C9  ; غير معرّف
$83CA: 60       RTS  
$83CB: B0 03    BCS  $83D0
$83CD: E6 35    INC  $35
$83CF: C8       INY  
$83D0: 98       TYA  
$83D1: 20 E6 B0 JSR  $B0E6
$83D4: AD 1A 07 LDA  $071A
$83D7: C5 34    CMP  $34
$83D9: F0 16    BEQ  $83F1
$83DB: AD 68 07 LDA  $0768
$83DE: 18       CLC  
$83DF: 69 80    ADC  #$80
$83E1: 8D 68 07 STA  $0768
$83E4: A9 01    LDA  #$01
$83E6: 69 00    ADC  #$00
$83E8: A8       TAY  
$83E9: 20 C4 AF JSR  $AFC4
$83EC: 20 6F AF JSR  $AF6F
$83EF: E6 35    INC  $35
$83F1: A5 35    LDA  $35
$83F3: F0 68    BEQ  $845D
$83F5: 60       RTS  
$83F6: AD 49 07 LDA  $0749
$83F9: D0 48    BNE  $8443
$83FB: AD 19 07 LDA  $0719
$83FE: F0 18    BEQ  $8418
$8400: C9          .byte $C9  ; غير معرّف
$8401: 09 B0    ORA  #$B0
$8403: 3F          .byte $3F  ; غير معرّف
$8404: AC 5F 07 LDY  $075F
$8407: C0 07    CPY  #$07
$8409: D0 09    BNE  $8414
$840B: C9          .byte $C9  ; غير معرّف
$840C: 03          .byte $03  ; غير معرّف
$840D: 90 34    BCC  $8443
$840F: E9 01    SBC  #$01
$8411: 4C 18 84 JMP  $8418
$8414: C9          .byte $C9  ; غير معرّف
$8415: 02          .byte $02  ; غير معرّف
$8416: 90 2B    BCC  $8443
$8418: A8       TAY  
$8419: D0 08    BNE  $8423
$841B: AD 53 07 LDA  $0753
$841E: F0 14    BEQ  $8434
$8420: C8       INY  
$8421: D0 11    BNE  $8434
$8423: C8       INY  
$8424: AD 5F 07 LDA  $075F
$8427: C9          .byte $C9  ; غير معرّف
$8428: 07          .byte $07  ; غير معرّف
$8429: F0 09    BEQ  $8434
$842B: 88       DEY  
$842C: C0 04    CPY  #$04
$842E: B0 26    BCS  $8456
$8430: C0 03    CPY  #$03
$8432: B0 0F    BCS  $8443
$8434: C0 03    CPY  #$03
$8436: D0 04    BNE  $843C
$8438: A9 04    LDA  #$04
$843A: 85 FC    STA  $FC
$843C: 98       TYA  
$843D: 18       CLC  
$843E: 69 0C    ADC  #$0C
$8440: 8D 73 07 STA  $0773
$8443: AD 49 07 LDA  $0749
$8446: 18       CLC  
$8447: 69 04    ADC  #$04
$8449: 8D 49 07 STA  $0749
$844C: AD 19 07 LDA  $0719
$844F: 69 00    ADC  #$00
$8451: 8D 19 07 STA  $0719
$8454: C9          .byte $C9  ; غير معرّف
$8455: 07          .byte $07  ; غير معرّف
$8456: 90 08    BCC  $8460
$8458: A9 06    LDA  #$06
$845A: 8D A1 07 STA  $07A1
$845D: EE 72 07 INC  $0772
$8460: 60       RTS  
$8461: AD A1 07 LDA  $07A1
$8464: D0 20    BNE  $8486
$8466: AC 5F 07 LDY  $075F
$8469: C0 07    CPY  #$07
$846B: B0 1A    BCS  $8487
$846D: A9 00    LDA  #$00
$846F: 8D 60 07 STA  $0760
$8472: 8D 5C 07 STA  $075C
$8475: 8D 72 07 STA  $0772
$8478: EE 5F 07 INC  $075F
$847B: 20 03 9C JSR  $9C03
$847E: EE 57 07 INC  $0757
$8481: A9 01    LDA  #$01
$8483: 8D 70 07 STA  $0770
$8486: 60       RTS  
$8487: AD FC 06 LDA  $06FC
$848A: 0D FD 06 ORA  $06FD
$848D: 29 40    AND  #$40
$848F: F0 0D    BEQ  $849E
$8491: A9 01    LDA  #$01
$8493: 8D FC 07 STA  $07FC
$8496: A9 FF    LDA  #$FF
$8498: 8D 5A 07 STA  $075A
$849B: 20 48 92 JSR  $9248
$849E: 60       RTS  
$849F: FF          .byte $FF  ; غير معرّف
$84A0: FF          .byte $FF  ; غير معرّف
$84A1: F6 FB    INC  $FB,X
$84A3: F7          .byte $F7  ; غير معرّف
$84A4: FB          .byte $FB  ; غير معرّف
$84A5: F8       SED  
$84A6: FB          .byte $FB  ; غير معرّف
$84A7: F9 FB FA SBC  $FAFB,Y
$84AA: FB          .byte $FB  ; غير معرّف
$84AB: F6 50    INC  $50,X
$84AD: F7          .byte $F7  ; غير معرّف
$84AE: 50 F8    BVC  $84A8
$84B0: 50 F9    BVC  $84AB
$84B2: 50 FA    BVC  $84AE
$84B4: 50 FD    BVC  $84B3
$84B6: FE FF 41 INC  $41FF,X
$84B9: 42          .byte $42  ; غير معرّف
$84BA: 44          .byte $44  ; غير معرّف
$84BB: 45 48    EOR  $48
$84BD: 31 32    AND  ($32),Y
$84BF: 34          .byte $34  ; غير معرّف
$84C0: 35 38    AND  $38,X
$84C2: 00       BRK  
$84C3: BD 10 01 LDA  $0110,X
$84C6: F0 BE    BEQ  $8486
$84C8: C9          .byte $C9  ; غير معرّف
$84C9: 0B          .byte $0B  ; غير معرّف
$84CA: 90 05    BCC  $84D1
$84CC: A9 0B    LDA  #$0B
$84CE: 9D 10 01 STA  $0110,X
$84D1: A8       TAY  
$84D2: BD 2C 01 LDA  $012C,X
$84D5: D0 04    BNE  $84DB
$84D7: 9D 10 01 STA  $0110,X
$84DA: 60       RTS  
$84DB: DE 2C 01 DEC  $012C,X
$84DE: C9          .byte $C9  ; غير معرّف
$84DF: 2B          .byte $2B  ; غير معرّف
$84E0: D0 1E    BNE  $8500
$84E2: C0 0B    CPY  #$0B
$84E4: D0 07    BNE  $84ED
$84E6: EE 5A 07 INC  $075A
$84E9: A9 40    LDA  #$40
$84EB: 85 FE    STA  $FE
$84ED: B9 B7 84 LDA  $84B7,Y
$84F0: 4A       LSR  A
$84F1: 4A       LSR  A
$84F2: 4A       LSR  A
$84F3: 4A       LSR  A
$84F4: AA       TAX  
$84F5: B9 B7 84 LDA  $84B7,Y
$84F8: 29 0F    AND  #$0F
$84FA: 9D 34 01 STA  $0134,X
$84FD: 20 27 BC JSR  $BC27
$8500: BC E5 06 LDY  $06E5,X
$8503: B5 16    LDA  $16,X
$8505: C9          .byte $C9  ; غير معرّف
$8506: 12          .byte $12  ; غير معرّف
$8507: F0 22    BEQ  $852B
$8509: C9          .byte $C9  ; غير معرّف
$850A: 0D F0 1E ORA  $1EF0
$850D: C9          .byte $C9  ; غير معرّف
$850E: 05 F0    ORA  $F0
$8510: 12          .byte $12  ; غير معرّف
$8511: C9          .byte $C9  ; غير معرّف
$8512: 0A       ASL  A
$8513: F0 16    BEQ  $852B
$8515: C9          .byte $C9  ; غير معرّف
$8516: 0B          .byte $0B  ; غير معرّف
$8517: F0 12    BEQ  $852B
$8519: C9          .byte $C9  ; غير معرّف
$851A: 09 B0    ORA  #$B0
$851C: 06 B5    ASL  $B5
$851E: 1E C9 02 ASL  $02C9,X
$8521: B0 08    BCS  $852B
$8523: AE EE 03 LDX  $03EE
$8526: BC EC 06 LDY  $06EC,X
$8529: A6 08    LDX  $08
$852B: BD 1E 01 LDA  $011E,X
$852E: C9          .byte $C9  ; غير معرّف
$852F: 18       CLC  
$8530: 90 05    BCC  $8537
$8532: E9 01    SBC  #$01
$8534: 9D 1E 01 STA  $011E,X
$8537: BD 1E 01 LDA  $011E,X
$853A: E9 08    SBC  #$08
$853C: 20 C1 E5 JSR  $E5C1
$853F: BD 17 01 LDA  $0117,X
$8542: 99 03 02 STA  $0203,Y
$8545: 18       CLC  
$8546: 69 08    ADC  #$08
$8548: 99 07 02 STA  $0207,Y
$854B: A9 02    LDA  #$02
$854D: 99 02 02 STA  $0202,Y
$8550: 99 06 02 STA  $0206,Y
$8553: BD 10 01 LDA  $0110,X
$8556: 0A       ASL  A
$8557: AA       TAX  
$8558: BD 9F 84 LDA  $849F,X
$855B: 99 01 02 STA  $0201,Y
$855E: BD A0 84 LDA  $84A0,X
$8561: 99 05 02 STA  $0205,Y
$8564: A6 08    LDX  $08
$8566: 60       RTS  
$8567: AD 3C 07 LDA  $073C
$856A: 20 04 8E JSR  $8E04
$856D: 8B          .byte $8B  ; غير معرّف
$856E: 85 9B    STA  $9B
$8570: 85 52    STA  $52
$8572: 86 5A    STX  $5A
$8574: 86 93    STX  $93
$8576: 86 9D    STX  $9D
$8578: 88       DEY  
$8579: A8       TAY  
$857A: 86 9D    STX  $9D
$857C: 88       DEY  
$857D: E6 86    INC  $86
$857F: BF          .byte $BF  ; غير معرّف
$8580: 85 E3    STA  $E3
$8582: 85 43    STA  $43
$8584: 86 FF    STX  $FF
$8586: 86 32    STX  $32
$8588: 87          .byte $87  ; غير معرّف
$8589: 49 87    EOR  #$87
$858B: 20 20 82 JSR  $8220
$858E: 20 19 8E JSR  $8E19
$8591: AD 70 07 LDA  $0770
$8594: F0 32    BEQ  $85C8
$8596: A2 03    LDX  #$03
$8598: 4C C5 85 JMP  $85C5
$859B: AD 44 07 LDA  $0744
$859E: 48       PHA  
$859F: AD 56 07 LDA  $0756
$85A2: 48       PHA  
$85A3: A9 00    LDA  #$00
$85A5: 8D 56 07 STA  $0756
$85A8: A9 02    LDA  #$02
$85AA: 8D 44 07 STA  $0744
$85AD: 20 F1 85 JSR  $85F1
$85B0: 68       PLA  
$85B1: 8D 56 07 STA  $0756
$85B4: 68       PLA  
$85B5: 8D 44 07 STA  $0744
$85B8: 4C 45 87 JMP  $8745
$85BB: 01 02    ORA  ($02,X)
$85BD: 03          .byte $03  ; غير معرّف
$85BE: 04          .byte $04  ; غير معرّف
$85BF: AC 4E 07 LDY  $074E
$85C2: BE BB 85 LDX  $85BB,Y
$85C5: 8E 73 07 STX  $0773
$85C8: 4C 45 87 JMP  $8745
$85CB: 00       BRK  
$85CC: 09 0A    ORA  #$0A
$85CE: 04          .byte $04  ; غير معرّف
$85CF: 22          .byte $22  ; غير معرّف
$85D0: 22          .byte $22  ; غير معرّف
$85D1: 0F          .byte $0F  ; غير معرّف
$85D2: 0F          .byte $0F  ; غير معرّف
$85D3: 0F          .byte $0F  ; غير معرّف
$85D4: 22          .byte $22  ; غير معرّف
$85D5: 0F          .byte $0F  ; غير معرّف
$85D6: 0F          .byte $0F  ; غير معرّف
$85D7: 22          .byte $22  ; غير معرّف
$85D8: 16 27    ASL  $27,X
$85DA: 18       CLC  
$85DB: 22          .byte $22  ; غير معرّف
$85DC: 30 27    BMI  $8605
$85DE: 19 22 37 ORA  $3722,Y
$85E1: 27          .byte $27  ; غير معرّف
$85E2: 16 AC    ASL  $AC,X
$85E4: 44          .byte $44  ; غير معرّف
$85E5: 07          .byte $07  ; غير معرّف
$85E6: F0 06    BEQ  $85EE
$85E8: B9 C7 85 LDA  $85C7,Y
$85EB: 8D 73 07 STA  $0773
$85EE: EE 3C 07 INC  $073C
$85F1: AE 00 03 LDX  $0300
$85F4: A0 00    LDY  #$00
$85F6: AD 53 07 LDA  $0753
$85F9: F0 02    BEQ  $85FD
$85FB: A0 04    LDY  #$04
$85FD: AD 56 07 LDA  $0756
$8600: C9          .byte $C9  ; غير معرّف
$8601: 02          .byte $02  ; غير معرّف
$8602: D0 02    BNE  $8606
$8604: A0 08    LDY  #$08
$8606: A9 03    LDA  #$03
$8608: 85 00    STA  $00
$860A: B9 D7 85 LDA  $85D7,Y
$860D: 9D 04 03 STA  $0304,X
$8610: C8       INY  
$8611: E8       INX  
$8612: C6 00    DEC  $00
$8614: 10 F4    BPL  $860A
$8616: AE 00 03 LDX  $0300
$8619: AC 44 07 LDY  $0744
$861C: D0 03    BNE  $8621
$861E: AC 4E 07 LDY  $074E
$8621: B9 CF 85 LDA  $85CF,Y
$8624: 9D 04 03 STA  $0304,X
$8627: A9 3F    LDA  #$3F
$8629: 9D 01 03 STA  $0301,X
$862C: A9 10    LDA  #$10
$862E: 9D 02 03 STA  $0302,X
$8631: A9 04    LDA  #$04
$8633: 9D 03 03 STA  $0303,X
$8636: A9 00    LDA  #$00
$8638: 9D 08 03 STA  $0308,X
$863B: 8A       TXA  
$863C: 18       CLC  
$863D: 69 07    ADC  #$07
$863F: 8D 00 03 STA  $0300
$8642: 60       RTS  
$8643: AD 33 07 LDA  $0733
$8646: C9          .byte $C9  ; غير معرّف
$8647: 01 D0    ORA  ($D0,X)
$8649: 05 A9    ORA  $A9
$864B: 0B          .byte $0B  ; غير معرّف
$864C: 8D 73 07 STA  $0773
$864F: 4C 45 87 JMP  $8745
$8652: A9 00    LDA  #$00
$8654: 20 08 88 JSR  $8808
$8657: 4C 45 87 JMP  $8745
$865A: 20 30 BC JSR  $BC30
$865D: AE 00 03 LDX  $0300
$8660: A9 20    LDA  #$20
$8662: 9D 01 03 STA  $0301,X
$8665: A9 73    LDA  #$73
$8667: 9D 02 03 STA  $0302,X
$866A: A9 03    LDA  #$03
$866C: 9D 03 03 STA  $0303,X
$866F: AC 5F 07 LDY  $075F
$8672: C8       INY  
$8673: 98       TYA  
$8674: 9D 04 03 STA  $0304,X
$8677: A9 28    LDA  #$28
$8679: 9D 05 03 STA  $0305,X
$867C: AC 5C 07 LDY  $075C
$867F: C8       INY  
$8680: 98       TYA  
$8681: 9D 06 03 STA  $0306,X
$8684: A9 00    LDA  #$00
$8686: 9D 07 03 STA  $0307,X
$8689: 8A       TXA  
$868A: 18       CLC  
$868B: 69 06    ADC  #$06
$868D: 8D 00 03 STA  $0300
$8690: 4C 45 87 JMP  $8745
$8693: AD 59 07 LDA  $0759
$8696: F0 0A    BEQ  $86A2
$8698: A9 00    LDA  #$00
$869A: 8D 59 07 STA  $0759
$869D: A9 02    LDA  #$02
$869F: 4C C7 86 JMP  $86C7
$86A2: EE 3C 07 INC  $073C
$86A5: 4C 45 87 JMP  $8745
$86A8: AD 70 07 LDA  $0770
$86AB: F0 33    BEQ  $86E0
$86AD: C9          .byte $C9  ; غير معرّف
$86AE: 03          .byte $03  ; غير معرّف
$86AF: F0 22    BEQ  $86D3
$86B1: AD 52 07 LDA  $0752
$86B4: D0 2A    BNE  $86E0
$86B6: AC 4E 07 LDY  $074E
$86B9: C0 03    CPY  #$03
$86BB: F0 05    BEQ  $86C2
$86BD: AD 69 07 LDA  $0769
$86C0: D0 1E    BNE  $86E0
$86C2: 20 A4 EF JSR  $EFA4
$86C5: A9 01    LDA  #$01
$86C7: 20 08 88 JSR  $8808
$86CA: 20 A5 88 JSR  $88A5
$86CD: A9 00    LDA  #$00
$86CF: 8D 74 07 STA  $0774
$86D2: 60       RTS  
$86D3: A9 12    LDA  #$12
$86D5: 8D A0 07 STA  $07A0
$86D8: A9 03    LDA  #$03
$86DA: 20 08 88 JSR  $8808
$86DD: 4C 4E 87 JMP  $874E
$86E0: A9 08    LDA  #$08
$86E2: 8D 3C 07 STA  $073C
$86E5: 60       RTS  
$86E6: EE 74 07 INC  $0774
$86E9: 20 B0 92 JSR  $92B0
$86EC: AD 1F 07 LDA  $071F
$86EF: D0 F8    BNE  $86E9
$86F1: CE 1E 07 DEC  $071E
$86F4: 10 03    BPL  $86F9
$86F6: EE 3C 07 INC  $073C
$86F9: A9 06    LDA  #$06
$86FB: 8D 73 07 STA  $0773
$86FE: 60       RTS  
$86FF: AD 70 07 LDA  $0770
$8702: D0 4A    BNE  $874E
$8704: A9 1E    LDA  #$1E
$8706: 8D 06 20 STA  $2006
$8709: A9 C0    LDA  #$C0
$870B: 8D 06 20 STA  $2006
$870E: A9 03    LDA  #$03
$8710: 85 01    STA  $01
$8712: A0 00    LDY  #$00
$8714: 84 00    STY  $00
$8716: AD 07 20 LDA  $2007
$8719: AD 07 20 LDA  $2007
$871C: 91 00    STA  ($00),Y
$871E: C8       INY  
$871F: D0 02    BNE  $8723
$8721: E6 01    INC  $01
$8723: A5 01    LDA  $01
$8725: C9          .byte $C9  ; غير معرّف
$8726: 04          .byte $04  ; غير معرّف
$8727: D0 F0    BNE  $8719
$8729: C0 3A    CPY  #$3A
$872B: 90 EC    BCC  $8719
$872D: A9 05    LDA  #$05
$872F: 4C 4C 86 JMP  $864C
$8732: AD 70 07 LDA  $0770
$8735: D0 17    BNE  $874E
$8737: A2 00    LDX  #$00
$8739: 9D 00 03 STA  $0300,X
$873C: 9D 00 04 STA  $0400,X
$873F: CA       DEX  
$8740: D0 F7    BNE  $8739
$8742: 20 25 83 JSR  $8325
$8745: EE 3C 07 INC  $073C
$8748: 60       RTS  
$8749: A9 FA    LDA  #$FA
$874B: 20 36 BC JSR  $BC36
$874E: EE 72 07 INC  $0772
$8751: 60       RTS  
$8752: 20 43 05 JSR  $0543
$8755: 16 0A    ASL  $0A,X
$8757: 1B          .byte $1B  ; غير معرّف
$8758: 12          .byte $12  ; غير معرّف
$8759: 18       CLC  
$875A: 20 52 0B JSR  $0B52
$875D: 20 18 1B JSR  $1B18
$8760: 15 0D    ORA  $0D,X
$8762: 24 24    BIT  $24
$8764: 1D 12 16 ORA  $1612,X
$8767: 0E 20 68 ASL  $6820
$876A: 05 00    ORA  $00
$876C: 24 24    BIT  $24
$876E: 2E 29 23 ROL  $2329
$8771: C0 7F    CPY  #$7F
$8773: AA       TAX  
$8774: 23          .byte $23  ; غير معرّف
$8775: C2          .byte $C2  ; غير معرّف
$8776: 01 EA    ORA  ($EA,X)
$8778: FF          .byte $FF  ; غير معرّف
$8779: 21 CD    AND  ($CD,X)
$877B: 07          .byte $07  ; غير معرّف
$877C: 24 24    BIT  $24
$877E: 29 24    AND  #$24
$8780: 24 24    BIT  $24
$8782: 24 21    BIT  $21
$8784: 4B          .byte $4B  ; غير معرّف
$8785: 09 20    ORA  #$20
$8787: 18       CLC  
$8788: 1B          .byte $1B  ; غير معرّف
$8789: 15 0D    ORA  $0D,X
$878B: 24 24    BIT  $24
$878D: 28       PLP  
$878E: 24 22    BIT  $22
$8790: 0C          .byte $0C  ; غير معرّف
$8791: 47          .byte $47  ; غير معرّف
$8792: 24 23    BIT  $23
$8794: DC          .byte $DC  ; غير معرّف
$8795: 01 BA    ORA  ($BA,X)
$8797: FF          .byte $FF  ; غير معرّف
$8798: 21 CD    AND  ($CD,X)
$879A: 05 16    ORA  $16
$879C: 0A       ASL  A
$879D: 1B          .byte $1B  ; غير معرّف
$879E: 12          .byte $12  ; غير معرّف
$879F: 18       CLC  
$87A0: 22          .byte $22  ; غير معرّف
$87A1: 0C          .byte $0C  ; غير معرّف
$87A2: 07          .byte $07  ; غير معرّف
$87A3: 1D 12 16 ORA  $1612,X
$87A6: 0E 24 1E ASL  $1E24
$87A9: 19 FF 21 ORA  $21FF,Y
$87AC: CD 05 16 CMP  $1605
$87AF: 0A       ASL  A
$87B0: 1B          .byte $1B  ; غير معرّف
$87B1: 12          .byte $12  ; غير معرّف
$87B2: 18       CLC  
$87B3: 22          .byte $22  ; غير معرّف
$87B4: 0B          .byte $0B  ; غير معرّف
$87B5: 09 10    ORA  #$10
$87B7: 0A       ASL  A
$87B8: 16 0E    ASL  $0E,X
$87BA: 24 18    BIT  $18
$87BC: 1F          .byte $1F  ; غير معرّف
$87BD: 0E 1B FF ASL  $FF1B
$87C0: 25 84    AND  $84
$87C2: 15 20    ORA  $20,X
$87C4: 0E 15 0C ASL  $0C15
$87C7: 18       CLC  
$87C8: 16 0E    ASL  $0E,X
$87CA: 24 1D    BIT  $1D
$87CC: 18       CLC  
$87CD: 24 20    BIT  $20
$87CF: 0A       ASL  A
$87D0: 1B          .byte $1B  ; غير معرّف
$87D1: 19 24 23 ORA  $2324,Y
$87D4: 18       CLC  
$87D5: 17          .byte $17  ; غير معرّف
$87D6: 0E 2B 26 ASL  $262B
$87D9: 25 01    AND  $01
$87DB: 24 26    BIT  $26
$87DD: 2D 01 24 AND  $2401
$87E0: 26 35    ROL  $35
$87E2: 01 24    ORA  ($24,X)
$87E4: 27          .byte $27  ; غير معرّف
$87E5: D9 46 AA CMP  $AA46,Y
$87E8: 27          .byte $27  ; غير معرّف
$87E9: E1 45    SBC  ($45,X)
$87EB: AA       TAX  
$87EC: FF          .byte $FF  ; غير معرّف
$87ED: 15 1E    ORA  $1E,X
$87EF: 12          .byte $12  ; غير معرّف
$87F0: 10 12    BPL  $8804
$87F2: 04          .byte $04  ; غير معرّف
$87F3: 03          .byte $03  ; غير معرّف
$87F4: 02          .byte $02  ; غير معرّف
$87F5: 00       BRK  
$87F6: 24 05    BIT  $05
$87F8: 24 00    BIT  $00
$87FA: 08       PHP  
$87FB: 07          .byte $07  ; غير معرّف
$87FC: 06 00    ASL  $00
$87FE: 00       BRK  
$87FF: 00       BRK  
$8800: 27          .byte $27  ; غير معرّف
$8801: 27          .byte $27  ; غير معرّف
$8802: 46 4E    LSR  $4E
$8804: 59 61 6E EOR  $6E61,Y
$8807: 6E 48 0A ROR  $0A48
$880A: A8       TAY  
$880B: C0 04    CPY  #$04
$880D: 90 0C    BCC  $881B
$880F: C0 08    CPY  #$08
$8811: 90 02    BCC  $8815
$8813: A0 08    LDY  #$08
$8815: AD 7A 07 LDA  $077A
$8818: D0 01    BNE  $881B
$881A: C8       INY  
$881B: BE FE 87 LDX  $87FE,Y
$881E: A0 00    LDY  #$00
$8820: BD 52 87 LDA  $8752,X
$8823: C9          .byte $C9  ; غير معرّف
$8824: FF          .byte $FF  ; غير معرّف
$8825: F0 07    BEQ  $882E
$8827: 99 01 03 STA  $0301,Y
$882A: E8       INX  
$882B: C8       INY  
$882C: D0 F2    BNE  $8820
$882E: A9 00    LDA  #$00
$8830: 99 01 03 STA  $0301,Y
$8833: 68       PLA  
$8834: AA       TAX  
$8835: C9          .byte $C9  ; غير معرّف
$8836: 04          .byte $04  ; غير معرّف
$8837: B0 49    BCS  $8882
$8839: CA       DEX  
$883A: D0 23    BNE  $885F
$883C: AD 5A 07 LDA  $075A
$883F: 18       CLC  
$8840: 69 01    ADC  #$01
$8842: C9          .byte $C9  ; غير معرّف
$8843: 0A       ASL  A
$8844: 90 07    BCC  $884D
$8846: E9 0A    SBC  #$0A
$8848: A0 9F    LDY  #$9F
$884A: 8C 08 03 STY  $0308
$884D: 8D 09 03 STA  $0309
$8850: AC 5F 07 LDY  $075F
$8853: C8       INY  
$8854: 8C 14 03 STY  $0314
$8857: AC 5C 07 LDY  $075C
$885A: C8       INY  
$885B: 8C 16 03 STY  $0316
$885E: 60       RTS  
$885F: AD 7A 07 LDA  $077A
$8862: F0 1D    BEQ  $8881
$8864: AD 53 07 LDA  $0753
$8867: CA       DEX  
$8868: D0 09    BNE  $8873
$886A: AC 70 07 LDY  $0770
$886D: C0 03    CPY  #$03
$886F: F0 02    BEQ  $8873
$8871: 49 01    EOR  #$01
$8873: 4A       LSR  A
$8874: 90 0B    BCC  $8881
$8876: A0 04    LDY  #$04
$8878: B9 ED 87 LDA  $87ED,Y
$887B: 99 04 03 STA  $0304,Y
$887E: 88       DEY  
$887F: 10 F7    BPL  $8878
$8881: 60       RTS  
$8882: E9 04    SBC  #$04
$8884: 0A       ASL  A
$8885: 0A       ASL  A
$8886: AA       TAX  
$8887: A0 00    LDY  #$00
$8889: BD F2 87 LDA  $87F2,X
$888C: 99 1C 03 STA  $031C,Y
$888F: E8       INX  
$8890: C8       INY  
$8891: C8       INY  
$8892: C8       INY  
$8893: C8       INY  
$8894: C0 0C    CPY  #$0C
$8896: 90 F1    BCC  $8889
$8898: A9 2C    LDA  #$2C
$889A: 4C 3F 86 JMP  $863F
$889D: AD A0 07 LDA  $07A0
$88A0: D0 0B    BNE  $88AD
$88A2: 20 20 82 JSR  $8220
$88A5: A9 07    LDA  #$07
$88A7: 8D A0 07 STA  $07A0
$88AA: EE 3C 07 INC  $073C
$88AD: 60       RTS  
$88AE: AD 26 07 LDA  $0726
$88B1: 29 01    AND  #$01
$88B3: 85 05    STA  $05
$88B5: AC 40 03 LDY  $0340
$88B8: 84 00    STY  $00
$88BA: AD 21 07 LDA  $0721
$88BD: 99 42 03 STA  $0342,Y
$88C0: AD 20 07 LDA  $0720
$88C3: 99 41 03 STA  $0341,Y
$88C6: A9 9A    LDA  #$9A
$88C8: 99 43 03 STA  $0343,Y
$88CB: A9 00    LDA  #$00
$88CD: 85 04    STA  $04
$88CF: AA       TAX  
$88D0: 86 01    STX  $01
$88D2: BD A1 06 LDA  $06A1,X
$88D5: 29 C0    AND  #$C0
$88D7: 85 03    STA  $03
$88D9: 0A       ASL  A
$88DA: 2A       ROL  A
$88DB: 2A       ROL  A
$88DC: A8       TAY  
$88DD: B9 08 8B LDA  $8B08,Y
$88E0: 85 06    STA  $06
$88E2: B9 0C 8B LDA  $8B0C,Y
$88E5: 85 07    STA  $07
$88E7: BD A1 06 LDA  $06A1,X
$88EA: 0A       ASL  A
$88EB: 0A       ASL  A
$88EC: 85 02    STA  $02
$88EE: AD 1F 07 LDA  $071F
$88F1: 29 01    AND  #$01
$88F3: 49 01    EOR  #$01
$88F5: 0A       ASL  A
$88F6: 65 02    ADC  $02
$88F8: A8       TAY  
$88F9: A6 00    LDX  $00
$88FB: B1 06    LDA  ($06),Y
$88FD: 9D 44 03 STA  $0344,X
$8900: C8       INY  
$8901: B1 06    LDA  ($06),Y
$8903: 9D 45 03 STA  $0345,X
$8906: A4 04    LDY  $04
$8908: A5 05    LDA  $05
$890A: D0 0E    BNE  $891A
$890C: A5 01    LDA  $01
$890E: 4A       LSR  A
$890F: B0 19    BCS  $892A
$8911: 26 03    ROL  $03
$8913: 26 03    ROL  $03
$8915: 26 03    ROL  $03
$8917: 4C 30 89 JMP  $8930
$891A: A5 01    LDA  $01
$891C: 4A       LSR  A
$891D: B0 0F    BCS  $892E
$891F: 46 03    LSR  $03
$8921: 46 03    LSR  $03
$8923: 46 03    LSR  $03
$8925: 46 03    LSR  $03
$8927: 4C 30 89 JMP  $8930
$892A: 46 03    LSR  $03
$892C: 46 03    LSR  $03
$892E: E6 04    INC  $04
$8930: B9 F9 03 LDA  $03F9,Y
$8933: 05 03    ORA  $03
$8935: 99 F9 03 STA  $03F9,Y
$8938: E6 00    INC  $00
$893A: E6 00    INC  $00
$893C: A6 01    LDX  $01
$893E: E8       INX  
$893F: E0 0D    CPX  #$0D
$8941: 90 8D    BCC  $88D0
$8943: A4 00    LDY  $00
$8945: C8       INY  
$8946: C8       INY  
$8947: C8       INY  
$8948: A9 00    LDA  #$00
$894A: 99 41 03 STA  $0341,Y
$894D: 8C 40 03 STY  $0340
$8950: EE 21 07 INC  $0721
$8953: AD 21 07 LDA  $0721
$8956: 29 1F    AND  #$1F
$8958: D0 0D    BNE  $8967
$895A: A9 80    LDA  #$80
$895C: 8D 21 07 STA  $0721
$895F: AD 20 07 LDA  $0720
$8962: 49 04    EOR  #$04
$8964: 8D 20 07 STA  $0720
$8967: 4C BD 89 JMP  $89BD
$896A: AD 21 07 LDA  $0721
$896D: 29 1F    AND  #$1F
$896F: 38       SEC  
$8970: E9 04    SBC  #$04
$8972: 29 1F    AND  #$1F
$8974: 85 01    STA  $01
$8976: AD 20 07 LDA  $0720
$8979: B0 02    BCS  $897D
$897B: 49 04    EOR  #$04
$897D: 29 04    AND  #$04
$897F: 09 23    ORA  #$23
$8981: 85 00    STA  $00
$8983: A5 01    LDA  $01
$8985: 4A       LSR  A
$8986: 4A       LSR  A
$8987: 69 C0    ADC  #$C0
$8989: 85 01    STA  $01
$898B: A2 00    LDX  #$00
$898D: AC 40 03 LDY  $0340
$8990: A5 00    LDA  $00
$8992: 99 41 03 STA  $0341,Y
$8995: A5 01    LDA  $01
$8997: 18       CLC  
$8998: 69 08    ADC  #$08
$899A: 99 42 03 STA  $0342,Y
$899D: 85 01    STA  $01
$899F: BD F9 03 LDA  $03F9,X
$89A2: 99 44 03 STA  $0344,Y
$89A5: A9 01    LDA  #$01
$89A7: 99 43 03 STA  $0343,Y
$89AA: 4A       LSR  A
$89AB: 9D F9 03 STA  $03F9,X
$89AE: C8       INY  
$89AF: C8       INY  
$89B0: C8       INY  
$89B1: C8       INY  
$89B2: E8       INX  
$89B3: E0 07    CPX  #$07
$89B5: 90 D9    BCC  $8990
$89B7: 99 41 03 STA  $0341,Y
$89BA: 8C 40 03 STY  $0340
$89BD: A9 06    LDA  #$06
$89BF: 8D 73 07 STA  $0773
$89C2: 60       RTS  
$89C3: 27          .byte $27  ; غير معرّف
$89C4: 27          .byte $27  ; غير معرّف
$89C5: 27          .byte $27  ; غير معرّف
$89C6: 17          .byte $17  ; غير معرّف
$89C7: 07          .byte $07  ; غير معرّف
$89C8: 17          .byte $17  ; غير معرّف
$89C9: 3F          .byte $3F  ; غير معرّف
$89CA: 0C          .byte $0C  ; غير معرّف
$89CB: 04          .byte $04  ; غير معرّف
$89CC: FF          .byte $FF  ; غير معرّف
$89CD: FF          .byte $FF  ; غير معرّف
$89CE: FF          .byte $FF  ; غير معرّف
$89CF: FF          .byte $FF  ; غير معرّف
$89D0: 00       BRK  
$89D1: 0F          .byte $0F  ; غير معرّف
$89D2: 07          .byte $07  ; غير معرّف
$89D3: 12          .byte $12  ; غير معرّف
$89D4: 0F          .byte $0F  ; غير معرّف
$89D5: 0F          .byte $0F  ; غير معرّف
$89D6: 07          .byte $07  ; غير معرّف
$89D7: 17          .byte $17  ; غير معرّف
$89D8: 0F          .byte $0F  ; غير معرّف
$89D9: 0F          .byte $0F  ; غير معرّف
$89DA: 07          .byte $07  ; غير معرّف
$89DB: 17          .byte $17  ; غير معرّف
$89DC: 1C          .byte $1C  ; غير معرّف
$89DD: 0F          .byte $0F  ; غير معرّف
$89DE: 07          .byte $07  ; غير معرّف
$89DF: 17          .byte $17  ; غير معرّف
$89E0: 00       BRK  
$89E1: A5 09    LDA  $09
$89E3: 29 07    AND  #$07
$89E5: D0 51    BNE  $8A38
$89E7: AE 00 03 LDX  $0300
$89EA: E0 31    CPX  #$31
$89EC: B0 4A    BCS  $8A38
$89EE: A8       TAY  
$89EF: B9 C9 89 LDA  $89C9,Y
$89F2: 9D 01 03 STA  $0301,X
$89F5: E8       INX  
$89F6: C8       INY  
$89F7: C0 08    CPY  #$08
$89F9: 90 F4    BCC  $89EF
$89FB: AE 00 03 LDX  $0300
$89FE: A9 03    LDA  #$03
$8A00: 85 00    STA  $00
$8A02: AD 4E 07 LDA  $074E
$8A05: 0A       ASL  A
$8A06: 0A       ASL  A
$8A07: A8       TAY  
$8A08: B9 D1 89 LDA  $89D1,Y
$8A0B: 9D 04 03 STA  $0304,X
$8A0E: C8       INY  
$8A0F: E8       INX  
$8A10: C6 00    DEC  $00
$8A12: 10 F4    BPL  $8A08
$8A14: AE 00 03 LDX  $0300
$8A17: AC D4 06 LDY  $06D4
$8A1A: B9 C3 89 LDA  $89C3,Y
$8A1D: 9D 05 03 STA  $0305,X
$8A20: AD 00 03 LDA  $0300
$8A23: 18       CLC  
$8A24: 69 07    ADC  #$07
$8A26: 8D 00 03 STA  $0300
$8A29: EE D4 06 INC  $06D4
$8A2C: AD D4 06 LDA  $06D4
$8A2F: C9          .byte $C9  ; غير معرّف
$8A30: 06 90    ASL  $90
$8A32: 05 A9    ORA  $A9
$8A34: 00       BRK  
$8A35: 8D D4 06 STA  $06D4
$8A38: 60       RTS  
$8A39: 45 45    EOR  $45
$8A3B: 47          .byte $47  ; غير معرّف
$8A3C: 47          .byte $47  ; غير معرّف
$8A3D: 47          .byte $47  ; غير معرّف
$8A3E: 47          .byte $47  ; غير معرّف
$8A3F: 47          .byte $47  ; غير معرّف
$8A40: 47          .byte $47  ; غير معرّف
$8A41: 57          .byte $57  ; غير معرّف
$8A42: 58       CLI  
$8A43: 59 5A 24 EOR  $245A,Y
$8A46: 24 24    BIT  $24
$8A48: 24 26    BIT  $26
$8A4A: 26 26    ROL  $26
$8A4C: 26 A0    ROL  $A0
$8A4E: 41 A9    EOR  ($A9,X)
$8A50: 03          .byte $03  ; غير معرّف
$8A51: AE 4E 07 LDX  $074E
$8A54: D0 02    BNE  $8A58
$8A56: A9 04    LDA  #$04
$8A58: 20 97 8A JSR  $8A97
$8A5B: A9 06    LDA  #$06
$8A5D: 8D 73 07 STA  $0773
$8A60: 60       RTS  
$8A61: 20 6D 8A JSR  $8A6D
$8A64: EE F0 03 INC  $03F0
$8A67: DE EC 03 DEC  $03EC,X
$8A6A: 60       RTS  
$8A6B: A9 00    LDA  #$00
$8A6D: A0 03    LDY  #$03
$8A6F: C9          .byte $C9  ; غير معرّف
$8A70: 00       BRK  
$8A71: F0 14    BEQ  $8A87
$8A73: A0 00    LDY  #$00
$8A75: C9          .byte $C9  ; غير معرّف
$8A76: 58       CLI  
$8A77: F0 0E    BEQ  $8A87
$8A79: C9          .byte $C9  ; غير معرّف
$8A7A: 51 F0    EOR  ($F0),Y
$8A7C: 0A       ASL  A
$8A7D: C8       INY  
$8A7E: C9          .byte $C9  ; غير معرّف
$8A7F: 5D F0 05 EOR  $05F0,X
$8A82: C9          .byte $C9  ; غير معرّف
$8A83: 52          .byte $52  ; غير معرّف
$8A84: F0 01    BEQ  $8A87
$8A86: C8       INY  
$8A87: 98       TYA  
$8A88: AC 00 03 LDY  $0300
$8A8B: C8       INY  
$8A8C: 20 97 8A JSR  $8A97
$8A8F: 88       DEY  
$8A90: 98       TYA  
$8A91: 18       CLC  
$8A92: 69 0A    ADC  #$0A
$8A94: 4C 3F 86 JMP  $863F
$8A97: 86 00    STX  $00
$8A99: 84 01    STY  $01
$8A9B: 0A       ASL  A
$8A9C: 0A       ASL  A
$8A9D: AA       TAX  
$8A9E: A0 20    LDY  #$20
$8AA0: A5 06    LDA  $06
$8AA2: C9          .byte $C9  ; غير معرّف
$8AA3: D0 90    BNE  $8A35
$8AA5: 02          .byte $02  ; غير معرّف
$8AA6: A0 24    LDY  #$24
$8AA8: 84 03    STY  $03
$8AAA: 29 0F    AND  #$0F
$8AAC: 0A       ASL  A
$8AAD: 85 04    STA  $04
$8AAF: A9 00    LDA  #$00
$8AB1: 85 05    STA  $05
$8AB3: A5 02    LDA  $02
$8AB5: 18       CLC  
$8AB6: 69 20    ADC  #$20
$8AB8: 0A       ASL  A
$8AB9: 26 05    ROL  $05
$8ABB: 0A       ASL  A
$8ABC: 26 05    ROL  $05
$8ABE: 65 04    ADC  $04
$8AC0: 85 04    STA  $04
$8AC2: A5 05    LDA  $05
$8AC4: 69 00    ADC  #$00
$8AC6: 18       CLC  
$8AC7: 65 03    ADC  $03
$8AC9: 85 05    STA  $05
$8ACB: A4 01    LDY  $01
$8ACD: BD 39 8A LDA  $8A39,X
$8AD0: 99 03 03 STA  $0303,Y
$8AD3: BD 3A 8A LDA  $8A3A,X
$8AD6: 99 04 03 STA  $0304,Y
$8AD9: BD 3B 8A LDA  $8A3B,X
$8ADC: 99 08 03 STA  $0308,Y
$8ADF: BD 3C 8A LDA  $8A3C,X
$8AE2: 99 09 03 STA  $0309,Y
$8AE5: A5 04    LDA  $04
$8AE7: 99 01 03 STA  $0301,Y
$8AEA: 18       CLC  
$8AEB: 69 20    ADC  #$20
$8AED: 99 06 03 STA  $0306,Y
$8AF0: A5 05    LDA  $05
$8AF2: 99 00 03 STA  $0300,Y
$8AF5: 99 05 03 STA  $0305,Y
$8AF8: A9 02    LDA  #$02
$8AFA: 99 02 03 STA  $0302,Y
$8AFD: 99 07 03 STA  $0307,Y
$8B00: A9 00    LDA  #$00
$8B02: 99 0A 03 STA  $030A,Y
$8B05: A6 00    LDX  $00
$8B07: 60       RTS  
$8B08: 10 AC    BPL  $8AB6
$8B0A: 64          .byte $64  ; غير معرّف
$8B0B: 8C 8B 8B STY  $8B8B
$8B0E: 8C 8C 24 STY  $248C
$8B11: 24 24    BIT  $24
$8B13: 24 27    BIT  $27
$8B15: 27          .byte $27  ; غير معرّف
$8B16: 27          .byte $27  ; غير معرّف
$8B17: 27          .byte $27  ; غير معرّف
$8B18: 24 24    BIT  $24
$8B1A: 24 35    BIT  $35
$8B1C: 36 25    ROL  $25,X
$8B1E: 37          .byte $37  ; غير معرّف
$8B1F: 25 24    AND  $24
$8B21: 38       SEC  
$8B22: 24 24    BIT  $24
$8B24: 24 30    BIT  $30
$8B26: 30 26    BMI  $8B4E
$8B28: 26 26    ROL  $26
$8B2A: 34          .byte $34  ; غير معرّف
$8B2B: 26 24    ROL  $24
$8B2D: 31 24    AND  ($24),Y
$8B2F: 32          .byte $32  ; غير معرّف
$8B30: 33          .byte $33  ; غير معرّف
$8B31: 26 24    ROL  $24
$8B33: 33          .byte $33  ; غير معرّف
$8B34: 34          .byte $34  ; غير معرّف
$8B35: 26 26    ROL  $26
$8B37: 26 26    ROL  $26
$8B39: 26 26    ROL  $26
$8B3B: 26 24    ROL  $24
$8B3D: C0 24    CPY  #$24
$8B3F: C0 24    CPY  #$24
$8B41: 7F          .byte $7F  ; غير معرّف
$8B42: 7F          .byte $7F  ; غير معرّف
$8B43: 24 B8    BIT  $B8
$8B45: BA       TSX  
$8B46: B9 BB B8 LDA  $B8BB,Y
$8B49: BC B9 BD LDY  $BDB9,X
$8B4C: BA       TSX  
$8B4D: BC BB BD LDY  $BDBB,X
$8B50: 60       RTS  
$8B51: 64          .byte $64  ; غير معرّف
$8B52: 61 65    ADC  ($65,X)
$8B54: 62          .byte $62  ; غير معرّف
$8B55: 66 63    ROR  $63
$8B57: 67          .byte $67  ; غير معرّف
$8B58: 60       RTS  
$8B59: 64          .byte $64  ; غير معرّف
$8B5A: 61 65    ADC  ($65,X)
$8B5C: 62          .byte $62  ; غير معرّف
$8B5D: 66 63    ROR  $63
$8B5F: 67          .byte $67  ; غير معرّف
$8B60: 68       PLA  
$8B61: 68       PLA  
$8B62: 69 69    ADC  #$69
$8B64: 26 26    ROL  $26
$8B66: 6A       ROR  A
$8B67: 6A       ROR  A
$8B68: 4B          .byte $4B  ; غير معرّف
$8B69: 4C 4D 4E JMP  $4E4D
$8B6C: 4D 4F 4D EOR  $4D4F
$8B6F: 4F          .byte $4F  ; غير معرّف
$8B70: 4D 4E 50 EOR  $504E
$8B73: 51 6B    EOR  ($6B),Y
$8B75: 70 2C    BVS  $8BA3
$8B77: 2D 6C 71 AND  $716C
$8B7A: 6D 72 6E ADC  $6E72
$8B7D: 73          .byte $73  ; غير معرّف
$8B7E: 6F          .byte $6F  ; غير معرّف
$8B7F: 74          .byte $74  ; غير معرّف
$8B80: 86 8A    STX  $8A
$8B82: 87          .byte $87  ; غير معرّف
$8B83: 8B          .byte $8B  ; غير معرّف
$8B84: 88       DEY  
$8B85: 8C 88 8C STY  $8C88
$8B88: 89          .byte $89  ; غير معرّف
$8B89: 8D 69 69 STA  $6969
$8B8C: 8E 91 8F STX  $8F91
$8B8F: 92          .byte $92  ; غير معرّف
$8B90: 26 93    ROL  $93
$8B92: 26 93    ROL  $93
$8B94: 90 94    BCC  $8B2A
$8B96: 69 69    ADC  #$69
$8B98: A4 E9    LDY  $E9
$8B9A: EA       NOP  
$8B9B: EB          .byte $EB  ; غير معرّف
$8B9C: 24 24    BIT  $24
$8B9E: 24 24    BIT  $24
$8BA0: 24 2F    BIT  $2F
$8BA2: 24 3D    BIT  $3D
$8BA4: A2 A2    LDX  #$A2
$8BA6: A3          .byte $A3  ; غير معرّف
$8BA7: A3          .byte $A3  ; غير معرّف
$8BA8: 24 24    BIT  $24
$8BAA: 24 24    BIT  $24
$8BAC: A2 A2    LDX  #$A2
$8BAE: A3          .byte $A3  ; غير معرّف
$8BAF: A3          .byte $A3  ; غير معرّف
$8BB0: 99 24 99 STA  $9924,Y
$8BB3: 24 24    BIT  $24
$8BB5: A2 3E    LDX  #$3E
$8BB7: 3F          .byte $3F  ; غير معرّف
$8BB8: 5B          .byte $5B  ; غير معرّف
$8BB9: 5C          .byte $5C  ; غير معرّف
$8BBA: 24 A3    BIT  $A3
$8BBC: 24 24    BIT  $24
$8BBE: 24 24    BIT  $24
$8BC0: 9D 47 9E STA  $9E47,X
$8BC3: 47          .byte $47  ; غير معرّف
$8BC4: 47          .byte $47  ; غير معرّف
$8BC5: 47          .byte $47  ; غير معرّف
$8BC6: 27          .byte $27  ; غير معرّف
$8BC7: 27          .byte $27  ; غير معرّف
$8BC8: 47          .byte $47  ; غير معرّف
$8BC9: 47          .byte $47  ; غير معرّف
$8BCA: 47          .byte $47  ; غير معرّف
$8BCB: 47          .byte $47  ; غير معرّف
$8BCC: 27          .byte $27  ; غير معرّف
$8BCD: 27          .byte $27  ; غير معرّف
$8BCE: 47          .byte $47  ; غير معرّف
$8BCF: 47          .byte $47  ; غير معرّف
$8BD0: A9 47    LDA  #$47
$8BD2: AA       TAX  
$8BD3: 47          .byte $47  ; غير معرّف
$8BD4: 9B          .byte $9B  ; غير معرّف
$8BD5: 27          .byte $27  ; غير معرّف
$8BD6: 9C          .byte $9C  ; غير معرّف
$8BD7: 27          .byte $27  ; غير معرّف
$8BD8: 27          .byte $27  ; غير معرّف
$8BD9: 27          .byte $27  ; غير معرّف
$8BDA: 27          .byte $27  ; غير معرّف
$8BDB: 27          .byte $27  ; غير معرّف
$8BDC: 52          .byte $52  ; غير معرّف
$8BDD: 52          .byte $52  ; غير معرّف
$8BDE: 52          .byte $52  ; غير معرّف
$8BDF: 52          .byte $52  ; غير معرّف
$8BE0: 80          .byte $80  ; غير معرّف
$8BE1: A0 81    LDY  #$81
$8BE3: A1 BE    LDA  ($BE,X)
$8BE5: BE BF BF LDX  $BFBF,Y
$8BE8: 75 BA    ADC  $BA,X
$8BEA: 76 BB    ROR  $BB,X
$8BEC: BA       TSX  
$8BED: BA       TSX  
$8BEE: BB          .byte $BB  ; غير معرّف
$8BEF: BB          .byte $BB  ; غير معرّف
$8BF0: 45 47    EOR  $47
$8BF2: 45 47    EOR  $47
$8BF4: 47          .byte $47  ; غير معرّف
$8BF5: 47          .byte $47  ; غير معرّف
$8BF6: 47          .byte $47  ; غير معرّف
$8BF7: 47          .byte $47  ; غير معرّف
$8BF8: 45 47    EOR  $47
$8BFA: 45 47    EOR  $47
$8BFC: B4 B6    LDY  $B6,X
$8BFE: B5 B7    LDA  $B7,X
$8C00: 45 47    EOR  $47
$8C02: 45 47    EOR  $47
$8C04: 45 47    EOR  $47
$8C06: 45 47    EOR  $47
$8C08: 45 47    EOR  $47
$8C0A: 45 47    EOR  $47
$8C0C: 45 47    EOR  $47
$8C0E: 45 47    EOR  $47
$8C10: 45 47    EOR  $47
$8C12: 45 47    EOR  $47
$8C14: 47          .byte $47  ; غير معرّف
$8C15: 47          .byte $47  ; غير معرّف
$8C16: 47          .byte $47  ; غير معرّف
$8C17: 47          .byte $47  ; غير معرّف
$8C18: 47          .byte $47  ; غير معرّف
$8C19: 47          .byte $47  ; غير معرّف
$8C1A: 47          .byte $47  ; غير معرّف
$8C1B: 47          .byte $47  ; غير معرّف
$8C1C: 47          .byte $47  ; غير معرّف
$8C1D: 47          .byte $47  ; غير معرّف
$8C1E: 47          .byte $47  ; غير معرّف
$8C1F: 47          .byte $47  ; غير معرّف
$8C20: 47          .byte $47  ; غير معرّف
$8C21: 47          .byte $47  ; غير معرّف
$8C22: 47          .byte $47  ; غير معرّف
$8C23: 47          .byte $47  ; غير معرّف
$8C24: 47          .byte $47  ; غير معرّف
$8C25: 47          .byte $47  ; غير معرّف
$8C26: 47          .byte $47  ; غير معرّف
$8C27: 47          .byte $47  ; غير معرّف
$8C28: 24 24    BIT  $24
$8C2A: 24 24    BIT  $24
$8C2C: 24 24    BIT  $24
$8C2E: 24 24    BIT  $24
$8C30: AB          .byte $AB  ; غير معرّف
$8C31: AC AD AE LDY  $AEAD
$8C34: 5D 5E 5D EOR  $5D5E,X
$8C37: 5E C1 24 LSR  $24C1,X
$8C3A: C1 24    CMP  ($24,X)
$8C3C: C6 C8    DEC  $C8
$8C3E: C7          .byte $C7  ; غير معرّف
$8C3F: C9          .byte $C9  ; غير معرّف
$8C40: CA       DEX  
$8C41: CC CB CD CPY  $CDCB
$8C44: 2A       ROL  A
$8C45: 2A       ROL  A
$8C46: 40       RTI  
$8C47: 40       RTI  
$8C48: 24 24    BIT  $24
$8C4A: 24 24    BIT  $24
$8C4C: 24 47    BIT  $47
$8C4E: 24 47    BIT  $47
$8C50: 82          .byte $82  ; غير معرّف
$8C51: 83          .byte $83  ; غير معرّف
$8C52: 84 85    STY  $85
$8C54: 24 47    BIT  $47
$8C56: 24 47    BIT  $47
$8C58: 86 8A    STX  $8A
$8C5A: 87          .byte $87  ; غير معرّف
$8C5B: 8B          .byte $8B  ; غير معرّف
$8C5C: 8E 91 8F STX  $8F91
$8C5F: 92          .byte $92  ; غير معرّف
$8C60: 24 2F    BIT  $2F
$8C62: 24 3D    BIT  $3D
$8C64: 24 24    BIT  $24
$8C66: 24 35    BIT  $35
$8C68: 36 25    ROL  $25,X
$8C6A: 37          .byte $37  ; غير معرّف
$8C6B: 25 24    AND  $24
$8C6D: 38       SEC  
$8C6E: 24 24    BIT  $24
$8C70: 24 24    BIT  $24
$8C72: 39 24 3A AND  $3A24,Y
$8C75: 24 3B    BIT  $3B
$8C77: 24 3C    BIT  $3C
$8C79: 24 24    BIT  $24
$8C7B: 24 41    BIT  $41
$8C7D: 26 41    ROL  $41
$8C7F: 26 26    ROL  $26
$8C81: 26 26    ROL  $26
$8C83: 26 B0    ROL  $B0
$8C85: B1 B2    LDA  ($B2),Y
$8C87: B3          .byte $B3  ; غير معرّف
$8C88: 77          .byte $77  ; غير معرّف
$8C89: 79 77 79 ADC  $7977,Y
$8C8C: 53          .byte $53  ; غير معرّف
$8C8D: 55 54    EOR  $54,X
$8C8F: 56 53    LSR  $53,X
$8C91: 55 54    EOR  $54,X
$8C93: 56 A5    LSR  $A5,X
$8C95: A7          .byte $A7  ; غير معرّف
$8C96: A6 A8    LDX  $A8
$8C98: C2          .byte $C2  ; غير معرّف
$8C99: C4 C3    CPY  $C3
$8C9B: C5 57    CMP  $57
$8C9D: 59 58 5A EOR  $5A58,Y
$8CA0: 7B          .byte $7B  ; غير معرّف
$8CA1: 7D 7C 7E ADC  $7E7C,X
$8CA4: 3F          .byte $3F  ; غير معرّف
$8CA5: 00       BRK  
$8CA6: 20 0F 15 JSR  $150F
$8CA9: 12          .byte $12  ; غير معرّف
$8CAA: 25 0F    AND  $0F
$8CAC: 3A          .byte $3A  ; غير معرّف
$8CAD: 1A          .byte $1A  ; غير معرّف
$8CAE: 0F          .byte $0F  ; غير معرّف
$8CAF: 0F          .byte $0F  ; غير معرّف
$8CB0: 30 12    BMI  $8CC4
$8CB2: 0F          .byte $0F  ; غير معرّف
$8CB3: 0F          .byte $0F  ; غير معرّف
$8CB4: 27          .byte $27  ; غير معرّف
$8CB5: 12          .byte $12  ; غير معرّف
$8CB6: 0F          .byte $0F  ; غير معرّف
$8CB7: 22          .byte $22  ; غير معرّف
$8CB8: 16 27    ASL  $27,X
$8CBA: 18       CLC  
$8CBB: 0F          .byte $0F  ; غير معرّف
$8CBC: 10 30    BPL  $8CEE
$8CBE: 27          .byte $27  ; غير معرّف
$8CBF: 0F          .byte $0F  ; غير معرّف
$8CC0: 16 30    ASL  $30,X
$8CC2: 27          .byte $27  ; غير معرّف
$8CC3: 0F          .byte $0F  ; غير معرّف
$8CC4: 0F          .byte $0F  ; غير معرّف
$8CC5: 30 10    BMI  $8CD7
$8CC7: 00       BRK  
$8CC8: 3F          .byte $3F  ; غير معرّف
$8CC9: 00       BRK  
$8CCA: 20 0F 29 JSR  $290F
$8CCD: 1A          .byte $1A  ; غير معرّف
$8CCE: 0F          .byte $0F  ; غير معرّف
$8CCF: 0F          .byte $0F  ; غير معرّف
$8CD0: 36 17    ROL  $17,X
$8CD2: 0F          .byte $0F  ; غير معرّف
$8CD3: 0F          .byte $0F  ; غير معرّف
$8CD4: 30 21    BMI  $8CF7
$8CD6: 0F          .byte $0F  ; غير معرّف
$8CD7: 0F          .byte $0F  ; غير معرّف
$8CD8: 27          .byte $27  ; غير معرّف
$8CD9: 17          .byte $17  ; غير معرّف
$8CDA: 0F          .byte $0F  ; غير معرّف
$8CDB: 0F          .byte $0F  ; غير معرّف
$8CDC: 16 27    ASL  $27,X
$8CDE: 18       CLC  
$8CDF: 0F          .byte $0F  ; غير معرّف
$8CE0: 1A          .byte $1A  ; غير معرّف
$8CE1: 30 27    BMI  $8D0A
$8CE3: 0F          .byte $0F  ; غير معرّف
$8CE4: 16 30    ASL  $30,X
$8CE6: 27          .byte $27  ; غير معرّف
$8CE7: 0F          .byte $0F  ; غير معرّف
$8CE8: 0F          .byte $0F  ; غير معرّف
$8CE9: 36 17    ROL  $17,X
$8CEB: 00       BRK  
$8CEC: 3F          .byte $3F  ; غير معرّف
$8CED: 00       BRK  
$8CEE: 20 0F 29 JSR  $290F
$8CF1: 1A          .byte $1A  ; غير معرّف
$8CF2: 09 0F    ORA  #$0F
$8CF4: 3C          .byte $3C  ; غير معرّف
$8CF5: 1C          .byte $1C  ; غير معرّف
$8CF6: 0F          .byte $0F  ; غير معرّف
$8CF7: 0F          .byte $0F  ; غير معرّف
$8CF8: 30 21    BMI  $8D1B
$8CFA: 1C          .byte $1C  ; غير معرّف
$8CFB: 0F          .byte $0F  ; غير معرّف
$8CFC: 27          .byte $27  ; غير معرّف
$8CFD: 17          .byte $17  ; غير معرّف
$8CFE: 1C          .byte $1C  ; غير معرّف
$8CFF: 0F          .byte $0F  ; غير معرّف
$8D00: 16 27    ASL  $27,X
$8D02: 18       CLC  
$8D03: 0F          .byte $0F  ; غير معرّف
$8D04: 1C          .byte $1C  ; غير معرّف
$8D05: 36 17    ROL  $17,X
$8D07: 0F          .byte $0F  ; غير معرّف
$8D08: 16 30    ASL  $30,X
$8D0A: 27          .byte $27  ; غير معرّف
$8D0B: 0F          .byte $0F  ; غير معرّف
$8D0C: 0C          .byte $0C  ; غير معرّف
$8D0D: 3C          .byte $3C  ; غير معرّف
$8D0E: 1C          .byte $1C  ; غير معرّف
$8D0F: 00       BRK  
$8D10: 3F          .byte $3F  ; غير معرّف
$8D11: 00       BRK  
$8D12: 20 0F 30 JSR  $300F
$8D15: 10 00    BPL  $8D17
$8D17: 0F          .byte $0F  ; غير معرّف
$8D18: 30 10    BMI  $8D2A
$8D1A: 00       BRK  
$8D1B: 0F          .byte $0F  ; غير معرّف
$8D1C: 30 16    BMI  $8D34
$8D1E: 00       BRK  
$8D1F: 0F          .byte $0F  ; غير معرّف
$8D20: 27          .byte $27  ; غير معرّف
$8D21: 17          .byte $17  ; غير معرّف
$8D22: 00       BRK  
$8D23: 0F          .byte $0F  ; غير معرّف
$8D24: 16 27    ASL  $27,X
$8D26: 18       CLC  
$8D27: 0F          .byte $0F  ; غير معرّف
$8D28: 1C          .byte $1C  ; غير معرّف
$8D29: 36 17    ROL  $17,X
$8D2B: 0F          .byte $0F  ; غير معرّف
$8D2C: 16 30    ASL  $30,X
$8D2E: 27          .byte $27  ; غير معرّف
$8D2F: 0F          .byte $0F  ; غير معرّف
$8D30: 00       BRK  
$8D31: 30 10    BMI  $8D43
$8D33: 00       BRK  
$8D34: 3F          .byte $3F  ; غير معرّف
$8D35: 00       BRK  
$8D36: 04          .byte $04  ; غير معرّف
$8D37: 22          .byte $22  ; غير معرّف
$8D38: 30 00    BMI  $8D3A
$8D3A: 10 00    BPL  $8D3C
$8D3C: 3F          .byte $3F  ; غير معرّف
$8D3D: 00       BRK  
$8D3E: 04          .byte $04  ; غير معرّف
$8D3F: 0F          .byte $0F  ; غير معرّف
$8D40: 30 00    BMI  $8D42
$8D42: 10 00    BPL  $8D44
$8D44: 3F          .byte $3F  ; غير معرّف
$8D45: 00       BRK  
$8D46: 04          .byte $04  ; غير معرّف
$8D47: 22          .byte $22  ; غير معرّف
$8D48: 27          .byte $27  ; غير معرّف
$8D49: 16 0F    ASL  $0F,X
$8D4B: 00       BRK  
$8D4C: 3F          .byte $3F  ; غير معرّف
$8D4D: 14          .byte $14  ; غير معرّف
$8D4E: 04          .byte $04  ; غير معرّف
$8D4F: 0F          .byte $0F  ; غير معرّف
$8D50: 1A          .byte $1A  ; غير معرّف
$8D51: 30 27    BMI  $8D7A
$8D53: 00       BRK  
$8D54: 25 48    AND  $48
$8D56: 10 1D    BPL  $8D75
$8D58: 11 0A    ORA  ($0A),Y
$8D5A: 17          .byte $17  ; غير معرّف
$8D5B: 14          .byte $14  ; غير معرّف
$8D5C: 24 22    BIT  $22
$8D5E: 18       CLC  
$8D5F: 1E 24 16 ASL  $1624,X
$8D62: 0A       ASL  A
$8D63: 1B          .byte $1B  ; غير معرّف
$8D64: 12          .byte $12  ; غير معرّف
$8D65: 18       CLC  
$8D66: 2B          .byte $2B  ; غير معرّف
$8D67: 00       BRK  
$8D68: 25 48    AND  $48
$8D6A: 10 1D    BPL  $8D89
$8D6C: 11 0A    ORA  ($0A),Y
$8D6E: 17          .byte $17  ; غير معرّف
$8D6F: 14          .byte $14  ; غير معرّف
$8D70: 24 22    BIT  $22
$8D72: 18       CLC  
$8D73: 1E 24 15 ASL  $1524,X
$8D76: 1E 12 10 ASL  $1012,X
$8D79: 12          .byte $12  ; غير معرّف
$8D7A: 2B          .byte $2B  ; غير معرّف
$8D7B: 00       BRK  
$8D7C: 25 C5    AND  $C5
$8D7E: 16 0B    ASL  $0B,X
$8D80: 1E 1D 24 ASL  $241D,X
$8D83: 18       CLC  
$8D84: 1E 1B 24 ASL  $241B,X
$8D87: 19 1B 12 ORA  $121B,Y
$8D8A: 17          .byte $17  ; غير معرّف
$8D8B: 0C          .byte $0C  ; غير معرّف
$8D8C: 0E 1C 1C ASL  $1C1C
$8D8F: 24 12    BIT  $12
$8D91: 1C          .byte $1C  ; غير معرّف
$8D92: 24 12    BIT  $12
$8D94: 17          .byte $17  ; غير معرّف
$8D95: 26 05    ROL  $05
$8D97: 0F          .byte $0F  ; غير معرّف
$8D98: 0A       ASL  A
$8D99: 17          .byte $17  ; غير معرّف
$8D9A: 18       CLC  
$8D9B: 1D 11 0E ORA  $0E11,X
$8D9E: 1B          .byte $1B  ; غير معرّف
$8D9F: 24 0C    BIT  $0C
$8DA1: 0A       ASL  A
$8DA2: 1C          .byte $1C  ; غير معرّف
$8DA3: 1D 15 0E ORA  $0E15,X
$8DA6: 2B          .byte $2B  ; غير معرّف
$8DA7: 00       BRK  
$8DA8: 25 A7    AND  $A7
$8DAA: 13          .byte $13  ; غير معرّف
$8DAB: 22          .byte $22  ; غير معرّف
$8DAC: 18       CLC  
$8DAD: 1E 1B 24 ASL  $241B,X
$8DB0: 1A          .byte $1A  ; غير معرّف
$8DB1: 1E 0E 1C ASL  $1C0E,X
$8DB4: 1D 24 12 ORA  $1224,X
$8DB7: 1C          .byte $1C  ; غير معرّف
$8DB8: 24 18    BIT  $18
$8DBA: 1F          .byte $1F  ; غير معرّف
$8DBB: 0E 1B AF ASL  $AF1B
$8DBE: 00       BRK  
$8DBF: 25 E3    AND  $E3
$8DC1: 1B          .byte $1B  ; غير معرّف
$8DC2: 20 0E 24 JSR  $240E
$8DC5: 19 1B 0E ORA  $0E1B,Y
$8DC8: 1C          .byte $1C  ; غير معرّف
$8DC9: 0E 17 1D ASL  $1D17
$8DCC: 24 22    BIT  $22
$8DCE: 18       CLC  
$8DCF: 1E 24 0A ASL  $0A24,X
$8DD2: 24 17    BIT  $17
$8DD4: 0E 20 24 ASL  $2420
$8DD7: 1A          .byte $1A  ; غير معرّف
$8DD8: 1E 0E 1C ASL  $1C0E,X
$8DDB: 1D AF 00 ORA  $00AF,X
$8DDE: 26 4A    ROL  $4A
$8DE0: 0D 19 1E ORA  $1E19
$8DE3: 1C          .byte $1C  ; غير معرّف
$8DE4: 11 24    ORA  ($24),Y
$8DE6: 0B          .byte $0B  ; غير معرّف
$8DE7: 1E 1D 1D ASL  $1D1D,X
$8DEA: 18       CLC  
$8DEB: 17          .byte $17  ; غير معرّف
$8DEC: 24 0B    BIT  $0B
$8DEE: 00       BRK  
$8DEF: 26 88    ROL  $88
$8DF1: 11 1D    ORA  ($1D),Y
$8DF3: 18       CLC  
$8DF4: 24 1C    BIT  $1C
$8DF6: 0E 15 0E ASL  $0E15
$8DF9: 0C          .byte $0C  ; غير معرّف
$8DFA: 1D 24 0A ORA  $0A24,X
$8DFD: 24 20    BIT  $20
$8DFF: 18       CLC  
$8E00: 1B          .byte $1B  ; غير معرّف
$8E01: 15 0D    ORA  $0D,X
$8E03: 00       BRK  
$8E04: 0A       ASL  A
$8E05: A8       TAY  
$8E06: 68       PLA  
$8E07: 85 04    STA  $04
$8E09: 68       PLA  
$8E0A: 85 05    STA  $05
$8E0C: C8       INY  
$8E0D: B1 04    LDA  ($04),Y
$8E0F: 85 06    STA  $06
$8E11: C8       INY  
$8E12: B1 04    LDA  ($04),Y
$8E14: 85 07    STA  $07
$8E16: 6C 06 00 JMP  ($0006)
$8E19: AD 02 20 LDA  $2002
$8E1C: AD 78 07 LDA  $0778
$8E1F: 09 10    ORA  #$10
$8E21: 29 F0    AND  #$F0
$8E23: 20 ED 8E JSR  $8EED
$8E26: A9 24    LDA  #$24
$8E28: 20 2D 8E JSR  $8E2D
$8E2B: A9 20    LDA  #$20
$8E2D: 8D 06 20 STA  $2006
$8E30: A9 00    LDA  #$00
$8E32: 8D 06 20 STA  $2006
$8E35: A2 04    LDX  #$04
$8E37: A0 C0    LDY  #$C0
$8E39: A9 24    LDA  #$24
$8E3B: 8D 07 20 STA  $2007
$8E3E: 88       DEY  
$8E3F: D0 FA    BNE  $8E3B
$8E41: CA       DEX  
$8E42: D0 F7    BNE  $8E3B
$8E44: A0 40    LDY  #$40
$8E46: 8A       TXA  
$8E47: 8D 00 03 STA  $0300
$8E4A: 8D 01 03 STA  $0301
$8E4D: 8D 07 20 STA  $2007
$8E50: 88       DEY  
$8E51: D0 FA    BNE  $8E4D
$8E53: 8D 3F 07 STA  $073F
$8E56: 8D 40 07 STA  $0740
$8E59: 4C E6 8E JMP  $8EE6
$8E5C: A9 01    LDA  #$01
$8E5E: 8D 16 40 STA  $4016
$8E61: 4A       LSR  A
$8E62: AA       TAX  
$8E63: 8D 16 40 STA  $4016
$8E66: 20 6A 8E JSR  $8E6A
$8E69: E8       INX  
$8E6A: A0 08    LDY  #$08
$8E6C: 48       PHA  
$8E6D: BD 16 40 LDA  $4016,X
$8E70: 85 00    STA  $00
$8E72: 4A       LSR  A
$8E73: 05 00    ORA  $00
$8E75: 4A       LSR  A
$8E76: 68       PLA  
$8E77: 2A       ROL  A
$8E78: 88       DEY  
$8E79: D0 F1    BNE  $8E6C
$8E7B: 9D FC 06 STA  $06FC,X
$8E7E: 48       PHA  
$8E7F: 29 30    AND  #$30
$8E81: 3D 4A 07 AND  $074A,X
$8E84: F0 07    BEQ  $8E8D
$8E86: 68       PLA  
$8E87: 29 CF    AND  #$CF
$8E89: 9D FC 06 STA  $06FC,X
$8E8C: 60       RTS  
$8E8D: 68       PLA  
$8E8E: 9D 4A 07 STA  $074A,X
$8E91: 60       RTS  
$8E92: 8D 06 20 STA  $2006
$8E95: C8       INY  
$8E96: B1 00    LDA  ($00),Y
$8E98: 8D 06 20 STA  $2006
$8E9B: C8       INY  
$8E9C: B1 00    LDA  ($00),Y
$8E9E: 0A       ASL  A
$8E9F: 48       PHA  
$8EA0: AD 78 07 LDA  $0778
$8EA3: 09 04    ORA  #$04
$8EA5: B0 02    BCS  $8EA9
$8EA7: 29 FB    AND  #$FB
$8EA9: 20 ED 8E JSR  $8EED
$8EAC: 68       PLA  
$8EAD: 0A       ASL  A
$8EAE: 90 03    BCC  $8EB3
$8EB0: 09 02    ORA  #$02
$8EB2: C8       INY  
$8EB3: 4A       LSR  A
$8EB4: 4A       LSR  A
$8EB5: AA       TAX  
$8EB6: B0 01    BCS  $8EB9
$8EB8: C8       INY  
$8EB9: B1 00    LDA  ($00),Y
$8EBB: 8D 07 20 STA  $2007
$8EBE: CA       DEX  
$8EBF: D0 F5    BNE  $8EB6
$8EC1: 38       SEC  
$8EC2: 98       TYA  
$8EC3: 65 00    ADC  $00
$8EC5: 85 00    STA  $00
$8EC7: A9 00    LDA  #$00
$8EC9: 65 01    ADC  $01
$8ECB: 85 01    STA  $01
$8ECD: A9 3F    LDA  #$3F
$8ECF: 8D 06 20 STA  $2006
$8ED2: A9 00    LDA  #$00
$8ED4: 8D 06 20 STA  $2006
$8ED7: 8D 06 20 STA  $2006
$8EDA: 8D 06 20 STA  $2006
$8EDD: AE 02 20 LDX  $2002
$8EE0: A0 00    LDY  #$00
$8EE2: B1 00    LDA  ($00),Y
$8EE4: D0 AC    BNE  $8E92
$8EE6: 8D 05 20 STA  $2005
$8EE9: 8D 05 20 STA  $2005
$8EEC: 60       RTS  
$8EED: 8D 00 20 STA  $2000
$8EF0: 8D 78 07 STA  $0778
$8EF3: 60       RTS  
$8EF4: F0 06    BEQ  $8EFC
$8EF6: 62          .byte $62  ; غير معرّف
$8EF7: 06 62    ASL  $62
$8EF9: 06 6D    ASL  $6D
$8EFB: 02          .byte $02  ; غير معرّف
$8EFC: 6D 02 7A ADC  $7A02
$8EFF: 03          .byte $03  ; غير معرّف
$8F00: 06 0C    ASL  $0C
$8F02: 12          .byte $12  ; غير معرّف
$8F03: 18       CLC  
$8F04: 1E 24 85 ASL  $8524,X
$8F07: 00       BRK  
$8F08: 20 11 8F JSR  $8F11
$8F0B: A5 00    LDA  $00
$8F0D: 4A       LSR  A
$8F0E: 4A       LSR  A
$8F0F: 4A       LSR  A
$8F10: 4A       LSR  A
$8F11: 18       CLC  
$8F12: 69 01    ADC  #$01
$8F14: 29 0F    AND  #$0F
$8F16: C9          .byte $C9  ; غير معرّف
$8F17: 06 B0    ASL  $B0
$8F19: 44          .byte $44  ; غير معرّف
$8F1A: 48       PHA  
$8F1B: 0A       ASL  A
$8F1C: A8       TAY  
$8F1D: AE 00 03 LDX  $0300
$8F20: A9 20    LDA  #$20
$8F22: C0 00    CPY  #$00
$8F24: D0 02    BNE  $8F28
$8F26: A9 22    LDA  #$22
$8F28: 9D 01 03 STA  $0301,X
$8F2B: B9 F4 8E LDA  $8EF4,Y
$8F2E: 9D 02 03 STA  $0302,X
$8F31: B9 F5 8E LDA  $8EF5,Y
$8F34: 9D 03 03 STA  $0303,X
$8F37: 85 03    STA  $03
$8F39: 86 02    STX  $02
$8F3B: 68       PLA  
$8F3C: AA       TAX  
$8F3D: BD 00 8F LDA  $8F00,X
$8F40: 38       SEC  
$8F41: F9 F5 8E SBC  $8EF5,Y
$8F44: A8       TAY  
$8F45: A6 02    LDX  $02
$8F47: B9 D7 07 LDA  $07D7,Y
$8F4A: 9D 04 03 STA  $0304,X
$8F4D: E8       INX  
$8F4E: C8       INY  
$8F4F: C6 03    DEC  $03
$8F51: D0 F4    BNE  $8F47
$8F53: A9 00    LDA  #$00
$8F55: 9D 04 03 STA  $0304,X
$8F58: E8       INX  
$8F59: E8       INX  
$8F5A: E8       INX  
$8F5B: 8E 00 03 STX  $0300
$8F5E: 60       RTS  
$8F5F: AD 70 07 LDA  $0770
$8F62: C9          .byte $C9  ; غير معرّف
$8F63: 00       BRK  
$8F64: F0 16    BEQ  $8F7C
$8F66: A2 05    LDX  #$05
$8F68: BD 34 01 LDA  $0134,X
$8F6B: 18       CLC  
$8F6C: 79 D7 07 ADC  $07D7,Y
$8F6F: 30 16    BMI  $8F87
$8F71: C9          .byte $C9  ; غير معرّف
$8F72: 0A       ASL  A
$8F73: B0 19    BCS  $8F8E
$8F75: 99 D7 07 STA  $07D7,Y
$8F78: 88       DEY  
$8F79: CA       DEX  
$8F7A: 10 EC    BPL  $8F68
$8F7C: A9 00    LDA  #$00
$8F7E: A2 06    LDX  #$06
$8F80: 9D 33 01 STA  $0133,X
$8F83: CA       DEX  
$8F84: 10 FA    BPL  $8F80
$8F86: 60       RTS  
$8F87: DE 33 01 DEC  $0133,X
$8F8A: A9 09    LDA  #$09
$8F8C: D0 E7    BNE  $8F75
$8F8E: 38       SEC  
$8F8F: E9 0A    SBC  #$0A
$8F91: FE 33 01 INC  $0133,X
$8F94: 4C 75 8F JMP  $8F75
$8F97: A2 05    LDX  #$05
$8F99: 20 9E 8F JSR  $8F9E
$8F9C: A2 0B    LDX  #$0B
$8F9E: A0 05    LDY  #$05
$8FA0: 38       SEC  
$8FA1: BD DD 07 LDA  $07DD,X
$8FA4: F9 D7 07 SBC  $07D7,Y
$8FA7: CA       DEX  
$8FA8: 88       DEY  
$8FA9: 10 F6    BPL  $8FA1
$8FAB: 90 0E    BCC  $8FBB
$8FAD: E8       INX  
$8FAE: C8       INY  
$8FAF: BD DD 07 LDA  $07DD,X
$8FB2: 99 D7 07 STA  $07D7,Y
$8FB5: E8       INX  
$8FB6: C8       INY  
$8FB7: C0 06    CPY  #$06
$8FB9: 90 F4    BCC  $8FAF
$8FBB: 60       RTS  
$8FBC: 04          .byte $04  ; غير معرّف
$8FBD: 30 48    BMI  $9007
$8FBF: 60       RTS  
$8FC0: 78       SEI  
$8FC1: 90 A8    BCC  $8F6B
$8FC3: C0 D8    CPY  #$D8
$8FC5: E8       INX  
$8FC6: 24 F8    BIT  $F8
$8FC8: FC          .byte $FC  ; غير معرّف
$8FC9: 28       PLP  
$8FCA: 2C 18 FF BIT  $FF18
$8FCD: 23          .byte $23  ; غير معرّف
$8FCE: 58       CLI  
$8FCF: A0 6F    LDY  #$6F
$8FD1: 20 CC 90 JSR  $90CC
$8FD4: A0 1F    LDY  #$1F
$8FD6: 99 B0 07 STA  $07B0,Y
$8FD9: 88       DEY  
$8FDA: 10 FA    BPL  $8FD6
$8FDC: A9 18    LDA  #$18
$8FDE: 8D A2 07 STA  $07A2
$8FE1: 20 03 9C JSR  $9C03
$8FE4: A0 4B    LDY  #$4B
$8FE6: 20 CC 90 JSR  $90CC
$8FE9: A2 21    LDX  #$21
$8FEB: A9 00    LDA  #$00
$8FED: 9D 80 07 STA  $0780,X
$8FF0: CA       DEX  
$8FF1: 10 FA    BPL  $8FED
$8FF3: AD 5B 07 LDA  $075B
$8FF6: AC 52 07 LDY  $0752
$8FF9: F0 03    BEQ  $8FFE
$8FFB: AD 51 07 LDA  $0751
$8FFE: 8D 1A 07 STA  $071A
$9001: 8D 25 07 STA  $0725
$9004: 8D 28 07 STA  $0728
$9007: 20 38 B0 JSR  $B038
$900A: A0 20    LDY  #$20
$900C: 29 01    AND  #$01
$900E: F0 02    BEQ  $9012
$9010: A0 24    LDY  #$24
$9012: 8C 20 07 STY  $0720
$9015: A0 80    LDY  #$80
$9017: 8C 21 07 STY  $0721
$901A: 0A       ASL  A
$901B: 0A       ASL  A
$901C: 0A       ASL  A
$901D: 0A       ASL  A
$901E: 8D A0 06 STA  $06A0
$9021: CE 30 07 DEC  $0730
$9024: CE 31 07 DEC  $0731
$9027: CE 32 07 DEC  $0732
$902A: A9 0B    LDA  #$0B
$902C: 8D 1E 07 STA  $071E
$902F: 20 22 9C JSR  $9C22
$9032: AD 6A 07 LDA  $076A
$9035: D0 10    BNE  $9047
$9037: AD 5F 07 LDA  $075F
$903A: C9          .byte $C9  ; غير معرّف
$903B: 04          .byte $04  ; غير معرّف
$903C: 90 0C    BCC  $904A
$903E: D0 07    BNE  $9047
$9040: AD 5C 07 LDA  $075C
$9043: C9          .byte $C9  ; غير معرّف
$9044: 02          .byte $02  ; غير معرّف
$9045: 90 03    BCC  $904A
$9047: EE CC 06 INC  $06CC
$904A: AD 5B 07 LDA  $075B
$904D: F0 05    BEQ  $9054
$904F: A9 02    LDA  #$02
$9051: 8D 10 07 STA  $0710
$9054: A9 80    LDA  #$80
$9056: 85 FB    STA  $FB
$9058: A9 01    LDA  #$01
$905A: 8D 74 07 STA  $0774
$905D: EE 72 07 INC  $0772
$9060: 60       RTS  
$9061: A9 01    LDA  #$01
$9063: 8D 57 07 STA  $0757
$9066: 8D 54 07 STA  $0754
$9069: A9 02    LDA  #$02
$906B: 8D 5A 07 STA  $075A
$906E: 8D 61 07 STA  $0761
$9071: A9 00    LDA  #$00
$9073: 8D 74 07 STA  $0774
$9076: A8       TAY  
$9077: 99 00 03 STA  $0300,Y
$907A: C8       INY  
$907B: D0 FA    BNE  $9077
$907D: 8D 59 07 STA  $0759
$9080: 8D 69 07 STA  $0769
$9083: 8D 28 07 STA  $0728
$9086: A9 FF    LDA  #$FF
$9088: 8D A0 03 STA  $03A0
$908B: AD 1A 07 LDA  $071A
$908E: 4E 78 07 LSR  $0778
$9091: 29 01    AND  #$01
$9093: 6A       ROR  A
$9094: 2E 78 07 ROL  $0778
$9097: 20 ED 90 JSR  $90ED
$909A: A9 38    LDA  #$38
$909C: 8D E3 06 STA  $06E3
$909F: A9 48    LDA  #$48
$90A1: 8D E2 06 STA  $06E2
$90A4: A9 58    LDA  #$58
$90A6: 8D E1 06 STA  $06E1
$90A9: A2 0E    LDX  #$0E
$90AB: BD BC 8F LDA  $8FBC,X
$90AE: 9D E4 06 STA  $06E4,X
$90B1: CA       DEX  
$90B2: 10 F7    BPL  $90AB
$90B4: A0 03    LDY  #$03
$90B6: B9 CB 8F LDA  $8FCB,Y
$90B9: 99 00 02 STA  $0200,Y
$90BC: 88       DEY  
$90BD: 10 F7    BPL  $90B6
$90BF: 20 AF 92 JSR  $92AF
$90C2: 20 AA 92 JSR  $92AA
$90C5: EE 22 07 INC  $0722
$90C8: EE 72 07 INC  $0772
$90CB: 60       RTS  
$90CC: A2 07    LDX  #$07
$90CE: A9 00    LDA  #$00
$90D0: 85 06    STA  $06
$90D2: 86 07    STX  $07
$90D4: E0 01    CPX  #$01
$90D6: D0 04    BNE  $90DC
$90D8: C0 60    CPY  #$60
$90DA: B0 02    BCS  $90DE
$90DC: 91 06    STA  ($06),Y
$90DE: 88       DEY  
$90DF: C0 FF    CPY  #$FF
$90E1: D0 F1    BNE  $90D4
$90E3: CA       DEX  
$90E4: 10 EC    BPL  $90D2
$90E6: 60       RTS  
$90E7: 02          .byte $02  ; غير معرّف
$90E8: 01 04    ORA  ($04,X)
$90EA: 08       PHP  
$90EB: 10 20    BPL  $910D
$90ED: AD 70 07 LDA  $0770
$90F0: F0 23    BEQ  $9115
$90F2: AD 52 07 LDA  $0752
$90F5: C9          .byte $C9  ; غير معرّف
$90F6: 02          .byte $02  ; غير معرّف
$90F7: F0 0D    BEQ  $9106
$90F9: A0 05    LDY  #$05
$90FB: AD 10 07 LDA  $0710
$90FE: C9          .byte $C9  ; غير معرّف
$90FF: 06 F0    ASL  $F0
$9101: 0E C9 07 ASL  $07C9
$9104: F0 0A    BEQ  $9110
$9106: AC 4E 07 LDY  $074E
$9109: AD 43 07 LDA  $0743
$910C: F0 02    BEQ  $9110
$910E: A0 04    LDY  #$04
$9110: B9 E7 90 LDA  $90E7,Y
$9113: 85 FB    STA  $FB
$9115: 60       RTS  
$9116: 28       PLP  
$9117: 18       CLC  
$9118: 38       SEC  
$9119: 28       PLP  
$911A: 08       PHP  
$911B: 00       BRK  
$911C: 00       BRK  
$911D: 20 B0 50 JSR  $50B0
$9120: 00       BRK  
$9121: 00       BRK  
$9122: B0 B0    BCS  $90D4
$9124: F0 00    BEQ  $9126
$9126: 20 00 00 JSR  $0000
$9129: 00       BRK  
$912A: 00       BRK  
$912B: 00       BRK  
$912C: 00       BRK  
$912D: 20 04 03 JSR  $0304
$9130: 02          .byte $02  ; غير معرّف
$9131: AD 1A 07 LDA  $071A
$9134: 85 6D    STA  $6D
$9136: A9 28    LDA  #$28
$9138: 8D 0A 07 STA  $070A
$913B: A9 01    LDA  #$01
$913D: 85 33    STA  $33
$913F: 85 B5    STA  $B5
$9141: A9 00    LDA  #$00
$9143: 85 1D    STA  $1D
$9145: CE 90 04 DEC  $0490
$9148: A0 00    LDY  #$00
$914A: 8C 5B 07 STY  $075B
$914D: AD 4E 07 LDA  $074E
$9150: D0 01    BNE  $9153
$9152: C8       INY  
$9153: 8C 04 07 STY  $0704
$9156: AE 10 07 LDX  $0710
$9159: AC 52 07 LDY  $0752
$915C: F0 07    BEQ  $9165
$915E: C0 01    CPY  #$01
$9160: F0 03    BEQ  $9165
$9162: BE 18 91 LDX  $9118,Y
$9165: B9 16 91 LDA  $9116,Y
$9168: 85 86    STA  $86
$916A: BD 1C 91 LDA  $911C,X
$916D: 85 CE    STA  $CE
$916F: BD 25 91 LDA  $9125,X
$9172: 8D C4 03 STA  $03C4
$9175: 20 F1 85 JSR  $85F1
$9178: AC 15 07 LDY  $0715
$917B: F0 1A    BEQ  $9197
$917D: AD 57 07 LDA  $0757
$9180: F0 15    BEQ  $9197
$9182: B9 2D 91 LDA  $912D,Y
$9185: 8D F8 07 STA  $07F8
$9188: A9 01    LDA  #$01
$918A: 8D FA 07 STA  $07FA
$918D: 4A       LSR  A
$918E: 8D F9 07 STA  $07F9
$9191: 8D 57 07 STA  $0757
$9194: 8D 9F 07 STA  $079F
$9197: AC 58 07 LDY  $0758
$919A: F0 14    BEQ  $91B0
$919C: A9 03    LDA  #$03
$919E: 85 1D    STA  $1D
$91A0: A2 00    LDX  #$00
$91A2: 20 84 BD JSR  $BD84
$91A5: A9 F0    LDA  #$F0
$91A7: 85 D7    STA  $D7
$91A9: A2 05    LDX  #$05
$91AB: A0 00    LDY  #$00
$91AD: 20 1E B9 JSR  $B91E
$91B0: AC 4E 07 LDY  $074E
$91B3: D0 03    BNE  $91B8
$91B5: 20 0B B7 JSR  $B70B
$91B8: A9 07    LDA  #$07
$91BA: 85 0E    STA  $0E
$91BC: 60       RTS  
$91BD: 56 40    LSR  $40,X
$91BF: 65 70    ADC  $70
$91C1: 66 40    ROR  $40
$91C3: 66 40    ROR  $40
$91C5: 66 40    ROR  $40
$91C7: 66 60    ROR  $60
$91C9: 65 70    ADC  $70
$91CB: 00       BRK  
$91CC: 00       BRK  
$91CD: EE 74 07 INC  $0774
$91D0: A9 00    LDA  #$00
$91D2: 8D 22 07 STA  $0722
$91D5: A9 80    LDA  #$80
$91D7: 85 FC    STA  $FC
$91D9: CE 5A 07 DEC  $075A
$91DC: 10 0B    BPL  $91E9
$91DE: A9 00    LDA  #$00
$91E0: 8D 72 07 STA  $0772
$91E3: A9 03    LDA  #$03
$91E5: 8D 70 07 STA  $0770
$91E8: 60       RTS  
$91E9: AD 5F 07 LDA  $075F
$91EC: 0A       ASL  A
$91ED: AA       TAX  
$91EE: AD 5C 07 LDA  $075C
$91F1: 29 02    AND  #$02
$91F3: F0 01    BEQ  $91F6
$91F5: E8       INX  
$91F6: BC BD 91 LDY  $91BD,X
$91F9: AD 5C 07 LDA  $075C
$91FC: 4A       LSR  A
$91FD: 98       TYA  
$91FE: B0 04    BCS  $9204
$9200: 4A       LSR  A
$9201: 4A       LSR  A
$9202: 4A       LSR  A
$9203: 4A       LSR  A
$9204: 29 0F    AND  #$0F
$9206: CD 1A 07 CMP  $071A
$9209: F0 04    BEQ  $920F
$920B: 90 02    BCC  $920F
$920D: A9 00    LDA  #$00
$920F: 8D 5B 07 STA  $075B
$9212: 20 82 92 JSR  $9282
$9215: 4C 64 92 JMP  $9264
$9218: AD 72 07 LDA  $0772
$921B: 20 04 8E JSR  $8E04
$921E: 24 92    BIT  $92
$9220: 67          .byte $67  ; غير معرّف
$9221: 85 37    STA  $37
$9223: 92          .byte $92  ; غير معرّف
$9224: A9 00    LDA  #$00
$9226: 8D 3C 07 STA  $073C
$9229: 8D 22 07 STA  $0722
$922C: A9 02    LDA  #$02
$922E: 85 FC    STA  $FC
$9230: EE 74 07 INC  $0774
$9233: EE 72 07 INC  $0772
$9236: 60       RTS  
$9237: A9 00    LDA  #$00
$9239: 8D 74 07 STA  $0774
$923C: AD FC 06 LDA  $06FC
$923F: 29 10    AND  #$10
$9241: D0 05    BNE  $9248
$9243: AD A0 07 LDA  $07A0
$9246: D0 39    BNE  $9281
$9248: A9 80    LDA  #$80
$924A: 85 FC    STA  $FC
$924C: 20 82 92 JSR  $9282
$924F: 90 13    BCC  $9264
$9251: AD 5F 07 LDA  $075F
$9254: 8D FD 07 STA  $07FD
$9257: A9 00    LDA  #$00
$9259: 0A       ASL  A
$925A: 8D 72 07 STA  $0772
$925D: 8D A0 07 STA  $07A0
$9260: 8D 70 07 STA  $0770
$9263: 60       RTS  
$9264: 20 03 9C JSR  $9C03
$9267: A9 01    LDA  #$01
$9269: 8D 54 07 STA  $0754
$926C: EE 57 07 INC  $0757
$926F: A9 00    LDA  #$00
$9271: 8D 47 07 STA  $0747
$9274: 8D 56 07 STA  $0756
$9277: 85 0E    STA  $0E
$9279: 8D 72 07 STA  $0772
$927C: A9 01    LDA  #$01
$927E: 8D 70 07 STA  $0770
$9281: 60       RTS  
$9282: 38       SEC  
$9283: AD 7A 07 LDA  $077A
$9286: F0 21    BEQ  $92A9
$9288: AD 61 07 LDA  $0761
$928B: 30 1C    BMI  $92A9
$928D: AD 53 07 LDA  $0753
$9290: 49 01    EOR  #$01
$9292: 8D 53 07 STA  $0753
$9295: A2 06    LDX  #$06
$9297: BD 5A 07 LDA  $075A,X
$929A: 48       PHA  
$929B: BD 61 07 LDA  $0761,X
$929E: 9D 5A 07 STA  $075A,X
$92A1: 68       PLA  
$92A2: 9D 61 07 STA  $0761,X
$92A5: CA       DEX  
$92A6: 10 EF    BPL  $9297
$92A8: 18       CLC  
$92A9: 60       RTS  
$92AA: A9 FF    LDA  #$FF
$92AC: 8D C9 06 STA  $06C9
$92AF: 60       RTS  
$92B0: AC 1F 07 LDY  $071F
$92B3: D0 05    BNE  $92BA
$92B5: A0 08    LDY  #$08
$92B7: 8C 1F 07 STY  $071F
$92BA: 88       DEY  
$92BB: 98       TYA  
$92BC: 20 C8 92 JSR  $92C8
$92BF: CE 1F 07 DEC  $071F
$92C2: D0 03    BNE  $92C7
$92C4: 20 6A 89 JSR  $896A
$92C7: 60       RTS  
$92C8: 20 04 8E JSR  $8E04
$92CB: DB          .byte $DB  ; غير معرّف
$92CC: 92          .byte $92  ; غير معرّف
$92CD: AE 88 AE LDX  $AE88
$92D0: 88       DEY  
$92D1: FC          .byte $FC  ; غير معرّف
$92D2: 93          .byte $93  ; غير معرّف
$92D3: DB          .byte $DB  ; غير معرّف
$92D4: 92          .byte $92  ; غير معرّف
$92D5: AE 88 AE LDX  $AE88
$92D8: 88       DEY  
$92D9: FC          .byte $FC  ; غير معرّف
$92DA: 93          .byte $93  ; غير معرّف
$92DB: EE 26 07 INC  $0726
$92DE: AD 26 07 LDA  $0726
$92E1: 29 0F    AND  #$0F
$92E3: D0 06    BNE  $92EB
$92E5: 8D 26 07 STA  $0726
$92E8: EE 25 07 INC  $0725
$92EB: EE A0 06 INC  $06A0
$92EE: AD A0 06 LDA  $06A0
$92F1: 29 1F    AND  #$1F
$92F3: 8D A0 06 STA  $06A0
$92F6: 60       RTS  
$92F7: 00       BRK  
$92F8: 30 60    BMI  $935A
$92FA: 93          .byte $93  ; غير معرّف
$92FB: 00       BRK  
$92FC: 00       BRK  
$92FD: 11 12    ORA  ($12),Y
$92FF: 12          .byte $12  ; غير معرّف
$9300: 13          .byte $13  ; غير معرّف
$9301: 00       BRK  
$9302: 00       BRK  
$9303: 51 52    EOR  ($52),Y
$9305: 53          .byte $53  ; غير معرّف
$9306: 00       BRK  
$9307: 00       BRK  
$9308: 00       BRK  
$9309: 00       BRK  
$930A: 00       BRK  
$930B: 00       BRK  
$930C: 01 02    ORA  ($02,X)
$930E: 02          .byte $02  ; غير معرّف
$930F: 03          .byte $03  ; غير معرّف
$9310: 00       BRK  
$9311: 00       BRK  
$9312: 00       BRK  
$9313: 00       BRK  
$9314: 00       BRK  
$9315: 00       BRK  
$9316: 91 92    STA  ($92),Y
$9318: 93          .byte $93  ; غير معرّف
$9319: 00       BRK  
$931A: 00       BRK  
$931B: 00       BRK  
$931C: 00       BRK  
$931D: 51 52    EOR  ($52),Y
$931F: 53          .byte $53  ; غير معرّف
$9320: 41 42    EOR  ($42,X)
$9322: 43          .byte $43  ; غير معرّف
$9323: 00       BRK  
$9324: 00       BRK  
$9325: 00       BRK  
$9326: 00       BRK  
$9327: 00       BRK  
$9328: 91 92    STA  ($92),Y
$932A: 97          .byte $97  ; غير معرّف
$932B: 87          .byte $87  ; غير معرّف
$932C: 88       DEY  
$932D: 89          .byte $89  ; غير معرّف
$932E: 99 00 00 STA  $0000,Y
$9331: 00       BRK  
$9332: 11 12    ORA  ($12),Y
$9334: 13          .byte $13  ; غير معرّف
$9335: A4 A5    LDY  $A5
$9337: A5 A5    LDA  $A5
$9339: A6 97    LDX  $97
$933B: 98       TYA  
$933C: 99 01 02 STA  $0201,Y
$933F: 03          .byte $03  ; غير معرّف
$9340: 00       BRK  
$9341: A4 A5    LDY  $A5
$9343: A6 00    LDX  $00
$9345: 11 12    ORA  ($12),Y
$9347: 12          .byte $12  ; غير معرّف
$9348: 12          .byte $12  ; غير معرّف
$9349: 13          .byte $13  ; غير معرّف
$934A: 00       BRK  
$934B: 00       BRK  
$934C: 00       BRK  
$934D: 00       BRK  
$934E: 01 02    ORA  ($02,X)
$9350: 02          .byte $02  ; غير معرّف
$9351: 03          .byte $03  ; غير معرّف
$9352: 00       BRK  
$9353: A4 A5    LDY  $A5
$9355: A5 A6    LDA  $A6
$9357: 00       BRK  
$9358: 00       BRK  
$9359: 00       BRK  
$935A: 11 12    ORA  ($12),Y
$935C: 12          .byte $12  ; غير معرّف
$935D: 13          .byte $13  ; غير معرّف
$935E: 00       BRK  
$935F: 00       BRK  
$9360: 00       BRK  
$9361: 00       BRK  
$9362: 00       BRK  
$9363: 00       BRK  
$9364: 00       BRK  
$9365: 9C          .byte $9C  ; غير معرّف
$9366: 00       BRK  
$9367: 8B          .byte $8B  ; غير معرّف
$9368: AA       TAX  
$9369: AA       TAX  
$936A: AA       TAX  
$936B: AA       TAX  
$936C: 11 12    ORA  ($12),Y
$936E: 13          .byte $13  ; غير معرّف
$936F: 8B          .byte $8B  ; غير معرّف
$9370: 00       BRK  
$9371: 9C          .byte $9C  ; غير معرّف
$9372: 9C          .byte $9C  ; غير معرّف
$9373: 00       BRK  
$9374: 00       BRK  
$9375: 01 02    ORA  ($02,X)
$9377: 03          .byte $03  ; غير معرّف
$9378: 11 12    ORA  ($12),Y
$937A: 12          .byte $12  ; غير معرّف
$937B: 13          .byte $13  ; غير معرّف
$937C: 00       BRK  
$937D: 00       BRK  
$937E: 00       BRK  
$937F: 00       BRK  
$9380: AA       TAX  
$9381: AA       TAX  
$9382: 9C          .byte $9C  ; غير معرّف
$9383: AA       TAX  
$9384: 00       BRK  
$9385: 8B          .byte $8B  ; غير معرّف
$9386: 00       BRK  
$9387: 01 02    ORA  ($02,X)
$9389: 03          .byte $03  ; غير معرّف
$938A: 80          .byte $80  ; غير معرّف
$938B: 83          .byte $83  ; غير معرّف
$938C: 00       BRK  
$938D: 81 84    STA  ($84,X)
$938F: 00       BRK  
$9390: 82          .byte $82  ; غير معرّف
$9391: 85 00    STA  $00
$9393: 02          .byte $02  ; غير معرّف
$9394: 00       BRK  
$9395: 00       BRK  
$9396: 03          .byte $03  ; غير معرّف
$9397: 00       BRK  
$9398: 00       BRK  
$9399: 04          .byte $04  ; غير معرّف
$939A: 00       BRK  
$939B: 00       BRK  
$939C: 00       BRK  
$939D: 05 06    ORA  $06
$939F: 07          .byte $07  ; غير معرّف
$93A0: 06 0A    ASL  $0A
$93A2: 00       BRK  
$93A3: 08       PHP  
$93A4: 09 4D    ORA  #$4D
$93A6: 00       BRK  
$93A7: 00       BRK  
$93A8: 0D 0F 4E ORA  $4E0F
$93AB: 0E 4E 4E ASL  $4E4E
$93AE: 00       BRK  
$93AF: 0D 1A 86 ORA  $861A
$93B2: 87          .byte $87  ; غير معرّف
$93B3: 87          .byte $87  ; غير معرّف
$93B4: 87          .byte $87  ; غير معرّف
$93B5: 87          .byte $87  ; غير معرّف
$93B6: 87          .byte $87  ; غير معرّف
$93B7: 87          .byte $87  ; غير معرّف
$93B8: 87          .byte $87  ; غير معرّف
$93B9: 87          .byte $87  ; غير معرّف
$93BA: 87          .byte $87  ; غير معرّف
$93BB: 87          .byte $87  ; غير معرّف
$93BC: 69 69    ADC  #$69
$93BE: 00       BRK  
$93BF: 00       BRK  
$93C0: 00       BRK  
$93C1: 00       BRK  
$93C2: 00       BRK  
$93C3: 45 47    EOR  $47
$93C5: 47          .byte $47  ; غير معرّف
$93C6: 47          .byte $47  ; غير معرّف
$93C7: 47          .byte $47  ; غير معرّف
$93C8: 47          .byte $47  ; غير معرّف
$93C9: 00       BRK  
$93CA: 00       BRK  
$93CB: 00       BRK  
$93CC: 00       BRK  
$93CD: 00       BRK  
$93CE: 00       BRK  
$93CF: 00       BRK  
$93D0: 00       BRK  
$93D1: 00       BRK  
$93D2: 00       BRK  
$93D3: 00       BRK  
$93D4: 00       BRK  
$93D5: 00       BRK  
$93D6: 86 87    STX  $87
$93D8: 69 54    ADC  #$54
$93DA: 52          .byte $52  ; غير معرّف
$93DB: 62          .byte $62  ; غير معرّف
$93DC: 00       BRK  
$93DD: 00       BRK  
$93DE: 00       BRK  
$93DF: 18       CLC  
$93E0: 01 18    ORA  ($18,X)
$93E2: 07          .byte $07  ; غير معرّف
$93E3: 18       CLC  
$93E4: 0F          .byte $0F  ; غير معرّف
$93E5: 18       CLC  
$93E6: FF          .byte $FF  ; غير معرّف
$93E7: 18       CLC  
$93E8: 01 1F    ORA  ($1F,X)
$93EA: 07          .byte $07  ; غير معرّف
$93EB: 1F          .byte $1F  ; غير معرّف
$93EC: 0F          .byte $0F  ; غير معرّف
$93ED: 1F          .byte $1F  ; غير معرّف
$93EE: 81 1F    STA  ($1F,X)
$93F0: 01 00    ORA  ($00,X)
$93F2: 8F          .byte $8F  ; غير معرّف
$93F3: 1F          .byte $1F  ; غير معرّف
$93F4: F1 1F    SBC  ($1F),Y
$93F6: F9 18 F1 SBC  $F118,Y
$93F9: 18       CLC  
$93FA: FF          .byte $FF  ; غير معرّف
$93FB: 1F          .byte $1F  ; غير معرّف
$93FC: AD 28 07 LDA  $0728
$93FF: F0 03    BEQ  $9404
$9401: 20 08 95 JSR  $9508
$9404: A2 0C    LDX  #$0C
$9406: A9 00    LDA  #$00
$9408: 9D A1 06 STA  $06A1,X
$940B: CA       DEX  
$940C: 10 FA    BPL  $9408
$940E: AC 42 07 LDY  $0742
$9411: F0 42    BEQ  $9455
$9413: AD 25 07 LDA  $0725
$9416: C9          .byte $C9  ; غير معرّف
$9417: 03          .byte $03  ; غير معرّف
$9418: 30 05    BMI  $941F
$941A: 38       SEC  
$941B: E9 03    SBC  #$03
$941D: 10 F7    BPL  $9416
$941F: 0A       ASL  A
$9420: 0A       ASL  A
$9421: 0A       ASL  A
$9422: 0A       ASL  A
$9423: 79 F6 92 ADC  $92F6,Y
$9426: 6D 26 07 ADC  $0726
$9429: AA       TAX  
$942A: BD FA 92 LDA  $92FA,X
$942D: F0 26    BEQ  $9455
$942F: 48       PHA  
$9430: 29 0F    AND  #$0F
$9432: 38       SEC  
$9433: E9 01    SBC  #$01
$9435: 85 00    STA  $00
$9437: 0A       ASL  A
$9438: 65 00    ADC  $00
$943A: AA       TAX  
$943B: 68       PLA  
$943C: 4A       LSR  A
$943D: 4A       LSR  A
$943E: 4A       LSR  A
$943F: 4A       LSR  A
$9440: A8       TAY  
$9441: A9 03    LDA  #$03
$9443: 85 00    STA  $00
$9445: BD 8A 93 LDA  $938A,X
$9448: 99 A1 06 STA  $06A1,Y
$944B: E8       INX  
$944C: C8       INY  
$944D: C0 0B    CPY  #$0B
$944F: F0 04    BEQ  $9455
$9451: C6 00    DEC  $00
$9453: D0 F0    BNE  $9445
$9455: AE 41 07 LDX  $0741
$9458: F0 13    BEQ  $946D
$945A: BC AD 93 LDY  $93AD,X
$945D: A2 00    LDX  #$00
$945F: B9 B1 93 LDA  $93B1,Y
$9462: F0 03    BEQ  $9467
$9464: 9D A1 06 STA  $06A1,X
$9467: C8       INY  
$9468: E8       INX  
$9469: E0 0D    CPX  #$0D
$946B: D0 F2    BNE  $945F
$946D: AC 4E 07 LDY  $074E
$9470: D0 0C    BNE  $947E
$9472: AD 5F 07 LDA  $075F
$9475: C9          .byte $C9  ; غير معرّف
$9476: 07          .byte $07  ; غير معرّف
$9477: D0 05    BNE  $947E
$9479: A9 62    LDA  #$62
$947B: 4C 88 94 JMP  $9488
$947E: B9 D8 93 LDA  $93D8,Y
$9481: AC 43 07 LDY  $0743
$9484: F0 02    BEQ  $9488
$9486: A9 88    LDA  #$88
$9488: 85 07    STA  $07
$948A: A2 00    LDX  #$00
$948C: AD 27 07 LDA  $0727
$948F: 0A       ASL  A
$9490: A8       TAY  
$9491: B9 DC 93 LDA  $93DC,Y
$9494: 85 00    STA  $00
$9496: C8       INY  
$9497: 84 01    STY  $01
$9499: AD 43 07 LDA  $0743
$949C: F0 0A    BEQ  $94A8
$949E: E0 00    CPX  #$00
$94A0: F0 06    BEQ  $94A8
$94A2: A5 00    LDA  $00
$94A4: 29 08    AND  #$08
$94A6: 85 00    STA  $00
$94A8: A0 00    LDY  #$00
$94AA: B9 8A C6 LDA  $C68A,Y
$94AD: 24 00    BIT  $00
$94AF: F0 05    BEQ  $94B6
$94B1: A5 07    LDA  $07
$94B3: 9D A1 06 STA  $06A1,X
$94B6: E8       INX  
$94B7: E0 0D    CPX  #$0D
$94B9: F0 18    BEQ  $94D3
$94BB: AD 4E 07 LDA  $074E
$94BE: C9          .byte $C9  ; غير معرّف
$94BF: 02          .byte $02  ; غير معرّف
$94C0: D0 08    BNE  $94CA
$94C2: E0 0B    CPX  #$0B
$94C4: D0 04    BNE  $94CA
$94C6: A9 54    LDA  #$54
$94C8: 85 07    STA  $07
$94CA: C8       INY  
$94CB: C0 08    CPY  #$08
$94CD: D0 DB    BNE  $94AA
$94CF: A4 01    LDY  $01
$94D1: D0 BE    BNE  $9491
$94D3: 20 08 95 JSR  $9508
$94D6: AD A0 06 LDA  $06A0
$94D9: 20 E1 9B JSR  $9BE1
$94DC: A2 00    LDX  #$00
$94DE: A0 00    LDY  #$00
$94E0: 84 00    STY  $00
$94E2: BD A1 06 LDA  $06A1,X
$94E5: 29 C0    AND  #$C0
$94E7: 0A       ASL  A
$94E8: 2A       ROL  A
$94E9: 2A       ROL  A
$94EA: A8       TAY  
$94EB: BD A1 06 LDA  $06A1,X
$94EE: D9 04 95 CMP  $9504,Y
$94F1: B0 02    BCS  $94F5
$94F3: A9 00    LDA  #$00
$94F5: A4 00    LDY  $00
$94F7: 91 06    STA  ($06),Y
$94F9: 98       TYA  
$94FA: 18       CLC  
$94FB: 69 10    ADC  #$10
$94FD: A8       TAY  
$94FE: E8       INX  
$94FF: E0 0D    CPX  #$0D
$9501: 90 DD    BCC  $94E0
$9503: 60       RTS  
$9504: 10 51    BPL  $9557
$9506: 88       DEY  
$9507: C0 A2    CPY  #$A2
$9509: 02          .byte $02  ; غير معرّف
$950A: 86 08    STX  $08
$950C: A9 00    LDA  #$00
$950E: 8D 29 07 STA  $0729
$9511: AC 2C 07 LDY  $072C
$9514: B1 E7    LDA  ($E7),Y
$9516: C9          .byte $C9  ; غير معرّف
$9517: FD F0 4B SBC  $4BF0,X
$951A: BD 30 07 LDA  $0730,X
$951D: 10 46    BPL  $9565
$951F: C8       INY  
$9520: B1 E7    LDA  ($E7),Y
$9522: 0A       ASL  A
$9523: 90 0B    BCC  $9530
$9525: AD 2B 07 LDA  $072B
$9528: D0 06    BNE  $9530
$952A: EE 2B 07 INC  $072B
$952D: EE 2A 07 INC  $072A
$9530: 88       DEY  
$9531: B1 E7    LDA  ($E7),Y
$9533: 29 0F    AND  #$0F
$9535: C9          .byte $C9  ; غير معرّف
$9536: 0D D0 1B ORA  $1BD0
$9539: C8       INY  
$953A: B1 E7    LDA  ($E7),Y
$953C: 88       DEY  
$953D: 29 40    AND  #$40
$953F: D0 1C    BNE  $955D
$9541: AD 2B 07 LDA  $072B
$9544: D0 17    BNE  $955D
$9546: C8       INY  
$9547: B1 E7    LDA  ($E7),Y
$9549: 29 1F    AND  #$1F
$954B: 8D 2A 07 STA  $072A
$954E: EE 2B 07 INC  $072B
$9551: 4C 6E 95 JMP  $956E
$9554: C9          .byte $C9  ; غير معرّف
$9555: 0E D0 05 ASL  $05D0
$9558: AD 28 07 LDA  $0728
$955B: D0 08    BNE  $9565
$955D: AD 2A 07 LDA  $072A
$9560: CD 25 07 CMP  $0725
$9563: 90 06    BCC  $956B
$9565: 20 95 95 JSR  $9595
$9568: 4C 71 95 JMP  $9571
$956B: EE 29 07 INC  $0729
$956E: 20 89 95 JSR  $9589
$9571: A6 08    LDX  $08
$9573: BD 30 07 LDA  $0730,X
$9576: 30 03    BMI  $957B
$9578: DE 30 07 DEC  $0730,X
$957B: CA       DEX  
$957C: 10 8C    BPL  $950A
$957E: AD 29 07 LDA  $0729
$9581: D0 85    BNE  $9508
$9583: AD 28 07 LDA  $0728
$9586: D0 80    BNE  $9508
$9588: 60       RTS  
$9589: EE 2C 07 INC  $072C
$958C: EE 2C 07 INC  $072C
$958F: A9 00    LDA  #$00
$9591: 8D 2B 07 STA  $072B
$9594: 60       RTS  
$9595: BD 30 07 LDA  $0730,X
$9598: 30 03    BMI  $959D
$959A: BC 2D 07 LDY  $072D,X
$959D: A2 10    LDX  #$10
$959F: B1 E7    LDA  ($E7),Y
$95A1: C9          .byte $C9  ; غير معرّف
$95A2: FD F0 E3 SBC  $E3F0,X
$95A5: 29 0F    AND  #$0F
$95A7: C9          .byte $C9  ; غير معرّف
$95A8: 0F          .byte $0F  ; غير معرّف
$95A9: F0 08    BEQ  $95B3
$95AB: A2 08    LDX  #$08
$95AD: C9          .byte $C9  ; غير معرّف
$95AE: 0C          .byte $0C  ; غير معرّف
$95AF: F0 02    BEQ  $95B3
$95B1: A2 00    LDX  #$00
$95B3: 86 07    STX  $07
$95B5: A6 08    LDX  $08
$95B7: C9          .byte $C9  ; غير معرّف
$95B8: 0E D0 08 ASL  $08D0
$95BB: A9 00    LDA  #$00
$95BD: 85 07    STA  $07
$95BF: A9 2E    LDA  #$2E
$95C1: D0 53    BNE  $9616
$95C3: C9          .byte $C9  ; غير معرّف
$95C4: 0D D0 1B ORA  $1BD0
$95C7: A9 22    LDA  #$22
$95C9: 85 07    STA  $07
$95CB: C8       INY  
$95CC: B1 E7    LDA  ($E7),Y
$95CE: 29 40    AND  #$40
$95D0: F0 63    BEQ  $9635
$95D2: B1 E7    LDA  ($E7),Y
$95D4: 29 7F    AND  #$7F
$95D6: C9          .byte $C9  ; غير معرّف
$95D7: 4B          .byte $4B  ; غير معرّف
$95D8: D0 03    BNE  $95DD
$95DA: EE 45 07 INC  $0745
$95DD: 29 3F    AND  #$3F
$95DF: 4C 16 96 JMP  $9616
$95E2: C9          .byte $C9  ; غير معرّف
$95E3: 0C          .byte $0C  ; غير معرّف
$95E4: B0 27    BCS  $960D
$95E6: C8       INY  
$95E7: B1 E7    LDA  ($E7),Y
$95E9: 29 70    AND  #$70
$95EB: D0 0B    BNE  $95F8
$95ED: A9 16    LDA  #$16
$95EF: 85 07    STA  $07
$95F1: B1 E7    LDA  ($E7),Y
$95F3: 29 0F    AND  #$0F
$95F5: 4C 16 96 JMP  $9616
$95F8: 85 00    STA  $00
$95FA: C9          .byte $C9  ; غير معرّف
$95FB: 70 D0    BVS  $95CD
$95FD: 0A       ASL  A
$95FE: B1 E7    LDA  ($E7),Y
$9600: 29 08    AND  #$08
$9602: F0 04    BEQ  $9608
$9604: A9 00    LDA  #$00
$9606: 85 00    STA  $00
$9608: A5 00    LDA  $00
$960A: 4C 12 96 JMP  $9612
$960D: C8       INY  
$960E: B1 E7    LDA  ($E7),Y
$9610: 29 70    AND  #$70
$9612: 4A       LSR  A
$9613: 4A       LSR  A
$9614: 4A       LSR  A
$9615: 4A       LSR  A
$9616: 85 00    STA  $00
$9618: BD 30 07 LDA  $0730,X
$961B: 10 42    BPL  $965F
$961D: AD 2A 07 LDA  $072A
$9620: CD 25 07 CMP  $0725
$9623: F0 11    BEQ  $9636
$9625: AC 2C 07 LDY  $072C
$9628: B1 E7    LDA  ($E7),Y
$962A: 29 0F    AND  #$0F
$962C: C9          .byte $C9  ; غير معرّف
$962D: 0E D0 05 ASL  $05D0
$9630: AD 28 07 LDA  $0728
$9633: D0 21    BNE  $9656
$9635: 60       RTS  
$9636: AD 28 07 LDA  $0728
$9639: F0 0B    BEQ  $9646
$963B: A9 00    LDA  #$00
$963D: 8D 28 07 STA  $0728
$9640: 8D 29 07 STA  $0729
$9643: 85 08    STA  $08
$9645: 60       RTS  
$9646: AC 2C 07 LDY  $072C
$9649: B1 E7    LDA  ($E7),Y
$964B: 29 F0    AND  #$F0
$964D: 4A       LSR  A
$964E: 4A       LSR  A
$964F: 4A       LSR  A
$9650: 4A       LSR  A
$9651: CD 26 07 CMP  $0726
$9654: D0 DF    BNE  $9635
$9656: AD 2C 07 LDA  $072C
$9659: 9D 2D 07 STA  $072D,X
$965C: 20 89 95 JSR  $9589
$965F: A5 00    LDA  $00
$9661: 18       CLC  
$9662: 65 07    ADC  $07
$9664: 20 04 8E JSR  $8E04
$9667: E5 98    SBC  $98
$9669: 40       RTI  
$966A: 97          .byte $97  ; غير معرّف
$966B: 2E 9A 3E ROL  $3E9A
$966E: 9A       TXS  
$966F: F2          .byte $F2  ; غير معرّف
$9670: 99 50 9A STA  $9A50,Y
$9673: 59 9A E5 EOR  $E59A,Y
$9676: 98       TYA  
$9677: 41 9B    EOR  ($9B,X)
$9679: BA       TSX  
$967A: 97          .byte $97  ; غير معرّف
$967B: 79 99 7C ADC  $7C99,Y
$967E: 99 7F 99 STA  $997F,Y
$9681: 57          .byte $57  ; غير معرّف
$9682: 99 68 99 STA  $9968,Y
$9685: 6B          .byte $6B  ; غير معرّف
$9686: 99 D0 99 STA  $99D0,Y
$9689: D7          .byte $D7  ; غير معرّف
$968A: 99 06 98 STA  $9806,Y
$968D: B7          .byte $B7  ; غير معرّف
$968E: 9A       TXS  
$968F: AB          .byte $AB  ; غير معرّف
$9690: 98       TYA  
$9691: 94 99    STY  $99,X
$9693: 0E 9B 0E ASL  $0E9B
$9696: 9B          .byte $9B  ; غير معرّف
$9697: 0E 9B 01 ASL  $019B
$969A: 9B          .byte $9B  ; غير معرّف
$969B: 19 9B 19 ORA  $199B,Y
$969E: 9B          .byte $9B  ; غير معرّف
$969F: 19 9B 14 ORA  $149B,Y
$96A2: 9B          .byte $9B  ; غير معرّف
$96A3: 19 9B 6F ORA  $6F9B,Y
$96A6: 98       TYA  
$96A7: 19 9A D3 ORA  $D39A,Y
$96AA: 9A       TXS  
$96AB: 82          .byte $82  ; غير معرّف
$96AC: 98       TYA  
$96AD: 9E          .byte $9E  ; غير معرّف
$96AE: 99 09 9A STA  $9A09,Y
$96B1: 0E 9A 01 ASL  $019A
$96B4: 9A       TXS  
$96B5: F2          .byte $F2  ; غير معرّف
$96B6: 96 0D    STX  $0D,Y
$96B8: 97          .byte $97  ; غير معرّف
$96B9: 0D 97 2B ORA  $2B97
$96BC: 97          .byte $97  ; غير معرّف
$96BD: 2B          .byte $2B  ; غير معرّف
$96BE: 97          .byte $97  ; غير معرّف
$96BF: 2B          .byte $2B  ; غير معرّف
$96C0: 97          .byte $97  ; غير معرّف
$96C1: 45 96    EOR  $96
$96C3: C5 96    CMP  $96
$96C5: BC 2D 07 LDY  $072D,X
$96C8: C8       INY  
$96C9: B1 E7    LDA  ($E7),Y
$96CB: 48       PHA  
$96CC: 29 40    AND  #$40
$96CE: D0 12    BNE  $96E2
$96D0: 68       PLA  
$96D1: 48       PHA  
$96D2: 29 0F    AND  #$0F
$96D4: 8D 27 07 STA  $0727
$96D7: 68       PLA  
$96D8: 29 30    AND  #$30
$96DA: 4A       LSR  A
$96DB: 4A       LSR  A
$96DC: 4A       LSR  A
$96DD: 4A       LSR  A
$96DE: 8D 42 07 STA  $0742
$96E1: 60       RTS  
$96E2: 68       PLA  
$96E3: 29 07    AND  #$07
$96E5: C9          .byte $C9  ; غير معرّف
$96E6: 04          .byte $04  ; غير معرّف
$96E7: 90 05    BCC  $96EE
$96E9: 8D 44 07 STA  $0744
$96EC: A9 00    LDA  #$00
$96EE: 8D 41 07 STA  $0741
$96F1: 60       RTS  
$96F2: A2 04    LDX  #$04
$96F4: AD 5F 07 LDA  $075F
$96F7: F0 08    BEQ  $9701
$96F9: E8       INX  
$96FA: AC 4E 07 LDY  $074E
$96FD: 88       DEY  
$96FE: D0 01    BNE  $9701
$9700: E8       INX  
$9701: 8A       TXA  
$9702: 8D D6 06 STA  $06D6
$9705: 20 08 88 JSR  $8808
$9708: A9 0D    LDA  #$0D
$970A: 20 16 97 JSR  $9716
$970D: AD 23 07 LDA  $0723
$9710: 49 01    EOR  #$01
$9712: 8D 23 07 STA  $0723
$9715: 60       RTS  
$9716: 85 00    STA  $00
$9718: A9 00    LDA  #$00
$971A: A2 04    LDX  #$04
$971C: B4 16    LDY  $16,X
$971E: C4 00    CPY  $00
$9720: D0 02    BNE  $9724
$9722: 95 0F    STA  $0F,X
$9724: CA       DEX  
$9725: 10 F5    BPL  $971C
$9727: 60       RTS  
$9728: 14          .byte $14  ; غير معرّف
$9729: 17          .byte $17  ; غير معرّف
$972A: 18       CLC  
$972B: A6 00    LDX  $00
$972D: BD 20 97 LDA  $9720,X
$9730: A0 05    LDY  #$05
$9732: 88       DEY  
$9733: 30 07    BMI  $973C
$9735: D9 16 00 CMP  $0016,Y
$9738: D0 F8    BNE  $9732
$973A: A9 00    LDA  #$00
$973C: 8D CD 06 STA  $06CD
$973F: 60       RTS  
$9740: AD 33 07 LDA  $0733
$9743: 20 04 8E JSR  $8E04
$9746: 4C 97 78 JMP  $7897
$9749: 97          .byte $97  ; غير معرّف
$974A: 69 9A    ADC  #$9A
$974C: 20 BB 9B JSR  $9BBB
$974F: BD 30 07 LDA  $0730,X
$9752: F0 1F    BEQ  $9773
$9754: 10 11    BPL  $9767
$9756: 98       TYA  
$9757: 9D 30 07 STA  $0730,X
$975A: AD 25 07 LDA  $0725
$975D: 0D 26 07 ORA  $0726
$9760: F0 05    BEQ  $9767
$9762: A9 16    LDA  #$16
$9764: 4C B0 97 JMP  $97B0
$9767: A6 07    LDX  $07
$9769: A9 17    LDA  #$17
$976B: 9D A1 06 STA  $06A1,X
$976E: A9 4C    LDA  #$4C
$9770: 4C AA 97 JMP  $97AA
$9773: A9 18    LDA  #$18
$9775: 4C B0 97 JMP  $97B0
$9778: 20 AC 9B JSR  $9BAC
$977B: 84 06    STY  $06
$977D: 90 0C    BCC  $978B
$977F: BD 30 07 LDA  $0730,X
$9782: 4A       LSR  A
$9783: 9D 36 07 STA  $0736,X
$9786: A9 19    LDA  #$19
$9788: 4C B0 97 JMP  $97B0
$978B: A9 1B    LDA  #$1B
$978D: BC 30 07 LDY  $0730,X
$9790: F0 1E    BEQ  $97B0
$9792: BD 36 07 LDA  $0736,X
$9795: 85 06    STA  $06
$9797: A6 07    LDX  $07
$9799: A9 1A    LDA  #$1A
$979B: 9D A1 06 STA  $06A1,X
$979E: C4 06    CPY  $06
$97A0: D0 2C    BNE  $97CE
$97A2: E8       INX  
$97A3: A9 4F    LDA  #$4F
$97A5: 9D A1 06 STA  $06A1,X
$97A8: A9 50    LDA  #$50
$97AA: E8       INX  
$97AB: A0 0F    LDY  #$0F
$97AD: 4C 7D 9B JMP  $9B7D
$97B0: A6 07    LDX  $07
$97B2: A0 00    LDY  #$00
$97B4: 4C 7D 9B JMP  $9B7D
$97B7: 42          .byte $42  ; غير معرّف
$97B8: 41 43    EOR  ($43,X)
$97BA: 20 AC 9B JSR  $9BAC
$97BD: A0 00    LDY  #$00
$97BF: B0 07    BCS  $97C8
$97C1: C8       INY  
$97C2: BD 30 07 LDA  $0730,X
$97C5: D0 01    BNE  $97C8
$97C7: C8       INY  
$97C8: B9 B7 97 LDA  $97B7,Y
$97CB: 8D A1 06 STA  $06A1
$97CE: 60       RTS  
$97CF: 00       BRK  
$97D0: 45 45    EOR  $45
$97D2: 45 00    EOR  $00
$97D4: 00       BRK  
$97D5: 48       PHA  
$97D6: 47          .byte $47  ; غير معرّف
$97D7: 46 00    LSR  $00
$97D9: 45 49    EOR  $49
$97DB: 49 49    EOR  #$49
$97DD: 45 47    EOR  $47
$97DF: 47          .byte $47  ; غير معرّف
$97E0: 4A       LSR  A
$97E1: 47          .byte $47  ; غير معرّف
$97E2: 47          .byte $47  ; غير معرّف
$97E3: 47          .byte $47  ; غير معرّف
$97E4: 47          .byte $47  ; غير معرّف
$97E5: 4B          .byte $4B  ; غير معرّف
$97E6: 47          .byte $47  ; غير معرّف
$97E7: 47          .byte $47  ; غير معرّف
$97E8: 49 49    EOR  #$49
$97EA: 49 49    EOR  #$49
$97EC: 49 47    EOR  #$47
$97EE: 4A       LSR  A
$97EF: 47          .byte $47  ; غير معرّف
$97F0: 4A       LSR  A
$97F1: 47          .byte $47  ; غير معرّف
$97F2: 47          .byte $47  ; غير معرّف
$97F3: 4B          .byte $4B  ; غير معرّف
$97F4: 47          .byte $47  ; غير معرّف
$97F5: 4B          .byte $4B  ; غير معرّف
$97F6: 47          .byte $47  ; غير معرّف
$97F7: 47          .byte $47  ; غير معرّف
$97F8: 47          .byte $47  ; غير معرّف
$97F9: 47          .byte $47  ; غير معرّف
$97FA: 47          .byte $47  ; غير معرّف
$97FB: 47          .byte $47  ; غير معرّف
$97FC: 4A       LSR  A
$97FD: 47          .byte $47  ; غير معرّف
$97FE: 4A       LSR  A
$97FF: 47          .byte $47  ; غير معرّف
$9800: 4A       LSR  A
$9801: 4B          .byte $4B  ; غير معرّف
$9802: 47          .byte $47  ; غير معرّف
$9803: 4B          .byte $4B  ; غير معرّف
$9804: 47          .byte $47  ; غير معرّف
$9805: 4B          .byte $4B  ; غير معرّف
$9806: 20 BB 9B JSR  $9BBB
$9809: 84 07    STY  $07
$980B: A0 04    LDY  #$04
$980D: 20 AF 9B JSR  $9BAF
$9810: 8A       TXA  
$9811: 48       PHA  
$9812: BC 30 07 LDY  $0730,X
$9815: A6 07    LDX  $07
$9817: A9 0B    LDA  #$0B
$9819: 85 06    STA  $06
$981B: B9 CF 97 LDA  $97CF,Y
$981E: 9D A1 06 STA  $06A1,X
$9821: E8       INX  
$9822: A5 06    LDA  $06
$9824: F0 07    BEQ  $982D
$9826: C8       INY  
$9827: C8       INY  
$9828: C8       INY  
$9829: C8       INY  
$982A: C8       INY  
$982B: C6 06    DEC  $06
$982D: E0 0B    CPX  #$0B
$982F: D0 EA    BNE  $981B
$9831: 68       PLA  
$9832: AA       TAX  
$9833: AD 25 07 LDA  $0725
$9836: F0 36    BEQ  $986E
$9838: BD 30 07 LDA  $0730,X
$983B: C9          .byte $C9  ; غير معرّف
$983C: 01 F0    ORA  ($F0,X)
$983E: 2A       ROL  A
$983F: A4 07    LDY  $07
$9841: D0 04    BNE  $9847
$9843: C9          .byte $C9  ; غير معرّف
$9844: 03          .byte $03  ; غير معرّف
$9845: F0 22    BEQ  $9869
$9847: C9          .byte $C9  ; غير معرّف
$9848: 02          .byte $02  ; غير معرّف
$9849: D0 23    BNE  $986E
$984B: 20 CB 9B JSR  $9BCB
$984E: 48       PHA  
$984F: 20 4A 99 JSR  $994A
$9852: 68       PLA  
$9853: 95 87    STA  $87,X
$9855: AD 25 07 LDA  $0725
$9858: 95 6E    STA  $6E,X
$985A: A9 01    LDA  #$01
$985C: 95 B6    STA  $B6,X
$985E: 95 0F    STA  $0F,X
$9860: A9 90    LDA  #$90
$9862: 95 CF    STA  $CF,X
$9864: A9 31    LDA  #$31
$9866: 95 16    STA  $16,X
$9868: 60       RTS  
$9869: A0 52    LDY  #$52
$986B: 8C AB 06 STY  $06AB
$986E: 60       RTS  
$986F: 20 BB 9B JSR  $9BBB
$9872: BC 30 07 LDY  $0730,X
$9875: A6 07    LDX  $07
$9877: A9 6B    LDA  #$6B
$9879: 9D A1 06 STA  $06A1,X
$987C: A9 6C    LDA  #$6C
$987E: 9D A2 06 STA  $06A2,X
$9881: 60       RTS  
$9882: A0 03    LDY  #$03
$9884: 20 AF 9B JSR  $9BAF
$9887: A0 0A    LDY  #$0A
$9889: 20 B3 98 JSR  $98B3
$988C: B0 10    BCS  $989E
$988E: A2 06    LDX  #$06
$9890: A9 00    LDA  #$00
$9892: 9D A1 06 STA  $06A1,X
$9895: CA       DEX  
$9896: 10 F8    BPL  $9890
$9898: B9 DD 98 LDA  $98DD,Y
$989B: 8D A8 06 STA  $06A8
$989E: 60       RTS  
$989F: 15 14    ORA  $14,X
$98A1: 00       BRK  
$98A2: 00       BRK  
$98A3: 15 1E    ORA  $1E,X
$98A5: 1D 1C 15 ORA  $151C,X
$98A8: 21 20    AND  ($20,X)
$98AA: 1F          .byte $1F  ; غير معرّف
$98AB: A0 03    LDY  #$03
$98AD: 20 AF 9B JSR  $9BAF
$98B0: 20 BB 9B JSR  $9BBB
$98B3: 88       DEY  
$98B4: 88       DEY  
$98B5: 84 05    STY  $05
$98B7: BC 30 07 LDY  $0730,X
$98BA: 84 06    STY  $06
$98BC: A6 05    LDX  $05
$98BE: E8       INX  
$98BF: B9 9F 98 LDA  $989F,Y
$98C2: C9          .byte $C9  ; غير معرّف
$98C3: 00       BRK  
$98C4: F0 08    BEQ  $98CE
$98C6: A2 00    LDX  #$00
$98C8: A4 05    LDY  $05
$98CA: 20 7D 9B JSR  $9B7D
$98CD: 18       CLC  
$98CE: A4 06    LDY  $06
$98D0: B9 A3 98 LDA  $98A3,Y
$98D3: 9D A1 06 STA  $06A1,X
$98D6: B9 A7 98 LDA  $98A7,Y
$98D9: 9D A2 06 STA  $06A2,X
$98DC: 60       RTS  
$98DD: 11 10    ORA  ($10),Y
$98DF: 15 14    ORA  $14,X
$98E1: 13          .byte $13  ; غير معرّف
$98E2: 12          .byte $12  ; غير معرّف
$98E3: 15 14    ORA  $14,X
$98E5: 20 39 99 JSR  $9939
$98E8: A5 00    LDA  $00
$98EA: F0 04    BEQ  $98F0
$98EC: C8       INY  
$98ED: C8       INY  
$98EE: C8       INY  
$98EF: C8       INY  
$98F0: 98       TYA  
$98F1: 48       PHA  
$98F2: AD 60 07 LDA  $0760
$98F5: 0D 5F 07 ORA  $075F
$98F8: F0 2B    BEQ  $9925
$98FA: BC 30 07 LDY  $0730,X
$98FD: F0 26    BEQ  $9925
$98FF: 20 4A 99 JSR  $994A
$9902: B0 21    BCS  $9925
$9904: 20 CB 9B JSR  $9BCB
$9907: 18       CLC  
$9908: 69 08    ADC  #$08
$990A: 95 87    STA  $87,X
$990C: AD 25 07 LDA  $0725
$990F: 69 00    ADC  #$00
$9911: 95 6E    STA  $6E,X
$9913: A9 01    LDA  #$01
$9915: 95 B6    STA  $B6,X
$9917: 95 0F    STA  $0F,X
$9919: 20 D3 9B JSR  $9BD3
$991C: 95 CF    STA  $CF,X
$991E: A9 0D    LDA  #$0D
$9920: 95 16    STA  $16,X
$9922: 20 87 C7 JSR  $C787
$9925: 68       PLA  
$9926: A8       TAY  
$9927: A6 07    LDX  $07
$9929: B9 DD 98 LDA  $98DD,Y
$992C: 9D A1 06 STA  $06A1,X
$992F: E8       INX  
$9930: B9 DF 98 LDA  $98DF,Y
$9933: A4 06    LDY  $06
$9935: 88       DEY  
$9936: 4C 7D 9B JMP  $9B7D
$9939: A0 01    LDY  #$01
$993B: 20 AF 9B JSR  $9BAF
$993E: 20 BB 9B JSR  $9BBB
$9941: 98       TYA  
$9942: 29 07    AND  #$07
$9944: 85 06    STA  $06
$9946: BC 30 07 LDY  $0730,X
$9949: 60       RTS  
$994A: A2 00    LDX  #$00
$994C: 18       CLC  
$994D: B5 0F    LDA  $0F,X
$994F: F0 05    BEQ  $9956
$9951: E8       INX  
$9952: E0 05    CPX  #$05
$9954: D0 F6    BNE  $994C
$9956: 60       RTS  
$9957: 20 AC 9B JSR  $9BAC
$995A: A9 86    LDA  #$86
$995C: 8D AB 06 STA  $06AB
$995F: A2 0B    LDX  #$0B
$9961: A0 01    LDY  #$01
$9963: A9 87    LDA  #$87
$9965: 4C 7D 9B JMP  $9B7D
$9968: A9 03    LDA  #$03
$996A: 2C A9 07 BIT  $07A9
$996D: 48       PHA  
$996E: 20 AC 9B JSR  $9BAC
$9971: 68       PLA  
$9972: AA       TAX  
$9973: A9 C0    LDA  #$C0
$9975: 9D A1 06 STA  $06A1,X
$9978: 60       RTS  
$9979: A9 06    LDA  #$06
$997B: 2C A9 07 BIT  $07A9
$997E: 2C A9 09 BIT  $09A9
$9981: 48       PHA  
$9982: 20 AC 9B JSR  $9BAC
$9985: 68       PLA  
$9986: AA       TAX  
$9987: A9 0B    LDA  #$0B
$9989: 9D A1 06 STA  $06A1,X
$998C: E8       INX  
$998D: A0 00    LDY  #$00
$998F: A9 63    LDA  #$63
$9991: 4C 7D 9B JMP  $9B7D
$9994: 20 BB 9B JSR  $9BBB
$9997: A2 02    LDX  #$02
$9999: A9 6D    LDA  #$6D
$999B: 4C 7D 9B JMP  $9B7D
$999E: A9 24    LDA  #$24
$99A0: 8D A1 06 STA  $06A1
$99A3: A2 01    LDX  #$01
$99A5: A0 08    LDY  #$08
$99A7: A9 25    LDA  #$25
$99A9: 20 7D 9B JSR  $9B7D
$99AC: A9 61    LDA  #$61
$99AE: 8D AB 06 STA  $06AB
$99B1: 20 CB 9B JSR  $9BCB
$99B4: 38       SEC  
$99B5: E9 08    SBC  #$08
$99B7: 85 8C    STA  $8C
$99B9: AD 25 07 LDA  $0725
$99BC: E9 00    SBC  #$00
$99BE: 85 73    STA  $73
$99C0: A9 30    LDA  #$30
$99C2: 85 D4    STA  $D4
$99C4: A9 B0    LDA  #$B0
$99C6: 8D 0D 01 STA  $010D
$99C9: A9 30    LDA  #$30
$99CB: 85 1B    STA  $1B
$99CD: E6 14    INC  $14
$99CF: 60       RTS  
$99D0: A2 00    LDX  #$00
$99D2: A0 0F    LDY  #$0F
$99D4: 4C E9 99 JMP  $99E9
$99D7: 8A       TXA  
$99D8: 48       PHA  
$99D9: A2 01    LDX  #$01
$99DB: A0 0F    LDY  #$0F
$99DD: A9 44    LDA  #$44
$99DF: 20 7D 9B JSR  $9B7D
$99E2: 68       PLA  
$99E3: AA       TAX  
$99E4: 20 BB 9B JSR  $9BBB
$99E7: A2 01    LDX  #$01
$99E9: A9 40    LDA  #$40
$99EB: 4C 7D 9B JMP  $9B7D
$99EE: C3          .byte $C3  ; غير معرّف
$99EF: C2          .byte $C2  ; غير معرّف
$99F0: C2          .byte $C2  ; غير معرّف
$99F1: C2          .byte $C2  ; غير معرّف
$99F2: AC 4E 07 LDY  $074E
$99F5: B9 EE 99 LDA  $99EE,Y
$99F8: 4C 44 9A JMP  $9A44
$99FB: 06 07    ASL  $07
$99FD: 08       PHP  
$99FE: C5 0C    CMP  $0C
$9A00: 89          .byte $89  ; غير معرّف
$9A01: A0 0C    LDY  #$0C
$9A03: 20 AF 9B JSR  $9BAF
$9A06: 4C 0E 9A JMP  $9A0E
$9A09: A9 08    LDA  #$08
$9A0B: 8D 73 07 STA  $0773
$9A0E: A4 00    LDY  $00
$9A10: BE F9 99 LDX  $99F9,Y
$9A13: B9 FC 99 LDA  $99FC,Y
$9A16: 4C 20 9A JMP  $9A20
$9A19: 20 BB 9B JSR  $9BBB
$9A1C: A6 07    LDX  $07
$9A1E: A9 C4    LDA  #$C4
$9A20: A0 00    LDY  #$00
$9A22: 4C 7D 9B JMP  $9B7D
$9A25: 69 61    ADC  #$61
$9A27: 61 62    ADC  ($62,X)
$9A29: 22          .byte $22  ; غير معرّف
$9A2A: 51 52    EOR  ($52),Y
$9A2C: 52          .byte $52  ; غير معرّف
$9A2D: 88       DEY  
$9A2E: AC 4E 07 LDY  $074E
$9A31: AD 43 07 LDA  $0743
$9A34: F0 02    BEQ  $9A38
$9A36: A0 04    LDY  #$04
$9A38: B9 29 9A LDA  $9A29,Y
$9A3B: 4C 44 9A JMP  $9A44
$9A3E: AC 4E 07 LDY  $074E
$9A41: B9 25 9A LDA  $9A25,Y
$9A44: 48       PHA  
$9A45: 20 AC 9B JSR  $9BAC
$9A48: A6 07    LDX  $07
$9A4A: A0 00    LDY  #$00
$9A4C: 68       PLA  
$9A4D: 4C 7D 9B JMP  $9B7D
$9A50: AC 4E 07 LDY  $074E
$9A53: B9 29 9A LDA  $9A29,Y
$9A56: 4C 5F 9A JMP  $9A5F
$9A59: AC 4E 07 LDY  $074E
$9A5C: B9 25 9A LDA  $9A25,Y
$9A5F: 48       PHA  
$9A60: 20 BB 9B JSR  $9BBB
$9A63: 68       PLA  
$9A64: A6 07    LDX  $07
$9A66: 4C 7D 9B JMP  $9B7D
$9A69: 20 BB 9B JSR  $9BBB
$9A6C: A6 07    LDX  $07
$9A6E: A9 64    LDA  #$64
$9A70: 9D A1 06 STA  $06A1,X
$9A73: E8       INX  
$9A74: 88       DEY  
$9A75: 30 0E    BMI  $9A85
$9A77: A9 65    LDA  #$65
$9A79: 9D A1 06 STA  $06A1,X
$9A7C: E8       INX  
$9A7D: 88       DEY  
$9A7E: 30 05    BMI  $9A85
$9A80: A9 66    LDA  #$66
$9A82: 20 7D 9B JSR  $9B7D
$9A85: AE 6A 04 LDX  $046A
$9A88: 20 D3 9B JSR  $9BD3
$9A8B: 9D 77 04 STA  $0477,X
$9A8E: AD 25 07 LDA  $0725
$9A91: 9D 6B 04 STA  $046B,X
$9A94: 20 CB 9B JSR  $9BCB
$9A97: 9D 71 04 STA  $0471,X
$9A9A: E8       INX  
$9A9B: E0 06    CPX  #$06
$9A9D: 90 02    BCC  $9AA1
$9A9F: A2 00    LDX  #$00
$9AA1: 8E 6A 04 STX  $046A
$9AA4: 60       RTS  
$9AA5: 07          .byte $07  ; غير معرّف
$9AA6: 07          .byte $07  ; غير معرّف
$9AA7: 06 05    ASL  $05
$9AA9: 04          .byte $04  ; غير معرّف
$9AAA: 03          .byte $03  ; غير معرّف
$9AAB: 02          .byte $02  ; غير معرّف
$9AAC: 01 00    ORA  ($00,X)
$9AAE: 03          .byte $03  ; غير معرّف
$9AAF: 03          .byte $03  ; غير معرّف
$9AB0: 04          .byte $04  ; غير معرّف
$9AB1: 05 06    ORA  $06
$9AB3: 07          .byte $07  ; غير معرّف
$9AB4: 08       PHP  
$9AB5: 09 0A    ORA  #$0A
$9AB7: 20 AC 9B JSR  $9BAC
$9ABA: 90 05    BCC  $9AC1
$9ABC: A9 09    LDA  #$09
$9ABE: 8D 34 07 STA  $0734
$9AC1: CE 34 07 DEC  $0734
$9AC4: AC 34 07 LDY  $0734
$9AC7: BE AE 9A LDX  $9AAE,Y
$9ACA: B9 A5 9A LDA  $9AA5,Y
$9ACD: A8       TAY  
$9ACE: A9 61    LDA  #$61
$9AD0: 4C 7D 9B JMP  $9B7D
$9AD3: 20 BB 9B JSR  $9BBB
$9AD6: 20 4A 99 JSR  $994A
$9AD9: 20 CB 9B JSR  $9BCB
$9ADC: 95 87    STA  $87,X
$9ADE: AD 25 07 LDA  $0725
$9AE1: 95 6E    STA  $6E,X
$9AE3: 20 D3 9B JSR  $9BD3
$9AE6: 95 CF    STA  $CF,X
$9AE8: 95 58    STA  $58,X
$9AEA: A9 32    LDA  #$32
$9AEC: 95 16    STA  $16,X
$9AEE: A0 01    LDY  #$01
$9AF0: 94 B6    STY  $B6,X
$9AF2: F6 0F    INC  $0F,X
$9AF4: A6 07    LDX  $07
$9AF6: A9 67    LDA  #$67
$9AF8: 9D A1 06 STA  $06A1,X
$9AFB: A9 68    LDA  #$68
$9AFD: 9D A2 06 STA  $06A2,X
$9B00: 60       RTS  
$9B01: AD 5D 07 LDA  $075D
$9B04: F0 36    BEQ  $9B3C
$9B06: A9 00    LDA  #$00
$9B08: 8D 5D 07 STA  $075D
$9B0B: 4C 19 9B JMP  $9B19
$9B0E: 20 36 9B JSR  $9B36
$9B11: 4C 2C 9B JMP  $9B2C
$9B14: A9 00    LDA  #$00
$9B16: 8D BC 06 STA  $06BC
$9B19: 20 36 9B JSR  $9B36
$9B1C: 84 07    STY  $07
$9B1E: A9 00    LDA  #$00
$9B20: AC 4E 07 LDY  $074E
$9B23: 88       DEY  
$9B24: F0 02    BEQ  $9B28
$9B26: A9 05    LDA  #$05
$9B28: 18       CLC  
$9B29: 65 07    ADC  $07
$9B2B: A8       TAY  
$9B2C: B9 E8 BD LDA  $BDE8,Y
$9B2F: 48       PHA  
$9B30: 20 BB 9B JSR  $9BBB
$9B33: 4C 48 9A JMP  $9A48
$9B36: A5 00    LDA  $00
$9B38: 38       SEC  
$9B39: E9 00    SBC  #$00
$9B3B: A8       TAY  
$9B3C: 60       RTS  
$9B3D: 87          .byte $87  ; غير معرّف
$9B3E: 00       BRK  
$9B3F: 00       BRK  
$9B40: 00       BRK  
$9B41: 20 AC 9B JSR  $9BAC
$9B44: 90 2D    BCC  $9B73
$9B46: AD 4E 07 LDA  $074E
$9B49: D0 28    BNE  $9B73
$9B4B: AE 6A 04 LDX  $046A
$9B4E: 20 CB 9B JSR  $9BCB
$9B51: 38       SEC  
$9B52: E9 10    SBC  #$10
$9B54: 9D 71 04 STA  $0471,X
$9B57: AD 25 07 LDA  $0725
$9B5A: E9 00    SBC  #$00
$9B5C: 9D 6B 04 STA  $046B,X
$9B5F: C8       INY  
$9B60: C8       INY  
$9B61: 98       TYA  
$9B62: 0A       ASL  A
$9B63: 0A       ASL  A
$9B64: 0A       ASL  A
$9B65: 0A       ASL  A
$9B66: 9D 77 04 STA  $0477,X
$9B69: E8       INX  
$9B6A: E0 05    CPX  #$05
$9B6C: 90 02    BCC  $9B70
$9B6E: A2 00    LDX  #$00
$9B70: 8E 6A 04 STX  $046A
$9B73: AE 4E 07 LDX  $074E
$9B76: BD 3D 9B LDA  $9B3D,X
$9B79: A2 08    LDX  #$08
$9B7B: A0 0F    LDY  #$0F
$9B7D: 8C 35 07 STY  $0735
$9B80: BC A1 06 LDY  $06A1,X
$9B83: F0 18    BEQ  $9B9D
$9B85: C0 17    CPY  #$17
$9B87: F0 17    BEQ  $9BA0
$9B89: C0 1A    CPY  #$1A
$9B8B: F0 13    BEQ  $9BA0
$9B8D: C0 C0    CPY  #$C0
$9B8F: F0 0C    BEQ  $9B9D
$9B91: C0 C0    CPY  #$C0
$9B93: B0 0B    BCS  $9BA0
$9B95: C0 54    CPY  #$54
$9B97: D0 04    BNE  $9B9D
$9B99: C9          .byte $C9  ; غير معرّف
$9B9A: 50 F0    BVC  $9B8C
$9B9C: 03          .byte $03  ; غير معرّف
$9B9D: 9D A1 06 STA  $06A1,X
$9BA0: E8       INX  
$9BA1: E0 0D    CPX  #$0D
$9BA3: B0 06    BCS  $9BAB
$9BA5: AC 35 07 LDY  $0735
$9BA8: 88       DEY  
$9BA9: 10 D2    BPL  $9B7D
$9BAB: 60       RTS  
$9BAC: 20 BB 9B JSR  $9BBB
$9BAF: BD 30 07 LDA  $0730,X
$9BB2: 18       CLC  
$9BB3: 10 05    BPL  $9BBA
$9BB5: 98       TYA  
$9BB6: 9D 30 07 STA  $0730,X
$9BB9: 38       SEC  
$9BBA: 60       RTS  
$9BBB: BC 2D 07 LDY  $072D,X
$9BBE: B1 E7    LDA  ($E7),Y
$9BC0: 29 0F    AND  #$0F
$9BC2: 85 07    STA  $07
$9BC4: C8       INY  
$9BC5: B1 E7    LDA  ($E7),Y
$9BC7: 29 0F    AND  #$0F
$9BC9: A8       TAY  
$9BCA: 60       RTS  
$9BCB: AD 26 07 LDA  $0726
$9BCE: 0A       ASL  A
$9BCF: 0A       ASL  A
$9BD0: 0A       ASL  A
$9BD1: 0A       ASL  A
$9BD2: 60       RTS  
$9BD3: A5 07    LDA  $07
$9BD5: 0A       ASL  A
$9BD6: 0A       ASL  A
$9BD7: 0A       ASL  A
$9BD8: 0A       ASL  A
$9BD9: 18       CLC  
$9BDA: 69 20    ADC  #$20
$9BDC: 60       RTS  
$9BDD: 00       BRK  
$9BDE: D0 05    BNE  $9BE5
$9BE0: 05 48    ORA  $48
$9BE2: 4A       LSR  A
$9BE3: 4A       LSR  A
$9BE4: 4A       LSR  A
$9BE5: 4A       LSR  A
$9BE6: A8       TAY  
$9BE7: B9 DF 9B LDA  $9BDF,Y
$9BEA: 85 07    STA  $07
$9BEC: 68       PLA  
$9BED: 29 0F    AND  #$0F
$9BEF: 18       CLC  
$9BF0: 79 DD 9B ADC  $9BDD,Y
$9BF3: 85 06    STA  $06
$9BF5: 60       RTS  
$9BF6: FF          .byte $FF  ; غير معرّف
$9BF7: FF          .byte $FF  ; غير معرّف
$9BF8: 12          .byte $12  ; غير معرّف
$9BF9: 36 0E    ROL  $0E,X
$9BFB: 0E 0E 32 ASL  $320E
$9BFE: 32          .byte $32  ; غير معرّف
$9BFF: 32          .byte $32  ; غير معرّف
$9C00: 0A       ASL  A
$9C01: 26 40    ROL  $40
$9C03: 20 13 9C JSR  $9C13
$9C06: 8D 50 07 STA  $0750
$9C09: 29 60    AND  #$60
$9C0B: 0A       ASL  A
$9C0C: 2A       ROL  A
$9C0D: 2A       ROL  A
$9C0E: 2A       ROL  A
$9C0F: 8D 4E 07 STA  $074E
$9C12: 60       RTS  
$9C13: AC 5F 07 LDY  $075F
$9C16: B9 B4 9C LDA  $9CB4,Y
$9C19: 18       CLC  
$9C1A: 6D 60 07 ADC  $0760
$9C1D: A8       TAY  
$9C1E: B9 BC 9C LDA  $9CBC,Y
$9C21: 60       RTS  
$9C22: AD 50 07 LDA  $0750
$9C25: 20 09 9C JSR  $9C09
$9C28: A8       TAY  
$9C29: AD 50 07 LDA  $0750
$9C2C: 29 1F    AND  #$1F
$9C2E: 8D 4F 07 STA  $074F
$9C31: B9 E0 9C LDA  $9CE0,Y
$9C34: 18       CLC  
$9C35: 6D 4F 07 ADC  $074F
$9C38: A8       TAY  
$9C39: B9 E4 9C LDA  $9CE4,Y
$9C3C: 85 E9    STA  $E9
$9C3E: B9 06 9D LDA  $9D06,Y
$9C41: 85 EA    STA  $EA
$9C43: AC 4E 07 LDY  $074E
$9C46: B9 28 9D LDA  $9D28,Y
$9C49: 18       CLC  
$9C4A: 6D 4F 07 ADC  $074F
$9C4D: A8       TAY  
$9C4E: B9 2C 9D LDA  $9D2C,Y
$9C51: 85 E7    STA  $E7
$9C53: B9 4E 9D LDA  $9D4E,Y
$9C56: 85 E8    STA  $E8
$9C58: A0 00    LDY  #$00
$9C5A: B1 E7    LDA  ($E7),Y
$9C5C: 48       PHA  
$9C5D: 29 07    AND  #$07
$9C5F: C9          .byte $C9  ; غير معرّف
$9C60: 04          .byte $04  ; غير معرّف
$9C61: 90 05    BCC  $9C68
$9C63: 8D 44 07 STA  $0744
$9C66: A9 00    LDA  #$00
$9C68: 8D 41 07 STA  $0741
$9C6B: 68       PLA  
$9C6C: 48       PHA  
$9C6D: 29 38    AND  #$38
$9C6F: 4A       LSR  A
$9C70: 4A       LSR  A
$9C71: 4A       LSR  A
$9C72: 8D 10 07 STA  $0710
$9C75: 68       PLA  
$9C76: 29 C0    AND  #$C0
$9C78: 18       CLC  
$9C79: 2A       ROL  A
$9C7A: 2A       ROL  A
$9C7B: 2A       ROL  A
$9C7C: 8D 15 07 STA  $0715
$9C7F: C8       INY  
$9C80: B1 E7    LDA  ($E7),Y
$9C82: 48       PHA  
$9C83: 29 0F    AND  #$0F
$9C85: 8D 27 07 STA  $0727
$9C88: 68       PLA  
$9C89: 48       PHA  
$9C8A: 29 30    AND  #$30
$9C8C: 4A       LSR  A
$9C8D: 4A       LSR  A
$9C8E: 4A       LSR  A
$9C8F: 4A       LSR  A
$9C90: 8D 42 07 STA  $0742
$9C93: 68       PLA  
$9C94: 29 C0    AND  #$C0
$9C96: 18       CLC  
$9C97: 2A       ROL  A
$9C98: 2A       ROL  A
$9C99: 2A       ROL  A
$9C9A: C9          .byte $C9  ; غير معرّف
$9C9B: 03          .byte $03  ; غير معرّف
$9C9C: D0 05    BNE  $9CA3
$9C9E: 8D 43 07 STA  $0743
$9CA1: A9 00    LDA  #$00
$9CA3: 8D 33 07 STA  $0733
$9CA6: A5 E7    LDA  $E7
$9CA8: 18       CLC  
$9CA9: 69 02    ADC  #$02
$9CAB: 85 E7    STA  $E7
$9CAD: A5 E8    LDA  $E8
$9CAF: 69 00    ADC  #$00
$9CB1: 85 E8    STA  $E8
$9CB3: 60       RTS  
$9CB4: 00       BRK  
$9CB5: 05 0A    ORA  $0A
$9CB7: 0E 13 17 ASL  $1713
$9CBA: 1B          .byte $1B  ; غير معرّف
$9CBB: 20 25 29 JSR  $2925
$9CBE: C0 26    CPY  #$26
$9CC0: 60       RTS  
$9CC1: 28       PLP  
$9CC2: 29 01    AND  #$01
$9CC4: 27          .byte $27  ; غير معرّف
$9CC5: 62          .byte $62  ; غير معرّف
$9CC6: 24 35    BIT  $35
$9CC8: 20 63 22 JSR  $2263
$9CCB: 29 41    AND  #$41
$9CCD: 2C 61 2A BIT  $2A61
$9CD0: 31 26    AND  ($26),Y
$9CD2: 62          .byte $62  ; غير معرّف
$9CD3: 2E 23 2D ROL  $2D23
$9CD6: 60       RTS  
$9CD7: 33          .byte $33  ; غير معرّف
$9CD8: 29 01    AND  #$01
$9CDA: 27          .byte $27  ; غير معرّف
$9CDB: 64          .byte $64  ; غير معرّف
$9CDC: 30 32    BMI  $9D10
$9CDE: 21 65    AND  ($65,X)
$9CE0: 1F          .byte $1F  ; غير معرّف
$9CE1: 06 1C    ASL  $1C
$9CE3: 00       BRK  
$9CE4: 70 97    BVS  $9C7D
$9CE6: B0 DF    BCS  $9CC7
$9CE8: 0A       ASL  A
$9CE9: 1F          .byte $1F  ; غير معرّف
$9CEA: 59 7E 9B EOR  $9B7E,Y
$9CED: A9 D0    LDA  #$D0
$9CEF: 01 1F    ORA  ($1F,X)
$9CF1: 3C          .byte $3C  ; غير معرّف
$9CF2: 51 7B    EOR  ($7B),Y
$9CF4: 7C          .byte $7C  ; غير معرّف
$9CF5: A0 A9    LDY  #$A9
$9CF7: CE F1 FA DEC  $FAF1
$9CFA: FB          .byte $FB  ; غير معرّف
$9CFB: 35 60    AND  $60,X
$9CFD: 8E AA B3 STX  $B3AA
$9D00: D8       CLD  
$9D01: 05 33    ORA  $33
$9D03: 60       RTS  
$9D04: 71 9B    ADC  ($9B),Y
$9D06: 9D 9D 9D STA  $9D9D,X
$9D09: 9D 9E 9E STA  $9E9E,X
$9D0C: 9E          .byte $9E  ; غير معرّف
$9D0D: 9E          .byte $9E  ; غير معرّف
$9D0E: 9E          .byte $9E  ; غير معرّف
$9D0F: 9E          .byte $9E  ; غير معرّف
$9D10: 9E          .byte $9E  ; غير معرّف
$9D11: 9F          .byte $9F  ; غير معرّف
$9D12: 9F          .byte $9F  ; غير معرّف
$9D13: 9F          .byte $9F  ; غير معرّف
$9D14: 9F          .byte $9F  ; غير معرّف
$9D15: 9F          .byte $9F  ; غير معرّف
$9D16: 9F          .byte $9F  ; غير معرّف
$9D17: 9F          .byte $9F  ; غير معرّف
$9D18: 9F          .byte $9F  ; غير معرّف
$9D19: 9F          .byte $9F  ; غير معرّف
$9D1A: 9F          .byte $9F  ; غير معرّف
$9D1B: 9F          .byte $9F  ; غير معرّف
$9D1C: 9F          .byte $9F  ; غير معرّف
$9D1D: A0 A0    LDY  #$A0
$9D1F: A0 A0    LDY  #$A0
$9D21: A0 A0    LDY  #$A0
$9D23: A1 A1    LDA  ($A1,X)
$9D25: A1 A1    LDA  ($A1,X)
$9D27: A1 00    LDA  ($00,X)
$9D29: 03          .byte $03  ; غير معرّف
$9D2A: 19 1C 06 ORA  $061C,Y
$9D2D: 45 C0    EOR  $C0
$9D2F: 6B          .byte $6B  ; غير معرّف
$9D30: CE 37 8A DEC  $8A37
$9D33: 19 8E F3 ORA  $F38E,Y
$9D36: 48       PHA  
$9D37: CD 32 3B CMP  $3B32
$9D3A: 7A          .byte $7A  ; غير معرّف
$9D3B: 8F          .byte $8F  ; غير معرّف
$9D3C: F6 5B    INC  $5B,X
$9D3E: CE FF 92 DEC  $92FF
$9D41: 05 7E    ORA  $7E
$9D43: D7          .byte $D7  ; غير معرّف
$9D44: 02          .byte $02  ; غير معرّف
$9D45: 35 D8    AND  $D8,X
$9D47: 79 AF 10 ADC  $10AF,Y
$9D4A: 8F          .byte $8F  ; غير معرّف
$9D4B: 02          .byte $02  ; غير معرّف
$9D4C: 6F          .byte $6F  ; غير معرّف
$9D4D: FA          .byte $FA  ; غير معرّف
$9D4E: AE AE AE LDX  $AEAE
$9D51: A4 A4    LDY  $A4
$9D53: A5 A5    LDA  $A5
$9D55: A6 A6    LDX  $A6
$9D57: A6 A7    LDX  $A7
$9D59: A7          .byte $A7  ; غير معرّف
$9D5A: A8       TAY  
$9D5B: A8       TAY  
$9D5C: A8       TAY  
$9D5D: A8       TAY  
$9D5E: A8       TAY  
$9D5F: A9 A9    LDA  #$A9
$9D61: A9 AA    LDA  #$AA
$9D63: AB          .byte $AB  ; غير معرّف
$9D64: AB          .byte $AB  ; غير معرّف
$9D65: AB          .byte $AB  ; غير معرّف
$9D66: AC AC AC LDY  $ACAC
$9D69: AD A1 A2 LDA  $A2A1
$9D6C: A2 A3    LDX  #$A3
$9D6E: A3          .byte $A3  ; غير معرّف
$9D6F: A3          .byte $A3  ; غير معرّف
$9D70: 76 DD    ROR  $DD,X
$9D72: BB          .byte $BB  ; غير معرّف
$9D73: 4C EA 1D JMP  $1DEA
$9D76: 1B          .byte $1B  ; غير معرّف
$9D77: CC 56 5D CPY  $5D56
$9D7A: 16 9D    ASL  $9D,X
$9D7C: C6 1D    DEC  $1D
$9D7E: 36 9D    ROL  $9D,X
$9D80: C9          .byte $C9  ; غير معرّف
$9D81: 1D 04 DB ORA  $DB04,X
$9D84: 49 1D    EOR  #$1D
$9D86: 84 1B    STY  $1B
$9D88: C9          .byte $C9  ; غير معرّف
$9D89: 5D 88 95 EOR  $9588,X
$9D8C: 0F          .byte $0F  ; غير معرّف
$9D8D: 08       PHP  
$9D8E: 30 4C    BMI  $9DDC
$9D90: 78       SEI  
$9D91: 2D A6 28 AND  $28A6
$9D94: 90 B5    BCC  $9D4B
$9D96: FF          .byte $FF  ; غير معرّف
$9D97: 0F          .byte $0F  ; غير معرّف
$9D98: 03          .byte $03  ; غير معرّف
$9D99: 56 1B    LSR  $1B,X
$9D9B: C9          .byte $C9  ; غير معرّف
$9D9C: 1B          .byte $1B  ; غير معرّف
$9D9D: 0F          .byte $0F  ; غير معرّف
$9D9E: 07          .byte $07  ; غير معرّف
$9D9F: 36 1B    ROL  $1B,X
$9DA1: AA       TAX  
$9DA2: 1B          .byte $1B  ; غير معرّف
$9DA3: 48       PHA  
$9DA4: 95 0F    STA  $0F,X
$9DA6: 0A       ASL  A
$9DA7: 2A       ROL  A
$9DA8: 1B          .byte $1B  ; غير معرّف
$9DA9: 5B          .byte $5B  ; غير معرّف
$9DAA: 0C          .byte $0C  ; غير معرّف
$9DAB: 78       SEI  
$9DAC: 2D 90 B5 AND  $B590
$9DAF: FF          .byte $FF  ; غير معرّف
$9DB0: 0B          .byte $0B  ; غير معرّف
$9DB1: 8C 4B 4C STY  $4C4B
$9DB4: 77          .byte $77  ; غير معرّف
$9DB5: 5F          .byte $5F  ; غير معرّف
$9DB6: EB          .byte $EB  ; غير معرّف
$9DB7: 0C          .byte $0C  ; غير معرّف
$9DB8: BD DB 19 LDA  $19DB,X
$9DBB: 9D 75 1D STA  $1D75,X
$9DBE: 7D 5B D9 ADC  $D95B,X
$9DC1: 1D 3D DD ORA  $DD3D,X
$9DC4: 99 1D 26 STA  $261D,Y
$9DC7: 9D 5A 2B STA  $2B5A,X
$9DCA: 8A       TXA  
$9DCB: 2C CA 1B BIT  $1BCA
$9DCE: 20 95 7B JSR  $7B95
$9DD1: 5C          .byte $5C  ; غير معرّف
$9DD2: DB          .byte $DB  ; غير معرّف
$9DD3: 4C 1B CC JMP  $CC1B
$9DD6: 3B          .byte $3B  ; غير معرّف
$9DD7: CC 78 2D CPY  $2D78
$9DDA: A6 28    LDX  $28
$9DDC: 90 B5    BCC  $9D93
$9DDE: FF          .byte $FF  ; غير معرّف
$9DDF: 0B          .byte $0B  ; غير معرّف
$9DE0: 8C 3B 1D STY  $1D3B
$9DE3: 8B          .byte $8B  ; غير معرّف
$9DE4: 1D AB 0C ORA  $0CAB,X
$9DE7: DB          .byte $DB  ; غير معرّف
$9DE8: 1D 0F 03 ORA  $030F,X
$9DEB: 65 1D    ADC  $1D
$9DED: 6B          .byte $6B  ; غير معرّف
$9DEE: 1B          .byte $1B  ; غير معرّف
$9DEF: 05 9D    ORA  $9D
$9DF1: 0B          .byte $0B  ; غير معرّف
$9DF2: 1B          .byte $1B  ; غير معرّف
$9DF3: 05 9B    ORA  $9B
$9DF5: 0B          .byte $0B  ; غير معرّف
$9DF6: 1D 8B 0C ORA  $0C8B,X
$9DF9: 1B          .byte $1B  ; غير معرّف
$9DFA: 8C 70 15 STY  $1570
$9DFD: 7B          .byte $7B  ; غير معرّف
$9DFE: 0C          .byte $0C  ; غير معرّف
$9DFF: DB          .byte $DB  ; غير معرّف
$9E00: 0C          .byte $0C  ; غير معرّف
$9E01: 0F          .byte $0F  ; غير معرّف
$9E02: 08       PHP  
$9E03: 78       SEI  
$9E04: 2D A6 28 AND  $28A6
$9E07: 90 B5    BCC  $9DBE
$9E09: FF          .byte $FF  ; غير معرّف
$9E0A: 27          .byte $27  ; غير معرّف
$9E0B: A9 4B    LDA  #$4B
$9E0D: 0C          .byte $0C  ; غير معرّف
$9E0E: 68       PLA  
$9E0F: 29 0F    AND  #$0F
$9E11: 06 77    ASL  $77
$9E13: 1B          .byte $1B  ; غير معرّف
$9E14: 0F          .byte $0F  ; غير معرّف
$9E15: 0B          .byte $0B  ; غير معرّف
$9E16: 60       RTS  
$9E17: 15 4B    ORA  $4B,X
$9E19: 8C 78 2D STY  $2D78
$9E1C: 90 B5    BCC  $9DD3
$9E1E: FF          .byte $FF  ; غير معرّف
$9E1F: 0F          .byte $0F  ; غير معرّف
$9E20: 03          .byte $03  ; غير معرّف
$9E21: 8E 65 E1 STX  $E165
$9E24: BB          .byte $BB  ; غير معرّف
$9E25: 38       SEC  
$9E26: 6D A8 3E ADC  $3EA8
$9E29: E5 E7    SBC  $E7
$9E2B: 0F          .byte $0F  ; غير معرّف
$9E2C: 08       PHP  
$9E2D: 0B          .byte $0B  ; غير معرّف
$9E2E: 02          .byte $02  ; غير معرّف
$9E2F: 2B          .byte $2B  ; غير معرّف
$9E30: 02          .byte $02  ; غير معرّف
$9E31: 5E 65 E1 LSR  $E165,X
$9E34: BB          .byte $BB  ; غير معرّف
$9E35: 0E DB 0E ASL  $0EDB
$9E38: BB          .byte $BB  ; غير معرّف
$9E39: 8E DB 0E STX  $0EDB
$9E3C: FE 65 EC INC  $EC65,X
$9E3F: 0F          .byte $0F  ; غير معرّف
$9E40: 0D 4E 65 ORA  $654E
$9E43: E1 0F    SBC  ($0F,X)
$9E45: 0E 4E 02 ASL  $024E
$9E48: E0 0F    CPX  #$0F
$9E4A: 10 FE    BPL  $9E4A
$9E4C: E5 E1    SBC  $E1
$9E4E: 1B          .byte $1B  ; غير معرّف
$9E4F: 85 7B    STA  $7B
$9E51: 0C          .byte $0C  ; غير معرّف
$9E52: 5B          .byte $5B  ; غير معرّف
$9E53: 95 78    STA  $78,X
$9E55: 2D 90 B5 AND  $B590
$9E58: FF          .byte $FF  ; غير معرّف
$9E59: A5 86    LDA  $86
$9E5B: E4 28    CPX  $28
$9E5D: 18       CLC  
$9E5E: A8       TAY  
$9E5F: 45 83    EOR  $83
$9E61: 69 03    ADC  #$03
$9E63: C6 29    DEC  $29
$9E65: 9B          .byte $9B  ; غير معرّف
$9E66: 83          .byte $83  ; غير معرّف
$9E67: 16 A4    ASL  $A4,X
$9E69: 88       DEY  
$9E6A: 24 E9    BIT  $E9
$9E6C: 28       PLP  
$9E6D: 05 A8    ORA  $A8
$9E6F: 7B          .byte $7B  ; غير معرّف
$9E70: 28       PLP  
$9E71: 24 8F    BIT  $8F
$9E73: C8       INY  
$9E74: 03          .byte $03  ; غير معرّف
$9E75: E8       INX  
$9E76: 03          .byte $03  ; غير معرّف
$9E77: 46 A8    LSR  $A8
$9E79: 85 24    STA  $24
$9E7B: C8       INY  
$9E7C: 24 FF    BIT  $FF
$9E7E: EB          .byte $EB  ; غير معرّف
$9E7F: 8E 0F 03 STX  $030F
$9E82: FB          .byte $FB  ; غير معرّف
$9E83: 05 17    ORA  $17
$9E85: 85 DB    STA  $DB
$9E87: 8E 0F 07 STX  $070F
$9E8A: 57          .byte $57  ; غير معرّف
$9E8B: 05 7B    ORA  $7B
$9E8D: 05 9B    ORA  $9B
$9E8F: 80          .byte $80  ; غير معرّف
$9E90: 2B          .byte $2B  ; غير معرّف
$9E91: 85 FB    STA  $FB
$9E93: 05 0F    ORA  $0F
$9E95: 0B          .byte $0B  ; غير معرّف
$9E96: 1B          .byte $1B  ; غير معرّف
$9E97: 05 9B    ORA  $9B
$9E99: 05 FF    ORA  $FF
$9E9B: 2E C2 66 ROL  $66C2
$9E9E: E2          .byte $E2  ; غير معرّف
$9E9F: 11 0F    ORA  ($0F),Y
$9EA1: 07          .byte $07  ; غير معرّف
$9EA2: 02          .byte $02  ; غير معرّف
$9EA3: 11 0F    ORA  ($0F),Y
$9EA5: 0C          .byte $0C  ; غير معرّف
$9EA6: 12          .byte $12  ; غير معرّف
$9EA7: 11 FF    ORA  ($FF),Y
$9EA9: 0E C2 A8 ASL  $A8C2
$9EAC: AB          .byte $AB  ; غير معرّف
$9EAD: 00       BRK  
$9EAE: BB          .byte $BB  ; غير معرّف
$9EAF: 8E 6B 82 STX  $826B
$9EB2: DE 00 A0 DEC  $A000,X
$9EB5: 33          .byte $33  ; غير معرّف
$9EB6: 86 43    STX  $43
$9EB8: 06 3E    ASL  $3E
$9EBA: B4 A0    LDY  $A0,X
$9EBC: CB          .byte $CB  ; غير معرّف
$9EBD: 02          .byte $02  ; غير معرّف
$9EBE: 0F          .byte $0F  ; غير معرّف
$9EBF: 07          .byte $07  ; غير معرّف
$9EC0: 7E 42 A6 ROR  $A642,X
$9EC3: 83          .byte $83  ; غير معرّف
$9EC4: 02          .byte $02  ; غير معرّف
$9EC5: 0F          .byte $0F  ; غير معرّف
$9EC6: 0A       ASL  A
$9EC7: 3B          .byte $3B  ; غير معرّف
$9EC8: 02          .byte $02  ; غير معرّف
$9EC9: CB          .byte $CB  ; غير معرّف
$9ECA: 37          .byte $37  ; غير معرّف
$9ECB: 0F          .byte $0F  ; غير معرّف
$9ECC: 0C          .byte $0C  ; غير معرّف
$9ECD: E3          .byte $E3  ; غير معرّف
$9ECE: 0E FF 9B ASL  $9BFF
$9ED1: 8E CA 0E STX  $0ECA
$9ED4: EE 42 44 INC  $4442
$9ED7: 5B          .byte $5B  ; غير معرّف
$9ED8: 86 80    STX  $80
$9EDA: B8       CLV  
$9EDB: 1B          .byte $1B  ; غير معرّف
$9EDC: 80          .byte $80  ; غير معرّف
$9EDD: 50 BA    BVC  $9E99
$9EDF: 10 B7    BPL  $9E98
$9EE1: 5B          .byte $5B  ; غير معرّف
$9EE2: 00       BRK  
$9EE3: 17          .byte $17  ; غير معرّف
$9EE4: 85 4B    STA  $4B
$9EE6: 05 FE    ORA  $FE
$9EE8: 34          .byte $34  ; غير معرّف
$9EE9: 40       RTI  
$9EEA: B7          .byte $B7  ; غير معرّف
$9EEB: 86 C6    STX  $C6
$9EED: 06 5B    ASL  $5B
$9EEF: 80          .byte $80  ; غير معرّف
$9EF0: 83          .byte $83  ; غير معرّف
$9EF1: 00       BRK  
$9EF2: D0 38    BNE  $9F2C
$9EF4: 5B          .byte $5B  ; غير معرّف
$9EF5: 8E 8A 0E STX  $0E8A
$9EF8: A6 00    LDX  $00
$9EFA: BB          .byte $BB  ; غير معرّف
$9EFB: 0E C5 80 ASL  $80C5
$9EFE: F3          .byte $F3  ; غير معرّف
$9EFF: 00       BRK  
$9F00: FF          .byte $FF  ; غير معرّف
$9F01: 1E C2 00 ASL  $00C2,X
$9F04: 6B          .byte $6B  ; غير معرّف
$9F05: 06 8B    ASL  $8B
$9F07: 86 63    STX  $63
$9F09: B7          .byte $B7  ; غير معرّف
$9F0A: 0F          .byte $0F  ; غير معرّف
$9F0B: 05 03    ORA  $03
$9F0D: 06 23    ASL  $23
$9F0F: 06 4B    ASL  $4B
$9F11: B7          .byte $B7  ; غير معرّف
$9F12: BB          .byte $BB  ; غير معرّف
$9F13: 00       BRK  
$9F14: 5B          .byte $5B  ; غير معرّف
$9F15: B7          .byte $B7  ; غير معرّف
$9F16: FB          .byte $FB  ; غير معرّف
$9F17: 37          .byte $37  ; غير معرّف
$9F18: 3B          .byte $3B  ; غير معرّف
$9F19: B7          .byte $B7  ; غير معرّف
$9F1A: 0F          .byte $0F  ; غير معرّف
$9F1B: 0B          .byte $0B  ; غير معرّف
$9F1C: 1B          .byte $1B  ; غير معرّف
$9F1D: 37          .byte $37  ; غير معرّف
$9F1E: FF          .byte $FF  ; غير معرّف
$9F1F: 2B          .byte $2B  ; غير معرّف
$9F20: D7          .byte $D7  ; غير معرّف
$9F21: E3          .byte $E3  ; غير معرّف
$9F22: 03          .byte $03  ; غير معرّف
$9F23: C2          .byte $C2  ; غير معرّف
$9F24: 86 E2    STX  $E2
$9F26: 06 76    ASL  $76
$9F28: A5 A3    LDA  $A3
$9F2A: 8F          .byte $8F  ; غير معرّف
$9F2B: 03          .byte $03  ; غير معرّف
$9F2C: 86 2B    STX  $2B
$9F2E: 57          .byte $57  ; غير معرّف
$9F2F: 68       PLA  
$9F30: 28       PLP  
$9F31: E9 28    SBC  #$28
$9F33: E5 83    SBC  $83
$9F35: 24 8F    BIT  $8F
$9F37: 36 A8    ROL  $A8,X
$9F39: 5B          .byte $5B  ; غير معرّف
$9F3A: 03          .byte $03  ; غير معرّف
$9F3B: FF          .byte $FF  ; غير معرّف
$9F3C: 0F          .byte $0F  ; غير معرّف
$9F3D: 02          .byte $02  ; غير معرّف
$9F3E: 78       SEI  
$9F3F: 40       RTI  
$9F40: 48       PHA  
$9F41: CE F8 C3 DEC  $C3F8
$9F44: F8       SED  
$9F45: C3          .byte $C3  ; غير معرّف
$9F46: 0F          .byte $0F  ; غير معرّف
$9F47: 07          .byte $07  ; غير معرّف
$9F48: 7B          .byte $7B  ; غير معرّف
$9F49: 43          .byte $43  ; غير معرّف
$9F4A: C6 D0    DEC  $D0
$9F4C: 0F          .byte $0F  ; غير معرّف
$9F4D: 8A       TXA  
$9F4E: C8       INY  
$9F4F: 50 FF    BVC  $9F50
$9F51: 85 86    STA  $86
$9F53: 0B          .byte $0B  ; غير معرّف
$9F54: 80          .byte $80  ; غير معرّف
$9F55: 1B          .byte $1B  ; غير معرّف
$9F56: 00       BRK  
$9F57: DB          .byte $DB  ; غير معرّف
$9F58: 37          .byte $37  ; غير معرّف
$9F59: 77          .byte $77  ; غير معرّف
$9F5A: 80          .byte $80  ; غير معرّف
$9F5B: EB          .byte $EB  ; غير معرّف
$9F5C: 37          .byte $37  ; غير معرّف
$9F5D: FE 2B 20 INC  $202B,X
$9F60: 2B          .byte $2B  ; غير معرّف
$9F61: 80          .byte $80  ; غير معرّف
$9F62: 7B          .byte $7B  ; غير معرّف
$9F63: 38       SEC  
$9F64: AB          .byte $AB  ; غير معرّف
$9F65: B8       CLV  
$9F66: 77          .byte $77  ; غير معرّف
$9F67: 86 FE    STX  $FE
$9F69: 42          .byte $42  ; غير معرّف
$9F6A: 20 49 86 JSR  $8649
$9F6D: 8B          .byte $8B  ; غير معرّف
$9F6E: 06 9B    ASL  $9B
$9F70: 80          .byte $80  ; غير معرّف
$9F71: 7B          .byte $7B  ; غير معرّف
$9F72: 8E 5B B7 STX  $B75B
$9F75: 9B          .byte $9B  ; غير معرّف
$9F76: 0E BB 0E ASL  $0EBB
$9F79: 9B          .byte $9B  ; غير معرّف
$9F7A: 80          .byte $80  ; غير معرّف
$9F7B: FF          .byte $FF  ; غير معرّف
$9F7C: 0B          .byte $0B  ; غير معرّف
$9F7D: 80          .byte $80  ; غير معرّف
$9F7E: 60       RTS  
$9F7F: 38       SEC  
$9F80: 10 B8    BPL  $9F3A
$9F82: C0 3B    CPY  #$3B
$9F84: DB          .byte $DB  ; غير معرّف
$9F85: 8E 40 B8 STX  $B840
$9F88: F0 38    BEQ  $9FC2
$9F8A: 7B          .byte $7B  ; غير معرّف
$9F8B: 8E A0 B8 STX  $B8A0
$9F8E: C0 B8    CPY  #$B8
$9F90: FB          .byte $FB  ; غير معرّف
$9F91: 00       BRK  
$9F92: A0 B8    LDY  #$B8
$9F94: 30 BB    BMI  $9F51
$9F96: EE 42 88 INC  $8842
$9F99: 0F          .byte $0F  ; غير معرّف
$9F9A: 0B          .byte $0B  ; غير معرّف
$9F9B: 2B          .byte $2B  ; غير معرّف
$9F9C: 0E 67 0E ASL  $0E67
$9F9F: FF          .byte $FF  ; غير معرّف
$9FA0: 0A       ASL  A
$9FA1: AA       TAX  
$9FA2: 0E 28 2A ASL  $2A28
$9FA5: 0E 31 88 ASL  $8831
$9FA8: FF          .byte $FF  ; غير معرّف
$9FA9: C7          .byte $C7  ; غير معرّف
$9FAA: 83          .byte $83  ; غير معرّف
$9FAB: D7          .byte $D7  ; غير معرّف
$9FAC: 03          .byte $03  ; غير معرّف
$9FAD: 42          .byte $42  ; غير معرّف
$9FAE: 8F          .byte $8F  ; غير معرّف
$9FAF: 7A          .byte $7A  ; غير معرّف
$9FB0: 03          .byte $03  ; غير معرّف
$9FB1: 05 A4    ORA  $A4
$9FB3: 78       SEI  
$9FB4: 24 A6    BIT  $A6
$9FB6: 25 E4    AND  $E4
$9FB8: 25 4B    AND  $4B
$9FBA: 83          .byte $83  ; غير معرّف
$9FBB: E3          .byte $E3  ; غير معرّف
$9FBC: 03          .byte $03  ; غير معرّف
$9FBD: 05 A4    ORA  $A4
$9FBF: 89          .byte $89  ; غير معرّف
$9FC0: 24 B5    BIT  $B5
$9FC2: 24 09    BIT  $09
$9FC4: A4 65    LDY  $65
$9FC6: 24 C9    BIT  $C9
$9FC8: 24 0F    BIT  $0F
$9FCA: 08       PHP  
$9FCB: 85 25    STA  $25
$9FCD: FF          .byte $FF  ; غير معرّف
$9FCE: CD A5 B5 CMP  $B5A5
$9FD1: A8       TAY  
$9FD2: 07          .byte $07  ; غير معرّف
$9FD3: A8       TAY  
$9FD4: 76 28    ROR  $28,X
$9FD6: CC 25 65 CPY  $6525
$9FD9: A4 A9    LDY  $A9
$9FDB: 24 E5    BIT  $E5
$9FDD: 24 19    BIT  $19
$9FDF: A4 0F    LDY  $0F
$9FE1: 07          .byte $07  ; غير معرّف
$9FE2: 95 28    STA  $28,X
$9FE4: E6 24    INC  $24
$9FE6: 19 A4 D7 ORA  $D7A4,Y
$9FE9: 29 16    AND  #$16
$9FEB: A9 58    LDA  #$58
$9FED: 29 97    AND  #$97
$9FEF: 29 FF    AND  #$FF
$9FF1: 0F          .byte $0F  ; غير معرّف
$9FF2: 02          .byte $02  ; غير معرّف
$9FF3: 02          .byte $02  ; غير معرّف
$9FF4: 11 0F    ORA  ($0F),Y
$9FF6: 07          .byte $07  ; غير معرّف
$9FF7: 02          .byte $02  ; غير معرّف
$9FF8: 11 FF    ORA  ($FF),Y
$9FFA: FF          .byte $FF  ; غير معرّف
$9FFB: 2B          .byte $2B  ; غير معرّف
$9FFC: 82          .byte $82  ; غير معرّف
$9FFD: AB          .byte $AB  ; غير معرّف
$9FFE: 38       SEC  
$9FFF: DE 42 E2 DEC  $E242,X
$A002: 1B          .byte $1B  ; غير معرّف
$A003: B8       CLV  
$A004: EB          .byte $EB  ; غير معرّف
$A005: 3B          .byte $3B  ; غير معرّف
$A006: DB          .byte $DB  ; غير معرّف
$A007: 80          .byte $80  ; غير معرّف
$A008: 8B          .byte $8B  ; غير معرّف
$A009: B8       CLV  
$A00A: 1B          .byte $1B  ; غير معرّف
$A00B: 82          .byte $82  ; غير معرّف
$A00C: FB          .byte $FB  ; غير معرّف
$A00D: B8       CLV  
$A00E: 7B          .byte $7B  ; غير معرّف
$A00F: 80          .byte $80  ; غير معرّف
$A010: FB          .byte $FB  ; غير معرّف
$A011: 3C          .byte $3C  ; غير معرّف
$A012: 5B          .byte $5B  ; غير معرّف
$A013: BC 7B B8 LDY  $B87B,X
$A016: 1B          .byte $1B  ; غير معرّف
$A017: 8E CB 0E STX  $0ECB
$A01A: 1B          .byte $1B  ; غير معرّف
$A01B: 8E 0F 0D STX  $0D0F
$A01E: 2B          .byte $2B  ; غير معرّف
$A01F: 3B          .byte $3B  ; غير معرّف
$A020: BB          .byte $BB  ; غير معرّف
$A021: B8       CLV  
$A022: EB          .byte $EB  ; غير معرّف
$A023: 82          .byte $82  ; غير معرّف
$A024: 4B          .byte $4B  ; غير معرّف
$A025: B8       CLV  
$A026: BB          .byte $BB  ; غير معرّف
$A027: 38       SEC  
$A028: 3B          .byte $3B  ; غير معرّف
$A029: B7          .byte $B7  ; غير معرّف
$A02A: BB          .byte $BB  ; غير معرّف
$A02B: 02          .byte $02  ; غير معرّف
$A02C: 0F          .byte $0F  ; غير معرّف
$A02D: 13          .byte $13  ; غير معرّف
$A02E: 1B          .byte $1B  ; غير معرّف
$A02F: 00       BRK  
$A030: CB          .byte $CB  ; غير معرّف
$A031: 80          .byte $80  ; غير معرّف
$A032: 6B          .byte $6B  ; غير معرّف
$A033: BC FF 7B LDY  $7BFF,X
$A036: 80          .byte $80  ; غير معرّف
$A037: AE 00 80 LDX  $8000
$A03A: 8B          .byte $8B  ; غير معرّف
$A03B: 8E E8 05 STX  $05E8
$A03E: F9 86 17 SBC  $1786,Y
$A041: 86 16    STX  $16
$A043: 85 4E    STA  $4E
$A045: 2B          .byte $2B  ; غير معرّف
$A046: 80          .byte $80  ; غير معرّف
$A047: AB          .byte $AB  ; غير معرّف
$A048: 8E 87 85 STX  $8587
$A04B: C3          .byte $C3  ; غير معرّف
$A04C: 05 8B    ORA  $8B
$A04E: 82          .byte $82  ; غير معرّف
$A04F: 9B          .byte $9B  ; غير معرّف
$A050: 02          .byte $02  ; غير معرّف
$A051: AB          .byte $AB  ; غير معرّف
$A052: 02          .byte $02  ; غير معرّف
$A053: BB          .byte $BB  ; غير معرّف
$A054: 86 CB    STX  $CB
$A056: 06 D3    ASL  $D3
$A058: 03          .byte $03  ; غير معرّف
$A059: 3B          .byte $3B  ; غير معرّف
$A05A: 8E 6B 0E STX  $0E6B
$A05D: A7          .byte $A7  ; غير معرّف
$A05E: 8E FF 29 STX  $29FF
$A061: 8E 52 11 STX  $1152
$A064: 83          .byte $83  ; غير معرّف
$A065: 0E 0F 03 ASL  $030F
$A068: 9B          .byte $9B  ; غير معرّف
$A069: 0E 2B 8E ASL  $8E2B
$A06C: 5B          .byte $5B  ; غير معرّف
$A06D: 0E CB 8E ASL  $8ECB
$A070: FB          .byte $FB  ; غير معرّف
$A071: 0E FB 82 ASL  $82FB
$A074: 9B          .byte $9B  ; غير معرّف
$A075: 82          .byte $82  ; غير معرّف
$A076: BB          .byte $BB  ; غير معرّف
$A077: 02          .byte $02  ; غير معرّف
$A078: FE 42 E8 INC  $E842,X
$A07B: BB          .byte $BB  ; غير معرّف
$A07C: 8E 0F 0A STX  $0A0F
$A07F: AB          .byte $AB  ; غير معرّف
$A080: 0E CB 0E ASL  $0ECB
$A083: F9 0E 88 SBC  $880E,Y
$A086: 86 A6    STX  $A6
$A088: 06 DB    ASL  $DB
$A08A: 02          .byte $02  ; غير معرّف
$A08B: B6 8E    LDX  $8E,Y
$A08D: FF          .byte $FF  ; غير معرّف
$A08E: AB          .byte $AB  ; غير معرّف
$A08F: CE DE 42 DEC  $42DE
$A092: C0 CB    CPY  #$CB
$A094: CE 5B 8E DEC  $8E5B
$A097: 1B          .byte $1B  ; غير معرّف
$A098: CE 4B 85 DEC  $854B
$A09B: 67          .byte $67  ; غير معرّف
$A09C: 45 0F    EOR  $0F
$A09E: 07          .byte $07  ; غير معرّف
$A09F: 2B          .byte $2B  ; غير معرّف
$A0A0: 00       BRK  
$A0A1: 7B          .byte $7B  ; غير معرّف
$A0A2: 85 97    STA  $97
$A0A4: 05 0F    ORA  $0F
$A0A6: 0A       ASL  A
$A0A7: 92          .byte $92  ; غير معرّف
$A0A8: 02          .byte $02  ; غير معرّف
$A0A9: FF          .byte $FF  ; غير معرّف
$A0AA: 0A       ASL  A
$A0AB: AA       TAX  
$A0AC: 0E 24 4A ASL  $4A24
$A0AF: 1E 23 AA ASL  $AA23,X
$A0B2: FF          .byte $FF  ; غير معرّف
$A0B3: 1B          .byte $1B  ; غير معرّف
$A0B4: 80          .byte $80  ; غير معرّف
$A0B5: BB          .byte $BB  ; غير معرّف
$A0B6: 38       SEC  
$A0B7: 4B          .byte $4B  ; غير معرّف
$A0B8: BC EB 3B LDY  $3BEB,X
$A0BB: 0F          .byte $0F  ; غير معرّف
$A0BC: 04          .byte $04  ; غير معرّف
$A0BD: 2B          .byte $2B  ; غير معرّف
$A0BE: 00       BRK  
$A0BF: AB          .byte $AB  ; غير معرّف
$A0C0: 38       SEC  
$A0C1: EB          .byte $EB  ; غير معرّف
$A0C2: 00       BRK  
$A0C3: CB          .byte $CB  ; غير معرّف
$A0C4: 8E FB 80 STX  $80FB
$A0C7: AB          .byte $AB  ; غير معرّف
$A0C8: B8       CLV  
$A0C9: 6B          .byte $6B  ; غير معرّف
$A0CA: 80          .byte $80  ; غير معرّف
$A0CB: FB          .byte $FB  ; غير معرّف
$A0CC: 3C          .byte $3C  ; غير معرّف
$A0CD: 9B          .byte $9B  ; غير معرّف
$A0CE: BB          .byte $BB  ; غير معرّف
$A0CF: 5B          .byte $5B  ; غير معرّف
$A0D0: BC FB 00 LDY  $00FB,X
$A0D3: 6B          .byte $6B  ; غير معرّف
$A0D4: B8       CLV  
$A0D5: FB          .byte $FB  ; غير معرّف
$A0D6: 38       SEC  
$A0D7: FF          .byte $FF  ; غير معرّف
$A0D8: 0B          .byte $0B  ; غير معرّف
$A0D9: 86 1A    STX  $1A
$A0DB: 06 DB    ASL  $DB
$A0DD: 06 DE    ASL  $DE
$A0DF: C2          .byte $C2  ; غير معرّف
$A0E0: 02          .byte $02  ; غير معرّف
$A0E1: F0 3B    BEQ  $A11E
$A0E3: BB          .byte $BB  ; غير معرّف
$A0E4: 80          .byte $80  ; غير معرّف
$A0E5: EB          .byte $EB  ; غير معرّف
$A0E6: 06 0B    ASL  $0B
$A0E8: 86 93    STX  $93
$A0EA: 06 F0    ASL  $F0
$A0EC: 39 0F 06 AND  $060F,Y
$A0EF: 60       RTS  
$A0F0: B8       CLV  
$A0F1: 1B          .byte $1B  ; غير معرّف
$A0F2: 86 A0    STX  $A0
$A0F4: B9 B7 27 LDA  $27B7,Y
$A0F7: BD 27 2B LDA  $2B27,X
$A0FA: 83          .byte $83  ; غير معرّف
$A0FB: A1 26    LDA  ($26,X)
$A0FD: A9 26    LDA  #$26
$A0FF: EE 25 0B INC  $0B25
$A102: 27          .byte $27  ; غير معرّف
$A103: B4 FF    LDY  $FF,X
$A105: 0F          .byte $0F  ; غير معرّف
$A106: 02          .byte $02  ; غير معرّف
$A107: 1E 2F 60 ASL  $602F,X
$A10A: E0 3A    CPX  #$3A
$A10C: A5 A7    LDA  $A7
$A10E: DB          .byte $DB  ; غير معرّف
$A10F: 80          .byte $80  ; غير معرّف
$A110: 3B          .byte $3B  ; غير معرّف
$A111: 82          .byte $82  ; غير معرّف
$A112: 8B          .byte $8B  ; غير معرّف
$A113: 02          .byte $02  ; غير معرّف
$A114: FE 42 68 INC  $6842,X
$A117: 70 BB    BVS  $A0D4
$A119: 25 A7    AND  $A7
$A11B: 2C 27 B2 BIT  $B227
$A11E: 26 B9    ROL  $B9
$A120: 26 9B    ROL  $9B
$A122: 80          .byte $80  ; غير معرّف
$A123: A8       TAY  
$A124: 82          .byte $82  ; غير معرّف
$A125: B5 27    LDA  $27,X
$A127: BC 27 B0 LDY  $B027,X
$A12A: BB          .byte $BB  ; غير معرّف
$A12B: 3B          .byte $3B  ; غير معرّف
$A12C: 82          .byte $82  ; غير معرّف
$A12D: 87          .byte $87  ; غير معرّف
$A12E: 34          .byte $34  ; غير معرّف
$A12F: EE 25 6B INC  $6B25
$A132: FF          .byte $FF  ; غير معرّف
$A133: 1E A5 0A ASL  $0AA5,X
$A136: 2E 28 27 ROL  $2728
$A139: 2E 33 C7 ROL  $C733
$A13C: 0F          .byte $0F  ; غير معرّف
$A13D: 03          .byte $03  ; غير معرّف
$A13E: 1E 40 07 ASL  $0740,X
$A141: 2E 30 E7 ROL  $E730
$A144: 0F          .byte $0F  ; غير معرّف
$A145: 05 1E    ORA  $1E
$A147: 24 44    BIT  $44
$A149: 0F          .byte $0F  ; غير معرّف
$A14A: 07          .byte $07  ; غير معرّف
$A14B: 1E 22 6A ASL  $6A22,X
$A14E: 2E 23 AB ROL  $AB23
$A151: 0F          .byte $0F  ; غير معرّف
$A152: 09 1E    ORA  #$1E
$A154: 41 68    EOR  ($68,X)
$A156: 1E 2A 8A ASL  $8A2A,X
$A159: 2E 23 A2 ROL  $A223
$A15C: 2E 32 EA ROL  $EA32
$A15F: FF          .byte $FF  ; غير معرّف
$A160: 3B          .byte $3B  ; غير معرّف
$A161: 87          .byte $87  ; غير معرّف
$A162: 66 27    ROR  $27
$A164: CC 27 EE CPY  $EE27
$A167: 31 87    AND  ($87),Y
$A169: EE 23 A7 INC  $A723
$A16C: 3B          .byte $3B  ; غير معرّف
$A16D: 87          .byte $87  ; غير معرّف
$A16E: DB          .byte $DB  ; غير معرّف
$A16F: 07          .byte $07  ; غير معرّف
$A170: FF          .byte $FF  ; غير معرّف
$A171: 0F          .byte $0F  ; غير معرّف
$A172: 01 2E    ORA  ($2E,X)
$A174: 25 2B    AND  $2B
$A176: 2E 25 4B ROL  $4B25
$A179: 4E 25 CB LSR  $CB25
$A17C: 6B          .byte $6B  ; غير معرّف
$A17D: 07          .byte $07  ; غير معرّف
$A17E: 97          .byte $97  ; غير معرّف
$A17F: 47          .byte $47  ; غير معرّف
$A180: E9 87    SBC  #$87
$A182: 47          .byte $47  ; غير معرّف
$A183: C7          .byte $C7  ; غير معرّف
$A184: 7A          .byte $7A  ; غير معرّف
$A185: 07          .byte $07  ; غير معرّف
$A186: D6 C7    DEC  $C7,X
$A188: 78       SEI  
$A189: 07          .byte $07  ; غير معرّف
$A18A: 38       SEC  
$A18B: 87          .byte $87  ; غير معرّف
$A18C: AB          .byte $AB  ; غير معرّف
$A18D: 47          .byte $47  ; غير معرّف
$A18E: E3          .byte $E3  ; غير معرّف
$A18F: 07          .byte $07  ; غير معرّف
$A190: 9B          .byte $9B  ; غير معرّف
$A191: 87          .byte $87  ; غير معرّف
$A192: 0F          .byte $0F  ; غير معرّف
$A193: 09 68    ORA  #$68
$A195: 47          .byte $47  ; غير معرّف
$A196: DB          .byte $DB  ; غير معرّف
$A197: C7          .byte $C7  ; غير معرّف
$A198: 3B          .byte $3B  ; غير معرّف
$A199: C7          .byte $C7  ; غير معرّف
$A19A: FF          .byte $FF  ; غير معرّف
$A19B: 47          .byte $47  ; غير معرّف
$A19C: 9B          .byte $9B  ; غير معرّف
$A19D: CB          .byte $CB  ; غير معرّف
$A19E: 07          .byte $07  ; غير معرّف
$A19F: FA          .byte $FA  ; غير معرّف
$A1A0: 1D 86 9B ORA  $9B86,X
$A1A3: 3A          .byte $3A  ; غير معرّف
$A1A4: 87          .byte $87  ; غير معرّف
$A1A5: 56 07    LSR  $07,X
$A1A7: 88       DEY  
$A1A8: 1B          .byte $1B  ; غير معرّف
$A1A9: 07          .byte $07  ; غير معرّف
$A1AA: 9D 2E 65 STA  $652E,X
$A1AD: F0 FF    BEQ  $A1AE
$A1AF: 9B          .byte $9B  ; غير معرّف
$A1B0: 07          .byte $07  ; غير معرّف
$A1B1: 05 32    ORA  $32
$A1B3: 06 33    ASL  $33
$A1B5: 07          .byte $07  ; غير معرّف
$A1B6: 34          .byte $34  ; غير معرّف
$A1B7: CE 03 DC DEC  $DC03
$A1BA: 51 EE    EOR  ($EE),Y
$A1BC: 07          .byte $07  ; غير معرّف
$A1BD: 73          .byte $73  ; غير معرّف
$A1BE: E0 74    CPX  #$74
$A1C0: 0A       ASL  A
$A1C1: 7E 06 9E ROR  $9E06,X
$A1C4: 0A       ASL  A
$A1C5: CE 06 E4 DEC  $E406
$A1C8: 00       BRK  
$A1C9: E8       INX  
$A1CA: 0A       ASL  A
$A1CB: FE 0A 2E INC  $2E0A,X
$A1CE: 89          .byte $89  ; غير معرّف
$A1CF: 4E 0B 54 LSR  $540B
$A1D2: 0A       ASL  A
$A1D3: 14          .byte $14  ; غير معرّف
$A1D4: 8A       TXA  
$A1D5: C4 0A    CPY  $0A
$A1D7: 34          .byte $34  ; غير معرّف
$A1D8: 8A       TXA  
$A1D9: 7E 06 C7 ROR  $C706,X
$A1DC: 0A       ASL  A
$A1DD: 01 E0    ORA  ($E0,X)
$A1DF: 02          .byte $02  ; غير معرّف
$A1E0: 0A       ASL  A
$A1E1: 47          .byte $47  ; غير معرّف
$A1E2: 0A       ASL  A
$A1E3: 81 60    STA  ($60,X)
$A1E5: 82          .byte $82  ; غير معرّف
$A1E6: 0A       ASL  A
$A1E7: C7          .byte $C7  ; غير معرّف
$A1E8: 0A       ASL  A
$A1E9: 0E 87 7E ASL  $7E87
$A1EC: 02          .byte $02  ; غير معرّف
$A1ED: A7          .byte $A7  ; غير معرّف
$A1EE: 02          .byte $02  ; غير معرّف
$A1EF: B3          .byte $B3  ; غير معرّف
$A1F0: 02          .byte $02  ; غير معرّف
$A1F1: D7          .byte $D7  ; غير معرّف
$A1F2: 02          .byte $02  ; غير معرّف
$A1F3: E3          .byte $E3  ; غير معرّف
$A1F4: 02          .byte $02  ; غير معرّف
$A1F5: 07          .byte $07  ; غير معرّف
$A1F6: 82          .byte $82  ; غير معرّف
$A1F7: 13          .byte $13  ; غير معرّف
$A1F8: 02          .byte $02  ; غير معرّف
$A1F9: 3E 06 7E ROL  $7E06,X
$A1FC: 02          .byte $02  ; غير معرّف
$A1FD: AE 07 FE LDX  $FE07
$A200: 0A       ASL  A
$A201: 0D C4 CD ORA  $CDC4
$A204: 43          .byte $43  ; غير معرّف
$A205: CE 09 DE DEC  $DE09
$A208: 0B          .byte $0B  ; غير معرّف
$A209: DD 42 FE CMP  $FE42,X
$A20C: 02          .byte $02  ; غير معرّف
$A20D: 5D C7 FD EOR  $FDC7,X
$A210: 5B          .byte $5B  ; غير معرّف
$A211: 07          .byte $07  ; غير معرّف
$A212: 05 32    ORA  $32
$A214: 06 33    ASL  $33
$A216: 07          .byte $07  ; غير معرّف
$A217: 34          .byte $34  ; غير معرّف
$A218: 5E 0A 68 LSR  $680A,X
$A21B: 64          .byte $64  ; غير معرّف
$A21C: 98       TYA  
$A21D: 64          .byte $64  ; غير معرّف
$A21E: A8       TAY  
$A21F: 64          .byte $64  ; غير معرّف
$A220: CE 06 FE DEC  $FE06
$A223: 02          .byte $02  ; غير معرّف
$A224: 0D 01 1E ORA  $1E01
$A227: 0E 7E 02 ASL  $027E
$A22A: 94 63    STY  $63,X
$A22C: B4 63    LDY  $63,X
$A22E: D4          .byte $D4  ; غير معرّف
$A22F: 63          .byte $63  ; غير معرّف
$A230: F4          .byte $F4  ; غير معرّف
$A231: 63          .byte $63  ; غير معرّف
$A232: 14          .byte $14  ; غير معرّف
$A233: E3          .byte $E3  ; غير معرّف
$A234: 2E 0E 5E ROL  $5E0E
$A237: 02          .byte $02  ; غير معرّف
$A238: 64          .byte $64  ; غير معرّف
$A239: 35 88    AND  $88,X
$A23B: 72          .byte $72  ; غير معرّف
$A23C: BE 0E 0D LDX  $0D0E,Y
$A23F: 04          .byte $04  ; غير معرّف
$A240: AE 02 CE LDX  $CE02
$A243: 08       PHP  
$A244: CD 4B FE CMP  $FE4B
$A247: 02          .byte $02  ; غير معرّف
$A248: 0D 05 68 ORA  $6805
$A24B: 31 7E    AND  ($7E),Y
$A24D: 0A       ASL  A
$A24E: 96 31    STX  $31,Y
$A250: A9 63    LDA  #$63
$A252: A8       TAY  
$A253: 33          .byte $33  ; غير معرّف
$A254: D5 30    CMP  $30,X
$A256: EE 02 E6 INC  $E602
$A259: 62          .byte $62  ; غير معرّف
$A25A: F4          .byte $F4  ; غير معرّف
$A25B: 61 04    ADC  ($04,X)
$A25D: B1 08    LDA  ($08),Y
$A25F: 3F          .byte $3F  ; غير معرّف
$A260: 44          .byte $44  ; غير معرّف
$A261: 33          .byte $33  ; غير معرّف
$A262: 94 63    STY  $63,X
$A264: A4 31    LDY  $31
$A266: E4 31    CPX  $31
$A268: 04          .byte $04  ; غير معرّف
$A269: BF          .byte $BF  ; غير معرّف
$A26A: 08       PHP  
$A26B: 3F          .byte $3F  ; غير معرّف
$A26C: 04          .byte $04  ; غير معرّف
$A26D: BF          .byte $BF  ; غير معرّف
$A26E: 08       PHP  
$A26F: 3F          .byte $3F  ; غير معرّف
$A270: CD 4B 03 CMP  $034B
$A273: E4 0E    CPX  $0E
$A275: 03          .byte $03  ; غير معرّف
$A276: 2E 01 7E ROL  $7E01
$A279: 06 BE    ASL  $BE
$A27B: 02          .byte $02  ; غير معرّف
$A27C: DE 06 FE DEC  $FE06,X
$A27F: 0A       ASL  A
$A280: 0D C4 CD ORA  $CDC4
$A283: 43          .byte $43  ; غير معرّف
$A284: CE 09 DE DEC  $DE09
$A287: 0B          .byte $0B  ; غير معرّف
$A288: DD 42 FE CMP  $FE42,X
$A28B: 02          .byte $02  ; غير معرّف
$A28C: 5D C7 FD EOR  $FDC7,X
$A28F: 9B          .byte $9B  ; غير معرّف
$A290: 07          .byte $07  ; غير معرّف
$A291: 05 32    ORA  $32
$A293: 06 33    ASL  $33
$A295: 07          .byte $07  ; غير معرّف
$A296: 34          .byte $34  ; غير معرّف
$A297: FE 00 27 INC  $2700,X
$A29A: B1 65    LDA  ($65),Y
$A29C: 32          .byte $32  ; غير معرّف
$A29D: 75 0A    ADC  $0A,X
$A29F: 71 00    ADC  ($00),Y
$A2A1: B7          .byte $B7  ; غير معرّف
$A2A2: 31 08    AND  ($08),Y
$A2A4: E4 18    CPX  $18
$A2A6: 64          .byte $64  ; غير معرّف
$A2A7: 1E 04 57 ASL  $5704,X
$A2AA: 3B          .byte $3B  ; غير معرّف
$A2AB: BB          .byte $BB  ; غير معرّف
$A2AC: 0A       ASL  A
$A2AD: 17          .byte $17  ; غير معرّف
$A2AE: 8A       TXA  
$A2AF: 27          .byte $27  ; غير معرّف
$A2B0: 3A          .byte $3A  ; غير معرّف
$A2B1: 73          .byte $73  ; غير معرّف
$A2B2: 0A       ASL  A
$A2B3: 7B          .byte $7B  ; غير معرّف
$A2B4: 0A       ASL  A
$A2B5: D7          .byte $D7  ; غير معرّف
$A2B6: 0A       ASL  A
$A2B7: E7          .byte $E7  ; غير معرّف
$A2B8: 3A          .byte $3A  ; غير معرّف
$A2B9: 3B          .byte $3B  ; غير معرّف
$A2BA: 8A       TXA  
$A2BB: 97          .byte $97  ; غير معرّف
$A2BC: 0A       ASL  A
$A2BD: FE 08 24 INC  $2408,X
$A2C0: 8A       TXA  
$A2C1: 2E 00 3E ROL  $3E00
$A2C4: 40       RTI  
$A2C5: 38       SEC  
$A2C6: 64          .byte $64  ; غير معرّف
$A2C7: 6F          .byte $6F  ; غير معرّف
$A2C8: 00       BRK  
$A2C9: 9F          .byte $9F  ; غير معرّف
$A2CA: 00       BRK  
$A2CB: BE 43 C8 LDX  $C843,Y
$A2CE: 0A       ASL  A
$A2CF: C9          .byte $C9  ; غير معرّف
$A2D0: 63          .byte $63  ; غير معرّف
$A2D1: CE 07 FE DEC  $FE07
$A2D4: 07          .byte $07  ; غير معرّف
$A2D5: 2E 81 66 ROL  $6681
$A2D8: 42          .byte $42  ; غير معرّف
$A2D9: 6A       ROR  A
$A2DA: 42          .byte $42  ; غير معرّف
$A2DB: 79 0A BE ADC  $BE0A,Y
$A2DE: 00       BRK  
$A2DF: C8       INY  
$A2E0: 64          .byte $64  ; غير معرّف
$A2E1: F8       SED  
$A2E2: 64          .byte $64  ; غير معرّف
$A2E3: 08       PHP  
$A2E4: E4 2E    CPX  $2E
$A2E6: 07          .byte $07  ; غير معرّف
$A2E7: 7E 03 9E ROR  $9E03,X
$A2EA: 07          .byte $07  ; غير معرّف
$A2EB: BE 03 DE LDX  $DE03,Y
$A2EE: 07          .byte $07  ; غير معرّف
$A2EF: FE 0A 03 INC  $030A,X
$A2F2: A5 0D    LDA  $0D
$A2F4: 44          .byte $44  ; غير معرّف
$A2F5: CD 43 CE CMP  $CE43
$A2F8: 09 DD    ORA  #$DD
$A2FA: 42          .byte $42  ; غير معرّف
$A2FB: DE 0B FE DEC  $FE0B,X
$A2FE: 02          .byte $02  ; غير معرّف
$A2FF: 5D C7 FD EOR  $FDC7,X
$A302: 9B          .byte $9B  ; غير معرّف
$A303: 07          .byte $07  ; غير معرّف
$A304: 05 32    ORA  $32
$A306: 06 33    ASL  $33
$A308: 07          .byte $07  ; غير معرّف
$A309: 34          .byte $34  ; غير معرّف
$A30A: FE 06 0C INC  $0C06,X
$A30D: 81 39    STA  ($39,X)
$A30F: 0A       ASL  A
$A310: 5C          .byte $5C  ; غير معرّف
$A311: 01 89    ORA  ($89,X)
$A313: 0A       ASL  A
$A314: AC 01 D9 LDY  $D901
$A317: 0A       ASL  A
$A318: FC          .byte $FC  ; غير معرّف
$A319: 01 2E    ORA  ($2E,X)
$A31B: 83          .byte $83  ; غير معرّف
$A31C: A7          .byte $A7  ; غير معرّف
$A31D: 01 B7    ORA  ($B7,X)
$A31F: 00       BRK  
$A320: C7          .byte $C7  ; غير معرّف
$A321: 01 DE    ORA  ($DE,X)
$A323: 0A       ASL  A
$A324: FE 02 4E INC  $4E02,X
$A327: 83          .byte $83  ; غير معرّف
$A328: 5A          .byte $5A  ; غير معرّف
$A329: 32          .byte $32  ; غير معرّف
$A32A: 63          .byte $63  ; غير معرّف
$A32B: 0A       ASL  A
$A32C: 69 0A    ADC  #$0A
$A32E: 7E 02 EE ROR  $EE02,X
$A331: 03          .byte $03  ; غير معرّف
$A332: FA          .byte $FA  ; غير معرّف
$A333: 32          .byte $32  ; غير معرّف
$A334: 03          .byte $03  ; غير معرّف
$A335: 8A       TXA  
$A336: 09 0A    ORA  #$0A
$A338: 1E 02 EE ASL  $EE02,X
$A33B: 03          .byte $03  ; غير معرّف
$A33C: FA          .byte $FA  ; غير معرّف
$A33D: 32          .byte $32  ; غير معرّف
$A33E: 03          .byte $03  ; غير معرّف
$A33F: 8A       TXA  
$A340: 09 0A    ORA  #$0A
$A342: 14          .byte $14  ; غير معرّف
$A343: 42          .byte $42  ; غير معرّف
$A344: 1E 02 7E ASL  $7E02,X
$A347: 0A       ASL  A
$A348: 9E          .byte $9E  ; غير معرّف
$A349: 07          .byte $07  ; غير معرّف
$A34A: FE 0A 2E INC  $2E0A,X
$A34D: 86 5E    STX  $5E
$A34F: 0A       ASL  A
$A350: 8E 06 BE STX  $BE06
$A353: 0A       ASL  A
$A354: EE 07 3E INC  $3E07
$A357: 83          .byte $83  ; غير معرّف
$A358: 5E 07 FE LSR  $FE07,X
$A35B: 0A       ASL  A
$A35C: 0D C4 41 ORA  $41C4
$A35F: 52          .byte $52  ; غير معرّف
$A360: 51 52    EOR  ($52),Y
$A362: CD 43 CE CMP  $CE43
$A365: 09 DE    ORA  #$DE
$A367: 0B          .byte $0B  ; غير معرّف
$A368: DD 42 FE CMP  $FE42,X
$A36B: 02          .byte $02  ; غير معرّف
$A36C: 5D C7 FD EOR  $FDC7,X
$A36F: 5B          .byte $5B  ; غير معرّف
$A370: 07          .byte $07  ; غير معرّف
$A371: 05 32    ORA  $32
$A373: 06 33    ASL  $33
$A375: 07          .byte $07  ; غير معرّف
$A376: 34          .byte $34  ; غير معرّف
$A377: FE 0A AE INC  $AE0A,X
$A37A: 86 BE    STX  $BE
$A37C: 07          .byte $07  ; غير معرّف
$A37D: FE 02 0D INC  $0D02,X
$A380: 02          .byte $02  ; غير معرّف
$A381: 27          .byte $27  ; غير معرّف
$A382: 32          .byte $32  ; غير معرّف
$A383: 46 61    LSR  $61
$A385: 55 62    EOR  $62,X
$A387: 5E 0E 1E LSR  $1E0E,X
$A38A: 82          .byte $82  ; غير معرّف
$A38B: 68       PLA  
$A38C: 3C          .byte $3C  ; غير معرّف
$A38D: 74          .byte $74  ; غير معرّف
$A38E: 3A          .byte $3A  ; غير معرّف
$A38F: 7D 4B 5E ADC  $5E4B,X
$A392: 8E 7D 4B STX  $4B7D
$A395: 7E 82 84 ROR  $8482,X
$A398: 62          .byte $62  ; غير معرّف
$A399: 94 61    STY  $61,X
$A39B: A4 31    LDY  $31
$A39D: BD 4B CE LDA  $CE4B,X
$A3A0: 06 FE    ASL  $FE
$A3A2: 02          .byte $02  ; غير معرّف
$A3A3: 0D 06 34 ORA  $3406
$A3A6: 31 3E    AND  ($3E),Y
$A3A8: 0A       ASL  A
$A3A9: 64          .byte $64  ; غير معرّف
$A3AA: 32          .byte $32  ; غير معرّف
$A3AB: 75 0A    ADC  $0A,X
$A3AD: 7B          .byte $7B  ; غير معرّف
$A3AE: 61 A4    ADC  ($A4,X)
$A3B0: 33          .byte $33  ; غير معرّف
$A3B1: AE 02 DE LDX  $DE02
$A3B4: 0E 3E 82 ASL  $823E
$A3B7: 64          .byte $64  ; غير معرّف
$A3B8: 32          .byte $32  ; غير معرّف
$A3B9: 78       SEI  
$A3BA: 32          .byte $32  ; غير معرّف
$A3BB: B4 36    LDY  $36,X
$A3BD: C8       INY  
$A3BE: 36 DD    ROL  $DD,X
$A3C0: 4B          .byte $4B  ; غير معرّف
$A3C1: 44          .byte $44  ; غير معرّف
$A3C2: B2          .byte $B2  ; غير معرّف
$A3C3: 58       CLI  
$A3C4: 32          .byte $32  ; غير معرّف
$A3C5: 94 63    STY  $63,X
$A3C7: A4 3E    LDY  $3E
$A3C9: BA       TSX  
$A3CA: 30 C9    BMI  $A395
$A3CC: 61 CE    ADC  ($CE,X)
$A3CE: 06 DD    ASL  $DD
$A3D0: 4B          .byte $4B  ; غير معرّف
$A3D1: CE 86 DD DEC  $DD86
$A3D4: 4B          .byte $4B  ; غير معرّف
$A3D5: FE 02 2E INC  $2E02,X
$A3D8: 86 5E    STX  $5E
$A3DA: 02          .byte $02  ; غير معرّف
$A3DB: 7E 06 FE ROR  $FE06,X
$A3DE: 02          .byte $02  ; غير معرّف
$A3DF: 1E 86 3E ASL  $3E86,X
$A3E2: 02          .byte $02  ; غير معرّف
$A3E3: 5E 06 7E LSR  $7E06,X
$A3E6: 02          .byte $02  ; غير معرّف
$A3E7: 9E          .byte $9E  ; غير معرّف
$A3E8: 06 FE    ASL  $FE
$A3EA: 0A       ASL  A
$A3EB: 0D C4 CD ORA  $CDC4
$A3EE: 43          .byte $43  ; غير معرّف
$A3EF: CE 09 DE DEC  $DE09
$A3F2: 0B          .byte $0B  ; غير معرّف
$A3F3: DD 42 FE CMP  $FE42,X
$A3F6: 02          .byte $02  ; غير معرّف
$A3F7: 5D C7 FD EOR  $FDC7,X
$A3FA: 5B          .byte $5B  ; غير معرّف
$A3FB: 06 05    ASL  $05
$A3FD: 32          .byte $32  ; غير معرّف
$A3FE: 06 33    ASL  $33
$A400: 07          .byte $07  ; غير معرّف
$A401: 34          .byte $34  ; غير معرّف
$A402: 5E 0A AE LSR  $AE0A,X
$A405: 02          .byte $02  ; غير معرّف
$A406: 0D 01 39 ORA  $3901
$A409: 73          .byte $73  ; غير معرّف
$A40A: 0D 03 39 ORA  $3903
$A40D: 7B          .byte $7B  ; غير معرّف
$A40E: 4D 4B DE EOR  $DE4B
$A411: 06 1E    ASL  $1E
$A413: 8A       TXA  
$A414: AE 06 C4 LDX  $C406
$A417: 33          .byte $33  ; غير معرّف
$A418: 16 FE    ASL  $FE,X
$A41A: A5 77    LDA  $77
$A41C: FE 02 FE INC  $FE02,X
$A41F: 82          .byte $82  ; غير معرّف
$A420: 0D 07 39 ORA  $3907
$A423: 73          .byte $73  ; غير معرّف
$A424: A8       TAY  
$A425: 74          .byte $74  ; غير معرّف
$A426: ED 4B 49 SBC  $494B
$A429: FB          .byte $FB  ; غير معرّف
$A42A: E8       INX  
$A42B: 74          .byte $74  ; غير معرّف
$A42C: FE 0A 2E INC  $2E0A,X
$A42F: 82          .byte $82  ; غير معرّف
$A430: 67          .byte $67  ; غير معرّف
$A431: 02          .byte $02  ; غير معرّف
$A432: 84 7A    STY  $7A
$A434: 87          .byte $87  ; غير معرّف
$A435: 31 0D    AND  ($0D),Y
$A437: 0B          .byte $0B  ; غير معرّف
$A438: FE 02 0D INC  $0D02,X
$A43B: 0C          .byte $0C  ; غير معرّف
$A43C: 39 73 5E AND  $5E73,Y
$A43F: 06 C6    ASL  $C6
$A441: 76 45    ROR  $45,X
$A443: FF          .byte $FF  ; غير معرّف
$A444: BE 0A DD LDX  $DD0A,Y
$A447: 48       PHA  
$A448: FE 06 3D INC  $3D06,X
$A44B: CB          .byte $CB  ; غير معرّف
$A44C: 46 7E    LSR  $7E
$A44E: AD 4A FE LDA  $FE4A
$A451: 82          .byte $82  ; غير معرّف
$A452: 39 F3 A9 AND  $A9F3,Y
$A455: 7B          .byte $7B  ; غير معرّف
$A456: 4E 8A 9E LSR  $9E8A
$A459: 07          .byte $07  ; غير معرّف
$A45A: FE 0A 0D INC  $0D0A,X
$A45D: C4 CD    CPY  $CD
$A45F: 43          .byte $43  ; غير معرّف
$A460: CE 09 DE DEC  $DE09
$A463: 0B          .byte $0B  ; غير معرّف
$A464: DD 42 FE CMP  $FE42,X
$A467: 02          .byte $02  ; غير معرّف
$A468: 5D C7 FD EOR  $FDC7,X
$A46B: 94 11    STY  $11,X
$A46D: 0F          .byte $0F  ; غير معرّف
$A46E: 26 FE    ROL  $FE
$A470: 10 28    BPL  $A49A
$A472: 94 65    STY  $65,X
$A474: 15 EB    ORA  $EB,X
$A476: 12          .byte $12  ; غير معرّف
$A477: FA          .byte $FA  ; غير معرّف
$A478: 41 4A    EOR  ($4A,X)
$A47A: 96 54    STX  $54,Y
$A47C: 40       RTI  
$A47D: A4 42    LDY  $42
$A47F: B7          .byte $B7  ; غير معرّف
$A480: 13          .byte $13  ; غير معرّف
$A481: E9 19    SBC  #$19
$A483: F5 15    SBC  $15,X
$A485: 11 80    ORA  ($80),Y
$A487: 47          .byte $47  ; غير معرّف
$A488: 42          .byte $42  ; غير معرّف
$A489: 71 13    ADC  ($13),Y
$A48B: 80          .byte $80  ; غير معرّف
$A48C: 41 15    EOR  ($15,X)
$A48E: 92          .byte $92  ; غير معرّف
$A48F: 1B          .byte $1B  ; غير معرّف
$A490: 1F          .byte $1F  ; غير معرّف
$A491: 24 40    BIT  $40
$A493: 55 12    EOR  $12,X
$A495: 64          .byte $64  ; غير معرّف
$A496: 40       RTI  
$A497: 95 12    STA  $12,X
$A499: A4 40    LDY  $40
$A49B: D2          .byte $D2  ; غير معرّف
$A49C: 12          .byte $12  ; غير معرّف
$A49D: E1 40    SBC  ($40,X)
$A49F: 13          .byte $13  ; غير معرّف
$A4A0: C0 2C    CPY  #$2C
$A4A2: 17          .byte $17  ; غير معرّف
$A4A3: 2F          .byte $2F  ; غير معرّف
$A4A4: 12          .byte $12  ; غير معرّف
$A4A5: 49 13    EOR  #$13
$A4A7: 83          .byte $83  ; غير معرّف
$A4A8: 40       RTI  
$A4A9: 9F          .byte $9F  ; غير معرّف
$A4AA: 14          .byte $14  ; غير معرّف
$A4AB: A3          .byte $A3  ; غير معرّف
$A4AC: 40       RTI  
$A4AD: 17          .byte $17  ; غير معرّف
$A4AE: 92          .byte $92  ; غير معرّف
$A4AF: 83          .byte $83  ; غير معرّف
$A4B0: 13          .byte $13  ; غير معرّف
$A4B1: 92          .byte $92  ; غير معرّف
$A4B2: 41 B9    EOR  ($B9,X)
$A4B4: 14          .byte $14  ; غير معرّف
$A4B5: C5 12    CMP  $12
$A4B7: C8       INY  
$A4B8: 40       RTI  
$A4B9: D4          .byte $D4  ; غير معرّف
$A4BA: 40       RTI  
$A4BB: 4B          .byte $4B  ; غير معرّف
$A4BC: 92          .byte $92  ; غير معرّف
$A4BD: 78       SEI  
$A4BE: 1B          .byte $1B  ; غير معرّف
$A4BF: 9C          .byte $9C  ; غير معرّف
$A4C0: 94 9F    STY  $9F,X
$A4C2: 11 DF    ORA  ($DF),Y
$A4C4: 14          .byte $14  ; غير معرّف
$A4C5: FE 11 7D INC  $7D11,X
$A4C8: C1 9E    CMP  ($9E,X)
$A4CA: 42          .byte $42  ; غير معرّف
$A4CB: CF          .byte $CF  ; غير معرّف
$A4CC: 20 FD 90 JSR  $90FD
$A4CF: B1 0F    LDA  ($0F),Y
$A4D1: 26 29    ROL  $29
$A4D3: 91 7E    STA  ($7E),Y
$A4D5: 42          .byte $42  ; غير معرّف
$A4D6: FE 40 28 INC  $2840,X
$A4D9: 92          .byte $92  ; غير معرّف
$A4DA: 4E 42 2E LSR  $2E42
$A4DD: C0 57    CPY  #$57
$A4DF: 73          .byte $73  ; غير معرّف
$A4E0: C3          .byte $C3  ; غير معرّف
$A4E1: 25 C7    AND  $C7
$A4E3: 27          .byte $27  ; غير معرّف
$A4E4: 23          .byte $23  ; غير معرّف
$A4E5: 84 33    STY  $33
$A4E7: 20 5C 01 JSR  $015C
$A4EA: 77          .byte $77  ; غير معرّف
$A4EB: 63          .byte $63  ; غير معرّف
$A4EC: 88       DEY  
$A4ED: 62          .byte $62  ; غير معرّف
$A4EE: 99 61 AA STA  $AA61,Y
$A4F1: 60       RTS  
$A4F2: BC 01 EE LDY  $EE01,X
$A4F5: 42          .byte $42  ; غير معرّف
$A4F6: 4E C0 69 LSR  $69C0
$A4F9: 11 7E    ORA  ($7E),Y
$A4FB: 42          .byte $42  ; غير معرّف
$A4FC: DE 40 F8 DEC  $F840,X
$A4FF: 62          .byte $62  ; غير معرّف
$A500: 0E C2 AE ASL  $AEC2
$A503: 40       RTI  
$A504: D7          .byte $D7  ; غير معرّف
$A505: 63          .byte $63  ; غير معرّف
$A506: E7          .byte $E7  ; غير معرّف
$A507: 63          .byte $63  ; غير معرّف
$A508: 33          .byte $33  ; غير معرّف
$A509: A7          .byte $A7  ; غير معرّف
$A50A: 37          .byte $37  ; غير معرّف
$A50B: 27          .byte $27  ; غير معرّف
$A50C: 43          .byte $43  ; غير معرّف
$A50D: 04          .byte $04  ; غير معرّف
$A50E: CC 01 E7 CPY  $E701
$A511: 73          .byte $73  ; غير معرّف
$A512: 0C          .byte $0C  ; غير معرّف
$A513: 81 3E    STA  ($3E,X)
$A515: 42          .byte $42  ; غير معرّف
$A516: 0D 0A 5E ORA  $5E0A
$A519: 40       RTI  
$A51A: 88       DEY  
$A51B: 72          .byte $72  ; غير معرّف
$A51C: BE 42 E7 LDX  $E742,Y
$A51F: 87          .byte $87  ; غير معرّف
$A520: FE 40 39 INC  $3940,X
$A523: E1 4E    SBC  ($4E,X)
$A525: 00       BRK  
$A526: 69 60    ADC  #$60
$A528: 87          .byte $87  ; غير معرّف
$A529: 60       RTS  
$A52A: A5 60    LDA  $60
$A52C: C3          .byte $C3  ; غير معرّف
$A52D: 31 FE    AND  ($FE),Y
$A52F: 31 6D    AND  ($6D),Y
$A531: C1 BE    CMP  ($BE,X)
$A533: 42          .byte $42  ; غير معرّف
$A534: EF          .byte $EF  ; غير معرّف
$A535: 20 FD 52 JSR  $52FD
$A538: 21 0F    AND  ($0F,X)
$A53A: 20 6E 40 JSR  $406E
$A53D: 58       CLI  
$A53E: F2          .byte $F2  ; غير معرّف
$A53F: 93          .byte $93  ; غير معرّف
$A540: 01 97    ORA  ($97,X)
$A542: 00       BRK  
$A543: 0C          .byte $0C  ; غير معرّف
$A544: 81 97    STA  ($97,X)
$A546: 40       RTI  
$A547: A6 41    LDX  $41
$A549: C7          .byte $C7  ; غير معرّف
$A54A: 40       RTI  
$A54B: 0D 04 03 ORA  $0304
$A54E: 01 07    ORA  ($07,X)
$A550: 01 23    ORA  ($23,X)
$A552: 01 27    ORA  ($27,X)
$A554: 01 EC    ORA  ($EC,X)
$A556: 03          .byte $03  ; غير معرّف
$A557: AC F3 C3 LDY  $C3F3
$A55A: 03          .byte $03  ; غير معرّف
$A55B: 78       SEI  
$A55C: E2          .byte $E2  ; غير معرّف
$A55D: 94 43    STY  $43,X
$A55F: 47          .byte $47  ; غير معرّف
$A560: F3          .byte $F3  ; غير معرّف
$A561: 74          .byte $74  ; غير معرّف
$A562: 43          .byte $43  ; غير معرّف
$A563: 47          .byte $47  ; غير معرّف
$A564: FB          .byte $FB  ; غير معرّف
$A565: 74          .byte $74  ; غير معرّف
$A566: 43          .byte $43  ; غير معرّف
$A567: 2C F1 4C BIT  $4CF1
$A56A: 63          .byte $63  ; غير معرّف
$A56B: 47          .byte $47  ; غير معرّف
$A56C: 00       BRK  
$A56D: 57          .byte $57  ; غير معرّف
$A56E: 21 5C    AND  ($5C,X)
$A570: 01 7C    ORA  ($7C,X)
$A572: 72          .byte $72  ; غير معرّف
$A573: 39 F1 EC AND  $ECF1,Y
$A576: 02          .byte $02  ; غير معرّف
$A577: 4C 81 D8 JMP  $D881
$A57A: 62          .byte $62  ; غير معرّف
$A57B: EC 01 0D CPX  $0D01
$A57E: 0D 0F 38 ORA  $380F
$A581: C7          .byte $C7  ; غير معرّف
$A582: 07          .byte $07  ; غير معرّف
$A583: ED 4A 1D SBC  $1D4A
$A586: C1 5F    CMP  ($5F,X)
$A588: 26 FD    ROL  $FD
$A58A: 54          .byte $54  ; غير معرّف
$A58B: 21 0F    AND  ($0F,X)
$A58D: 26 A7    ROL  $A7
$A58F: 22          .byte $22  ; غير معرّف
$A590: 37          .byte $37  ; غير معرّف
$A591: FB          .byte $FB  ; غير معرّف
$A592: 73          .byte $73  ; غير معرّف
$A593: 20 83 07 JSR  $0783
$A596: 87          .byte $87  ; غير معرّف
$A597: 02          .byte $02  ; غير معرّف
$A598: 93          .byte $93  ; غير معرّف
$A599: 20 C7 73 JSR  $73C7
$A59C: 04          .byte $04  ; غير معرّف
$A59D: F1 06    SBC  ($06),Y
$A59F: 31 39    AND  ($39),Y
$A5A1: 71 59    ADC  ($59),Y
$A5A3: 71 E7    ADC  ($E7),Y
$A5A5: 73          .byte $73  ; غير معرّف
$A5A6: 37          .byte $37  ; غير معرّف
$A5A7: A0 47    LDY  #$47
$A5A9: 04          .byte $04  ; غير معرّف
$A5AA: 86 7C    STX  $7C
$A5AC: E5 71    SBC  $71
$A5AE: E7          .byte $E7  ; غير معرّف
$A5AF: 31 33    AND  ($33),Y
$A5B1: A4 39    LDY  $39
$A5B3: 71 A9    ADC  ($A9),Y
$A5B5: 71 D3    ADC  ($D3),Y
$A5B7: 23          .byte $23  ; غير معرّف
$A5B8: 08       PHP  
$A5B9: F2          .byte $F2  ; غير معرّف
$A5BA: 13          .byte $13  ; غير معرّف
$A5BB: 05 27    ORA  $27
$A5BD: 02          .byte $02  ; غير معرّف
$A5BE: 49 71    EOR  #$71
$A5C0: 75 75    ADC  $75,X
$A5C2: E8       INX  
$A5C3: 72          .byte $72  ; غير معرّف
$A5C4: 67          .byte $67  ; غير معرّف
$A5C5: F3          .byte $F3  ; غير معرّف
$A5C6: 99 71 E7 STA  $E771,Y
$A5C9: 20 F4 72 JSR  $72F4
$A5CC: F7          .byte $F7  ; غير معرّف
$A5CD: 31 17    AND  ($17),Y
$A5CF: A0 33    LDY  #$33
$A5D1: 20 39 71 JSR  $7139
$A5D4: 73          .byte $73  ; غير معرّف
$A5D5: 28       PLP  
$A5D6: BC 05 39 LDY  $3905,X
$A5D9: F1 79    SBC  ($79),Y
$A5DB: 71 A6    ADC  ($A6),Y
$A5DD: 21 C3    AND  ($C3,X)
$A5DF: 06 D3    ASL  $D3
$A5E1: 20 DC 00 JSR  $00DC
$A5E4: FC          .byte $FC  ; غير معرّف
$A5E5: 00       BRK  
$A5E6: 07          .byte $07  ; غير معرّف
$A5E7: A2 13    LDX  #$13
$A5E9: 21 5F    AND  ($5F,X)
$A5EB: 32          .byte $32  ; غير معرّف
$A5EC: 8C 00 98 STY  $9800
$A5EF: 7A          .byte $7A  ; غير معرّف
$A5F0: C7          .byte $C7  ; غير معرّف
$A5F1: 63          .byte $63  ; غير معرّف
$A5F2: D9 61 03 CMP  $0361,Y
$A5F5: A2 07    LDX  #$07
$A5F7: 22          .byte $22  ; غير معرّف
$A5F8: 74          .byte $74  ; غير معرّف
$A5F9: 72          .byte $72  ; غير معرّف
$A5FA: 77          .byte $77  ; غير معرّف
$A5FB: 31 E7    AND  ($E7),Y
$A5FD: 73          .byte $73  ; غير معرّف
$A5FE: 39 F1 58 AND  $58F1,Y
$A601: 72          .byte $72  ; غير معرّف
$A602: 77          .byte $77  ; غير معرّف
$A603: 73          .byte $73  ; غير معرّف
$A604: D8       CLD  
$A605: 72          .byte $72  ; غير معرّف
$A606: 7F          .byte $7F  ; غير معرّف
$A607: B1 97    LDA  ($97),Y
$A609: 73          .byte $73  ; غير معرّف
$A60A: B6 64    LDX  $64,Y
$A60C: C5 65    CMP  $65
$A60E: D4          .byte $D4  ; غير معرّف
$A60F: 66 E3    ROR  $E3
$A611: 67          .byte $67  ; غير معرّف
$A612: F3          .byte $F3  ; غير معرّف
$A613: 67          .byte $67  ; غير معرّف
$A614: 8D C1 CF STA  $CFC1
$A617: 26 FD    ROL  $FD
$A619: 52          .byte $52  ; غير معرّف
$A61A: 31 0F    AND  ($0F),Y
$A61C: 20 6E 66 JSR  $666E
$A61F: 07          .byte $07  ; غير معرّف
$A620: 81 36    STA  ($36,X)
$A622: 01 66    ORA  ($66,X)
$A624: 00       BRK  
$A625: A7          .byte $A7  ; غير معرّف
$A626: 22          .byte $22  ; غير معرّف
$A627: 08       PHP  
$A628: F2          .byte $F2  ; غير معرّف
$A629: 67          .byte $67  ; غير معرّف
$A62A: 7B          .byte $7B  ; غير معرّف
$A62B: DC          .byte $DC  ; غير معرّف
$A62C: 02          .byte $02  ; غير معرّف
$A62D: 98       TYA  
$A62E: F2          .byte $F2  ; غير معرّف
$A62F: D7          .byte $D7  ; غير معرّف
$A630: 20 39 F1 JSR  $F139
$A633: 9F          .byte $9F  ; غير معرّف
$A634: 33          .byte $33  ; غير معرّف
$A635: DC          .byte $DC  ; غير معرّف
$A636: 27          .byte $27  ; غير معرّف
$A637: DC          .byte $DC  ; غير معرّف
$A638: 57          .byte $57  ; غير معرّف
$A639: 23          .byte $23  ; غير معرّف
$A63A: 83          .byte $83  ; غير معرّف
$A63B: 57          .byte $57  ; غير معرّف
$A63C: 63          .byte $63  ; غير معرّف
$A63D: 6C 51 87 JMP  ($8751)
$A640: 63          .byte $63  ; غير معرّف
$A641: 99 61 A3 STA  $A361,Y
$A644: 06 B3    ASL  $B3
$A646: 21 77    AND  ($77,X)
$A648: F3          .byte $F3  ; غير معرّف
$A649: F3          .byte $F3  ; غير معرّف
$A64A: 21 F7    AND  ($F7,X)
$A64C: 2A       ROL  A
$A64D: 13          .byte $13  ; غير معرّف
$A64E: 81 23    STA  ($23,X)
$A650: 22          .byte $22  ; غير معرّف
$A651: 53          .byte $53  ; غير معرّف
$A652: 00       BRK  
$A653: 63          .byte $63  ; غير معرّف
$A654: 22          .byte $22  ; غير معرّف
$A655: E9 0B    SBC  #$0B
$A657: 0C          .byte $0C  ; غير معرّف
$A658: 83          .byte $83  ; غير معرّف
$A659: 13          .byte $13  ; غير معرّف
$A65A: 21 16    AND  ($16,X)
$A65C: 22          .byte $22  ; غير معرّف
$A65D: 33          .byte $33  ; غير معرّف
$A65E: 05 8F    ORA  $8F
$A660: 35 EC    AND  $EC,X
$A662: 01 63    ORA  ($63,X)
$A664: A0 67    LDY  #$67
$A666: 20 73 01 JSR  $0173
$A669: 77          .byte $77  ; غير معرّف
$A66A: 01 83    ORA  ($83,X)
$A66C: 20 87 20 JSR  $2087
$A66F: B3          .byte $B3  ; غير معرّف
$A670: 20 B7 20 JSR  $20B7
$A673: C3          .byte $C3  ; غير معرّف
$A674: 01 C7    ORA  ($C7,X)
$A676: 00       BRK  
$A677: D3          .byte $D3  ; غير معرّف
$A678: 20 D7 20 JSR  $20D7
$A67B: 67          .byte $67  ; غير معرّف
$A67C: A0 77    LDY  #$77
$A67E: 07          .byte $07  ; غير معرّف
$A67F: 87          .byte $87  ; غير معرّف
$A680: 22          .byte $22  ; غير معرّف
$A681: E8       INX  
$A682: 62          .byte $62  ; غير معرّف
$A683: F5 65    SBC  $65,X
$A685: 1C          .byte $1C  ; غير معرّف
$A686: 82          .byte $82  ; غير معرّف
$A687: 7F          .byte $7F  ; غير معرّف
$A688: 38       SEC  
$A689: 8D C1 CF STA  $CFC1
$A68C: 26 FD    ROL  $FD
$A68E: 50 21    BVC  $A6B1
$A690: 07          .byte $07  ; غير معرّف
$A691: 81 47    STA  ($47,X)
$A693: 24 57    BIT  $57
$A695: 00       BRK  
$A696: 63          .byte $63  ; غير معرّف
$A697: 01 77    ORA  ($77,X)
$A699: 01 C9    ORA  ($C9,X)
$A69B: 71 68    ADC  ($68),Y
$A69D: F2          .byte $F2  ; غير معرّف
$A69E: E7          .byte $E7  ; غير معرّف
$A69F: 73          .byte $73  ; غير معرّف
$A6A0: 97          .byte $97  ; غير معرّف
$A6A1: FB          .byte $FB  ; غير معرّف
$A6A2: 06 83    ASL  $83
$A6A4: 5C          .byte $5C  ; غير معرّف
$A6A5: 01 D7    ORA  ($D7,X)
$A6A7: 22          .byte $22  ; غير معرّف
$A6A8: E7          .byte $E7  ; غير معرّف
$A6A9: 00       BRK  
$A6AA: 03          .byte $03  ; غير معرّف
$A6AB: A7          .byte $A7  ; غير معرّف
$A6AC: 6C 02 B3 JMP  ($B302)
$A6AF: 22          .byte $22  ; غير معرّف
$A6B0: E3          .byte $E3  ; غير معرّف
$A6B1: 01 E7    ORA  ($E7,X)
$A6B3: 07          .byte $07  ; غير معرّف
$A6B4: 47          .byte $47  ; غير معرّف
$A6B5: A0 57    LDY  #$57
$A6B7: 06 A7    ASL  $A7
$A6B9: 01 D3    ORA  ($D3,X)
$A6BB: 00       BRK  
$A6BC: D7          .byte $D7  ; غير معرّف
$A6BD: 01 07    ORA  ($07,X)
$A6BF: 81 67    STA  ($67,X)
$A6C1: 20 93 22 JSR  $2293
$A6C4: 03          .byte $03  ; غير معرّف
$A6C5: A3          .byte $A3  ; غير معرّف
$A6C6: 1C          .byte $1C  ; غير معرّف
$A6C7: 61 17    ADC  ($17,X)
$A6C9: 21 6F    AND  ($6F,X)
$A6CB: 33          .byte $33  ; غير معرّف
$A6CC: C7          .byte $C7  ; غير معرّف
$A6CD: 63          .byte $63  ; غير معرّف
$A6CE: D8       CLD  
$A6CF: 62          .byte $62  ; غير معرّف
$A6D0: E9 61    SBC  #$61
$A6D2: FA          .byte $FA  ; غير معرّف
$A6D3: 60       RTS  
$A6D4: 4F          .byte $4F  ; غير معرّف
$A6D5: B3          .byte $B3  ; غير معرّف
$A6D6: 87          .byte $87  ; غير معرّف
$A6D7: 63          .byte $63  ; غير معرّف
$A6D8: 9C          .byte $9C  ; غير معرّف
$A6D9: 01 B7    ORA  ($B7,X)
$A6DB: 63          .byte $63  ; غير معرّف
$A6DC: C8       INY  
$A6DD: 62          .byte $62  ; غير معرّف
$A6DE: D9 61 EA CMP  $EA61,Y
$A6E1: 60       RTS  
$A6E2: 39 F1 87 AND  $87F1,Y
$A6E5: 21 A7    AND  ($A7,X)
$A6E7: 01 B7    ORA  ($B7,X)
$A6E9: 20 39 F1 JSR  $F139
$A6EC: 5F          .byte $5F  ; غير معرّف
$A6ED: 38       SEC  
$A6EE: 6D C1 AF ADC  $AFC1
$A6F1: 26 FD    ROL  $FD
$A6F3: 90 11    BCC  $A706
$A6F5: 0F          .byte $0F  ; غير معرّف
$A6F6: 26 FE    ROL  $FE
$A6F8: 10 2A    BPL  $A724
$A6FA: 93          .byte $93  ; غير معرّف
$A6FB: 87          .byte $87  ; غير معرّف
$A6FC: 17          .byte $17  ; غير معرّف
$A6FD: A3          .byte $A3  ; غير معرّف
$A6FE: 14          .byte $14  ; غير معرّف
$A6FF: B2          .byte $B2  ; غير معرّف
$A700: 42          .byte $42  ; غير معرّف
$A701: 0A       ASL  A
$A702: 92          .byte $92  ; غير معرّف
$A703: 19 40 36 ORA  $3640,Y
$A706: 14          .byte $14  ; غير معرّف
$A707: 50 41    BVC  $A74A
$A709: 82          .byte $82  ; غير معرّف
$A70A: 16 2B    ASL  $2B,X
$A70C: 93          .byte $93  ; غير معرّف
$A70D: 24 41    BIT  $41
$A70F: BB          .byte $BB  ; غير معرّف
$A710: 14          .byte $14  ; غير معرّف
$A711: B8       CLV  
$A712: 00       BRK  
$A713: C2          .byte $C2  ; غير معرّف
$A714: 43          .byte $43  ; غير معرّف
$A715: C3          .byte $C3  ; غير معرّف
$A716: 13          .byte $13  ; غير معرّف
$A717: 1B          .byte $1B  ; غير معرّف
$A718: 94 67    STY  $67,X
$A71A: 12          .byte $12  ; غير معرّف
$A71B: C4 15    CPY  $15
$A71D: 53          .byte $53  ; غير معرّف
$A71E: C1 D2    CMP  ($D2,X)
$A720: 41 12    EOR  ($12,X)
$A722: C1 29    CMP  ($29,X)
$A724: 13          .byte $13  ; غير معرّف
$A725: 85 17    STA  $17
$A727: 1B          .byte $1B  ; غير معرّف
$A728: 92          .byte $92  ; غير معرّف
$A729: 1A          .byte $1A  ; غير معرّف
$A72A: 42          .byte $42  ; غير معرّف
$A72B: 47          .byte $47  ; غير معرّف
$A72C: 13          .byte $13  ; غير معرّف
$A72D: 83          .byte $83  ; غير معرّف
$A72E: 41 A7    EOR  ($A7,X)
$A730: 13          .byte $13  ; غير معرّف
$A731: 0E 91 A7 ASL  $A791
$A734: 63          .byte $63  ; غير معرّف
$A735: B7          .byte $B7  ; غير معرّف
$A736: 63          .byte $63  ; غير معرّف
$A737: C5 65    CMP  $65
$A739: D5 65    CMP  $65,X
$A73B: DD 4A E3 CMP  $E34A,X
$A73E: 67          .byte $67  ; غير معرّف
$A73F: F3          .byte $F3  ; غير معرّف
$A740: 67          .byte $67  ; غير معرّف
$A741: 8D C1 AE STA  $AEC1
$A744: 42          .byte $42  ; غير معرّف
$A745: DF          .byte $DF  ; غير معرّف
$A746: 20 FD 90 JSR  $90FD
$A749: 11 0F    ORA  ($0F),Y
$A74B: 26 6E    ROL  $6E
$A74D: 10 8B    BPL  $A6DA
$A74F: 17          .byte $17  ; غير معرّف
$A750: AF          .byte $AF  ; غير معرّف
$A751: 32          .byte $32  ; غير معرّف
$A752: D8       CLD  
$A753: 62          .byte $62  ; غير معرّف
$A754: E8       INX  
$A755: 62          .byte $62  ; غير معرّف
$A756: FC          .byte $FC  ; غير معرّف
$A757: 3F          .byte $3F  ; غير معرّف
$A758: AD C8 F8 LDA  $F8C8
$A75B: 64          .byte $64  ; غير معرّف
$A75C: 0C          .byte $0C  ; غير معرّف
$A75D: BE 43 43 LDX  $4343,Y
$A760: F8       SED  
$A761: 64          .byte $64  ; غير معرّف
$A762: 0C          .byte $0C  ; غير معرّف
$A763: BF          .byte $BF  ; غير معرّف
$A764: 73          .byte $73  ; غير معرّف
$A765: 40       RTI  
$A766: 84 40    STY  $40
$A768: 93          .byte $93  ; غير معرّف
$A769: 40       RTI  
$A76A: A4 40    LDY  $40
$A76C: B3          .byte $B3  ; غير معرّف
$A76D: 40       RTI  
$A76E: F8       SED  
$A76F: 64          .byte $64  ; غير معرّف
$A770: 48       PHA  
$A771: E4 5C    CPX  $5C
$A773: 39 83 40 AND  $4083,Y
$A776: 92          .byte $92  ; غير معرّف
$A777: 41 B3    EOR  ($B3,X)
$A779: 40       RTI  
$A77A: F8       SED  
$A77B: 64          .byte $64  ; غير معرّف
$A77C: 48       PHA  
$A77D: E4 5C    CPX  $5C
$A77F: 39 F8 64 AND  $64F8,Y
$A782: 13          .byte $13  ; غير معرّف
$A783: C2          .byte $C2  ; غير معرّف
$A784: 37          .byte $37  ; غير معرّف
$A785: 65 4C    ADC  $4C
$A787: 24 63    BIT  $63
$A789: 00       BRK  
$A78A: 97          .byte $97  ; غير معرّف
$A78B: 65 C3    ADC  $C3
$A78D: 42          .byte $42  ; غير معرّف
$A78E: 0B          .byte $0B  ; غير معرّف
$A78F: 97          .byte $97  ; غير معرّف
$A790: AC 32 F8 LDY  $F832
$A793: 64          .byte $64  ; غير معرّف
$A794: 0C          .byte $0C  ; غير معرّف
$A795: BE 53 45 LDX  $4553,Y
$A798: 9D 48 F8 STA  $F848,X
$A79B: 64          .byte $64  ; غير معرّف
$A79C: 2A       ROL  A
$A79D: E2          .byte $E2  ; غير معرّف
$A79E: 3C          .byte $3C  ; غير معرّف
$A79F: 47          .byte $47  ; غير معرّف
$A7A0: 56 43    LSR  $43,X
$A7A2: BA       TSX  
$A7A3: 62          .byte $62  ; غير معرّف
$A7A4: F8       SED  
$A7A5: 64          .byte $64  ; غير معرّف
$A7A6: 0C          .byte $0C  ; غير معرّف
$A7A7: B7          .byte $B7  ; غير معرّف
$A7A8: 88       DEY  
$A7A9: 64          .byte $64  ; غير معرّف
$A7AA: BC 31 D4 LDY  $D431,X
$A7AD: 45 FC    EOR  $FC
$A7AF: 31 3C    AND  ($3C),Y
$A7B1: B1 78    LDA  ($78),Y
$A7B3: 64          .byte $64  ; غير معرّف
$A7B4: 8C 38 0B STY  $0B38
$A7B7: 9C          .byte $9C  ; غير معرّف
$A7B8: 1A          .byte $1A  ; غير معرّف
$A7B9: 33          .byte $33  ; غير معرّف
$A7BA: 18       CLC  
$A7BB: 61 28    ADC  ($28,X)
$A7BD: 61 39    ADC  ($39,X)
$A7BF: 60       RTS  
$A7C0: 5D 4A EE EOR  $EE4A,X
$A7C3: 11 0F    ORA  ($0F),Y
$A7C5: B8       CLV  
$A7C6: 1D C1 3E ORA  $3EC1,X
$A7C9: 42          .byte $42  ; غير معرّف
$A7CA: 6F          .byte $6F  ; غير معرّف
$A7CB: 20 FD 52 JSR  $52FD
$A7CE: 31 0F    AND  ($0F),Y
$A7D0: 20 6E 40 JSR  $406E
$A7D3: F7          .byte $F7  ; غير معرّف
$A7D4: 20 07 84 JSR  $8407
$A7D7: 17          .byte $17  ; غير معرّف
$A7D8: 20 4F 34 JSR  $344F
$A7DB: C3          .byte $C3  ; غير معرّف
$A7DC: 03          .byte $03  ; غير معرّف
$A7DD: C7          .byte $C7  ; غير معرّف
$A7DE: 02          .byte $02  ; غير معرّف
$A7DF: D3          .byte $D3  ; غير معرّف
$A7E0: 22          .byte $22  ; غير معرّف
$A7E1: 27          .byte $27  ; غير معرّف
$A7E2: E3          .byte $E3  ; غير معرّف
$A7E3: 39 61 E7 AND  $E761,Y
$A7E6: 73          .byte $73  ; غير معرّف
$A7E7: 5C          .byte $5C  ; غير معرّف
$A7E8: E4 57    CPX  $57
$A7EA: 00       BRK  
$A7EB: 6C 73 47 JMP  ($4773)
$A7EE: A0 53    LDY  #$53
$A7F0: 06 63    ASL  $63
$A7F2: 22          .byte $22  ; غير معرّف
$A7F3: A7          .byte $A7  ; غير معرّف
$A7F4: 73          .byte $73  ; غير معرّف
$A7F5: FC          .byte $FC  ; غير معرّف
$A7F6: 73          .byte $73  ; غير معرّف
$A7F7: 13          .byte $13  ; غير معرّف
$A7F8: A1 33    LDA  ($33,X)
$A7FA: 05 43    ORA  $43
$A7FC: 21 5C    AND  ($5C,X)
$A7FE: 72          .byte $72  ; غير معرّف
$A7FF: C3          .byte $C3  ; غير معرّف
$A800: 23          .byte $23  ; غير معرّف
$A801: CC 03 77 CPY  $7703
$A804: FB          .byte $FB  ; غير معرّف
$A805: AC 02 39 LDY  $3902
$A808: F1 A7    SBC  ($A7),Y
$A80A: 73          .byte $73  ; غير معرّف
$A80B: D3          .byte $D3  ; غير معرّف
$A80C: 04          .byte $04  ; غير معرّف
$A80D: E8       INX  
$A80E: 72          .byte $72  ; غير معرّف
$A80F: E3          .byte $E3  ; غير معرّف
$A810: 22          .byte $22  ; غير معرّف
$A811: 26 F4    ROL  $F4
$A813: BC 02 8C LDY  $8C02,X
$A816: 81 A8    STA  ($A8,X)
$A818: 62          .byte $62  ; غير معرّف
$A819: 17          .byte $17  ; غير معرّف
$A81A: 87          .byte $87  ; غير معرّف
$A81B: 43          .byte $43  ; غير معرّف
$A81C: 24 A7    BIT  $A7
$A81E: 01 C3    ORA  ($C3,X)
$A820: 04          .byte $04  ; غير معرّف
$A821: 08       PHP  
$A822: F2          .byte $F2  ; غير معرّف
$A823: 97          .byte $97  ; غير معرّف
$A824: 21 A3    AND  ($A3,X)
$A826: 02          .byte $02  ; غير معرّف
$A827: C9          .byte $C9  ; غير معرّف
$A828: 0B          .byte $0B  ; غير معرّف
$A829: E1 69    SBC  ($69,X)
$A82B: F1 69    SBC  ($69),Y
$A82D: 8D C1 CF STA  $CFC1
$A830: 26 FD    ROL  $FD
$A832: 38       SEC  
$A833: 11 0F    ORA  ($0F),Y
$A835: 26 AD    ROL  $AD
$A837: 40       RTI  
$A838: 3D C7 FD AND  $FDC7,X
$A83B: 95 B1    STA  $B1,X
$A83D: 0F          .byte $0F  ; غير معرّف
$A83E: 26 0D    ROL  $0D
$A840: 02          .byte $02  ; غير معرّف
$A841: C8       INY  
$A842: 72          .byte $72  ; غير معرّف
$A843: 1C          .byte $1C  ; غير معرّف
$A844: 81 38    STA  ($38,X)
$A846: 72          .byte $72  ; غير معرّف
$A847: 0D 05 97 ORA  $9705
$A84A: 34          .byte $34  ; غير معرّف
$A84B: 98       TYA  
$A84C: 62          .byte $62  ; غير معرّف
$A84D: A3          .byte $A3  ; غير معرّف
$A84E: 20 B3 06 JSR  $06B3
$A851: C3          .byte $C3  ; غير معرّف
$A852: 20 CC 03 JSR  $03CC
$A855: F9 91 2C SBC  $2C91,Y
$A858: 81 48    STA  ($48,X)
$A85A: 62          .byte $62  ; غير معرّف
$A85B: 0D 09 37 ORA  $3709
$A85E: 63          .byte $63  ; غير معرّف
$A85F: 47          .byte $47  ; غير معرّف
$A860: 03          .byte $03  ; غير معرّف
$A861: 57          .byte $57  ; غير معرّف
$A862: 21 8C    AND  ($8C,X)
$A864: 02          .byte $02  ; غير معرّف
$A865: C5 79    CMP  $79
$A867: C7          .byte $C7  ; غير معرّف
$A868: 31 F9    AND  ($F9),Y
$A86A: 11 39    ORA  ($39),Y
$A86C: F1 A9    SBC  ($A9),Y
$A86E: 11 6F    ORA  ($6F),Y
$A870: B4 D3    LDY  $D3,X
$A872: 65 E3    ADC  $E3
$A874: 65 7D    ADC  $7D
$A876: C1 BF    CMP  ($BF,X)
$A878: 26 FD    ROL  $FD
$A87A: 00       BRK  
$A87B: C1 4C    CMP  ($4C,X)
$A87D: 00       BRK  
$A87E: F4          .byte $F4  ; غير معرّف
$A87F: 4F          .byte $4F  ; غير معرّف
$A880: 0D 02 02 ORA  $0202
$A883: 42          .byte $42  ; غير معرّف
$A884: 43          .byte $43  ; غير معرّف
$A885: 4F          .byte $4F  ; غير معرّف
$A886: 52          .byte $52  ; غير معرّف
$A887: C2          .byte $C2  ; غير معرّف
$A888: DE 00 5A DEC  $5A00,X
$A88B: C2          .byte $C2  ; غير معرّف
$A88C: 4D C7 FD EOR  $FDC7
$A88F: 90 51    BCC  $A8E2
$A891: 0F          .byte $0F  ; غير معرّف
$A892: 26 EE    ROL  $EE
$A894: 10 0B    BPL  $A8A1
$A896: 94 33    STY  $33,X
$A898: 14          .byte $14  ; غير معرّف
$A899: 42          .byte $42  ; غير معرّف
$A89A: 42          .byte $42  ; غير معرّف
$A89B: 77          .byte $77  ; غير معرّف
$A89C: 16 86    ASL  $86,X
$A89E: 44          .byte $44  ; غير معرّف
$A89F: 02          .byte $02  ; غير معرّف
$A8A0: 92          .byte $92  ; غير معرّف
$A8A1: 4A       LSR  A
$A8A2: 16 69    ASL  $69,X
$A8A4: 42          .byte $42  ; غير معرّف
$A8A5: 73          .byte $73  ; غير معرّف
$A8A6: 14          .byte $14  ; غير معرّف
$A8A7: B0 00    BCS  $A8A9
$A8A9: C7          .byte $C7  ; غير معرّف
$A8AA: 12          .byte $12  ; غير معرّف
$A8AB: 05 C0    ORA  $C0
$A8AD: 1C          .byte $1C  ; غير معرّف
$A8AE: 17          .byte $17  ; غير معرّف
$A8AF: 1F          .byte $1F  ; غير معرّف
$A8B0: 11 36    ORA  ($36),Y
$A8B2: 12          .byte $12  ; غير معرّف
$A8B3: 8F          .byte $8F  ; غير معرّف
$A8B4: 14          .byte $14  ; غير معرّف
$A8B5: 91 40    STA  ($40),Y
$A8B7: 1B          .byte $1B  ; غير معرّف
$A8B8: 94 35    STY  $35,X
$A8BA: 12          .byte $12  ; غير معرّف
$A8BB: 34          .byte $34  ; غير معرّف
$A8BC: 42          .byte $42  ; غير معرّف
$A8BD: 60       RTS  
$A8BE: 42          .byte $42  ; غير معرّف
$A8BF: 61 12    ADC  ($12,X)
$A8C1: 87          .byte $87  ; غير معرّف
$A8C2: 12          .byte $12  ; غير معرّف
$A8C3: 96 40    STX  $40,Y
$A8C5: A3          .byte $A3  ; غير معرّف
$A8C6: 14          .byte $14  ; غير معرّف
$A8C7: 1C          .byte $1C  ; غير معرّف
$A8C8: 98       TYA  
$A8C9: 1F          .byte $1F  ; غير معرّف
$A8CA: 11 47    ORA  ($47),Y
$A8CC: 12          .byte $12  ; غير معرّف
$A8CD: 9F          .byte $9F  ; غير معرّف
$A8CE: 15 CC    ORA  $CC,X
$A8D0: 15 CF    ORA  $CF,X
$A8D2: 11 05    ORA  ($05),Y
$A8D4: C0 1F    CPY  #$1F
$A8D6: 15 39    ORA  $39,X
$A8D8: 12          .byte $12  ; غير معرّف
$A8D9: 7C          .byte $7C  ; غير معرّف
$A8DA: 16 7F    ASL  $7F,X
$A8DC: 11 82    ORA  ($82),Y
$A8DE: 40       RTI  
$A8DF: 98       TYA  
$A8E0: 12          .byte $12  ; غير معرّف
$A8E1: DF          .byte $DF  ; غير معرّف
$A8E2: 15 16    ORA  $16,X
$A8E4: C4 17    CPY  $17
$A8E6: 14          .byte $14  ; غير معرّف
$A8E7: 54          .byte $54  ; غير معرّف
$A8E8: 12          .byte $12  ; غير معرّف
$A8E9: 9B          .byte $9B  ; غير معرّف
$A8EA: 16 28    ASL  $28,X
$A8EC: 94 CE    STY  $CE,X
$A8EE: 01 3D    ORA  ($3D,X)
$A8F0: C1 5E    CMP  ($5E,X)
$A8F2: 42          .byte $42  ; غير معرّف
$A8F3: 8F          .byte $8F  ; غير معرّف
$A8F4: 20 FD 97 JSR  $97FD
$A8F7: 11 0F    ORA  ($0F),Y
$A8F9: 26 FE    ROL  $FE
$A8FB: 10 2B    BPL  $A928
$A8FD: 92          .byte $92  ; غير معرّف
$A8FE: 57          .byte $57  ; غير معرّف
$A8FF: 12          .byte $12  ; غير معرّف
$A900: 8B          .byte $8B  ; غير معرّف
$A901: 12          .byte $12  ; غير معرّف
$A902: C0 41    CPY  #$41
$A904: F7          .byte $F7  ; غير معرّف
$A905: 13          .byte $13  ; غير معرّف
$A906: 5B          .byte $5B  ; غير معرّف
$A907: 92          .byte $92  ; غير معرّف
$A908: 69 0B    ADC  #$0B
$A90A: BB          .byte $BB  ; غير معرّف
$A90B: 12          .byte $12  ; غير معرّف
$A90C: B2          .byte $B2  ; غير معرّف
$A90D: 46 19    LSR  $19
$A90F: 93          .byte $93  ; غير معرّف
$A910: 71 00    ADC  ($00),Y
$A912: 17          .byte $17  ; غير معرّف
$A913: 94 7C    STY  $7C,X
$A915: 14          .byte $14  ; غير معرّف
$A916: 7F          .byte $7F  ; غير معرّف
$A917: 11 93    ORA  ($93),Y
$A919: 41 BF    EOR  ($BF,X)
$A91B: 15 FC    ORA  $FC,X
$A91D: 13          .byte $13  ; غير معرّف
$A91E: FF          .byte $FF  ; غير معرّف
$A91F: 11 2F    ORA  ($2F),Y
$A921: 95 50    STA  $50,X
$A923: 42          .byte $42  ; غير معرّف
$A924: 51 12    EOR  ($12),Y
$A926: 58       CLI  
$A927: 14          .byte $14  ; غير معرّف
$A928: A6 12    LDX  $12
$A92A: DB          .byte $DB  ; غير معرّف
$A92B: 12          .byte $12  ; غير معرّف
$A92C: 1B          .byte $1B  ; غير معرّف
$A92D: 93          .byte $93  ; غير معرّف
$A92E: 46 43    LSR  $43
$A930: 7B          .byte $7B  ; غير معرّف
$A931: 12          .byte $12  ; غير معرّف
$A932: 8D 49 B7 STA  $B749
$A935: 14          .byte $14  ; غير معرّف
$A936: 1B          .byte $1B  ; غير معرّف
$A937: 94 49    STY  $49,X
$A939: 0B          .byte $0B  ; غير معرّف
$A93A: BB          .byte $BB  ; غير معرّف
$A93B: 12          .byte $12  ; غير معرّف
$A93C: FC          .byte $FC  ; غير معرّف
$A93D: 13          .byte $13  ; غير معرّف
$A93E: FF          .byte $FF  ; غير معرّف
$A93F: 12          .byte $12  ; غير معرّف
$A940: 03          .byte $03  ; غير معرّف
$A941: C1 2F    CMP  ($2F,X)
$A943: 15 43    ORA  $43,X
$A945: 12          .byte $12  ; غير معرّف
$A946: 4B          .byte $4B  ; غير معرّف
$A947: 13          .byte $13  ; غير معرّف
$A948: 77          .byte $77  ; غير معرّف
$A949: 13          .byte $13  ; غير معرّف
$A94A: 9D 4A 15 STA  $154A,X
$A94D: C1 A1    CMP  ($A1,X)
$A94F: 41 C3    EOR  ($C3,X)
$A951: 12          .byte $12  ; غير معرّف
$A952: FE 01 7D INC  $7D01,X
$A955: C1 9E    CMP  ($9E,X)
$A957: 42          .byte $42  ; غير معرّف
$A958: CF          .byte $CF  ; غير معرّف
$A959: 20 FD 52 JSR  $52FD
$A95C: 21 0F    AND  ($0F,X)
$A95E: 20 6E 44 JSR  $446E
$A961: 0C          .byte $0C  ; غير معرّف
$A962: F1 4C    SBC  ($4C),Y
$A964: 01 AA    ORA  ($AA,X)
$A966: 35 D9    AND  $D9,X
$A968: 34          .byte $34  ; غير معرّف
$A969: EE 20 08 INC  $0820
$A96C: B3          .byte $B3  ; غير معرّف
$A96D: 37          .byte $37  ; غير معرّف
$A96E: 32          .byte $32  ; غير معرّف
$A96F: 43          .byte $43  ; غير معرّف
$A970: 04          .byte $04  ; غير معرّف
$A971: 4E 21 53 LSR  $5321
$A974: 20 7C 01 JSR  $017C
$A977: 97          .byte $97  ; غير معرّف
$A978: 21 B7    AND  ($B7,X)
$A97A: 07          .byte $07  ; غير معرّف
$A97B: 9C          .byte $9C  ; غير معرّف
$A97C: 81 E7    STA  ($E7,X)
$A97E: 42          .byte $42  ; غير معرّف
$A97F: 5F          .byte $5F  ; غير معرّف
$A980: B3          .byte $B3  ; غير معرّف
$A981: 97          .byte $97  ; غير معرّف
$A982: 63          .byte $63  ; غير معرّف
$A983: AC 02 C5 LDY  $C502
$A986: 41 49    EOR  ($49,X)
$A988: E0 58    CPX  #$58
$A98A: 61 76    ADC  ($76,X)
$A98C: 64          .byte $64  ; غير معرّف
$A98D: 85 65    STA  $65
$A98F: 94 66    STY  $66,X
$A991: A4 22    LDY  $22
$A993: A6 03    LDX  $03
$A995: C8       INY  
$A996: 22          .byte $22  ; غير معرّف
$A997: DC          .byte $DC  ; غير معرّف
$A998: 02          .byte $02  ; غير معرّف
$A999: 68       PLA  
$A99A: F2          .byte $F2  ; غير معرّف
$A99B: 96 42    STX  $42,Y
$A99D: 13          .byte $13  ; غير معرّف
$A99E: 82          .byte $82  ; غير معرّف
$A99F: 17          .byte $17  ; غير معرّف
$A9A0: 02          .byte $02  ; غير معرّف
$A9A1: AF          .byte $AF  ; غير معرّف
$A9A2: 34          .byte $34  ; غير معرّف
$A9A3: F6 21    INC  $21,X
$A9A5: FC          .byte $FC  ; غير معرّف
$A9A6: 06 26    ASL  $26
$A9A8: 80          .byte $80  ; غير معرّف
$A9A9: 2A       ROL  A
$A9AA: 24 36    BIT  $36
$A9AC: 01 8C    ORA  ($8C,X)
$A9AE: 00       BRK  
$A9AF: FF          .byte $FF  ; غير معرّف
$A9B0: 35 4E    AND  $4E,X
$A9B2: A0 55    LDY  #$55
$A9B4: 21 77    AND  ($77,X)
$A9B6: 20 87 07 JSR  $0787
$A9B9: 89          .byte $89  ; غير معرّف
$A9BA: 22          .byte $22  ; غير معرّف
$A9BB: AE 21 4C LDX  $4C21
$A9BE: 82          .byte $82  ; غير معرّف
$A9BF: 9F          .byte $9F  ; غير معرّف
$A9C0: 34          .byte $34  ; غير معرّف
$A9C1: EC 01 03 CPX  $0301
$A9C4: E7          .byte $E7  ; غير معرّف
$A9C5: 13          .byte $13  ; غير معرّف
$A9C6: 67          .byte $67  ; غير معرّف
$A9C7: 8D 4A AD STA  $AD4A
$A9CA: 41 0F    EOR  ($0F,X)
$A9CC: A6 FD    LDX  $FD
$A9CE: 10 51    BPL  $AA21
$A9D0: 4C 00 C7 JMP  $C700
$A9D3: 12          .byte $12  ; غير معرّف
$A9D4: C6 42    DEC  $42
$A9D6: 03          .byte $03  ; غير معرّف
$A9D7: 92          .byte $92  ; غير معرّف
$A9D8: 02          .byte $02  ; غير معرّف
$A9D9: 42          .byte $42  ; غير معرّف
$A9DA: 29 12    AND  #$12
$A9DC: 63          .byte $63  ; غير معرّف
$A9DD: 12          .byte $12  ; غير معرّف
$A9DE: 62          .byte $62  ; غير معرّف
$A9DF: 42          .byte $42  ; غير معرّف
$A9E0: 69 14    ADC  #$14
$A9E2: A5 12    LDA  $12
$A9E4: A4 42    LDY  $42
$A9E6: E2          .byte $E2  ; غير معرّف
$A9E7: 14          .byte $14  ; غير معرّف
$A9E8: E1 44    SBC  ($44,X)
$A9EA: F8       SED  
$A9EB: 16 37    ASL  $37,X
$A9ED: C1 8F    CMP  ($8F,X)
$A9EF: 38       SEC  
$A9F0: 02          .byte $02  ; غير معرّف
$A9F1: BB          .byte $BB  ; غير معرّف
$A9F2: 28       PLP  
$A9F3: 7A          .byte $7A  ; غير معرّف
$A9F4: 68       PLA  
$A9F5: 7A          .byte $7A  ; غير معرّف
$A9F6: A8       TAY  
$A9F7: 7A          .byte $7A  ; غير معرّف
$A9F8: E0 6A    CPX  #$6A
$A9FA: F0 6A    BEQ  $AA66
$A9FC: 6D C5 FD ADC  $FDC5
$A9FF: 92          .byte $92  ; غير معرّف
$AA00: 31 0F    AND  ($0F),Y
$AA02: 20 6E 40 JSR  $406E
$AA05: 0D 02 37 ORA  $3702
$AA08: 73          .byte $73  ; غير معرّف
$AA09: EC 00 0C CPX  $0C00
$AA0C: 80          .byte $80  ; غير معرّف
$AA0D: 3C          .byte $3C  ; غير معرّف
$AA0E: 00       BRK  
$AA0F: 6C 00 9C JMP  ($9C00)
$AA12: 00       BRK  
$AA13: 06 C0    ASL  $C0
$AA15: C7          .byte $C7  ; غير معرّف
$AA16: 73          .byte $73  ; غير معرّف
$AA17: 06 83    ASL  $83
$AA19: 28       PLP  
$AA1A: 72          .byte $72  ; غير معرّف
$AA1B: 96 40    STX  $40,Y
$AA1D: E7          .byte $E7  ; غير معرّف
$AA1E: 73          .byte $73  ; غير معرّف
$AA1F: 26 C0    ROL  $C0
$AA21: 87          .byte $87  ; غير معرّف
$AA22: 7B          .byte $7B  ; غير معرّف
$AA23: D2          .byte $D2  ; غير معرّف
$AA24: 41 39    EOR  ($39,X)
$AA26: F1 C8    SBC  ($C8),Y
$AA28: F2          .byte $F2  ; غير معرّف
$AA29: 97          .byte $97  ; غير معرّف
$AA2A: E3          .byte $E3  ; غير معرّف
$AA2B: A3          .byte $A3  ; غير معرّف
$AA2C: 23          .byte $23  ; غير معرّف
$AA2D: E7          .byte $E7  ; غير معرّف
$AA2E: 02          .byte $02  ; غير معرّف
$AA2F: E3          .byte $E3  ; غير معرّف
$AA30: 07          .byte $07  ; غير معرّف
$AA31: F3          .byte $F3  ; غير معرّف
$AA32: 22          .byte $22  ; غير معرّف
$AA33: 37          .byte $37  ; غير معرّف
$AA34: E3          .byte $E3  ; غير معرّف
$AA35: 9C          .byte $9C  ; غير معرّف
$AA36: 00       BRK  
$AA37: BC 00 EC LDY  $EC00,X
$AA3A: 00       BRK  
$AA3B: 0C          .byte $0C  ; غير معرّف
$AA3C: 80          .byte $80  ; غير معرّف
$AA3D: 3C          .byte $3C  ; غير معرّف
$AA3E: 00       BRK  
$AA3F: 86 21    STX  $21
$AA41: A6 06    LDX  $06
$AA43: B6 24    LDX  $24,Y
$AA45: 5C          .byte $5C  ; غير معرّف
$AA46: 80          .byte $80  ; غير معرّف
$AA47: 7C          .byte $7C  ; غير معرّف
$AA48: 00       BRK  
$AA49: 9C          .byte $9C  ; غير معرّف
$AA4A: 00       BRK  
$AA4B: 29 E1    AND  #$E1
$AA4D: DC          .byte $DC  ; غير معرّف
$AA4E: 05 F6    ORA  $F6
$AA50: 41 DC    EOR  ($DC,X)
$AA52: 80          .byte $80  ; غير معرّف
$AA53: E8       INX  
$AA54: 72          .byte $72  ; غير معرّف
$AA55: 0C          .byte $0C  ; غير معرّف
$AA56: 81 27    STA  ($27,X)
$AA58: 73          .byte $73  ; غير معرّف
$AA59: 4C 01 66 JMP  $6601
$AA5C: 74          .byte $74  ; غير معرّف
$AA5D: 0D 11 3F ORA  $3F11
$AA60: 35 B6    AND  $B6,X
$AA62: 41 2C    EOR  ($2C,X)
$AA64: 82          .byte $82  ; غير معرّف
$AA65: 36 40    ROL  $40,X
$AA67: 7C          .byte $7C  ; غير معرّف
$AA68: 02          .byte $02  ; غير معرّف
$AA69: 86 40    STX  $40
$AA6B: F9 61 39 SBC  $3961,Y
$AA6E: E1 AC    SBC  ($AC,X)
$AA70: 04          .byte $04  ; غير معرّف
$AA71: C6 41    DEC  $41
$AA73: 0C          .byte $0C  ; غير معرّف
$AA74: 83          .byte $83  ; غير معرّف
$AA75: 16 41    ASL  $41,X
$AA77: 88       DEY  
$AA78: F2          .byte $F2  ; غير معرّف
$AA79: 39 F1 7C AND  $7CF1,Y
$AA7C: 00       BRK  
$AA7D: 89          .byte $89  ; غير معرّف
$AA7E: 61 9C    ADC  ($9C,X)
$AA80: 00       BRK  
$AA81: A7          .byte $A7  ; غير معرّف
$AA82: 63          .byte $63  ; غير معرّف
$AA83: BC 00 C5 LDY  $C500,X
$AA86: 65 DC    ADC  $DC
$AA88: 00       BRK  
$AA89: E3          .byte $E3  ; غير معرّف
$AA8A: 67          .byte $67  ; غير معرّف
$AA8B: F3          .byte $F3  ; غير معرّف
$AA8C: 67          .byte $67  ; غير معرّف
$AA8D: 8D C1 CF STA  $CFC1
$AA90: 26 FD    ROL  $FD
$AA92: 55 B1    EOR  $B1,X
$AA94: 0F          .byte $0F  ; غير معرّف
$AA95: 26 CF    ROL  $CF
$AA97: 33          .byte $33  ; غير معرّف
$AA98: 07          .byte $07  ; غير معرّف
$AA99: B2          .byte $B2  ; غير معرّف
$AA9A: 15 11    ORA  $11,X
$AA9C: 52          .byte $52  ; غير معرّف
$AA9D: 42          .byte $42  ; غير معرّف
$AA9E: 99 0B AC STA  $AC0B,Y
$AAA1: 02          .byte $02  ; غير معرّف
$AAA2: D3          .byte $D3  ; غير معرّف
$AAA3: 24 D6    BIT  $D6
$AAA5: 42          .byte $42  ; غير معرّف
$AAA6: D7          .byte $D7  ; غير معرّف
$AAA7: 25 23    AND  $23
$AAA9: 84 CF    STY  $CF
$AAAB: 33          .byte $33  ; غير معرّف
$AAAC: 07          .byte $07  ; غير معرّف
$AAAD: E3          .byte $E3  ; غير معرّف
$AAAE: 19 61 78 ORA  $7861,Y
$AAB1: 7A          .byte $7A  ; غير معرّف
$AAB2: EF          .byte $EF  ; غير معرّف
$AAB3: 33          .byte $33  ; غير معرّف
$AAB4: 2C 81 46 BIT  $4681
$AAB7: 64          .byte $64  ; غير معرّف
$AAB8: 55 65    EOR  $65,X
$AABA: 65 65    ADC  $65
$AABC: EC 74 47 CPX  $4774
$AABF: 82          .byte $82  ; غير معرّف
$AAC0: 53          .byte $53  ; غير معرّف
$AAC1: 05 63    ORA  $63
$AAC3: 21 62    AND  ($62,X)
$AAC5: 41 96    EOR  ($96,X)
$AAC7: 22          .byte $22  ; غير معرّف
$AAC8: 9A       TXS  
$AAC9: 41 CC    EOR  ($CC,X)
$AACB: 03          .byte $03  ; غير معرّف
$AACC: B9 91 39 LDA  $3991,Y
$AACF: F1 63    SBC  ($63),Y
$AAD1: 26 67    ROL  $67
$AAD3: 27          .byte $27  ; غير معرّف
$AAD4: D3          .byte $D3  ; غير معرّف
$AAD5: 06 FC    ASL  $FC
$AAD7: 01 18    ORA  ($18,X)
$AAD9: E2          .byte $E2  ; غير معرّف
$AADA: D9 07 E9 CMP  $E907,Y
$AADD: 04          .byte $04  ; غير معرّف
$AADE: 0C          .byte $0C  ; غير معرّف
$AADF: 86 37    STX  $37
$AAE1: 22          .byte $22  ; غير معرّف
$AAE2: 93          .byte $93  ; غير معرّف
$AAE3: 24 87    BIT  $87
$AAE5: 84 AC    STY  $AC
$AAE7: 02          .byte $02  ; غير معرّف
$AAE8: C2          .byte $C2  ; غير معرّف
$AAE9: 41 C3    EOR  ($C3,X)
$AAEB: 23          .byte $23  ; غير معرّف
$AAEC: D9 71 FC CMP  $FC71,Y
$AAEF: 01 7F    ORA  ($7F,X)
$AAF1: B1 9C    LDA  ($9C),Y
$AAF3: 00       BRK  
$AAF4: A7          .byte $A7  ; غير معرّف
$AAF5: 63          .byte $63  ; غير معرّف
$AAF6: B6 64    LDX  $64,Y
$AAF8: CC 00 D4 CPY  $D400
$AAFB: 66 E3    ROR  $E3
$AAFD: 67          .byte $67  ; غير معرّف
$AAFE: F3          .byte $F3  ; غير معرّف
$AAFF: 67          .byte $67  ; غير معرّف
$AB00: 8D C1 CF STA  $CFC1
$AB03: 26 FD    ROL  $FD
$AB05: 50 B1    BVC  $AAB8
$AB07: 0F          .byte $0F  ; غير معرّف
$AB08: 26 FC    ROL  $FC
$AB0A: 00       BRK  
$AB0B: 1F          .byte $1F  ; غير معرّف
$AB0C: B3          .byte $B3  ; غير معرّف
$AB0D: 5C          .byte $5C  ; غير معرّف
$AB0E: 00       BRK  
$AB0F: 65 65    ADC  $65
$AB11: 74          .byte $74  ; غير معرّف
$AB12: 66 83    ROR  $83
$AB14: 67          .byte $67  ; غير معرّف
$AB15: 93          .byte $93  ; غير معرّف
$AB16: 67          .byte $67  ; غير معرّف
$AB17: DC          .byte $DC  ; غير معرّف
$AB18: 73          .byte $73  ; غير معرّف
$AB19: 4C 80 B3 JMP  $B380
$AB1C: 20 C9 0B JSR  $0BC9
$AB1F: C3          .byte $C3  ; غير معرّف
$AB20: 08       PHP  
$AB21: D3          .byte $D3  ; غير معرّف
$AB22: 2F          .byte $2F  ; غير معرّف
$AB23: DC          .byte $DC  ; غير معرّف
$AB24: 00       BRK  
$AB25: 2C 80 4C BIT  $4C80
$AB28: 00       BRK  
$AB29: 8C 00 D3 STY  $D300
$AB2C: 2E ED 4A ROL  $4AED
$AB2F: FC          .byte $FC  ; غير معرّف
$AB30: 00       BRK  
$AB31: D7          .byte $D7  ; غير معرّف
$AB32: A1 EC    LDA  ($EC,X)
$AB34: 01 4C    ORA  ($4C,X)
$AB36: 80          .byte $80  ; غير معرّف
$AB37: 59 11 D8 EOR  $D811,Y
$AB3A: 11 DA    ORA  ($DA),Y
$AB3C: 10 37    BPL  $AB75
$AB3E: A0 47    LDY  #$47
$AB40: 04          .byte $04  ; غير معرّف
$AB41: 99 11 E7 STA  $E711,Y
$AB44: 21 3A    AND  ($3A,X)
$AB46: 90 67    BCC  $ABAF
$AB48: 20 76 10 JSR  $1076
$AB4B: 77          .byte $77  ; غير معرّف
$AB4C: 60       RTS  
$AB4D: 87          .byte $87  ; غير معرّف
$AB4E: 07          .byte $07  ; غير معرّف
$AB4F: D8       CLD  
$AB50: 12          .byte $12  ; غير معرّف
$AB51: 39 F1 AC AND  $ACF1,Y
$AB54: 00       BRK  
$AB55: E9 71    SBC  #$71
$AB57: 0C          .byte $0C  ; غير معرّف
$AB58: 80          .byte $80  ; غير معرّف
$AB59: 2C 00 4C BIT  $4C00
$AB5C: 05 C7    ORA  $C7
$AB5E: 7B          .byte $7B  ; غير معرّف
$AB5F: 39 F1 EC AND  $ECF1,Y
$AB62: 00       BRK  
$AB63: F9 11 0C SBC  $0C11,Y
$AB66: 82          .byte $82  ; غير معرّف
$AB67: 6F          .byte $6F  ; غير معرّف
$AB68: 34          .byte $34  ; غير معرّف
$AB69: F8       SED  
$AB6A: 11 FA    ORA  ($FA),Y
$AB6C: 10 7F    BPL  $ABED
$AB6E: B2          .byte $B2  ; غير معرّف
$AB6F: AC 00 B6 LDY  $B600
$AB72: 64          .byte $64  ; غير معرّف
$AB73: CC 01 E3 CPY  $E301
$AB76: 67          .byte $67  ; غير معرّف
$AB77: F3          .byte $F3  ; غير معرّف
$AB78: 67          .byte $67  ; غير معرّف
$AB79: 8D C1 CF STA  $CFC1
$AB7C: 26 FD    ROL  $FD
$AB7E: 52          .byte $52  ; غير معرّف
$AB7F: B1 0F    LDA  ($0F),Y
$AB81: 20 6E 45 JSR  $456E
$AB84: 39 91 B3 AND  $B391,Y
$AB87: 04          .byte $04  ; غير معرّف
$AB88: C3          .byte $C3  ; غير معرّف
$AB89: 21 C8    AND  ($C8,X)
$AB8B: 11 CA    ORA  ($CA),Y
$AB8D: 10 49    BPL  $ABD8
$AB8F: 91 7C    STA  ($7C),Y
$AB91: 73          .byte $73  ; غير معرّف
$AB92: E8       INX  
$AB93: 12          .byte $12  ; غير معرّف
$AB94: 88       DEY  
$AB95: 91 8A    STA  ($8A),Y
$AB97: 10 E7    BPL  $AB80
$AB99: 21 05    AND  ($05,X)
$AB9B: 91 07    STA  ($07),Y
$AB9D: 30 17    BMI  $ABB6
$AB9F: 07          .byte $07  ; غير معرّف
$ABA0: 27          .byte $27  ; غير معرّف
$ABA1: 20 49 11 JSR  $1149
$ABA4: 9C          .byte $9C  ; غير معرّف
$ABA5: 01 C8    ORA  ($C8,X)
$ABA7: 72          .byte $72  ; غير معرّف
$ABA8: 23          .byte $23  ; غير معرّف
$ABA9: A6 27    LDX  $27
$ABAB: 26 D3    ROL  $D3
$ABAD: 03          .byte $03  ; غير معرّف
$ABAE: D8       CLD  
$ABAF: 7A          .byte $7A  ; غير معرّف
$ABB0: 89          .byte $89  ; غير معرّف
$ABB1: 91 D8    STA  ($D8),Y
$ABB3: 72          .byte $72  ; غير معرّف
$ABB4: 39 F1 A9 AND  $A9F1,Y
$ABB7: 11 09    ORA  ($09),Y
$ABB9: F1 63    SBC  ($63),Y
$ABBB: 24 67    BIT  $67
$ABBD: 24 D8    BIT  $D8
$ABBF: 62          .byte $62  ; غير معرّف
$ABC0: 28       PLP  
$ABC1: 91 2A    STA  ($2A),Y
$ABC3: 10 56    BPL  $AC1B
$ABC5: 21 70    AND  ($70,X)
$ABC7: 04          .byte $04  ; غير معرّف
$ABC8: 79 0B 8C ADC  $8C0B,Y
$ABCB: 00       BRK  
$ABCC: 94 21    STY  $21,X
$ABCE: 9F          .byte $9F  ; غير معرّف
$ABCF: 35 2F    AND  $2F,X
$ABD1: B8       CLV  
$ABD2: 3D C1 7F AND  $7FC1,X
$ABD5: 26 FD    ROL  $FD
$ABD7: 06 C1    ASL  $C1
$ABD9: 4C 00 F4 JMP  $F400
$ABDC: 4F          .byte $4F  ; غير معرّف
$ABDD: 0D 02 06 ORA  $0602
$ABE0: 20 24 4F JSR  $4F24
$ABE3: 35 A0    AND  $A0,X
$ABE5: 36 20    ROL  $20,X
$ABE7: 53          .byte $53  ; غير معرّف
$ABE8: 46 D5    LSR  $D5
$ABEA: 20 D6 20 JSR  $20D6
$ABED: 34          .byte $34  ; غير معرّف
$ABEE: A1 73    LDA  ($73,X)
$ABF0: 49 74    EOR  #$74
$ABF2: 20 94 20 JSR  $2094
$ABF5: B4 20    LDY  $20,X
$ABF7: D4          .byte $D4  ; غير معرّف
$ABF8: 20 F4 20 JSR  $20F4
$ABFB: 2E 80 59 ROL  $5980
$ABFE: 42          .byte $42  ; غير معرّف
$ABFF: 4D C7 FD EOR  $FDC7
$AC02: 96 31    STX  $31,Y
$AC04: 0F          .byte $0F  ; غير معرّف
$AC05: 26 0D    ROL  $0D
$AC07: 03          .byte $03  ; غير معرّف
$AC08: 1A          .byte $1A  ; غير معرّف
$AC09: 60       RTS  
$AC0A: 77          .byte $77  ; غير معرّف
$AC0B: 42          .byte $42  ; غير معرّف
$AC0C: C4 00    CPY  $00
$AC0E: C8       INY  
$AC0F: 62          .byte $62  ; غير معرّف
$AC10: B9 E1 D3 LDA  $D3E1,Y
$AC13: 06 D7    ASL  $D7
$AC15: 07          .byte $07  ; غير معرّف
$AC16: F9 61 0C SBC  $0C61,Y
$AC19: 81 4E    STA  ($4E,X)
$AC1B: B1 8E    LDA  ($8E),Y
$AC1D: B1 BC    LDA  ($BC),Y
$AC1F: 01 E4    ORA  ($E4,X)
$AC21: 50 E9    BVC  $AC0C
$AC23: 61 0C    ADC  ($0C,X)
$AC25: 81 0D    STA  ($0D,X)
$AC27: 0A       ASL  A
$AC28: 84 43    STY  $43
$AC2A: 98       TYA  
$AC2B: 72          .byte $72  ; غير معرّف
$AC2C: 0D 0C 0F ORA  $0F0C
$AC2F: 38       SEC  
$AC30: 1D C1 5F ORA  $5FC1,X
$AC33: 26 FD    ROL  $FD
$AC35: 48       PHA  
$AC36: 0F          .byte $0F  ; غير معرّف
$AC37: 0E 01 5E ASL  $5E01
$AC3A: 02          .byte $02  ; غير معرّف
$AC3B: A7          .byte $A7  ; غير معرّف
$AC3C: 00       BRK  
$AC3D: BC 73 1A LDY  $1A73,X
$AC40: E0 39    CPX  #$39
$AC42: 61 58    ADC  ($58,X)
$AC44: 62          .byte $62  ; غير معرّف
$AC45: 77          .byte $77  ; غير معرّف
$AC46: 63          .byte $63  ; غير معرّف
$AC47: 97          .byte $97  ; غير معرّف
$AC48: 63          .byte $63  ; غير معرّف
$AC49: B8       CLV  
$AC4A: 62          .byte $62  ; غير معرّف
$AC4B: D6 07    DEC  $07,X
$AC4D: F8       SED  
$AC4E: 62          .byte $62  ; غير معرّف
$AC4F: 19 E1 75 ORA  $75E1,Y
$AC52: 52          .byte $52  ; غير معرّف
$AC53: 86 40    STX  $40
$AC55: 87          .byte $87  ; غير معرّف
$AC56: 50 95    BVC  $ABED
$AC58: 52          .byte $52  ; غير معرّف
$AC59: 93          .byte $93  ; غير معرّف
$AC5A: 43          .byte $43  ; غير معرّف
$AC5B: A5 21    LDA  $21
$AC5D: C5 52    CMP  $52
$AC5F: D6 40    DEC  $40,X
$AC61: D7          .byte $D7  ; غير معرّف
$AC62: 20 E5 06 JSR  $06E5
$AC65: E6 51    INC  $51
$AC67: 3E 8D 5E ROL  $5E8D,X
$AC6A: 03          .byte $03  ; غير معرّف
$AC6B: 67          .byte $67  ; غير معرّف
$AC6C: 52          .byte $52  ; غير معرّف
$AC6D: 77          .byte $77  ; غير معرّف
$AC6E: 52          .byte $52  ; غير معرّف
$AC6F: 7E 02 9E ROR  $9E02,X
$AC72: 03          .byte $03  ; غير معرّف
$AC73: A6 43    LDX  $43
$AC75: A7          .byte $A7  ; غير معرّف
$AC76: 23          .byte $23  ; غير معرّف
$AC77: DE 05 FE DEC  $FE05,X
$AC7A: 02          .byte $02  ; غير معرّف
$AC7B: 1E 83 33 ASL  $3383,X
$AC7E: 54          .byte $54  ; غير معرّف
$AC7F: 46 40    LSR  $40
$AC81: 47          .byte $47  ; غير معرّف
$AC82: 21 56    AND  ($56,X)
$AC84: 04          .byte $04  ; غير معرّف
$AC85: 5E 02 83 LSR  $8302,X
$AC88: 54          .byte $54  ; غير معرّف
$AC89: 93          .byte $93  ; غير معرّف
$AC8A: 52          .byte $52  ; غير معرّف
$AC8B: 96 07    STX  $07,Y
$AC8D: 97          .byte $97  ; غير معرّف
$AC8E: 50 BE    BVC  $AC4E
$AC90: 03          .byte $03  ; غير معرّف
$AC91: C7          .byte $C7  ; غير معرّف
$AC92: 23          .byte $23  ; غير معرّف
$AC93: FE 02 0C INC  $0C02,X
$AC96: 82          .byte $82  ; غير معرّف
$AC97: 43          .byte $43  ; غير معرّف
$AC98: 45 45    EOR  $45
$AC9A: 24 46    BIT  $46
$AC9C: 24 90    BIT  $90
$AC9E: 08       PHP  
$AC9F: 95 51    STA  $51,X
$ACA1: 78       SEI  
$ACA2: FA          .byte $FA  ; غير معرّف
$ACA3: D7          .byte $D7  ; غير معرّف
$ACA4: 73          .byte $73  ; غير معرّف
$ACA5: 39 F1 8C AND  $8CF1,Y
$ACA8: 01 A8    ORA  ($A8,X)
$ACAA: 52          .byte $52  ; غير معرّف
$ACAB: B8       CLV  
$ACAC: 52          .byte $52  ; غير معرّف
$ACAD: CC 01 5F CPY  $5F01
$ACB0: B3          .byte $B3  ; غير معرّف
$ACB1: 97          .byte $97  ; غير معرّف
$ACB2: 63          .byte $63  ; غير معرّف
$ACB3: 9E          .byte $9E  ; غير معرّف
$ACB4: 00       BRK  
$ACB5: 0E 81 16 ASL  $1681
$ACB8: 24 66    BIT  $66
$ACBA: 04          .byte $04  ; غير معرّف
$ACBB: 8E 00 FE STX  $FE00
$ACBE: 01 08    ORA  ($08,X)
$ACC0: D2          .byte $D2  ; غير معرّف
$ACC1: 0E 06 6F ASL  $6F06
$ACC4: 47          .byte $47  ; غير معرّف
$ACC5: 9E          .byte $9E  ; غير معرّف
$ACC6: 0F          .byte $0F  ; غير معرّف
$ACC7: 0E 82 2D ASL  $2D82
$ACCA: 47          .byte $47  ; غير معرّف
$ACCB: 28       PLP  
$ACCC: 7A          .byte $7A  ; غير معرّف
$ACCD: 68       PLA  
$ACCE: 7A          .byte $7A  ; غير معرّف
$ACCF: A8       TAY  
$ACD0: 7A          .byte $7A  ; غير معرّف
$ACD1: AE 01 DE LDX  $DE01
$ACD4: 0F          .byte $0F  ; غير معرّف
$ACD5: 6D C5 FD ADC  $FDC5
$ACD8: 48       PHA  
$ACD9: 0F          .byte $0F  ; غير معرّف
$ACDA: 0E 01 5E ASL  $5E01
$ACDD: 02          .byte $02  ; غير معرّف
$ACDE: BC 01 FC LDY  $FC01,X
$ACE1: 01 2C    ORA  ($2C,X)
$ACE3: 82          .byte $82  ; غير معرّف
$ACE4: 41 52    EOR  ($52,X)
$ACE6: 4E 04 67 LSR  $6704
$ACE9: 25 68    AND  $68
$ACEB: 24 69    BIT  $69
$ACED: 24 BA    BIT  $BA
$ACEF: 42          .byte $42  ; غير معرّف
$ACF0: C7          .byte $C7  ; غير معرّف
$ACF1: 04          .byte $04  ; غير معرّف
$ACF2: DE 0B B2 DEC  $B20B,X
$ACF5: 87          .byte $87  ; غير معرّف
$ACF6: FE 02 2C INC  $2C02,X
$ACF9: E1 2C    SBC  ($2C,X)
$ACFB: 71 67    ADC  ($67),Y
$ACFD: 01 77    ORA  ($77,X)
$ACFF: 00       BRK  
$AD00: 87          .byte $87  ; غير معرّف
$AD01: 01 8E    ORA  ($8E,X)
$AD03: 00       BRK  
$AD04: EE 01 F6 INC  $F601
$AD07: 02          .byte $02  ; غير معرّف
$AD08: 03          .byte $03  ; غير معرّف
$AD09: 85 05    STA  $05
$AD0B: 02          .byte $02  ; غير معرّف
$AD0C: 13          .byte $13  ; غير معرّف
$AD0D: 21 16    AND  ($16,X)
$AD0F: 02          .byte $02  ; غير معرّف
$AD10: 27          .byte $27  ; غير معرّف
$AD11: 02          .byte $02  ; غير معرّف
$AD12: 2E 02 88 ROL  $8802
$AD15: 72          .byte $72  ; غير معرّف
$AD16: C7          .byte $C7  ; غير معرّف
$AD17: 20 D7 07 JSR  $07D7
$AD1A: E4 76    CPX  $76
$AD1C: 07          .byte $07  ; غير معرّف
$AD1D: A0 17    LDY  #$17
$AD1F: 06 48    ASL  $48
$AD21: 7A          .byte $7A  ; غير معرّف
$AD22: 76 20    ROR  $20,X
$AD24: 98       TYA  
$AD25: 72          .byte $72  ; غير معرّف
$AD26: 79 E1 88 ADC  $88E1,Y
$AD29: 62          .byte $62  ; غير معرّف
$AD2A: 9C          .byte $9C  ; غير معرّف
$AD2B: 01 B7    ORA  ($B7,X)
$AD2D: 73          .byte $73  ; غير معرّف
$AD2E: DC          .byte $DC  ; غير معرّف
$AD2F: 01 F8    ORA  ($F8,X)
$AD31: 62          .byte $62  ; غير معرّف
$AD32: FE 01 08 INC  $0801,X
$AD35: E2          .byte $E2  ; غير معرّف
$AD36: 0E 00 6E ASL  $6E00
$AD39: 02          .byte $02  ; غير معرّف
$AD3A: 73          .byte $73  ; غير معرّف
$AD3B: 20 77 23 JSR  $2377
$AD3E: 83          .byte $83  ; غير معرّف
$AD3F: 04          .byte $04  ; غير معرّف
$AD40: 93          .byte $93  ; غير معرّف
$AD41: 20 AE 00 JSR  $00AE
$AD44: FE 0A 0E INC  $0E0A,X
$AD47: 82          .byte $82  ; غير معرّف
$AD48: 39 71 A8 AND  $A871,Y
$AD4B: 72          .byte $72  ; غير معرّف
$AD4C: E7          .byte $E7  ; غير معرّف
$AD4D: 73          .byte $73  ; غير معرّف
$AD4E: 0C          .byte $0C  ; غير معرّف
$AD4F: 81 8F    STA  ($8F,X)
$AD51: 32          .byte $32  ; غير معرّف
$AD52: AE 00 FE LDX  $FE00
$AD55: 04          .byte $04  ; غير معرّف
$AD56: 04          .byte $04  ; غير معرّف
$AD57: D1 17    CMP  ($17),Y
$AD59: 04          .byte $04  ; غير معرّف
$AD5A: 26 49    ROL  $49
$AD5C: 27          .byte $27  ; غير معرّف
$AD5D: 29 DF    AND  #$DF
$AD5F: 33          .byte $33  ; غير معرّف
$AD60: FE 02 44 INC  $4402,X
$AD63: F6 7C    INC  $7C,X
$AD65: 01 8E    ORA  ($8E,X)
$AD67: 06 BF    ASL  $BF
$AD69: 47          .byte $47  ; غير معرّف
$AD6A: EE 0F 4D INC  $4D0F
$AD6D: C7          .byte $C7  ; غير معرّف
$AD6E: 0E 82 68 ASL  $6882
$AD71: 7A          .byte $7A  ; غير معرّف
$AD72: AE 01 DE LDX  $DE01
$AD75: 0F          .byte $0F  ; غير معرّف
$AD76: 6D C5 FD ADC  $FDC5
$AD79: 48       PHA  
$AD7A: 01 0E    ORA  ($0E,X)
$AD7C: 01 00    ORA  ($00,X)
$AD7E: 5A          .byte $5A  ; غير معرّف
$AD7F: 3E 06 45 ROL  $4506,X
$AD82: 46 47    LSR  $47
$AD84: 46 53    LSR  $53
$AD86: 44          .byte $44  ; غير معرّف
$AD87: AE 01 DF LDX  $DF01
$AD8A: 4A       LSR  A
$AD8B: 4D C7 0E EOR  $0EC7
$AD8E: 81 00    STA  ($00,X)
$AD90: 5A          .byte $5A  ; غير معرّف
$AD91: 2E 04 37 ROL  $3704
$AD94: 28       PLP  
$AD95: 3A          .byte $3A  ; غير معرّف
$AD96: 48       PHA  
$AD97: 46 47    LSR  $47
$AD99: C7          .byte $C7  ; غير معرّف
$AD9A: 07          .byte $07  ; غير معرّف
$AD9B: CE 0F DF DEC  $DF0F
$AD9E: 4A       LSR  A
$AD9F: 4D C7 0E EOR  $0EC7
$ADA2: 81 00    STA  ($00,X)
$ADA4: 5A          .byte $5A  ; غير معرّف
$ADA5: 33          .byte $33  ; غير معرّف
$ADA6: 53          .byte $53  ; غير معرّف
$ADA7: 43          .byte $43  ; غير معرّف
$ADA8: 51 46    EOR  ($46),Y
$ADAA: 40       RTI  
$ADAB: 47          .byte $47  ; غير معرّف
$ADAC: 50 53    BVC  $AE01
$ADAE: 04          .byte $04  ; غير معرّف
$ADAF: 55 40    EOR  $40,X
$ADB1: 56 50    LSR  $50,X
$ADB3: 62          .byte $62  ; غير معرّف
$ADB4: 43          .byte $43  ; غير معرّف
$ADB5: 64          .byte $64  ; غير معرّف
$ADB6: 40       RTI  
$ADB7: 65 50    ADC  $50
$ADB9: 71 41    ADC  ($41),Y
$ADBB: 73          .byte $73  ; غير معرّف
$ADBC: 51 83    EOR  ($83),Y
$ADBE: 51 94    EOR  ($94),Y
$ADC0: 40       RTI  
$ADC1: 95 50    STA  $50,X
$ADC3: A3          .byte $A3  ; غير معرّف
$ADC4: 50 A5    BVC  $AD6B
$ADC6: 40       RTI  
$ADC7: A6 50    LDX  $50
$ADC9: B3          .byte $B3  ; غير معرّف
$ADCA: 51 B6    EOR  ($B6),Y
$ADCC: 40       RTI  
$ADCD: B7          .byte $B7  ; غير معرّف
$ADCE: 50 C3    BVC  $AD93
$ADD0: 53          .byte $53  ; غير معرّف
$ADD1: DF          .byte $DF  ; غير معرّف
$ADD2: 4A       LSR  A
$ADD3: 4D C7 0E EOR  $0EC7
$ADD6: 81 00    STA  ($00,X)
$ADD8: 5A          .byte $5A  ; غير معرّف
$ADD9: 2E 02 36 ROL  $3602
$ADDC: 47          .byte $47  ; غير معرّف
$ADDD: 37          .byte $37  ; غير معرّف
$ADDE: 52          .byte $52  ; غير معرّف
$ADDF: 3A          .byte $3A  ; غير معرّف
$ADE0: 49 47    EOR  #$47
$ADE2: 25 A7    AND  $A7
$ADE4: 52          .byte $52  ; غير معرّف
$ADE5: D7          .byte $D7  ; غير معرّف
$ADE6: 04          .byte $04  ; غير معرّف
$ADE7: DF          .byte $DF  ; غير معرّف
$ADE8: 4A       LSR  A
$ADE9: 4D C7 0E EOR  $0EC7
$ADEC: 81 00    STA  ($00,X)
$ADEE: 5A          .byte $5A  ; غير معرّف
$ADEF: 3E 02 44 ROL  $4402,X
$ADF2: 51 53    EOR  ($53),Y
$ADF4: 44          .byte $44  ; غير معرّف
$ADF5: 54          .byte $54  ; غير معرّف
$ADF6: 44          .byte $44  ; غير معرّف
$ADF7: 55 24    EOR  $24,X
$ADF9: A1 54    LDA  ($54,X)
$ADFB: AE 01 B4 LDX  $B401
$ADFE: 21 DF    AND  ($DF,X)
$AE00: 4A       LSR  A
$AE01: E5 07    SBC  $07
$AE03: 4D C7 FD EOR  $FDC7
$AE06: 41 01    EOR  ($01,X)
$AE08: B4 34    LDY  $34,X
$AE0A: C8       INY  
$AE0B: 52          .byte $52  ; غير معرّف
$AE0C: F2          .byte $F2  ; غير معرّف
$AE0D: 51 47    EOR  ($47),Y
$AE0F: D3          .byte $D3  ; غير معرّف
$AE10: 6C 03 65 JMP  ($6503)
$AE13: 49 9E    EOR  #$9E
$AE15: 07          .byte $07  ; غير معرّف
$AE16: BE 01 CC LDX  $CC01,Y
$AE19: 03          .byte $03  ; غير معرّف
$AE1A: FE 07 0D INC  $0D07,X
$AE1D: C9          .byte $C9  ; غير معرّف
$AE1E: 1E 01 6C ASL  $6C01,X
$AE21: 01 62    ORA  ($62,X)
$AE23: 35 63    AND  $63,X
$AE25: 53          .byte $53  ; غير معرّف
$AE26: 8A       TXA  
$AE27: 41 AC    EOR  ($AC,X)
$AE29: 01 B3    ORA  ($B3,X)
$AE2B: 53          .byte $53  ; غير معرّف
$AE2C: E9 51    SBC  #$51
$AE2E: 26 C3    ROL  $C3
$AE30: 27          .byte $27  ; غير معرّف
$AE31: 33          .byte $33  ; غير معرّف
$AE32: 63          .byte $63  ; غير معرّف
$AE33: 43          .byte $43  ; غير معرّف
$AE34: 64          .byte $64  ; غير معرّف
$AE35: 33          .byte $33  ; غير معرّف
$AE36: BA       TSX  
$AE37: 60       RTS  
$AE38: C9          .byte $C9  ; غير معرّف
$AE39: 61 CE    ADC  ($CE,X)
$AE3B: 0B          .byte $0B  ; غير معرّف
$AE3C: E5 09    SBC  $09
$AE3E: EE 0F 7D INC  $7D0F
$AE41: CA       DEX  
$AE42: 7D 47 FD ADC  $FD47,X
$AE45: 41 01    EOR  ($01,X)
$AE47: B8       CLV  
$AE48: 52          .byte $52  ; غير معرّف
$AE49: EA       NOP  
$AE4A: 41 27    EOR  ($27,X)
$AE4C: B2          .byte $B2  ; غير معرّف
$AE4D: B3          .byte $B3  ; غير معرّف
$AE4E: 42          .byte $42  ; غير معرّف
$AE4F: 16 D4    ASL  $D4,X
$AE51: 4A       LSR  A
$AE52: 42          .byte $42  ; غير معرّف
$AE53: A5 51    LDA  $51
$AE55: A7          .byte $A7  ; غير معرّف
$AE56: 31 27    AND  ($27),Y
$AE58: D3          .byte $D3  ; غير معرّف
$AE59: 08       PHP  
$AE5A: E2          .byte $E2  ; غير معرّف
$AE5B: 16 64    ASL  $64,X
$AE5D: 2C 04 38 BIT  $3804
$AE60: 42          .byte $42  ; غير معرّف
$AE61: 76 64    ROR  $64,X
$AE63: 88       DEY  
$AE64: 62          .byte $62  ; غير معرّف
$AE65: DE 07 FE DEC  $FE07,X
$AE68: 01 0D    ORA  ($0D,X)
$AE6A: C9          .byte $C9  ; غير معرّف
$AE6B: 23          .byte $23  ; غير معرّف
$AE6C: 32          .byte $32  ; غير معرّف
$AE6D: 31 51    AND  ($51),Y
$AE6F: 98       TYA  
$AE70: 52          .byte $52  ; غير معرّف
$AE71: 0D C9 59 ORA  $59C9
$AE74: 42          .byte $42  ; غير معرّف
$AE75: 63          .byte $63  ; غير معرّف
$AE76: 53          .byte $53  ; غير معرّف
$AE77: 67          .byte $67  ; غير معرّف
$AE78: 31 14    AND  ($14),Y
$AE7A: C2          .byte $C2  ; غير معرّف
$AE7B: 36 31    ROL  $31,X
$AE7D: 87          .byte $87  ; غير معرّف
$AE7E: 53          .byte $53  ; غير معرّف
$AE7F: 17          .byte $17  ; غير معرّف
$AE80: E3          .byte $E3  ; غير معرّف
$AE81: 29 61    AND  #$61
$AE83: 30 62    BMI  $AEE7
$AE85: 3C          .byte $3C  ; غير معرّف
$AE86: 08       PHP  
$AE87: 42          .byte $42  ; غير معرّف
$AE88: 37          .byte $37  ; غير معرّف
$AE89: 59 40 6A EOR  $6A40,Y
$AE8C: 42          .byte $42  ; غير معرّف
$AE8D: 99 40 C9 STA  $C940,Y
$AE90: 61 D7    ADC  ($D7,X)
$AE92: 63          .byte $63  ; غير معرّف
$AE93: 39 D1 58 AND  $58D1,Y
$AE96: 52          .byte $52  ; غير معرّف
$AE97: C3          .byte $C3  ; غير معرّف
$AE98: 67          .byte $67  ; غير معرّف
$AE99: D3          .byte $D3  ; غير معرّف
$AE9A: 31 DC    AND  ($DC),Y
$AE9C: 06 F7    ASL  $F7
$AE9E: 42          .byte $42  ; غير معرّف
$AE9F: FA          .byte $FA  ; غير معرّف
$AEA0: 42          .byte $42  ; غير معرّف
$AEA1: 23          .byte $23  ; غير معرّف
$AEA2: B1 43    LDA  ($43),Y
$AEA4: 67          .byte $67  ; غير معرّف
$AEA5: C3          .byte $C3  ; غير معرّف
$AEA6: 34          .byte $34  ; غير معرّف
$AEA7: C7          .byte $C7  ; غير معرّف
$AEA8: 34          .byte $34  ; غير معرّف
$AEA9: D1 51    CMP  ($51),Y
$AEAB: 43          .byte $43  ; غير معرّف
$AEAC: B3          .byte $B3  ; غير معرّف
$AEAD: 47          .byte $47  ; غير معرّف
$AEAE: 33          .byte $33  ; غير معرّف
$AEAF: 9A       TXS  
$AEB0: 30 A9    BMI  $AE5B
$AEB2: 61 B8    ADC  ($B8,X)
$AEB4: 62          .byte $62  ; غير معرّف
$AEB5: BE 0B D5 LDX  $D50B,Y
$AEB8: 09 DE    ORA  #$DE
$AEBA: 0F          .byte $0F  ; غير معرّف
$AEBB: 0D CA 7D ORA  $7DCA
$AEBE: 47          .byte $47  ; غير معرّف
$AEBF: FD 49 0F SBC  $0F49,X
$AEC2: 1E 01 39 ASL  $3901,X
$AEC5: 73          .byte $73  ; غير معرّف
$AEC6: 5E 07 AE LSR  $AE07,X
$AEC9: 0B          .byte $0B  ; غير معرّف
$AECA: 1E 82 6E ASL  $6E82,X
$AECD: 88       DEY  
$AECE: 9E          .byte $9E  ; غير معرّف
$AECF: 02          .byte $02  ; غير معرّف
$AED0: 0D 04 2E ORA  $2E04
$AED3: 0B          .byte $0B  ; غير معرّف
$AED4: 45 09    EOR  $09
$AED6: 4E 0F ED LSR  $ED0F
$AED9: 47          .byte $47  ; غير معرّف
$AEDA: FD FF AD SBC  $ADFF,X
$AEDD: 72          .byte $72  ; غير معرّف
$AEDE: 07          .byte $07  ; غير معرّف
$AEDF: 20 04 8E JSR  $8E04
$AEE2: E4 8F    CPX  $8F
$AEE4: 67          .byte $67  ; غير معرّف
$AEE5: 85 71    STA  $71
$AEE7: 90 EA    BCC  $AED3
$AEE9: AE AE 53 LDX  $53AE
$AEEC: 07          .byte $07  ; غير معرّف
$AEED: BD FC 06 LDA  $06FC,X
$AEF0: 8D FC 06 STA  $06FC
$AEF3: 20 4A B0 JSR  $B04A
$AEF6: AD 72 07 LDA  $0772
$AEF9: C9          .byte $C9  ; غير معرّف
$AEFA: 03          .byte $03  ; غير معرّف
$AEFB: B0 01    BCS  $AEFE
$AEFD: 60       RTS  
$AEFE: 20 24 B6 JSR  $B624
$AF01: A2 00    LDX  #$00
$AF03: 86 08    STX  $08
$AF05: 20 47 C0 JSR  $C047
$AF08: 20 C3 84 JSR  $84C3
$AF0B: E8       INX  
$AF0C: E0 06    CPX  #$06
$AF0E: D0 F3    BNE  $AF03
$AF10: 20 80 F1 JSR  $F180
$AF13: 20 2A F1 JSR  $F12A
$AF16: 20 E9 EE JSR  $EEE9
$AF19: 20 D4 BE JSR  $BED4
$AF1C: A2 01    LDX  #$01
$AF1E: 86 08    STX  $08
$AF20: 20 70 BE JSR  $BE70
$AF23: CA       DEX  
$AF24: 86 08    STX  $08
$AF26: 20 70 BE JSR  $BE70
$AF29: 20 96 BB JSR  $BB96
$AF2C: 20 BC B9 JSR  $B9BC
$AF2F: 20 B8 B7 JSR  $B7B8
$AF32: 20 55 B8 JSR  $B855
$AF35: 20 4F B7 JSR  $B74F
$AF38: 20 E1 89 JSR  $89E1
$AF3B: A5 B5    LDA  $B5
$AF3D: C9          .byte $C9  ; غير معرّف
$AF3E: 02          .byte $02  ; غير معرّف
$AF3F: 10 11    BPL  $AF52
$AF41: AD 9F 07 LDA  $079F
$AF44: F0 1E    BEQ  $AF64
$AF46: C9          .byte $C9  ; غير معرّف
$AF47: 04          .byte $04  ; غير معرّف
$AF48: D0 08    BNE  $AF52
$AF4A: AD 7F 07 LDA  $077F
$AF4D: D0 03    BNE  $AF52
$AF4F: 20 ED 90 JSR  $90ED
$AF52: AC 9F 07 LDY  $079F
$AF55: A5 09    LDA  $09
$AF57: C0 08    CPY  #$08
$AF59: B0 02    BCS  $AF5D
$AF5B: 4A       LSR  A
$AF5C: 4A       LSR  A
$AF5D: 4A       LSR  A
$AF5E: 20 88 B2 JSR  $B288
$AF61: 4C 67 AF JMP  $AF67
$AF64: 20 9A B2 JSR  $B29A
$AF67: A5 0A    LDA  $0A
$AF69: 85 0D    STA  $0D
$AF6B: A9 00    LDA  #$00
$AF6D: 85 0C    STA  $0C
$AF6F: AD 73 07 LDA  $0773
$AF72: C9          .byte $C9  ; غير معرّف
$AF73: 06 F0    ASL  $F0
$AF75: 1C          .byte $1C  ; غير معرّف
$AF76: AD 1F 07 LDA  $071F
$AF79: D0 14    BNE  $AF8F
$AF7B: AD 3D 07 LDA  $073D
$AF7E: C9          .byte $C9  ; غير معرّف
$AF7F: 20 30 10 JSR  $1030
$AF82: AD 3D 07 LDA  $073D
$AF85: E9 20    SBC  #$20
$AF87: 8D 3D 07 STA  $073D
$AF8A: A9 00    LDA  #$00
$AF8C: 8D 40 03 STA  $0340
$AF8F: 20 B0 92 JSR  $92B0
$AF92: 60       RTS  
$AF93: AD FF 06 LDA  $06FF
$AF96: 18       CLC  
$AF97: 6D A1 03 ADC  $03A1
$AF9A: 8D FF 06 STA  $06FF
$AF9D: AD 23 07 LDA  $0723
$AFA0: D0 59    BNE  $AFFB
$AFA2: AD 55 07 LDA  $0755
$AFA5: C9          .byte $C9  ; غير معرّف
$AFA6: 50 90    BVC  $AF38
$AFA8: 52          .byte $52  ; غير معرّف
$AFA9: AD 85 07 LDA  $0785
$AFAC: D0 4D    BNE  $AFFB
$AFAE: AC FF 06 LDY  $06FF
$AFB1: 88       DEY  
$AFB2: 30 47    BMI  $AFFB
$AFB4: C8       INY  
$AFB5: C0 02    CPY  #$02
$AFB7: 90 01    BCC  $AFBA
$AFB9: 88       DEY  
$AFBA: AD 55 07 LDA  $0755
$AFBD: C9          .byte $C9  ; غير معرّف
$AFBE: 70 90    BVS  $AF50
$AFC0: 03          .byte $03  ; غير معرّف
$AFC1: AC FF 06 LDY  $06FF
$AFC4: 98       TYA  
$AFC5: 8D 75 07 STA  $0775
$AFC8: 18       CLC  
$AFC9: 6D 3D 07 ADC  $073D
$AFCC: 8D 3D 07 STA  $073D
$AFCF: 98       TYA  
$AFD0: 18       CLC  
$AFD1: 6D 1C 07 ADC  $071C
$AFD4: 8D 1C 07 STA  $071C
$AFD7: 8D 3F 07 STA  $073F
$AFDA: AD 1A 07 LDA  $071A
$AFDD: 69 00    ADC  #$00
$AFDF: 8D 1A 07 STA  $071A
$AFE2: 29 01    AND  #$01
$AFE4: 85 00    STA  $00
$AFE6: AD 78 07 LDA  $0778
$AFE9: 29 FE    AND  #$FE
$AFEB: 05 00    ORA  $00
$AFED: 8D 78 07 STA  $0778
$AFF0: 20 38 B0 JSR  $B038
$AFF3: A9 08    LDA  #$08
$AFF5: 8D 95 07 STA  $0795
$AFF8: 4C 00 B0 JMP  $B000
$AFFB: A9 00    LDA  #$00
$AFFD: 8D 75 07 STA  $0775
$B000: A2 00    LDX  #$00
$B002: 20 F6 F1 JSR  $F1F6
$B005: 85 00    STA  $00
$B007: A0 00    LDY  #$00
$B009: 0A       ASL  A
$B00A: B0 07    BCS  $B013
$B00C: C8       INY  
$B00D: A5 00    LDA  $00
$B00F: 29 20    AND  #$20
$B011: F0 1B    BEQ  $B02E
$B013: B9 1C 07 LDA  $071C,Y
$B016: 38       SEC  
$B017: F9 34 B0 SBC  $B034,Y
$B01A: 85 86    STA  $86
$B01C: B9 1A 07 LDA  $071A,Y
$B01F: E9 00    SBC  #$00
$B021: 85 6D    STA  $6D
$B023: A5 0C    LDA  $0C
$B025: D9 36 B0 CMP  $B036,Y
$B028: F0 04    BEQ  $B02E
$B02A: A9 00    LDA  #$00
$B02C: 85 57    STA  $57
$B02E: A9 00    LDA  #$00
$B030: 8D A1 03 STA  $03A1
$B033: 60       RTS  
$B034: 00       BRK  
$B035: 10 01    BPL  $B038
$B037: 02          .byte $02  ; غير معرّف
$B038: AD 1C 07 LDA  $071C
$B03B: 18       CLC  
$B03C: 69 FF    ADC  #$FF
$B03E: 8D 1D 07 STA  $071D
$B041: AD 1A 07 LDA  $071A
$B044: 69 00    ADC  #$00
$B046: 8D 1B 07 STA  $071B
$B049: 60       RTS  
$B04A: A5 0E    LDA  $0E
$B04C: 20 04 8E JSR  $8E04
$B04F: 31 91    AND  ($91),Y
$B051: C7          .byte $C7  ; غير معرّف
$B052: B1 06    LDA  ($06),Y
$B054: B2          .byte $B2  ; غير معرّف
$B055: E5 B1    SBC  $B1
$B057: A4 B2    LDY  $B2
$B059: CA       DEX  
$B05A: B2          .byte $B2  ; غير معرّف
$B05B: CD 91 69 CMP  $6991
$B05E: B0 E9    BCS  $B049
$B060: B0 33    BCS  $B095
$B062: B2          .byte $B2  ; غير معرّف
$B063: 45 B2    EOR  $B2
$B065: 69 B2    ADC  #$B2
$B067: 7D B2 AD ADC  $ADB2,X
$B06A: 52          .byte $52  ; غير معرّف
$B06B: 07          .byte $07  ; غير معرّف
$B06C: C9          .byte $C9  ; غير معرّف
$B06D: 02          .byte $02  ; غير معرّف
$B06E: F0 2B    BEQ  $B09B
$B070: A9 00    LDA  #$00
$B072: A4 CE    LDY  $CE
$B074: C0 30    CPY  #$30
$B076: 90 6E    BCC  $B0E6
$B078: AD 10 07 LDA  $0710
$B07B: C9          .byte $C9  ; غير معرّف
$B07C: 06 F0    ASL  $F0
$B07E: 04          .byte $04  ; غير معرّف
$B07F: C9          .byte $C9  ; غير معرّف
$B080: 07          .byte $07  ; غير معرّف
$B081: D0 50    BNE  $B0D3
$B083: AD C4 03 LDA  $03C4
$B086: D0 05    BNE  $B08D
$B088: A9 01    LDA  #$01
$B08A: 4C E6 B0 JMP  $B0E6
$B08D: 20 1F B2 JSR  $B21F
$B090: CE DE 06 DEC  $06DE
$B093: D0 50    BNE  $B0E5
$B095: EE 69 07 INC  $0769
$B098: 4C 15 B3 JMP  $B315
$B09B: AD 58 07 LDA  $0758
$B09E: D0 0C    BNE  $B0AC
$B0A0: A9 FF    LDA  #$FF
$B0A2: 20 00 B2 JSR  $B200
$B0A5: A5 CE    LDA  $CE
$B0A7: C9          .byte $C9  ; غير معرّف
$B0A8: 91 90    STA  ($90),Y
$B0AA: 28       PLP  
$B0AB: 60       RTS  
$B0AC: AD 99 03 LDA  $0399
$B0AF: C9          .byte $C9  ; غير معرّف
$B0B0: 60       RTS  
$B0B1: D0 32    BNE  $B0E5
$B0B3: A5 CE    LDA  $CE
$B0B5: C9          .byte $C9  ; غير معرّف
$B0B6: 99 A0 00 STA  $00A0,Y
$B0B9: A9 01    LDA  #$01
$B0BB: 90 0A    BCC  $B0C7
$B0BD: A9 03    LDA  #$03
$B0BF: 85 1D    STA  $1D
$B0C1: C8       INY  
$B0C2: A9 08    LDA  #$08
$B0C4: 8D B4 05 STA  $05B4
$B0C7: 8C 16 07 STY  $0716
$B0CA: 20 E6 B0 JSR  $B0E6
$B0CD: A5 86    LDA  $86
$B0CF: C9          .byte $C9  ; غير معرّف
$B0D0: 48       PHA  
$B0D1: 90 12    BCC  $B0E5
$B0D3: A9 08    LDA  #$08
$B0D5: 85 0E    STA  $0E
$B0D7: A9 01    LDA  #$01
$B0D9: 85 33    STA  $33
$B0DB: 4A       LSR  A
$B0DC: 8D 52 07 STA  $0752
$B0DF: 8D 16 07 STA  $0716
$B0E2: 8D 58 07 STA  $0758
$B0E5: 60       RTS  
$B0E6: 8D FC 06 STA  $06FC
$B0E9: A5 0E    LDA  $0E
$B0EB: C9          .byte $C9  ; غير معرّف
$B0EC: 0B          .byte $0B  ; غير معرّف
$B0ED: F0 3C    BEQ  $B12B
$B0EF: AD 4E 07 LDA  $074E
$B0F2: D0 10    BNE  $B104
$B0F4: A4 B5    LDY  $B5
$B0F6: 88       DEY  
$B0F7: D0 06    BNE  $B0FF
$B0F9: A5 CE    LDA  $CE
$B0FB: C9          .byte $C9  ; غير معرّف
$B0FC: D0 90    BNE  $B08E
$B0FE: 05 A9    ORA  $A9
$B100: 00       BRK  
$B101: 8D FC 06 STA  $06FC
$B104: AD FC 06 LDA  $06FC
$B107: 29 C0    AND  #$C0
$B109: 85 0A    STA  $0A
$B10B: AD FC 06 LDA  $06FC
$B10E: 29 03    AND  #$03
$B110: 85 0C    STA  $0C
$B112: AD FC 06 LDA  $06FC
$B115: 29 0C    AND  #$0C
$B117: 85 0B    STA  $0B
$B119: 29 04    AND  #$04
$B11B: F0 0E    BEQ  $B12B
$B11D: A5 1D    LDA  $1D
$B11F: D0 0A    BNE  $B12B
$B121: A4 0C    LDY  $0C
$B123: F0 06    BEQ  $B12B
$B125: A9 00    LDA  #$00
$B127: 85 0C    STA  $0C
$B129: 85 0B    STA  $0B
$B12B: 20 29 B3 JSR  $B329
$B12E: A0 01    LDY  #$01
$B130: AD 54 07 LDA  $0754
$B133: D0 09    BNE  $B13E
$B135: A0 00    LDY  #$00
$B137: AD 14 07 LDA  $0714
$B13A: F0 02    BEQ  $B13E
$B13C: A0 02    LDY  #$02
$B13E: 8C 99 04 STY  $0499
$B141: A9 01    LDA  #$01
$B143: A4 57    LDY  $57
$B145: F0 05    BEQ  $B14C
$B147: 10 01    BPL  $B14A
$B149: 0A       ASL  A
$B14A: 85 45    STA  $45
$B14C: 20 93 AF JSR  $AF93
$B14F: 20 80 F1 JSR  $F180
$B152: 20 2A F1 JSR  $F12A
$B155: A2 00    LDX  #$00
$B157: 20 9C E2 JSR  $E29C
$B15A: 20 64 DC JSR  $DC64
$B15D: A5 CE    LDA  $CE
$B15F: C9          .byte $C9  ; غير معرّف
$B160: 40       RTI  
$B161: 90 16    BCC  $B179
$B163: A5 0E    LDA  $0E
$B165: C9          .byte $C9  ; غير معرّف
$B166: 05 F0    ORA  $F0
$B168: 10 C9    BPL  $B133
$B16A: 07          .byte $07  ; غير معرّف
$B16B: F0 0C    BEQ  $B179
$B16D: C9          .byte $C9  ; غير معرّف
$B16E: 04          .byte $04  ; غير معرّف
$B16F: 90 08    BCC  $B179
$B171: AD C4 03 LDA  $03C4
$B174: 29 DF    AND  #$DF
$B176: 8D C4 03 STA  $03C4
$B179: A5 B5    LDA  $B5
$B17B: C9          .byte $C9  ; غير معرّف
$B17C: 02          .byte $02  ; غير معرّف
$B17D: 30 3B    BMI  $B1BA
$B17F: A2 01    LDX  #$01
$B181: 8E 23 07 STX  $0723
$B184: A0 04    LDY  #$04
$B186: 84 07    STY  $07
$B188: A2 00    LDX  #$00
$B18A: AC 59 07 LDY  $0759
$B18D: D0 05    BNE  $B194
$B18F: AC 43 07 LDY  $0743
$B192: D0 16    BNE  $B1AA
$B194: E8       INX  
$B195: A4 0E    LDY  $0E
$B197: C0 0B    CPY  #$0B
$B199: F0 0F    BEQ  $B1AA
$B19B: AC 12 07 LDY  $0712
$B19E: D0 06    BNE  $B1A6
$B1A0: C8       INY  
$B1A1: 84 FC    STY  $FC
$B1A3: 8C 12 07 STY  $0712
$B1A6: A0 06    LDY  #$06
$B1A8: 84 07    STY  $07
$B1AA: C5 07    CMP  $07
$B1AC: 30 0C    BMI  $B1BA
$B1AE: CA       DEX  
$B1AF: 30 0A    BMI  $B1BB
$B1B1: AC B1 07 LDY  $07B1
$B1B4: D0 04    BNE  $B1BA
$B1B6: A9 06    LDA  #$06
$B1B8: 85 0E    STA  $0E
$B1BA: 60       RTS  
$B1BB: A9 00    LDA  #$00
$B1BD: 8D 58 07 STA  $0758
$B1C0: 20 DD B1 JSR  $B1DD
$B1C3: EE 52 07 INC  $0752
$B1C6: 60       RTS  
$B1C7: A5 B5    LDA  $B5
$B1C9: D0 06    BNE  $B1D1
$B1CB: A5 CE    LDA  $CE
$B1CD: C9          .byte $C9  ; غير معرّف
$B1CE: E4 90    CPX  $90
$B1D0: 0C          .byte $0C  ; غير معرّف
$B1D1: A9 08    LDA  #$08
$B1D3: 8D 58 07 STA  $0758
$B1D6: A0 03    LDY  #$03
$B1D8: 84 1D    STY  $1D
$B1DA: 4C E6 B0 JMP  $B0E6
$B1DD: A9 02    LDA  #$02
$B1DF: 8D 52 07 STA  $0752
$B1E2: 4C 13 B2 JMP  $B213
$B1E5: A9 01    LDA  #$01
$B1E7: 20 00 B2 JSR  $B200
$B1EA: 20 93 AF JSR  $AF93
$B1ED: A0 00    LDY  #$00
$B1EF: AD D6 06 LDA  $06D6
$B1F2: D0 17    BNE  $B20B
$B1F4: C8       INY  
$B1F5: AD 4E 07 LDA  $074E
$B1F8: C9          .byte $C9  ; غير معرّف
$B1F9: 03          .byte $03  ; غير معرّف
$B1FA: D0 0F    BNE  $B20B
$B1FC: C8       INY  
$B1FD: 4C 0B B2 JMP  $B20B
$B200: 18       CLC  
$B201: 65 CE    ADC  $CE
$B203: 85 CE    STA  $CE
$B205: 60       RTS  
$B206: 20 1F B2 JSR  $B21F
$B209: A0 02    LDY  #$02
$B20B: CE DE 06 DEC  $06DE
$B20E: D0 0E    BNE  $B21E
$B210: 8C 52 07 STY  $0752
$B213: EE 74 07 INC  $0774
$B216: A9 00    LDA  #$00
$B218: 8D 72 07 STA  $0772
$B21B: 8D 22 07 STA  $0722
$B21E: 60       RTS  
$B21F: A9 08    LDA  #$08
$B221: 85 57    STA  $57
$B223: A0 01    LDY  #$01
$B225: A5 86    LDA  $86
$B227: 29 0F    AND  #$0F
$B229: D0 03    BNE  $B22E
$B22B: 85 57    STA  $57
$B22D: A8       TAY  
$B22E: 98       TYA  
$B22F: 20 E6 B0 JSR  $B0E6
$B232: 60       RTS  
$B233: AD 47 07 LDA  $0747
$B236: C9          .byte $C9  ; غير معرّف
$B237: F8       SED  
$B238: D0 03    BNE  $B23D
$B23A: 4C 55 B2 JMP  $B255
$B23D: C9          .byte $C9  ; غير معرّف
$B23E: C4 D0    CPY  $D0
$B240: 03          .byte $03  ; غير معرّف
$B241: 20 73 B2 JSR  $B273
$B244: 60       RTS  
$B245: AD 47 07 LDA  $0747
$B248: C9          .byte $C9  ; غير معرّف
$B249: F0 B0    BEQ  $B1FB
$B24B: 07          .byte $07  ; غير معرّف
$B24C: C9          .byte $C9  ; غير معرّف
$B24D: C8       INY  
$B24E: F0 23    BEQ  $B273
$B250: 4C E9 B0 JMP  $B0E9
$B253: D0 13    BNE  $B268
$B255: AC 0B 07 LDY  $070B
$B258: D0 0E    BNE  $B268
$B25A: 8C 0D 07 STY  $070D
$B25D: EE 0B 07 INC  $070B
$B260: AD 54 07 LDA  $0754
$B263: 49 01    EOR  #$01
$B265: 8D 54 07 STA  $0754
$B268: 60       RTS  
$B269: AD 47 07 LDA  $0747
$B26C: C9          .byte $C9  ; غير معرّف
$B26D: F0 B0    BEQ  $B21F
$B26F: 33          .byte $33  ; غير معرّف
$B270: 4C E9 B0 JMP  $B0E9
$B273: A9 00    LDA  #$00
$B275: 8D 47 07 STA  $0747
$B278: A9 08    LDA  #$08
$B27A: 85 0E    STA  $0E
$B27C: 60       RTS  
$B27D: AD 47 07 LDA  $0747
$B280: C9          .byte $C9  ; غير معرّف
$B281: C0 F0    CPY  #$F0
$B283: 13          .byte $13  ; غير معرّف
$B284: A5 09    LDA  $09
$B286: 4A       LSR  A
$B287: 4A       LSR  A
$B288: 29 03    AND  #$03
$B28A: 85 00    STA  $00
$B28C: AD C4 03 LDA  $03C4
$B28F: 29 FC    AND  #$FC
$B291: 05 00    ORA  $00
$B293: 8D C4 03 STA  $03C4
$B296: 60       RTS  
$B297: 20 73 B2 JSR  $B273
$B29A: AD C4 03 LDA  $03C4
$B29D: 29 FC    AND  #$FC
$B29F: 8D C4 03 STA  $03C4
$B2A2: 60       RTS  
$B2A3: 60       RTS  
$B2A4: A5 1B    LDA  $1B
$B2A6: C9          .byte $C9  ; غير معرّف
$B2A7: 30 D0    BMI  $B279
$B2A9: 15 AD    ORA  $AD,X
$B2AB: 13          .byte $13  ; غير معرّف
$B2AC: 07          .byte $07  ; غير معرّف
$B2AD: 85 FF    STA  $FF
$B2AF: A9 00    LDA  #$00
$B2B1: 8D 13 07 STA  $0713
$B2B4: A4 CE    LDY  $CE
$B2B6: C0 9E    CPY  #$9E
$B2B8: B0 02    BCS  $B2BC
$B2BA: A9 04    LDA  #$04
$B2BC: 4C E6 B0 JMP  $B0E6
$B2BF: E6 0E    INC  $0E
$B2C1: 60       RTS  
$B2C2: 15 23    ORA  $23,X
$B2C4: 16 1B    ASL  $1B,X
$B2C6: 17          .byte $17  ; غير معرّف
$B2C7: 18       CLC  
$B2C8: 23          .byte $23  ; غير معرّف
$B2C9: 63          .byte $63  ; غير معرّف
$B2CA: A9 01    LDA  #$01
$B2CC: 20 E6 B0 JSR  $B0E6
$B2CF: A5 CE    LDA  $CE
$B2D1: C9          .byte $C9  ; غير معرّف
$B2D2: AE 90 0E LDX  $0E90
$B2D5: AD 23 07 LDA  $0723
$B2D8: F0 09    BEQ  $B2E3
$B2DA: A9 20    LDA  #$20
$B2DC: 85 FC    STA  $FC
$B2DE: A9 00    LDA  #$00
$B2E0: 8D 23 07 STA  $0723
$B2E3: AD 90 04 LDA  $0490
$B2E6: 4A       LSR  A
$B2E7: B0 0D    BCS  $B2F6
$B2E9: AD 46 07 LDA  $0746
$B2EC: D0 03    BNE  $B2F1
$B2EE: EE 46 07 INC  $0746
$B2F1: A9 20    LDA  #$20
$B2F3: 8D C4 03 STA  $03C4
$B2F6: AD 46 07 LDA  $0746
$B2F9: C9          .byte $C9  ; غير معرّف
$B2FA: 05 D0    ORA  $D0
$B2FC: 2B          .byte $2B  ; غير معرّف
$B2FD: EE 5C 07 INC  $075C
$B300: AD 5C 07 LDA  $075C
$B303: C9          .byte $C9  ; غير معرّف
$B304: 03          .byte $03  ; غير معرّف
$B305: D0 0E    BNE  $B315
$B307: AC 5F 07 LDY  $075F
$B30A: AD 48 07 LDA  $0748
$B30D: D9 C2 B2 CMP  $B2C2,Y
$B310: 90 03    BCC  $B315
$B312: EE 5D 07 INC  $075D
$B315: EE 60 07 INC  $0760
$B318: 20 03 9C JSR  $9C03
$B31B: EE 57 07 INC  $0757
$B31E: 20 13 B2 JSR  $B213
$B321: 8D 5B 07 STA  $075B
$B324: A9 80    LDA  #$80
$B326: 85 FC    STA  $FC
$B328: 60       RTS  
$B329: A9 00    LDA  #$00
$B32B: AC 54 07 LDY  $0754
$B32E: D0 08    BNE  $B338
$B330: A5 1D    LDA  $1D
$B332: D0 07    BNE  $B33B
$B334: A5 0B    LDA  $0B
$B336: 29 04    AND  #$04
$B338: 8D 14 07 STA  $0714
$B33B: 20 50 B4 JSR  $B450
$B33E: AD 0B 07 LDA  $070B
$B341: D0 16    BNE  $B359
$B343: A5 1D    LDA  $1D
$B345: C9          .byte $C9  ; غير معرّف
$B346: 03          .byte $03  ; غير معرّف
$B347: F0 05    BEQ  $B34E
$B349: A0 18    LDY  #$18
$B34B: 8C 89 07 STY  $0789
$B34E: 20 04 8E JSR  $8E04
$B351: 5A          .byte $5A  ; غير معرّف
$B352: B3          .byte $B3  ; غير معرّف
$B353: 76 B3    ROR  $B3,X
$B355: 6D B3 CF ADC  $CFB3
$B358: B3          .byte $B3  ; غير معرّف
$B359: 60       RTS  
$B35A: 20 8F B5 JSR  $B58F
$B35D: A5 0C    LDA  $0C
$B35F: F0 02    BEQ  $B363
$B361: 85 33    STA  $33
$B363: 20 CC B5 JSR  $B5CC
$B366: 20 09 BF JSR  $BF09
$B369: 8D FF 06 STA  $06FF
$B36C: 60       RTS  
$B36D: AD 0A 07 LDA  $070A
$B370: 8D 09 07 STA  $0709
$B373: 4C AC B3 JMP  $B3AC
$B376: A4 9F    LDY  $9F
$B378: 10 13    BPL  $B38D
$B37A: A5 0A    LDA  $0A
$B37C: 29 80    AND  #$80
$B37E: 25 0D    AND  $0D
$B380: D0 11    BNE  $B393
$B382: AD 08 07 LDA  $0708
$B385: 38       SEC  
$B386: E5 CE    SBC  $CE
$B388: CD 06 07 CMP  $0706
$B38B: 90 06    BCC  $B393
$B38D: AD 0A 07 LDA  $070A
$B390: 8D 09 07 STA  $0709
$B393: AD 04 07 LDA  $0704
$B396: F0 14    BEQ  $B3AC
$B398: 20 8F B5 JSR  $B58F
$B39B: A5 CE    LDA  $CE
$B39D: C9          .byte $C9  ; غير معرّف
$B39E: 14          .byte $14  ; غير معرّف
$B39F: B0 05    BCS  $B3A6
$B3A1: A9 18    LDA  #$18
$B3A3: 8D 09 07 STA  $0709
$B3A6: A5 0C    LDA  $0C
$B3A8: F0 02    BEQ  $B3AC
$B3AA: 85 33    STA  $33
$B3AC: A5 0C    LDA  $0C
$B3AE: F0 03    BEQ  $B3B3
$B3B0: 20 CC B5 JSR  $B5CC
$B3B3: 20 09 BF JSR  $BF09
$B3B6: 8D FF 06 STA  $06FF
$B3B9: A5 0E    LDA  $0E
$B3BB: C9          .byte $C9  ; غير معرّف
$B3BC: 0B          .byte $0B  ; غير معرّف
$B3BD: D0 05    BNE  $B3C4
$B3BF: A9 28    LDA  #$28
$B3C1: 8D 09 07 STA  $0709
$B3C4: 4C 4D BF JMP  $BF4D
$B3C7: 0E 04 FC ASL  $FC04
$B3CA: F2          .byte $F2  ; غير معرّف
$B3CB: 00       BRK  
$B3CC: 00       BRK  
$B3CD: FF          .byte $FF  ; غير معرّف
$B3CE: FF          .byte $FF  ; غير معرّف
$B3CF: AD 16 04 LDA  $0416
$B3D2: 18       CLC  
$B3D3: 6D 33 04 ADC  $0433
$B3D6: 8D 16 04 STA  $0416
$B3D9: A0 00    LDY  #$00
$B3DB: A5 9F    LDA  $9F
$B3DD: 10 01    BPL  $B3E0
$B3DF: 88       DEY  
$B3E0: 84 00    STY  $00
$B3E2: 65 CE    ADC  $CE
$B3E4: 85 CE    STA  $CE
$B3E6: A5 B5    LDA  $B5
$B3E8: 65 00    ADC  $00
$B3EA: 85 B5    STA  $B5
$B3EC: A5 0C    LDA  $0C
$B3EE: 2D 90 04 AND  $0490
$B3F1: F0 2D    BEQ  $B420
$B3F3: AC 89 07 LDY  $0789
$B3F6: D0 27    BNE  $B41F
$B3F8: A0 18    LDY  #$18
$B3FA: 8C 89 07 STY  $0789
$B3FD: A2 00    LDX  #$00
$B3FF: A4 33    LDY  $33
$B401: 4A       LSR  A
$B402: B0 02    BCS  $B406
$B404: E8       INX  
$B405: E8       INX  
$B406: 88       DEY  
$B407: F0 01    BEQ  $B40A
$B409: E8       INX  
$B40A: A5 86    LDA  $86
$B40C: 18       CLC  
$B40D: 7D C7 B3 ADC  $B3C7,X
$B410: 85 86    STA  $86
$B412: A5 6D    LDA  $6D
$B414: 7D CB B3 ADC  $B3CB,X
$B417: 85 6D    STA  $6D
$B419: A5 0C    LDA  $0C
$B41B: 49 03    EOR  #$03
$B41D: 85 33    STA  $33
$B41F: 60       RTS  
$B420: 8D 89 07 STA  $0789
$B423: 60       RTS  
$B424: 20 20 1E JSR  $1E20
$B427: 28       PLP  
$B428: 28       PLP  
$B429: 0D 04 70 ORA  $7004
$B42C: 70 60    BVS  $B48E
$B42E: 90 90    BCC  $B3C0
$B430: 0A       ASL  A
$B431: 09 FC    ORA  #$FC
$B433: FC          .byte $FC  ; غير معرّف
$B434: FC          .byte $FC  ; غير معرّف
$B435: FB          .byte $FB  ; غير معرّف
$B436: FB          .byte $FB  ; غير معرّف
$B437: FE FF 00 INC  $00FF,X
$B43A: 00       BRK  
$B43B: 00       BRK  
$B43C: 00       BRK  
$B43D: 00       BRK  
$B43E: 80          .byte $80  ; غير معرّف
$B43F: 00       BRK  
$B440: D8       CLD  
$B441: E8       INX  
$B442: F0 28    BEQ  $B46C
$B444: 18       CLC  
$B445: 10 0C    BPL  $B453
$B447: E4 98    CPX  $98
$B449: D0 00    BNE  $B44B
$B44B: FF          .byte $FF  ; غير معرّف
$B44C: 01 00    ORA  ($00,X)
$B44E: 20 FF A5 JSR  $A5FF
$B451: 1D C9 03 ORA  $03C9,X
$B454: D0 23    BNE  $B479
$B456: A0 00    LDY  #$00
$B458: A5 0B    LDA  $0B
$B45A: 2D 90 04 AND  $0490
$B45D: F0 06    BEQ  $B465
$B45F: C8       INY  
$B460: 29 08    AND  #$08
$B462: D0 01    BNE  $B465
$B464: C8       INY  
$B465: BE 4D B4 LDX  $B44D,Y
$B468: 8E 33 04 STX  $0433
$B46B: A9 08    LDA  #$08
$B46D: BE 4A B4 LDX  $B44A,Y
$B470: 86 9F    STX  $9F
$B472: 30 01    BMI  $B475
$B474: 4A       LSR  A
$B475: 8D 0C 07 STA  $070C
$B478: 60       RTS  
$B479: AD 0E 07 LDA  $070E
$B47C: D0 0A    BNE  $B488
$B47E: A5 0A    LDA  $0A
$B480: 29 80    AND  #$80
$B482: F0 04    BEQ  $B488
$B484: 25 0D    AND  $0D
$B486: F0 03    BEQ  $B48B
$B488: 4C 1C B5 JMP  $B51C
$B48B: A5 1D    LDA  $1D
$B48D: F0 11    BEQ  $B4A0
$B48F: AD 04 07 LDA  $0704
$B492: F0 F4    BEQ  $B488
$B494: AD 82 07 LDA  $0782
$B497: D0 07    BNE  $B4A0
$B499: A5 9F    LDA  $9F
$B49B: 10 03    BPL  $B4A0
$B49D: 4C 1C B5 JMP  $B51C
$B4A0: A9 20    LDA  #$20
$B4A2: 8D 82 07 STA  $0782
$B4A5: A0 00    LDY  #$00
$B4A7: 8C 16 04 STY  $0416
$B4AA: 8C 33 04 STY  $0433
$B4AD: A5 B5    LDA  $B5
$B4AF: 8D 07 07 STA  $0707
$B4B2: A5 CE    LDA  $CE
$B4B4: 8D 08 07 STA  $0708
$B4B7: A9 01    LDA  #$01
$B4B9: 85 1D    STA  $1D
$B4BB: AD 00 07 LDA  $0700
$B4BE: C9          .byte $C9  ; غير معرّف
$B4BF: 09 90    ORA  #$90
$B4C1: 10 C8    BPL  $B48B
$B4C3: C9          .byte $C9  ; غير معرّف
$B4C4: 10 90    BPL  $B456
$B4C6: 0B          .byte $0B  ; غير معرّف
$B4C7: C8       INY  
$B4C8: C9          .byte $C9  ; غير معرّف
$B4C9: 19 90 06 ORA  $0690,Y
$B4CC: C8       INY  
$B4CD: C9          .byte $C9  ; غير معرّف
$B4CE: 1C          .byte $1C  ; غير معرّف
$B4CF: 90 01    BCC  $B4D2
$B4D1: C8       INY  
$B4D2: A9 01    LDA  #$01
$B4D4: 8D 06 07 STA  $0706
$B4D7: AD 04 07 LDA  $0704
$B4DA: F0 08    BEQ  $B4E4
$B4DC: A0 05    LDY  #$05
$B4DE: AD 7D 04 LDA  $047D
$B4E1: F0 01    BEQ  $B4E4
$B4E3: C8       INY  
$B4E4: B9 24 B4 LDA  $B424,Y
$B4E7: 8D 09 07 STA  $0709
$B4EA: B9 2B B4 LDA  $B42B,Y
$B4ED: 8D 0A 07 STA  $070A
$B4F0: B9 39 B4 LDA  $B439,Y
$B4F3: 8D 33 04 STA  $0433
$B4F6: B9 32 B4 LDA  $B432,Y
$B4F9: 85 9F    STA  $9F
$B4FB: AD 04 07 LDA  $0704
$B4FE: F0 11    BEQ  $B511
$B500: A9 04    LDA  #$04
$B502: 85 FF    STA  $FF
$B504: A5 CE    LDA  $CE
$B506: C9          .byte $C9  ; غير معرّف
$B507: 14          .byte $14  ; غير معرّف
$B508: B0 12    BCS  $B51C
$B50A: A9 00    LDA  #$00
$B50C: 85 9F    STA  $9F
$B50E: 4C 1C B5 JMP  $B51C
$B511: A9 01    LDA  #$01
$B513: AC 54 07 LDY  $0754
$B516: F0 02    BEQ  $B51A
$B518: A9 80    LDA  #$80
$B51A: 85 FF    STA  $FF
$B51C: A0 00    LDY  #$00
$B51E: 84 00    STY  $00
$B520: A5 1D    LDA  $1D
$B522: F0 09    BEQ  $B52D
$B524: AD 00 07 LDA  $0700
$B527: C9          .byte $C9  ; غير معرّف
$B528: 19 B0 33 ORA  $33B0,Y
$B52B: 90 18    BCC  $B545
$B52D: C8       INY  
$B52E: AD 4E 07 LDA  $074E
$B531: F0 12    BEQ  $B545
$B533: 88       DEY  
$B534: A5 0C    LDA  $0C
$B536: C5 45    CMP  $45
$B538: D0 0B    BNE  $B545
$B53A: A5 0A    LDA  $0A
$B53C: 29 40    AND  #$40
$B53E: D0 19    BNE  $B559
$B540: AD 83 07 LDA  $0783
$B543: D0 19    BNE  $B55E
$B545: C8       INY  
$B546: E6 00    INC  $00
$B548: AD 03 07 LDA  $0703
$B54B: D0 07    BNE  $B554
$B54D: AD 00 07 LDA  $0700
$B550: C9          .byte $C9  ; غير معرّف
$B551: 21 90    AND  ($90,X)
$B553: 0A       ASL  A
$B554: E6 00    INC  $00
$B556: 4C 5E B5 JMP  $B55E
$B559: A9 0A    LDA  #$0A
$B55B: 8D 83 07 STA  $0783
$B55E: B9 40 B4 LDA  $B440,Y
$B561: 8D 50 04 STA  $0450
$B564: A5 0E    LDA  $0E
$B566: C9          .byte $C9  ; غير معرّف
$B567: 07          .byte $07  ; غير معرّف
$B568: D0 02    BNE  $B56C
$B56A: A0 03    LDY  #$03
$B56C: B9 43 B4 LDA  $B443,Y
$B56F: 8D 56 04 STA  $0456
$B572: A4 00    LDY  $00
$B574: B9 47 B4 LDA  $B447,Y
$B577: 8D 02 07 STA  $0702
$B57A: A9 00    LDA  #$00
$B57C: 8D 01 07 STA  $0701
$B57F: A5 33    LDA  $33
$B581: C5 45    CMP  $45
$B583: F0 06    BEQ  $B58B
$B585: 0E 02 07 ASL  $0702
$B588: 2E 01 07 ROL  $0701
$B58B: 60       RTS  
$B58C: 02          .byte $02  ; غير معرّف
$B58D: 04          .byte $04  ; غير معرّف
$B58E: 07          .byte $07  ; غير معرّف
$B58F: A0 00    LDY  #$00
$B591: AD 00 07 LDA  $0700
$B594: C9          .byte $C9  ; غير معرّف
$B595: 1C          .byte $1C  ; غير معرّف
$B596: B0 15    BCS  $B5AD
$B598: C8       INY  
$B599: C9          .byte $C9  ; غير معرّف
$B59A: 0E B0 01 ASL  $01B0
$B59D: C8       INY  
$B59E: AD FC 06 LDA  $06FC
$B5A1: 29 7F    AND  #$7F
$B5A3: F0 20    BEQ  $B5C5
$B5A5: 29 03    AND  #$03
$B5A7: C5 45    CMP  $45
$B5A9: D0 08    BNE  $B5B3
$B5AB: A9 00    LDA  #$00
$B5AD: 8D 03 07 STA  $0703
$B5B0: 4C C5 B5 JMP  $B5C5
$B5B3: AD 00 07 LDA  $0700
$B5B6: C9          .byte $C9  ; غير معرّف
$B5B7: 0B          .byte $0B  ; غير معرّف
$B5B8: B0 0B    BCS  $B5C5
$B5BA: A5 33    LDA  $33
$B5BC: 85 45    STA  $45
$B5BE: A9 00    LDA  #$00
$B5C0: 85 57    STA  $57
$B5C2: 8D 05 07 STA  $0705
$B5C5: B9 8C B5 LDA  $B58C,Y
$B5C8: 8D 0C 07 STA  $070C
$B5CB: 60       RTS  
$B5CC: 2D 90 04 AND  $0490
$B5CF: C9          .byte $C9  ; غير معرّف
$B5D0: 00       BRK  
$B5D1: D0 08    BNE  $B5DB
$B5D3: A5 57    LDA  $57
$B5D5: F0 49    BEQ  $B620
$B5D7: 10 23    BPL  $B5FC
$B5D9: 30 03    BMI  $B5DE
$B5DB: 4A       LSR  A
$B5DC: 90 1E    BCC  $B5FC
$B5DE: AD 05 07 LDA  $0705
$B5E1: 18       CLC  
$B5E2: 6D 02 07 ADC  $0702
$B5E5: 8D 05 07 STA  $0705
$B5E8: A5 57    LDA  $57
$B5EA: 6D 01 07 ADC  $0701
$B5ED: 85 57    STA  $57
$B5EF: CD 56 04 CMP  $0456
$B5F2: 30 23    BMI  $B617
$B5F4: AD 56 04 LDA  $0456
$B5F7: 85 57    STA  $57
$B5F9: 4C 20 B6 JMP  $B620
$B5FC: AD 05 07 LDA  $0705
$B5FF: 38       SEC  
$B600: ED 02 07 SBC  $0702
$B603: 8D 05 07 STA  $0705
$B606: A5 57    LDA  $57
$B608: ED 01 07 SBC  $0701
$B60B: 85 57    STA  $57
$B60D: CD 50 04 CMP  $0450
$B610: 10 05    BPL  $B617
$B612: AD 50 04 LDA  $0450
$B615: 85 57    STA  $57
$B617: C9          .byte $C9  ; غير معرّف
$B618: 00       BRK  
$B619: 10 05    BPL  $B620
$B61B: 49 FF    EOR  #$FF
$B61D: 18       CLC  
$B61E: 69 01    ADC  #$01
$B620: 8D 00 07 STA  $0700
$B623: 60       RTS  
$B624: AD 56 07 LDA  $0756
$B627: C9          .byte $C9  ; غير معرّف
$B628: 02          .byte $02  ; غير معرّف
$B629: 90 43    BCC  $B66E
$B62B: A5 0A    LDA  $0A
$B62D: 29 40    AND  #$40
$B62F: F0 33    BEQ  $B664
$B631: 25 0D    AND  $0D
$B633: D0 2F    BNE  $B664
$B635: AD CE 06 LDA  $06CE
$B638: 29 01    AND  #$01
$B63A: AA       TAX  
$B63B: B5 24    LDA  $24,X
$B63D: D0 25    BNE  $B664
$B63F: A4 B5    LDY  $B5
$B641: 88       DEY  
$B642: D0 20    BNE  $B664
$B644: AD 14 07 LDA  $0714
$B647: D0 1B    BNE  $B664
$B649: A5 1D    LDA  $1D
$B64B: C9          .byte $C9  ; غير معرّف
$B64C: 03          .byte $03  ; غير معرّف
$B64D: F0 15    BEQ  $B664
$B64F: A9 20    LDA  #$20
$B651: 85 FF    STA  $FF
$B653: A9 02    LDA  #$02
$B655: 95 24    STA  $24,X
$B657: AC 0C 07 LDY  $070C
$B65A: 8C 11 07 STY  $0711
$B65D: 88       DEY  
$B65E: 8C 81 07 STY  $0781
$B661: EE CE 06 INC  $06CE
$B664: A2 00    LDX  #$00
$B666: 20 89 B6 JSR  $B689
$B669: A2 01    LDX  #$01
$B66B: 20 89 B6 JSR  $B689
$B66E: AD 4E 07 LDA  $074E
$B671: D0 13    BNE  $B686
$B673: A2 02    LDX  #$02
$B675: 86 08    STX  $08
$B677: 20 F9 B6 JSR  $B6F9
$B67A: 20 31 F1 JSR  $F131
$B67D: 20 91 F1 JSR  $F191
$B680: 20 E1 ED JSR  $EDE1
$B683: CA       DEX  
$B684: 10 EF    BPL  $B675
$B686: 60       RTS  
$B687: 40       RTI  
$B688: C0 86    CPY  #$86
$B68A: 08       PHP  
$B68B: B5 24    LDA  $24,X
$B68D: 0A       ASL  A
$B68E: B0 63    BCS  $B6F3
$B690: B4 24    LDY  $24,X
$B692: F0 5E    BEQ  $B6F2
$B694: 88       DEY  
$B695: F0 27    BEQ  $B6BE
$B697: A5 86    LDA  $86
$B699: 69 04    ADC  #$04
$B69B: 95 8D    STA  $8D,X
$B69D: A5 6D    LDA  $6D
$B69F: 69 00    ADC  #$00
$B6A1: 95 74    STA  $74,X
$B6A3: A5 CE    LDA  $CE
$B6A5: 95 D5    STA  $D5,X
$B6A7: A9 01    LDA  #$01
$B6A9: 95 BC    STA  $BC,X
$B6AB: A4 33    LDY  $33
$B6AD: 88       DEY  
$B6AE: B9 87 B6 LDA  $B687,Y
$B6B1: 95 5E    STA  $5E,X
$B6B3: A9 04    LDA  #$04
$B6B5: 95 A6    STA  $A6,X
$B6B7: A9 07    LDA  #$07
$B6B9: 9D A0 04 STA  $04A0,X
$B6BC: D6 24    DEC  $24,X
$B6BE: 8A       TXA  
$B6BF: 18       CLC  
$B6C0: 69 07    ADC  #$07
$B6C2: AA       TAX  
$B6C3: A9 50    LDA  #$50
$B6C5: 85 00    STA  $00
$B6C7: A9 03    LDA  #$03
$B6C9: 85 02    STA  $02
$B6CB: A9 00    LDA  #$00
$B6CD: 20 D7 BF JSR  $BFD7
$B6D0: 20 0F BF JSR  $BF0F
$B6D3: A6 08    LDX  $08
$B6D5: 20 3B F1 JSR  $F13B
$B6D8: 20 87 F1 JSR  $F187
$B6DB: 20 2D E2 JSR  $E22D
$B6DE: 20 C8 E1 JSR  $E1C8
$B6E1: AD D2 03 LDA  $03D2
$B6E4: 29 CC    AND  #$CC
$B6E6: D0 06    BNE  $B6EE
$B6E8: 20 D9 D6 JSR  $D6D9
$B6EB: 4C DE EC JMP  $ECDE
$B6EE: A9 00    LDA  #$00
$B6F0: 95 24    STA  $24,X
$B6F2: 60       RTS  
$B6F3: 20 3B F1 JSR  $F13B
$B6F6: 4C 09 ED JMP  $ED09
$B6F9: BD A8 07 LDA  $07A8,X
$B6FC: 29 01    AND  #$01
$B6FE: 85 07    STA  $07
$B700: B5 E4    LDA  $E4,X
$B702: C9          .byte $C9  ; غير معرّف
$B703: F8       SED  
$B704: D0 2C    BNE  $B732
$B706: AD 92 07 LDA  $0792
$B709: D0 3F    BNE  $B74A
$B70B: A0 00    LDY  #$00
$B70D: A5 33    LDA  $33
$B70F: 4A       LSR  A
$B710: 90 02    BCC  $B714
$B712: A0 08    LDY  #$08
$B714: 98       TYA  
$B715: 65 86    ADC  $86
$B717: 95 9C    STA  $9C,X
$B719: A5 6D    LDA  $6D
$B71B: 69 00    ADC  #$00
$B71D: 95 83    STA  $83,X
$B71F: A5 CE    LDA  $CE
$B721: 18       CLC  
$B722: 69 08    ADC  #$08
$B724: 95 E4    STA  $E4,X
$B726: A9 01    LDA  #$01
$B728: 95 CB    STA  $CB,X
$B72A: A4 07    LDY  $07
$B72C: B9 4D B7 LDA  $B74D,Y
$B72F: 8D 92 07 STA  $0792
$B732: A4 07    LDY  $07
$B734: BD 2C 04 LDA  $042C,X
$B737: 38       SEC  
$B738: F9 4B B7 SBC  $B74B,Y
$B73B: 9D 2C 04 STA  $042C,X
$B73E: B5 E4    LDA  $E4,X
$B740: E9 00    SBC  #$00
$B742: C9          .byte $C9  ; غير معرّف
$B743: 20 B0 02 JSR  $02B0
$B746: A9 F8    LDA  #$F8
$B748: 95 E4    STA  $E4,X
$B74A: 60       RTS  
$B74B: FF          .byte $FF  ; غير معرّف
$B74C: 50 40    BVC  $B78E
$B74E: 20 AD 70 JSR  $70AD
$B751: 07          .byte $07  ; غير معرّف
$B752: F0 4F    BEQ  $B7A3
$B754: A5 0E    LDA  $0E
$B756: C9          .byte $C9  ; غير معرّف
$B757: 08       PHP  
$B758: 90 49    BCC  $B7A3
$B75A: C9          .byte $C9  ; غير معرّف
$B75B: 0B          .byte $0B  ; غير معرّف
$B75C: F0 45    BEQ  $B7A3
$B75E: A5 B5    LDA  $B5
$B760: C9          .byte $C9  ; غير معرّف
$B761: 02          .byte $02  ; غير معرّف
$B762: B0 3F    BCS  $B7A3
$B764: AD 87 07 LDA  $0787
$B767: D0 3A    BNE  $B7A3
$B769: AD F8 07 LDA  $07F8
$B76C: 0D F9 07 ORA  $07F9
$B76F: 0D FA 07 ORA  $07FA
$B772: F0 26    BEQ  $B79A
$B774: AC F8 07 LDY  $07F8
$B777: 88       DEY  
$B778: D0 0C    BNE  $B786
$B77A: AD F9 07 LDA  $07F9
$B77D: 0D FA 07 ORA  $07FA
$B780: D0 04    BNE  $B786
$B782: A9 40    LDA  #$40
$B784: 85 FC    STA  $FC
$B786: A9 18    LDA  #$18
$B788: 8D 87 07 STA  $0787
$B78B: A0 23    LDY  #$23
$B78D: A9 FF    LDA  #$FF
$B78F: 8D 39 01 STA  $0139
$B792: 20 5F 8F JSR  $8F5F
$B795: A9 A4    LDA  #$A4
$B797: 4C 06 8F JMP  $8F06
$B79A: 8D 56 07 STA  $0756
$B79D: 20 31 D9 JSR  $D931
$B7A0: EE 59 07 INC  $0759
$B7A3: 60       RTS  
$B7A4: AD 23 07 LDA  $0723
$B7A7: F0 FA    BEQ  $B7A3
$B7A9: A5 CE    LDA  $CE
$B7AB: 25 B5    AND  $B5
$B7AD: D0 F4    BNE  $B7A3
$B7AF: 8D 23 07 STA  $0723
$B7B2: EE D6 06 INC  $06D6
$B7B5: 4C 98 C9 JMP  $C998
$B7B8: AD 4E 07 LDA  $074E
$B7BB: D0 37    BNE  $B7F4
$B7BD: 8D 7D 04 STA  $047D
$B7C0: AD 47 07 LDA  $0747
$B7C3: D0 2F    BNE  $B7F4
$B7C5: A0 04    LDY  #$04
$B7C7: B9 71 04 LDA  $0471,Y
$B7CA: 18       CLC  
$B7CB: 79 77 04 ADC  $0477,Y
$B7CE: 85 02    STA  $02
$B7D0: B9 6B 04 LDA  $046B,Y
$B7D3: F0 1C    BEQ  $B7F1
$B7D5: 69 00    ADC  #$00
$B7D7: 85 01    STA  $01
$B7D9: A5 86    LDA  $86
$B7DB: 38       SEC  
$B7DC: F9 71 04 SBC  $0471,Y
$B7DF: A5 6D    LDA  $6D
$B7E1: F9 6B 04 SBC  $046B,Y
$B7E4: 30 0B    BMI  $B7F1
$B7E6: A5 02    LDA  $02
$B7E8: 38       SEC  
$B7E9: E5 86    SBC  $86
$B7EB: A5 01    LDA  $01
$B7ED: E5 6D    SBC  $6D
$B7EF: 10 04    BPL  $B7F5
$B7F1: 88       DEY  
$B7F2: 10 D3    BPL  $B7C7
$B7F4: 60       RTS  
$B7F5: B9 77 04 LDA  $0477,Y
$B7F8: 4A       LSR  A
$B7F9: 85 00    STA  $00
$B7FB: B9 71 04 LDA  $0471,Y
$B7FE: 18       CLC  
$B7FF: 65 00    ADC  $00
$B801: 85 01    STA  $01
$B803: B9 6B 04 LDA  $046B,Y
$B806: 69 00    ADC  #$00
$B808: 85 00    STA  $00
$B80A: A5 09    LDA  $09
$B80C: 4A       LSR  A
$B80D: 90 2C    BCC  $B83B
$B80F: A5 01    LDA  $01
$B811: 38       SEC  
$B812: E5 86    SBC  $86
$B814: A5 00    LDA  $00
$B816: E5 6D    SBC  $6D
$B818: 10 0E    BPL  $B828
$B81A: A5 86    LDA  $86
$B81C: 38       SEC  
$B81D: E9 01    SBC  #$01
$B81F: 85 86    STA  $86
$B821: A5 6D    LDA  $6D
$B823: E9 00    SBC  #$00
$B825: 4C 39 B8 JMP  $B839
$B828: AD 90 04 LDA  $0490
$B82B: 4A       LSR  A
$B82C: 90 0D    BCC  $B83B
$B82E: A5 86    LDA  $86
$B830: 18       CLC  
$B831: 69 01    ADC  #$01
$B833: 85 86    STA  $86
$B835: A5 6D    LDA  $6D
$B837: 69 00    ADC  #$00
$B839: 85 6D    STA  $6D
$B83B: A9 10    LDA  #$10
$B83D: 85 00    STA  $00
$B83F: A9 01    LDA  #$01
$B841: 8D 7D 04 STA  $047D
$B844: 85 02    STA  $02
$B846: 4A       LSR  A
$B847: AA       TAX  
$B848: 4C D7 BF JMP  $BFD7
$B84B: 05 02    ORA  $02
$B84D: 08       PHP  
$B84E: 04          .byte $04  ; غير معرّف
$B84F: 01 03    ORA  ($03,X)
$B851: 03          .byte $03  ; غير معرّف
$B852: 04          .byte $04  ; غير معرّف
$B853: 04          .byte $04  ; غير معرّف
$B854: 04          .byte $04  ; غير معرّف
$B855: A2 05    LDX  #$05
$B857: 86 08    STX  $08
$B859: B5 16    LDA  $16,X
$B85B: C9          .byte $C9  ; غير معرّف
$B85C: 30 D0    BMI  $B82E
$B85E: 56 A5    LSR  $A5,X
$B860: 0E C9 04 ASL  $04C9
$B863: D0 31    BNE  $B896
$B865: A5 1D    LDA  $1D
$B867: C9          .byte $C9  ; غير معرّف
$B868: 03          .byte $03  ; غير معرّف
$B869: D0 2B    BNE  $B896
$B86B: B5 CF    LDA  $CF,X
$B86D: C9          .byte $C9  ; غير معرّف
$B86E: AA       TAX  
$B86F: B0 28    BCS  $B899
$B871: A5 CE    LDA  $CE
$B873: C9          .byte $C9  ; غير معرّف
$B874: A2 B0    LDX  #$B0
$B876: 22          .byte $22  ; غير معرّف
$B877: BD 17 04 LDA  $0417,X
$B87A: 69 FF    ADC  #$FF
$B87C: 9D 17 04 STA  $0417,X
$B87F: B5 CF    LDA  $CF,X
$B881: 69 01    ADC  #$01
$B883: 95 CF    STA  $CF,X
$B885: AD 0E 01 LDA  $010E
$B888: 38       SEC  
$B889: E9 FF    SBC  #$FF
$B88B: 8D 0E 01 STA  $010E
$B88E: AD 0D 01 LDA  $010D
$B891: E9 01    SBC  #$01
$B893: 8D 0D 01 STA  $010D
$B896: 4C AC B8 JMP  $B8AC
$B899: AC 0F 01 LDY  $010F
$B89C: B9 4B B8 LDA  $B84B,Y
$B89F: BE 50 B8 LDX  $B850,Y
$B8A2: 9D 34 01 STA  $0134,X
$B8A5: 20 27 BC JSR  $BC27
$B8A8: A9 05    LDA  #$05
$B8AA: 85 0E    STA  $0E
$B8AC: 20 AF F1 JSR  $F1AF
$B8AF: 20 52 F1 JSR  $F152
$B8B2: 20 4B E5 JSR  $E54B
$B8B5: 60       RTS  
$B8B6: 08       PHP  
$B8B7: 10 08    BPL  $B8C1
$B8B9: 00       BRK  
$B8BA: 20 AF F1 JSR  $F1AF
$B8BD: AD 47 07 LDA  $0747
$B8C0: D0 40    BNE  $B902
$B8C2: AD 0E 07 LDA  $070E
$B8C5: F0 3B    BEQ  $B902
$B8C7: A8       TAY  
$B8C8: 88       DEY  
$B8C9: 98       TYA  
$B8CA: 29 02    AND  #$02
$B8CC: D0 07    BNE  $B8D5
$B8CE: E6 CE    INC  $CE
$B8D0: E6 CE    INC  $CE
$B8D2: 4C D9 B8 JMP  $B8D9
$B8D5: C6 CE    DEC  $CE
$B8D7: C6 CE    DEC  $CE
$B8D9: B5 58    LDA  $58,X
$B8DB: 18       CLC  
$B8DC: 79 B6 B8 ADC  $B8B6,Y
$B8DF: 95 CF    STA  $CF,X
$B8E1: C0 01    CPY  #$01
$B8E3: 90 0F    BCC  $B8F4
$B8E5: A5 0A    LDA  $0A
$B8E7: 29 80    AND  #$80
$B8E9: F0 09    BEQ  $B8F4
$B8EB: 25 0D    AND  $0D
$B8ED: D0 05    BNE  $B8F4
$B8EF: A9 F4    LDA  #$F4
$B8F1: 8D DB 06 STA  $06DB
$B8F4: C0 03    CPY  #$03
$B8F6: D0 0A    BNE  $B902
$B8F8: AD DB 06 LDA  $06DB
$B8FB: 85 9F    STA  $9F
$B8FD: A9 00    LDA  #$00
$B8FF: 8D 0E 07 STA  $070E
$B902: 20 52 F1 JSR  $F152
$B905: 20 7D E8 JSR  $E87D
$B908: 20 7A D6 JSR  $D67A
$B90B: AD 0E 07 LDA  $070E
$B90E: F0 0D    BEQ  $B91D
$B910: AD 86 07 LDA  $0786
$B913: D0 08    BNE  $B91D
$B915: A9 04    LDA  #$04
$B917: 8D 86 07 STA  $0786
$B91A: EE 0E 07 INC  $070E
$B91D: 60       RTS  
$B91E: A9 2F    LDA  #$2F
$B920: 95 16    STA  $16,X
$B922: A9 01    LDA  #$01
$B924: 95 0F    STA  $0F,X
$B926: B9 76 00 LDA  $0076,Y
$B929: 95 6E    STA  $6E,X
$B92B: B9 8F 00 LDA  $008F,Y
$B92E: 95 87    STA  $87,X
$B930: B9 D7 00 LDA  $00D7,Y
$B933: 95 CF    STA  $CF,X
$B935: AC 98 03 LDY  $0398
$B938: D0 03    BNE  $B93D
$B93A: 8D 9D 03 STA  $039D
$B93D: 8A       TXA  
$B93E: 99 9A 03 STA  $039A,Y
$B941: EE 98 03 INC  $0398
$B944: A9 04    LDA  #$04
$B946: 85 FE    STA  $FE
$B948: 60       RTS  
$B949: 30 60    BMI  $B9AB
$B94B: E0 05    CPX  #$05
$B94D: D0 68    BNE  $B9B7
$B94F: AC 98 03 LDY  $0398
$B952: 88       DEY  
$B953: AD 99 03 LDA  $0399
$B956: D9 49 B9 CMP  $B949,Y
$B959: F0 0F    BEQ  $B96A
$B95B: A5 09    LDA  $09
$B95D: 4A       LSR  A
$B95E: 4A       LSR  A
$B95F: 90 09    BCC  $B96A
$B961: A5 D4    LDA  $D4
$B963: E9 01    SBC  #$01
$B965: 85 D4    STA  $D4
$B967: EE 99 03 INC  $0399
$B96A: AD 99 03 LDA  $0399
$B96D: C9          .byte $C9  ; غير معرّف
$B96E: 08       PHP  
$B96F: 90 46    BCC  $B9B7
$B971: 20 52 F1 JSR  $F152
$B974: 20 AF F1 JSR  $F1AF
$B977: A0 00    LDY  #$00
$B979: 20 35 E4 JSR  $E435
$B97C: C8       INY  
$B97D: CC 98 03 CPY  $0398
$B980: D0 F7    BNE  $B979
$B982: AD D1 03 LDA  $03D1
$B985: 29 0C    AND  #$0C
$B987: F0 10    BEQ  $B999
$B989: 88       DEY  
$B98A: BE 9A 03 LDX  $039A,Y
$B98D: 20 98 C9 JSR  $C998
$B990: 88       DEY  
$B991: 10 F7    BPL  $B98A
$B993: 8D 98 03 STA  $0398
$B996: 8D 99 03 STA  $0399
$B999: AD 99 03 LDA  $0399
$B99C: C9          .byte $C9  ; غير معرّف
$B99D: 20 90 17 JSR  $1790
$B9A0: A2 06    LDX  #$06
$B9A2: A9 01    LDA  #$01
$B9A4: A0 1B    LDY  #$1B
$B9A6: 20 F0 E3 JSR  $E3F0
$B9A9: A4 02    LDY  $02
$B9AB: C0 D0    CPY  #$D0
$B9AD: B0 08    BCS  $B9B7
$B9AF: B1 06    LDA  ($06),Y
$B9B1: D0 04    BNE  $B9B7
$B9B3: A9 26    LDA  #$26
$B9B5: 91 06    STA  ($06),Y
$B9B7: A6 08    LDX  $08
$B9B9: 60       RTS  
$B9BA: 0F          .byte $0F  ; غير معرّف
$B9BB: 07          .byte $07  ; غير معرّف
$B9BC: AD 4E 07 LDA  $074E
$B9BF: F0 6F    BEQ  $BA30
$B9C1: A2 02    LDX  #$02
$B9C3: 86 08    STX  $08
$B9C5: B5 0F    LDA  $0F,X
$B9C7: D0 51    BNE  $BA1A
$B9C9: BD A8 07 LDA  $07A8,X
$B9CC: AC CC 06 LDY  $06CC
$B9CF: 39 BA B9 AND  $B9BA,Y
$B9D2: C9          .byte $C9  ; غير معرّف
$B9D3: 06 B0    ASL  $B0
$B9D5: 44          .byte $44  ; غير معرّف
$B9D6: A8       TAY  
$B9D7: B9 6B 04 LDA  $046B,Y
$B9DA: F0 3E    BEQ  $BA1A
$B9DC: B9 7D 04 LDA  $047D,Y
$B9DF: F0 08    BEQ  $B9E9
$B9E1: E9 00    SBC  #$00
$B9E3: 99 7D 04 STA  $047D,Y
$B9E6: 4C 1A BA JMP  $BA1A
$B9E9: AD 47 07 LDA  $0747
$B9EC: D0 2C    BNE  $BA1A
$B9EE: A9 0E    LDA  #$0E
$B9F0: 99 7D 04 STA  $047D,Y
$B9F3: B9 6B 04 LDA  $046B,Y
$B9F6: 95 6E    STA  $6E,X
$B9F8: B9 71 04 LDA  $0471,Y
$B9FB: 95 87    STA  $87,X
$B9FD: B9 77 04 LDA  $0477,Y
$BA00: 38       SEC  
$BA01: E9 08    SBC  #$08
$BA03: 95 CF    STA  $CF,X
$BA05: A9 01    LDA  #$01
$BA07: 95 B6    STA  $B6,X
$BA09: 95 0F    STA  $0F,X
$BA0B: 4A       LSR  A
$BA0C: 95 1E    STA  $1E,X
$BA0E: A9 09    LDA  #$09
$BA10: 9D 9A 04 STA  $049A,X
$BA13: A9 33    LDA  #$33
$BA15: 95 16    STA  $16,X
$BA17: 4C 2D BA JMP  $BA2D
$BA1A: B5 16    LDA  $16,X
$BA1C: C9          .byte $C9  ; غير معرّف
$BA1D: 33          .byte $33  ; غير معرّف
$BA1E: D0 0D    BNE  $BA2D
$BA20: 20 7A D6 JSR  $D67A
$BA23: B5 0F    LDA  $0F,X
$BA25: F0 06    BEQ  $BA2D
$BA27: 20 AF F1 JSR  $F1AF
$BA2A: 20 33 BA JSR  $BA33
$BA2D: CA       DEX  
$BA2E: 10 93    BPL  $B9C3
$BA30: 60       RTS  
$BA31: 18       CLC  
$BA32: E8       INX  
$BA33: AD 47 07 LDA  $0747
$BA36: D0 3E    BNE  $BA76
$BA38: B5 1E    LDA  $1E,X
$BA3A: D0 2E    BNE  $BA6A
$BA3C: AD D1 03 LDA  $03D1
$BA3F: 29 0C    AND  #$0C
$BA41: C9          .byte $C9  ; غير معرّف
$BA42: 0C          .byte $0C  ; غير معرّف
$BA43: F0 40    BEQ  $BA85
$BA45: A0 01    LDY  #$01
$BA47: 20 43 E1 JSR  $E143
$BA4A: 30 01    BMI  $BA4D
$BA4C: C8       INY  
$BA4D: 94 46    STY  $46,X
$BA4F: 88       DEY  
$BA50: B9 31 BA LDA  $BA31,Y
$BA53: 95 58    STA  $58,X
$BA55: A5 00    LDA  $00
$BA57: 69 28    ADC  #$28
$BA59: C9          .byte $C9  ; غير معرّف
$BA5A: 50 90    BVC  $B9EC
$BA5C: 28       PLP  
$BA5D: A9 01    LDA  #$01
$BA5F: 95 1E    STA  $1E,X
$BA61: A9 0A    LDA  #$0A
$BA63: 9D 8A 07 STA  $078A,X
$BA66: A9 08    LDA  #$08
$BA68: 85 FE    STA  $FE
$BA6A: B5 1E    LDA  $1E,X
$BA6C: 29 20    AND  #$20
$BA6E: F0 03    BEQ  $BA73
$BA70: 20 63 BF JSR  $BF63
$BA73: 20 02 BF JSR  $BF02
$BA76: 20 AF F1 JSR  $F1AF
$BA79: 20 52 F1 JSR  $F152
$BA7C: 20 43 E2 JSR  $E243
$BA7F: 20 53 D8 JSR  $D853
$BA82: 4C 7D E8 JMP  $E87D
$BA85: 20 98 C9 JSR  $C998
$BA88: 60       RTS  
$BA89: 04          .byte $04  ; غير معرّف
$BA8A: 04          .byte $04  ; غير معرّف
$BA8B: 04          .byte $04  ; غير معرّف
$BA8C: 05 05    ORA  $05
$BA8E: 05 06    ORA  $06
$BA90: 06 06    ASL  $06
$BA92: 10 F0    BPL  $BA84
$BA94: AD A8 07 LDA  $07A8
$BA97: 29 07    AND  #$07
$BA99: D0 05    BNE  $BAA0
$BA9B: AD A8 07 LDA  $07A8
$BA9E: 29 08    AND  #$08
$BAA0: A8       TAY  
$BAA1: B9 2A 00 LDA  $002A,Y
$BAA4: D0 19    BNE  $BABF
$BAA6: BE 89 BA LDX  $BA89,Y
$BAA9: B5 0F    LDA  $0F,X
$BAAB: D0 12    BNE  $BABF
$BAAD: A6 08    LDX  $08
$BAAF: 8A       TXA  
$BAB0: 99 AE 06 STA  $06AE,Y
$BAB3: A9 90    LDA  #$90
$BAB5: 99 2A 00 STA  $002A,Y
$BAB8: A9 07    LDA  #$07
$BABA: 99 A2 04 STA  $04A2,Y
$BABD: 38       SEC  
$BABE: 60       RTS  
$BABF: A6 08    LDX  $08
$BAC1: 18       CLC  
$BAC2: 60       RTS  
$BAC3: AD 47 07 LDA  $0747
$BAC6: D0 63    BNE  $BB2B
$BAC8: B5 2A    LDA  $2A,X
$BACA: 29 7F    AND  #$7F
$BACC: BC AE 06 LDY  $06AE,X
$BACF: C9          .byte $C9  ; غير معرّف
$BAD0: 02          .byte $02  ; غير معرّف
$BAD1: F0 20    BEQ  $BAF3
$BAD3: B0 34    BCS  $BB09
$BAD5: 8A       TXA  
$BAD6: 18       CLC  
$BAD7: 69 0D    ADC  #$0D
$BAD9: AA       TAX  
$BADA: A9 10    LDA  #$10
$BADC: 85 00    STA  $00
$BADE: A9 0F    LDA  #$0F
$BAE0: 85 01    STA  $01
$BAE2: A9 04    LDA  #$04
$BAE4: 85 02    STA  $02
$BAE6: A9 00    LDA  #$00
$BAE8: 20 D7 BF JSR  $BFD7
$BAEB: 20 0F BF JSR  $BF0F
$BAEE: A6 08    LDX  $08
$BAF0: 4C 28 BB JMP  $BB28
$BAF3: A9 FE    LDA  #$FE
$BAF5: 95 AC    STA  $AC,X
$BAF7: B9 1E 00 LDA  $001E,Y
$BAFA: 29 F7    AND  #$F7
$BAFC: 99 1E 00 STA  $001E,Y
$BAFF: B6 46    LDX  $46,Y
$BB01: CA       DEX  
$BB02: BD 92 BA LDA  $BA92,X
$BB05: A6 08    LDX  $08
$BB07: 95 64    STA  $64,X
$BB09: D6 2A    DEC  $2A,X
$BB0B: B9 87 00 LDA  $0087,Y
$BB0E: 18       CLC  
$BB0F: 69 02    ADC  #$02
$BB11: 95 93    STA  $93,X
$BB13: B9 6E 00 LDA  $006E,Y
$BB16: 69 00    ADC  #$00
$BB18: 95 7A    STA  $7A,X
$BB1A: B9 CF 00 LDA  $00CF,Y
$BB1D: 38       SEC  
$BB1E: E9 0A    SBC  #$0A
$BB20: 95 DB    STA  $DB,X
$BB22: A9 01    LDA  #$01
$BB24: 95 C2    STA  $C2,X
$BB26: D0 03    BNE  $BB2B
$BB28: 20 C4 D7 JSR  $D7C4
$BB2B: 20 9B F1 JSR  $F19B
$BB2E: 20 48 F1 JSR  $F148
$BB31: 20 36 E2 JSR  $E236
$BB34: 20 DC E4 JSR  $E4DC
$BB37: 60       RTS  
$BB38: 20 84 BB JSR  $BB84
$BB3B: B5 76    LDA  $76,X
$BB3D: 99 7A 00 STA  $007A,Y
$BB40: B5 8F    LDA  $8F,X
$BB42: 09 05    ORA  #$05
$BB44: 99 93 00 STA  $0093,Y
$BB47: B5 D7    LDA  $D7,X
$BB49: E9 10    SBC  #$10
$BB4B: 99 DB 00 STA  $00DB,Y
$BB4E: 4C 6C BB JMP  $BB6C
$BB51: 20 84 BB JSR  $BB84
$BB54: BD EA 03 LDA  $03EA,X
$BB57: 99 7A 00 STA  $007A,Y
$BB5A: A5 06    LDA  $06
$BB5C: 0A       ASL  A
$BB5D: 0A       ASL  A
$BB5E: 0A       ASL  A
$BB5F: 0A       ASL  A
$BB60: 09 05    ORA  #$05
$BB62: 99 93 00 STA  $0093,Y
$BB65: A5 02    LDA  $02
$BB67: 69 20    ADC  #$20
$BB69: 99 DB 00 STA  $00DB,Y
$BB6C: A9 FB    LDA  #$FB
$BB6E: 99 AC 00 STA  $00AC,Y
$BB71: A9 01    LDA  #$01
$BB73: 99 C2 00 STA  $00C2,Y
$BB76: 99 2A 00 STA  $002A,Y
$BB79: 85 FE    STA  $FE
$BB7B: 86 08    STX  $08
$BB7D: 20 FE BB JSR  $BBFE
$BB80: EE 48 07 INC  $0748
$BB83: 60       RTS  
$BB84: A0 08    LDY  #$08
$BB86: B9 2A 00 LDA  $002A,Y
$BB89: F0 07    BEQ  $BB92
$BB8B: 88       DEY  
$BB8C: C0 05    CPY  #$05
$BB8E: D0 F6    BNE  $BB86
$BB90: A0 08    LDY  #$08
$BB92: 8C B7 06 STY  $06B7
$BB95: 60       RTS  
$BB96: A2 08    LDX  #$08
$BB98: 86 08    STX  $08
$BB9A: B5 2A    LDA  $2A,X
$BB9C: F0 56    BEQ  $BBF4
$BB9E: 0A       ASL  A
$BB9F: 90 06    BCC  $BBA7
$BBA1: 20 C3 BA JSR  $BAC3
$BBA4: 4C F4 BB JMP  $BBF4
$BBA7: B4 2A    LDY  $2A,X
$BBA9: 88       DEY  
$BBAA: F0 1D    BEQ  $BBC9
$BBAC: F6 2A    INC  $2A,X
$BBAE: B5 93    LDA  $93,X
$BBB0: 18       CLC  
$BBB1: 6D 75 07 ADC  $0775
$BBB4: 95 93    STA  $93,X
$BBB6: B5 7A    LDA  $7A,X
$BBB8: 69 00    ADC  #$00
$BBBA: 95 7A    STA  $7A,X
$BBBC: B5 2A    LDA  $2A,X
$BBBE: C9          .byte $C9  ; غير معرّف
$BBBF: 30 D0    BMI  $BB91
$BBC1: 26 A9    ROL  $A9
$BBC3: 00       BRK  
$BBC4: 95 2A    STA  $2A,X
$BBC6: 4C F4 BB JMP  $BBF4
$BBC9: 8A       TXA  
$BBCA: 18       CLC  
$BBCB: 69 0D    ADC  #$0D
$BBCD: AA       TAX  
$BBCE: A9 50    LDA  #$50
$BBD0: 85 00    STA  $00
$BBD2: A9 06    LDA  #$06
$BBD4: 85 02    STA  $02
$BBD6: 4A       LSR  A
$BBD7: 85 01    STA  $01
$BBD9: A9 00    LDA  #$00
$BBDB: 20 D7 BF JSR  $BFD7
$BBDE: A6 08    LDX  $08
$BBE0: B5 AC    LDA  $AC,X
$BBE2: C9          .byte $C9  ; غير معرّف
$BBE3: 05 D0    ORA  $D0
$BBE5: 02          .byte $02  ; غير معرّف
$BBE6: F6 2A    INC  $2A,X
$BBE8: 20 48 F1 JSR  $F148
$BBEB: 20 9B F1 JSR  $F19B
$BBEE: 20 36 E2 JSR  $E236
$BBF1: 20 86 E6 JSR  $E686
$BBF4: CA       DEX  
$BBF5: 10 A1    BPL  $BB98
$BBF7: 60       RTS  
$BBF8: 17          .byte $17  ; غير معرّف
$BBF9: 1D 0B 11 ORA  $110B,X
$BBFC: 02          .byte $02  ; غير معرّف
$BBFD: 13          .byte $13  ; غير معرّف
$BBFE: A9 01    LDA  #$01
$BC00: 8D 39 01 STA  $0139
$BC03: AE 53 07 LDX  $0753
$BC06: BC F8 BB LDY  $BBF8,X
$BC09: 20 5F 8F JSR  $8F5F
$BC0C: EE 5E 07 INC  $075E
$BC0F: AD 5E 07 LDA  $075E
$BC12: C9          .byte $C9  ; غير معرّف
$BC13: 64          .byte $64  ; غير معرّف
$BC14: D0 0C    BNE  $BC22
$BC16: A9 00    LDA  #$00
$BC18: 8D 5E 07 STA  $075E
$BC1B: EE 5A 07 INC  $075A
$BC1E: A9 40    LDA  #$40
$BC20: 85 FE    STA  $FE
$BC22: A9 02    LDA  #$02
$BC24: 8D 38 01 STA  $0138
$BC27: AE 53 07 LDX  $0753
$BC2A: BC FA BB LDY  $BBFA,X
$BC2D: 20 5F 8F JSR  $8F5F
$BC30: AC 53 07 LDY  $0753
$BC33: B9 FC BB LDA  $BBFC,Y
$BC36: 20 06 8F JSR  $8F06
$BC39: AC 00 03 LDY  $0300
$BC3C: B9 FB 02 LDA  $02FB,Y
$BC3F: D0 05    BNE  $BC46
$BC41: A9 24    LDA  #$24
$BC43: 99 FB 02 STA  $02FB,Y
$BC46: A6 08    LDX  $08
$BC48: 60       RTS  
$BC49: A9 2E    LDA  #$2E
$BC4B: 85 1B    STA  $1B
$BC4D: B5 76    LDA  $76,X
$BC4F: 85 73    STA  $73
$BC51: B5 8F    LDA  $8F,X
$BC53: 85 8C    STA  $8C
$BC55: A9 01    LDA  #$01
$BC57: 85 BB    STA  $BB
$BC59: B5 D7    LDA  $D7,X
$BC5B: 38       SEC  
$BC5C: E9 08    SBC  #$08
$BC5E: 85 D4    STA  $D4
$BC60: A9 01    LDA  #$01
$BC62: 85 23    STA  $23
$BC64: 85 14    STA  $14
$BC66: A9 03    LDA  #$03
$BC68: 8D 9F 04 STA  $049F
$BC6B: A5 39    LDA  $39
$BC6D: C9          .byte $C9  ; غير معرّف
$BC6E: 02          .byte $02  ; غير معرّف
$BC6F: B0 0A    BCS  $BC7B
$BC71: AD 56 07 LDA  $0756
$BC74: C9          .byte $C9  ; غير معرّف
$BC75: 02          .byte $02  ; غير معرّف
$BC76: 90 01    BCC  $BC79
$BC78: 4A       LSR  A
$BC79: 85 39    STA  $39
$BC7B: A9 20    LDA  #$20
$BC7D: 8D CA 03 STA  $03CA
$BC80: A9 02    LDA  #$02
$BC82: 85 FE    STA  $FE
$BC84: 60       RTS  
$BC85: A2 05    LDX  #$05
$BC87: 86 08    STX  $08
$BC89: A5 23    LDA  $23
$BC8B: F0 5D    BEQ  $BCEA
$BC8D: 0A       ASL  A
$BC8E: 90 23    BCC  $BCB3
$BC90: AD 47 07 LDA  $0747
$BC93: D0 43    BNE  $BCD8
$BC95: A5 39    LDA  $39
$BC97: F0 11    BEQ  $BCAA
$BC99: C9          .byte $C9  ; غير معرّف
$BC9A: 03          .byte $03  ; غير معرّف
$BC9B: F0 0D    BEQ  $BCAA
$BC9D: C9          .byte $C9  ; غير معرّف
$BC9E: 02          .byte $02  ; غير معرّف
$BC9F: D0 37    BNE  $BCD8
$BCA1: 20 F9 CA JSR  $CAF9
$BCA4: 20 63 E1 JSR  $E163
$BCA7: 4C D8 BC JMP  $BCD8
$BCAA: 20 77 CA JSR  $CA77
$BCAD: 20 C1 DF JSR  $DFC1
$BCB0: 4C D8 BC JMP  $BCD8
$BCB3: A5 09    LDA  $09
$BCB5: 29 03    AND  #$03
$BCB7: D0 19    BNE  $BCD2
$BCB9: C6 D4    DEC  $D4
$BCBB: A5 23    LDA  $23
$BCBD: E6 23    INC  $23
$BCBF: C9          .byte $C9  ; غير معرّف
$BCC0: 11 90    ORA  ($90),Y
$BCC2: 0F          .byte $0F  ; غير معرّف
$BCC3: A9 10    LDA  #$10
$BCC5: 95 58    STA  $58,X
$BCC7: A9 80    LDA  #$80
$BCC9: 85 23    STA  $23
$BCCB: 0A       ASL  A
$BCCC: 8D CA 03 STA  $03CA
$BCCF: 2A       ROL  A
$BCD0: 95 46    STA  $46,X
$BCD2: A5 23    LDA  $23
$BCD4: C9          .byte $C9  ; غير معرّف
$BCD5: 06 90    ASL  $90
$BCD7: 12          .byte $12  ; غير معرّف
$BCD8: 20 52 F1 JSR  $F152
$BCDB: 20 AF F1 JSR  $F1AF
$BCDE: 20 43 E2 JSR  $E243
$BCE1: 20 D2 E6 JSR  $E6D2
$BCE4: 20 53 D8 JSR  $D853
$BCE7: 20 7A D6 JSR  $D67A
$BCEA: 60       RTS  
$BCEB: 04          .byte $04  ; غير معرّف
$BCEC: 12          .byte $12  ; غير معرّف
$BCED: 48       PHA  
$BCEE: A9 11    LDA  #$11
$BCF0: AE EE 03 LDX  $03EE
$BCF3: AC 54 07 LDY  $0754
$BCF6: D0 02    BNE  $BCFA
$BCF8: A9 12    LDA  #$12
$BCFA: 95 26    STA  $26,X
$BCFC: 20 6B 8A JSR  $8A6B
$BCFF: AE EE 03 LDX  $03EE
$BD02: A5 02    LDA  $02
$BD04: 9D E4 03 STA  $03E4,X
$BD07: A8       TAY  
$BD08: A5 06    LDA  $06
$BD0A: 9D E6 03 STA  $03E6,X
$BD0D: B1 06    LDA  ($06),Y
$BD0F: 20 F6 BD JSR  $BDF6
$BD12: 85 00    STA  $00
$BD14: AC 54 07 LDY  $0754
$BD17: D0 01    BNE  $BD1A
$BD19: 98       TYA  
$BD1A: 90 25    BCC  $BD41
$BD1C: A0 11    LDY  #$11
$BD1E: 94 26    STY  $26,X
$BD20: A9 C4    LDA  #$C4
$BD22: A4 00    LDY  $00
$BD24: C0 58    CPY  #$58
$BD26: F0 04    BEQ  $BD2C
$BD28: C0 5D    CPY  #$5D
$BD2A: D0 15    BNE  $BD41
$BD2C: AD BC 06 LDA  $06BC
$BD2F: D0 08    BNE  $BD39
$BD31: A9 0B    LDA  #$0B
$BD33: 8D 9D 07 STA  $079D
$BD36: EE BC 06 INC  $06BC
$BD39: AD 9D 07 LDA  $079D
$BD3C: D0 02    BNE  $BD40
$BD3E: A0 C4    LDY  #$C4
$BD40: 98       TYA  
$BD41: 9D E8 03 STA  $03E8,X
$BD44: 20 84 BD JSR  $BD84
$BD47: A4 02    LDY  $02
$BD49: A9 23    LDA  #$23
$BD4B: 91 06    STA  ($06),Y
$BD4D: A9 10    LDA  #$10
$BD4F: 8D 84 07 STA  $0784
$BD52: 68       PLA  
$BD53: 85 05    STA  $05
$BD55: A0 00    LDY  #$00
$BD57: AD 14 07 LDA  $0714
$BD5A: D0 05    BNE  $BD61
$BD5C: AD 54 07 LDA  $0754
$BD5F: F0 01    BEQ  $BD62
$BD61: C8       INY  
$BD62: A5 CE    LDA  $CE
$BD64: 18       CLC  
$BD65: 79 EB BC ADC  $BCEB,Y
$BD68: 29 F0    AND  #$F0
$BD6A: 95 D7    STA  $D7,X
$BD6C: B4 26    LDY  $26,X
$BD6E: C0 11    CPY  #$11
$BD70: F0 06    BEQ  $BD78
$BD72: 20 02 BE JSR  $BE02
$BD75: 4C 7B BD JMP  $BD7B
$BD78: 20 9B BD JSR  $BD9B
$BD7B: AD EE 03 LDA  $03EE
$BD7E: 49 01    EOR  #$01
$BD80: 8D EE 03 STA  $03EE
$BD83: 60       RTS  
$BD84: A5 86    LDA  $86
$BD86: 18       CLC  
$BD87: 69 08    ADC  #$08
$BD89: 29 F0    AND  #$F0
$BD8B: 95 8F    STA  $8F,X
$BD8D: A5 6D    LDA  $6D
$BD8F: 69 00    ADC  #$00
$BD91: 95 76    STA  $76,X
$BD93: 9D EA 03 STA  $03EA,X
$BD96: A5 B5    LDA  $B5
$BD98: 95 BE    STA  $BE,X
$BD9A: 60       RTS  
$BD9B: 20 1F BE JSR  $BE1F
$BD9E: A9 02    LDA  #$02
$BDA0: 85 FF    STA  $FF
$BDA2: A9 00    LDA  #$00
$BDA4: 95 60    STA  $60,X
$BDA6: 9D 3C 04 STA  $043C,X
$BDA9: 85 9F    STA  $9F
$BDAB: A9 FE    LDA  #$FE
$BDAD: 95 A8    STA  $A8,X
$BDAF: A5 05    LDA  $05
$BDB1: 20 F6 BD JSR  $BDF6
$BDB4: 90 31    BCC  $BDE7
$BDB6: 98       TYA  
$BDB7: C9          .byte $C9  ; غير معرّف
$BDB8: 09 90    ORA  #$90
$BDBA: 02          .byte $02  ; غير معرّف
$BDBB: E9 05    SBC  #$05
$BDBD: 20 04 8E JSR  $8E04
$BDC0: D2          .byte $D2  ; غير معرّف
$BDC1: BD 38 BB LDA  $BB38,X
$BDC4: 38       SEC  
$BDC5: BB          .byte $BB  ; غير معرّف
$BDC6: D8       CLD  
$BDC7: BD D2 BD LDA  $BDD2,X
$BDCA: DF          .byte $DF  ; غير معرّف
$BDCB: BD D5 BD LDA  $BDD5,X
$BDCE: 38       SEC  
$BDCF: BB          .byte $BB  ; غير معرّف
$BDD0: D8       CLD  
$BDD1: BD A9 00 LDA  $00A9,X
$BDD4: 2C A9 02 BIT  $02A9
$BDD7: 2C A9 03 BIT  $03A9
$BDDA: 85 39    STA  $39
$BDDC: 4C 49 BC JMP  $BC49
$BDDF: A2 05    LDX  #$05
$BDE1: AC EE 03 LDY  $03EE
$BDE4: 20 1E B9 JSR  $B91E
$BDE7: 60       RTS  
$BDE8: C1 C0    CMP  ($C0,X)
$BDEA: 5F          .byte $5F  ; غير معرّف
$BDEB: 60       RTS  
$BDEC: 55 56    EOR  $56,X
$BDEE: 57          .byte $57  ; غير معرّف
$BDEF: 58       CLI  
$BDF0: 59 5A 5B EOR  $5B5A,Y
$BDF3: 5C          .byte $5C  ; غير معرّف
$BDF4: 5D 5E A0 EOR  $A05E,X
$BDF7: 0D D9 E8 ORA  $E8D9
$BDFA: BD F0 04 LDA  $04F0,X
$BDFD: 88       DEY  
$BDFE: 10 F8    BPL  $BDF8
$BE00: 18       CLC  
$BE01: 60       RTS  
$BE02: 20 1F BE JSR  $BE1F
$BE05: A9 01    LDA  #$01
$BE07: 9D EC 03 STA  $03EC,X
$BE0A: 85 FD    STA  $FD
$BE0C: 20 41 BE JSR  $BE41
$BE0F: A9 FE    LDA  #$FE
$BE11: 85 9F    STA  $9F
$BE13: A9 05    LDA  #$05
$BE15: 8D 39 01 STA  $0139
$BE18: 20 27 BC JSR  $BC27
$BE1B: AE EE 03 LDX  $03EE
$BE1E: 60       RTS  
$BE1F: AE EE 03 LDX  $03EE
$BE22: A4 02    LDY  $02
$BE24: F0 1A    BEQ  $BE40
$BE26: 98       TYA  
$BE27: 38       SEC  
$BE28: E9 10    SBC  #$10
$BE2A: 85 02    STA  $02
$BE2C: A8       TAY  
$BE2D: B1 06    LDA  ($06),Y
$BE2F: C9          .byte $C9  ; غير معرّف
$BE30: C2          .byte $C2  ; غير معرّف
$BE31: D0 0D    BNE  $BE40
$BE33: A9 00    LDA  #$00
$BE35: 91 06    STA  ($06),Y
$BE37: 20 4D 8A JSR  $8A4D
$BE3A: AE EE 03 LDX  $03EE
$BE3D: 20 51 BB JSR  $BB51
$BE40: 60       RTS  
$BE41: B5 8F    LDA  $8F,X
$BE43: 9D F1 03 STA  $03F1,X
$BE46: A9 F0    LDA  #$F0
$BE48: 95 60    STA  $60,X
$BE4A: 95 62    STA  $62,X
$BE4C: A9 FA    LDA  #$FA
$BE4E: 95 A8    STA  $A8,X
$BE50: A9 FC    LDA  #$FC
$BE52: 95 AA    STA  $AA,X
$BE54: A9 00    LDA  #$00
$BE56: 9D 3C 04 STA  $043C,X
$BE59: 9D 3E 04 STA  $043E,X
$BE5C: B5 76    LDA  $76,X
$BE5E: 95 78    STA  $78,X
$BE60: B5 8F    LDA  $8F,X
$BE62: 95 91    STA  $91,X
$BE64: B5 D7    LDA  $D7,X
$BE66: 18       CLC  
$BE67: 69 08    ADC  #$08
$BE69: 95 D9    STA  $D9,X
$BE6B: A9 FA    LDA  #$FA
$BE6D: 95 A8    STA  $A8,X
$BE6F: 60       RTS  
$BE70: B5 26    LDA  $26,X
$BE72: F0 5D    BEQ  $BED1
$BE74: 29 0F    AND  #$0F
$BE76: 48       PHA  
$BE77: A8       TAY  
$BE78: 8A       TXA  
$BE79: 18       CLC  
$BE7A: 69 09    ADC  #$09
$BE7C: AA       TAX  
$BE7D: 88       DEY  
$BE7E: F0 33    BEQ  $BEB3
$BE80: 20 A4 BF JSR  $BFA4
$BE83: 20 0F BF JSR  $BF0F
$BE86: 8A       TXA  
$BE87: 18       CLC  
$BE88: 69 02    ADC  #$02
$BE8A: AA       TAX  
$BE8B: 20 A4 BF JSR  $BFA4
$BE8E: 20 0F BF JSR  $BF0F
$BE91: A6 08    LDX  $08
$BE93: 20 59 F1 JSR  $F159
$BE96: 20 B6 F1 JSR  $F1B6
$BE99: 20 53 EC JSR  $EC53
$BE9C: 68       PLA  
$BE9D: B4 BE    LDY  $BE,X
$BE9F: F0 30    BEQ  $BED1
$BEA1: 48       PHA  
$BEA2: A9 F0    LDA  #$F0
$BEA4: D5 D9    CMP  $D9,X
$BEA6: B0 02    BCS  $BEAA
$BEA8: 95 D9    STA  $D9,X
$BEAA: B5 D7    LDA  $D7,X
$BEAC: C9          .byte $C9  ; غير معرّف
$BEAD: F0 68    BEQ  $BF17
$BEAF: 90 20    BCC  $BED1
$BEB1: B0 1C    BCS  $BECF
$BEB3: 20 A4 BF JSR  $BFA4
$BEB6: A6 08    LDX  $08
$BEB8: 20 59 F1 JSR  $F159
$BEBB: 20 B6 F1 JSR  $F1B6
$BEBE: 20 D1 EB JSR  $EBD1
$BEC1: B5 D7    LDA  $D7,X
$BEC3: 29 0F    AND  #$0F
$BEC5: C9          .byte $C9  ; غير معرّف
$BEC6: 05 68    ORA  $68
$BEC8: B0 07    BCS  $BED1
$BECA: A9 01    LDA  #$01
$BECC: 9D EC 03 STA  $03EC,X
$BECF: A9 00    LDA  #$00
$BED1: 95 26    STA  $26,X
$BED3: 60       RTS  
$BED4: A2 01    LDX  #$01
$BED6: 86 08    STX  $08
$BED8: AD 01 03 LDA  $0301
$BEDB: D0 21    BNE  $BEFE
$BEDD: BD EC 03 LDA  $03EC,X
$BEE0: F0 1C    BEQ  $BEFE
$BEE2: BD E6 03 LDA  $03E6,X
$BEE5: 85 06    STA  $06
$BEE7: A9 05    LDA  #$05
$BEE9: 85 07    STA  $07
$BEEB: BD E4 03 LDA  $03E4,X
$BEEE: 85 02    STA  $02
$BEF0: A8       TAY  
$BEF1: BD E8 03 LDA  $03E8,X
$BEF4: 91 06    STA  ($06),Y
$BEF6: 20 61 8A JSR  $8A61
$BEF9: A9 00    LDA  #$00
$BEFB: 9D EC 03 STA  $03EC,X
$BEFE: CA       DEX  
$BEFF: 10 D5    BPL  $BED6
$BF01: 60       RTS  
$BF02: E8       INX  
$BF03: 20 0F BF JSR  $BF0F
$BF06: A6 08    LDX  $08
$BF08: 60       RTS  
$BF09: AD 0E 07 LDA  $070E
$BF0C: D0 3E    BNE  $BF4C
$BF0E: AA       TAX  
$BF0F: B5 57    LDA  $57,X
$BF11: 0A       ASL  A
$BF12: 0A       ASL  A
$BF13: 0A       ASL  A
$BF14: 0A       ASL  A
$BF15: 85 01    STA  $01
$BF17: B5 57    LDA  $57,X
$BF19: 4A       LSR  A
$BF1A: 4A       LSR  A
$BF1B: 4A       LSR  A
$BF1C: 4A       LSR  A
$BF1D: C9          .byte $C9  ; غير معرّف
$BF1E: 08       PHP  
$BF1F: 90 02    BCC  $BF23
$BF21: 09 F0    ORA  #$F0
$BF23: 85 00    STA  $00
$BF25: A0 00    LDY  #$00
$BF27: C9          .byte $C9  ; غير معرّف
$BF28: 00       BRK  
$BF29: 10 01    BPL  $BF2C
$BF2B: 88       DEY  
$BF2C: 84 02    STY  $02
$BF2E: BD 00 04 LDA  $0400,X
$BF31: 18       CLC  
$BF32: 65 01    ADC  $01
$BF34: 9D 00 04 STA  $0400,X
$BF37: A9 00    LDA  #$00
$BF39: 2A       ROL  A
$BF3A: 48       PHA  
$BF3B: 6A       ROR  A
$BF3C: B5 86    LDA  $86,X
$BF3E: 65 00    ADC  $00
$BF40: 95 86    STA  $86,X
$BF42: B5 6D    LDA  $6D,X
$BF44: 65 02    ADC  $02
$BF46: 95 6D    STA  $6D,X
$BF48: 68       PLA  
$BF49: 18       CLC  
$BF4A: 65 00    ADC  $00
$BF4C: 60       RTS  
$BF4D: A2 00    LDX  #$00
$BF4F: AD 47 07 LDA  $0747
$BF52: D0 05    BNE  $BF59
$BF54: AD 0E 07 LDA  $070E
$BF57: D0 F3    BNE  $BF4C
$BF59: AD 09 07 LDA  $0709
$BF5C: 85 00    STA  $00
$BF5E: A9 04    LDA  #$04
$BF60: 4C AD BF JMP  $BFAD
$BF63: A0 3D    LDY  #$3D
$BF65: B5 1E    LDA  $1E,X
$BF67: C9          .byte $C9  ; غير معرّف
$BF68: 05 D0    ORA  $D0
$BF6A: 02          .byte $02  ; غير معرّف
$BF6B: A0 20    LDY  #$20
$BF6D: 4C 94 BF JMP  $BF94
$BF70: A0 00    LDY  #$00
$BF72: 4C 77 BF JMP  $BF77
$BF75: A0 01    LDY  #$01
$BF77: E8       INX  
$BF78: A9 03    LDA  #$03
$BF7A: 85 00    STA  $00
$BF7C: A9 06    LDA  #$06
$BF7E: 85 01    STA  $01
$BF80: A9 02    LDA  #$02
$BF82: 85 02    STA  $02
$BF84: 98       TYA  
$BF85: 4C D1 BF JMP  $BFD1
$BF88: A0 7F    LDY  #$7F
$BF8A: D0 02    BNE  $BF8E
$BF8C: A0 0F    LDY  #$0F
$BF8E: A9 02    LDA  #$02
$BF90: D0 04    BNE  $BF96
$BF92: A0 1C    LDY  #$1C
$BF94: A9 03    LDA  #$03
$BF96: 84 00    STY  $00
$BF98: E8       INX  
$BF99: 20 AD BF JSR  $BFAD
$BF9C: A6 08    LDX  $08
$BF9E: 60       RTS  
$BF9F: 06 08    ASL  $08
$BFA1: A0 00    LDY  #$00
$BFA3: 2C A0 01 BIT  $01A0
$BFA6: A9 50    LDA  #$50
$BFA8: 85 00    STA  $00
$BFAA: B9 9F BF LDA  $BF9F,Y
$BFAD: 85 02    STA  $02
$BFAF: A9 00    LDA  #$00
$BFB1: 4C D7 BF JMP  $BFD7
$BFB4: A9 00    LDA  #$00
$BFB6: 2C A9 01 BIT  $01A9
$BFB9: 48       PHA  
$BFBA: B4 16    LDY  $16,X
$BFBC: E8       INX  
$BFBD: A9 05    LDA  #$05
$BFBF: C0 29    CPY  #$29
$BFC1: D0 02    BNE  $BFC5
$BFC3: A9 09    LDA  #$09
$BFC5: 85 00    STA  $00
$BFC7: A9 0A    LDA  #$0A
$BFC9: 85 01    STA  $01
$BFCB: A9 03    LDA  #$03
$BFCD: 85 02    STA  $02
$BFCF: 68       PLA  
$BFD0: A8       TAY  
$BFD1: 20 D7 BF JSR  $BFD7
$BFD4: A6 08    LDX  $08
$BFD6: 60       RTS  
$BFD7: 48       PHA  
$BFD8: BD 16 04 LDA  $0416,X
$BFDB: 18       CLC  
$BFDC: 7D 33 04 ADC  $0433,X
$BFDF: 9D 16 04 STA  $0416,X
$BFE2: A0 00    LDY  #$00
$BFE4: B5 9F    LDA  $9F,X
$BFE6: 10 01    BPL  $BFE9
$BFE8: 88       DEY  
$BFE9: 84 07    STY  $07
$BFEB: 75 CE    ADC  $CE,X
$BFED: 95 CE    STA  $CE,X
$BFEF: B5 B5    LDA  $B5,X
$BFF1: 65 07    ADC  $07
$BFF3: 95 B5    STA  $B5,X
$BFF5: BD 33 04 LDA  $0433,X
$BFF8: 18       CLC  
$BFF9: 65 00    ADC  $00
$BFFB: 9D 33 04 STA  $0433,X
$BFFE: B5 9F    LDA  $9F,X
$C000: 69 00    ADC  #$00
$C002: 95 9F    STA  $9F,X
$C004: C5 02    CMP  $02
$C006: 30 10    BMI  $C018
$C008: BD 33 04 LDA  $0433,X
$C00B: C9          .byte $C9  ; غير معرّف
$C00C: 80          .byte $80  ; غير معرّف
$C00D: 90 09    BCC  $C018
$C00F: A5 02    LDA  $02
$C011: 95 9F    STA  $9F,X
$C013: A9 00    LDA  #$00
$C015: 9D 33 04 STA  $0433,X
$C018: 68       PLA  
$C019: F0 2B    BEQ  $C046
$C01B: A5 02    LDA  $02
$C01D: 49 FF    EOR  #$FF
$C01F: A8       TAY  
$C020: C8       INY  
$C021: 84 07    STY  $07
$C023: BD 33 04 LDA  $0433,X
$C026: 38       SEC  
$C027: E5 01    SBC  $01
$C029: 9D 33 04 STA  $0433,X
$C02C: B5 9F    LDA  $9F,X
$C02E: E9 00    SBC  #$00
$C030: 95 9F    STA  $9F,X
$C032: C5 07    CMP  $07
$C034: 10 10    BPL  $C046
$C036: BD 33 04 LDA  $0433,X
$C039: C9          .byte $C9  ; غير معرّف
$C03A: 80          .byte $80  ; غير معرّف
$C03B: B0 09    BCS  $C046
$C03D: A5 07    LDA  $07
$C03F: 95 9F    STA  $9F,X
$C041: A9 FF    LDA  #$FF
$C043: 9D 33 04 STA  $0433,X
$C046: 60       RTS  
$C047: B5 0F    LDA  $0F,X
$C049: 48       PHA  
$C04A: 0A       ASL  A
$C04B: B0 12    BCS  $C05F
$C04D: 68       PLA  
$C04E: F0 03    BEQ  $C053
$C050: 4C 82 C8 JMP  $C882
$C053: AD 1F 07 LDA  $071F
$C056: 29 07    AND  #$07
$C058: C9          .byte $C9  ; غير معرّف
$C059: 07          .byte $07  ; غير معرّف
$C05A: F0 0E    BEQ  $C06A
$C05C: 4C CC C0 JMP  $C0CC
$C05F: 68       PLA  
$C060: 29 0F    AND  #$0F
$C062: A8       TAY  
$C063: B9 0F 00 LDA  $000F,Y
$C066: D0 02    BNE  $C06A
$C068: 95 0F    STA  $0F,X
$C06A: 60       RTS  
$C06B: 03          .byte $03  ; غير معرّف
$C06C: 03          .byte $03  ; غير معرّف
$C06D: 06 06    ASL  $06
$C06F: 06 06    ASL  $06
$C071: 06 06    ASL  $06
$C073: 07          .byte $07  ; غير معرّف
$C074: 07          .byte $07  ; غير معرّف
$C075: 07          .byte $07  ; غير معرّف
$C076: 05 09    ORA  $09
$C078: 04          .byte $04  ; غير معرّف
$C079: 05 06    ORA  $06
$C07B: 08       PHP  
$C07C: 09 0A    ORA  #$0A
$C07E: 06 0B    ASL  $0B
$C080: 10 40    BPL  $C0C2
$C082: B0 B0    BCS  $C034
$C084: 80          .byte $80  ; غير معرّف
$C085: 40       RTI  
$C086: 40       RTI  
$C087: 80          .byte $80  ; غير معرّف
$C088: 40       RTI  
$C089: F0 F0    BEQ  $C07B
$C08B: F0 A5    BEQ  $C032
$C08D: 6D 38 E9 ADC  $E938
$C090: 04          .byte $04  ; غير معرّف
$C091: 85 6D    STA  $6D
$C093: AD 25 07 LDA  $0725
$C096: 38       SEC  
$C097: E9 04    SBC  #$04
$C099: 8D 25 07 STA  $0725
$C09C: AD 1A 07 LDA  $071A
$C09F: 38       SEC  
$C0A0: E9 04    SBC  #$04
$C0A2: 8D 1A 07 STA  $071A
$C0A5: AD 1B 07 LDA  $071B
$C0A8: 38       SEC  
$C0A9: E9 04    SBC  #$04
$C0AB: 8D 1B 07 STA  $071B
$C0AE: AD 2A 07 LDA  $072A
$C0B1: 38       SEC  
$C0B2: E9 04    SBC  #$04
$C0B4: 8D 2A 07 STA  $072A
$C0B7: A9 00    LDA  #$00
$C0B9: 8D 3B 07 STA  $073B
$C0BC: 8D 2B 07 STA  $072B
$C0BF: 8D 39 07 STA  $0739
$C0C2: 8D 3A 07 STA  $073A
$C0C5: B9 F8 9B LDA  $9BF8,Y
$C0C8: 8D 2C 07 STA  $072C
$C0CB: 60       RTS  
$C0CC: AD 45 07 LDA  $0745
$C0CF: F0 5E    BEQ  $C12F
$C0D1: AD 26 07 LDA  $0726
$C0D4: D0 59    BNE  $C12F
$C0D6: A0 0B    LDY  #$0B
$C0D8: 88       DEY  
$C0D9: 30 54    BMI  $C12F
$C0DB: AD 5F 07 LDA  $075F
$C0DE: D9 6B C0 CMP  $C06B,Y
$C0E1: D0 F5    BNE  $C0D8
$C0E3: AD 25 07 LDA  $0725
$C0E6: D9 76 C0 CMP  $C076,Y
$C0E9: D0 ED    BNE  $C0D8
$C0EB: A5 CE    LDA  $CE
$C0ED: D9 81 C0 CMP  $C081,Y
$C0F0: D0 23    BNE  $C115
$C0F2: A5 1D    LDA  $1D
$C0F4: C9          .byte $C9  ; غير معرّف
$C0F5: 00       BRK  
$C0F6: D0 1D    BNE  $C115
$C0F8: AD 5F 07 LDA  $075F
$C0FB: C9          .byte $C9  ; غير معرّف
$C0FC: 06 D0    ASL  $D0
$C0FE: 23          .byte $23  ; غير معرّف
$C0FF: EE D9 06 INC  $06D9
$C102: EE DA 06 INC  $06DA
$C105: AD DA 06 LDA  $06DA
$C108: C9          .byte $C9  ; غير معرّف
$C109: 03          .byte $03  ; غير معرّف
$C10A: D0 1E    BNE  $C12A
$C10C: AD D9 06 LDA  $06D9
$C10F: C9          .byte $C9  ; غير معرّف
$C110: 03          .byte $03  ; غير معرّف
$C111: F0 0F    BEQ  $C122
$C113: D0 07    BNE  $C11C
$C115: AD 5F 07 LDA  $075F
$C118: C9          .byte $C9  ; غير معرّف
$C119: 06 F0    ASL  $F0
$C11B: E6 20    INC  $20
$C11D: 8C C0 20 STY  $20C0
$C120: 71 D0    ADC  ($D0),Y
$C122: A9 00    LDA  #$00
$C124: 8D DA 06 STA  $06DA
$C127: 8D D9 06 STA  $06D9
$C12A: A9 00    LDA  #$00
$C12C: 8D 45 07 STA  $0745
$C12F: AD CD 06 LDA  $06CD
$C132: F0 10    BEQ  $C144
$C134: 95 16    STA  $16,X
$C136: A9 01    LDA  #$01
$C138: 95 0F    STA  $0F,X
$C13A: A9 00    LDA  #$00
$C13C: 95 1E    STA  $1E,X
$C13E: 8D CD 06 STA  $06CD
$C141: 4C 26 C2 JMP  $C226
$C144: AC 39 07 LDY  $0739
$C147: B1 E9    LDA  ($E9),Y
$C149: C9          .byte $C9  ; غير معرّف
$C14A: FF          .byte $FF  ; غير معرّف
$C14B: D0 03    BNE  $C150
$C14D: 4C 16 C2 JMP  $C216
$C150: 29 0F    AND  #$0F
$C152: C9          .byte $C9  ; غير معرّف
$C153: 0E F0 0E ASL  $0EF0
$C156: E0 05    CPX  #$05
$C158: 90 0A    BCC  $C164
$C15A: C8       INY  
$C15B: B1 E9    LDA  ($E9),Y
$C15D: 29 3F    AND  #$3F
$C15F: C9          .byte $C9  ; غير معرّف
$C160: 2E F0 01 ROL  $01F0
$C163: 60       RTS  
$C164: AD 1D 07 LDA  $071D
$C167: 18       CLC  
$C168: 69 30    ADC  #$30
$C16A: 29 F0    AND  #$F0
$C16C: 85 07    STA  $07
$C16E: AD 1B 07 LDA  $071B
$C171: 69 00    ADC  #$00
$C173: 85 06    STA  $06
$C175: AC 39 07 LDY  $0739
$C178: C8       INY  
$C179: B1 E9    LDA  ($E9),Y
$C17B: 0A       ASL  A
$C17C: 90 0B    BCC  $C189
$C17E: AD 3B 07 LDA  $073B
$C181: D0 06    BNE  $C189
$C183: EE 3B 07 INC  $073B
$C186: EE 3A 07 INC  $073A
$C189: 88       DEY  
$C18A: B1 E9    LDA  ($E9),Y
$C18C: 29 0F    AND  #$0F
$C18E: C9          .byte $C9  ; غير معرّف
$C18F: 0F          .byte $0F  ; غير معرّف
$C190: D0 19    BNE  $C1AB
$C192: AD 3B 07 LDA  $073B
$C195: D0 14    BNE  $C1AB
$C197: C8       INY  
$C198: B1 E9    LDA  ($E9),Y
$C19A: 29 3F    AND  #$3F
$C19C: 8D 3A 07 STA  $073A
$C19F: EE 39 07 INC  $0739
$C1A2: EE 39 07 INC  $0739
$C1A5: EE 3B 07 INC  $073B
$C1A8: 4C CC C0 JMP  $C0CC
$C1AB: AD 3A 07 LDA  $073A
$C1AE: 95 6E    STA  $6E,X
$C1B0: B1 E9    LDA  ($E9),Y
$C1B2: 29 F0    AND  #$F0
$C1B4: 95 87    STA  $87,X
$C1B6: CD 1D 07 CMP  $071D
$C1B9: B5 6E    LDA  $6E,X
$C1BB: ED 1B 07 SBC  $071B
$C1BE: B0 0B    BCS  $C1CB
$C1C0: B1 E9    LDA  ($E9),Y
$C1C2: 29 0F    AND  #$0F
$C1C4: C9          .byte $C9  ; غير معرّف
$C1C5: 0E F0 69 ASL  $69F0
$C1C8: 4C 50 C2 JMP  $C250
$C1CB: A5 07    LDA  $07
$C1CD: D5 87    CMP  $87,X
$C1CF: A5 06    LDA  $06
$C1D1: F5 6E    SBC  $6E,X
$C1D3: 90 41    BCC  $C216
$C1D5: A9 01    LDA  #$01
$C1D7: 95 B6    STA  $B6,X
$C1D9: B1 E9    LDA  ($E9),Y
$C1DB: 0A       ASL  A
$C1DC: 0A       ASL  A
$C1DD: 0A       ASL  A
$C1DE: 0A       ASL  A
$C1DF: 95 CF    STA  $CF,X
$C1E1: C9          .byte $C9  ; غير معرّف
$C1E2: E0 F0    CPX  #$F0
$C1E4: 4C C8 B1 JMP  $B1C8
$C1E7: E9 29    SBC  #$29
$C1E9: 40       RTI  
$C1EA: F0 05    BEQ  $C1F1
$C1EC: AD CC 06 LDA  $06CC
$C1EF: F0 6D    BEQ  $C25E
$C1F1: B1 E9    LDA  ($E9),Y
$C1F3: 29 3F    AND  #$3F
$C1F5: C9          .byte $C9  ; غير معرّف
$C1F6: 37          .byte $37  ; غير معرّف
$C1F7: 90 04    BCC  $C1FD
$C1F9: C9          .byte $C9  ; غير معرّف
$C1FA: 3F          .byte $3F  ; غير معرّف
$C1FB: 90 31    BCC  $C22E
$C1FD: C9          .byte $C9  ; غير معرّف
$C1FE: 06 D0    ASL  $D0
$C200: 07          .byte $07  ; غير معرّف
$C201: AC 6A 07 LDY  $076A
$C204: F0 02    BEQ  $C208
$C206: A9 02    LDA  #$02
$C208: 95 16    STA  $16,X
$C20A: A9 01    LDA  #$01
$C20C: 95 0F    STA  $0F,X
$C20E: 20 26 C2 JSR  $C226
$C211: B5 0F    LDA  $0F,X
$C213: D0 49    BNE  $C25E
$C215: 60       RTS  
$C216: AD CB 06 LDA  $06CB
$C219: D0 09    BNE  $C224
$C21B: AD 98 03 LDA  $0398
$C21E: C9          .byte $C9  ; غير معرّف
$C21F: 01 D0    ORA  ($D0,X)
$C221: 0B          .byte $0B  ; غير معرّف
$C222: A9 2F    LDA  #$2F
$C224: 95 16    STA  $16,X
$C226: A9 00    LDA  #$00
$C228: 95 1E    STA  $1E,X
$C22A: 20 6C C2 JSR  $C26C
$C22D: 60       RTS  
$C22E: 4C 1B C7 JMP  $C71B
$C231: C8       INY  
$C232: C8       INY  
$C233: B1 E9    LDA  ($E9),Y
$C235: 4A       LSR  A
$C236: 4A       LSR  A
$C237: 4A       LSR  A
$C238: 4A       LSR  A
$C239: 4A       LSR  A
$C23A: CD 5F 07 CMP  $075F
$C23D: D0 0E    BNE  $C24D
$C23F: 88       DEY  
$C240: B1 E9    LDA  ($E9),Y
$C242: 8D 50 07 STA  $0750
$C245: C8       INY  
$C246: B1 E9    LDA  ($E9),Y
$C248: 29 1F    AND  #$1F
$C24A: 8D 51 07 STA  $0751
$C24D: 4C 5B C2 JMP  $C25B
$C250: AC 39 07 LDY  $0739
$C253: B1 E9    LDA  ($E9),Y
$C255: 29 0F    AND  #$0F
$C257: C9          .byte $C9  ; غير معرّف
$C258: 0E D0 03 ASL  $03D0
$C25B: EE 39 07 INC  $0739
$C25E: EE 39 07 INC  $0739
$C261: EE 39 07 INC  $0739
$C264: A9 00    LDA  #$00
$C266: 8D 3B 07 STA  $073B
$C269: A6 08    LDX  $08
$C26B: 60       RTS  
$C26C: B5 16    LDA  $16,X
$C26E: C9          .byte $C9  ; غير معرّف
$C26F: 15 B0    ORA  $B0,X
$C271: 0D A8 B5 ORA  $B5A8
$C274: CF          .byte $CF  ; غير معرّف
$C275: 69 08    ADC  #$08
$C277: 95 CF    STA  $CF,X
$C279: A9 01    LDA  #$01
$C27B: 9D D8 03 STA  $03D8,X
$C27E: 98       TYA  
$C27F: 20 04 8E JSR  $8E04
$C282: 0E C3 0E ASL  $0EC3
$C285: C3          .byte $C3  ; غير معرّف
$C286: 0E C3 1E ASL  $1EC3
$C289: C3          .byte $C3  ; غير معرّف
$C28A: F0 C2    BEQ  $C24E
$C28C: 28       PLP  
$C28D: C3          .byte $C3  ; غير معرّف
$C28E: F1 C2    SBC  ($C2),Y
$C290: 42          .byte $42  ; غير معرّف
$C291: C3          .byte $C3  ; غير معرّف
$C292: 6B          .byte $6B  ; غير معرّف
$C293: C3          .byte $C3  ; غير معرّف
$C294: F0 C2    BEQ  $C258
$C296: 75 C3    ADC  $C3,X
$C298: 75 C3    ADC  $C3,X
$C29A: F7          .byte $F7  ; غير معرّف
$C29B: C2          .byte $C2  ; غير معرّف
$C29C: 87          .byte $87  ; غير معرّف
$C29D: C7          .byte $C7  ; غير معرّف
$C29E: D1 C7    CMP  ($C7),Y
$C2A0: 4A       LSR  A
$C2A1: C3          .byte $C3  ; غير معرّف
$C2A2: 3D C3 85 AND  $85C3,X
$C2A5: C3          .byte $C3  ; غير معرّف
$C2A6: A0 C7    LDY  #$C7
$C2A8: F0 C2    BEQ  $C26C
$C2AA: A0 C7    LDY  #$C7
$C2AC: A0 C7    LDY  #$C7
$C2AE: A0 C7    LDY  #$C7
$C2B0: A0 C7    LDY  #$C7
$C2B2: B8       CLV  
$C2B3: C7          .byte $C7  ; غير معرّف
$C2B4: F0 C2    BEQ  $C278
$C2B6: F0 C2    BEQ  $C27A
$C2B8: 5C          .byte $5C  ; غير معرّف
$C2B9: C4 5C    CPY  $5C
$C2BB: C4 5C    CPY  $5C
$C2BD: C4 5C    CPY  $5C
$C2BF: C4 59    CPY  $59
$C2C1: C4 F0    CPY  $F0
$C2C3: C2          .byte $C2  ; غير معرّف
$C2C4: F0 C2    BEQ  $C288
$C2C6: F0 C2    BEQ  $C28A
$C2C8: F0 C2    BEQ  $C28C
$C2CA: DF          .byte $DF  ; غير معرّف
$C2CB: C7          .byte $C7  ; غير معرّف
$C2CC: 12          .byte $12  ; غير معرّف
$C2CD: C8       INY  
$C2CE: 3F          .byte $3F  ; غير معرّف
$C2CF: C8       INY  
$C2D0: 45 C8    EOR  $C8
$C2D2: 0B          .byte $0B  ; غير معرّف
$C2D3: C8       INY  
$C2D4: 03          .byte $03  ; غير معرّف
$C2D5: C8       INY  
$C2D6: 0B          .byte $0B  ; غير معرّف
$C2D7: C8       INY  
$C2D8: 4B          .byte $4B  ; غير معرّف
$C2D9: C8       INY  
$C2DA: 57          .byte $57  ; غير معرّف
$C2DB: C8       INY  
$C2DC: 49 C5    EOR  #$C5
$C2DE: 60       RTS  
$C2DF: BC 1E B9 LDY  $B91E,X
$C2E2: F0 C2    BEQ  $C2A6
$C2E4: F0 C2    BEQ  $C2A8
$C2E6: F0 C2    BEQ  $C2AA
$C2E8: F0 C2    BEQ  $C2AC
$C2EA: F0 C2    BEQ  $C2AE
$C2EC: 07          .byte $07  ; غير معرّف
$C2ED: C3          .byte $C3  ; غير معرّف
$C2EE: 81 C8    STA  ($C8,X)
$C2F0: 60       RTS  
$C2F1: 20 0E C3 JSR  $C30E
$C2F4: 4C 46 C3 JMP  $C346
$C2F7: A9 02    LDA  #$02
$C2F9: 95 B6    STA  $B6,X
$C2FB: 95 CF    STA  $CF,X
$C2FD: 4A       LSR  A
$C2FE: 9D 96 07 STA  $0796,X
$C301: 4A       LSR  A
$C302: 95 1E    STA  $1E,X
$C304: 4C 46 C3 JMP  $C346
$C307: A9 B8    LDA  #$B8
$C309: 95 CF    STA  $CF,X
$C30B: 60       RTS  
$C30C: F8       SED  
$C30D: F4          .byte $F4  ; غير معرّف
$C30E: A0 01    LDY  #$01
$C310: AD 6A 07 LDA  $076A
$C313: D0 01    BNE  $C316
$C315: 88       DEY  
$C316: B9 0C C3 LDA  $C30C,Y
$C319: 95 58    STA  $58,X
$C31B: 4C 5A C3 JMP  $C35A
$C31E: 20 0E C3 JSR  $C30E
$C321: A9 01    LDA  #$01
$C323: 95 1E    STA  $1E,X
$C325: 60       RTS  
$C326: 80          .byte $80  ; غير معرّف
$C327: 50 A9    BVC  $C2D2
$C329: 00       BRK  
$C32A: 9D A2 03 STA  $03A2,X
$C32D: 95 58    STA  $58,X
$C32F: AC CC 06 LDY  $06CC
$C332: B9 26 C3 LDA  $C326,Y
$C335: 9D 96 07 STA  $0796,X
$C338: A9 0B    LDA  #$0B
$C33A: 4C 5C C3 JMP  $C35C
$C33D: A9 00    LDA  #$00
$C33F: 4C 19 C3 JMP  $C319
$C342: A9 00    LDA  #$00
$C344: 95 58    STA  $58,X
$C346: A9 09    LDA  #$09
$C348: D0 12    BNE  $C35C
$C34A: A0 30    LDY  #$30
$C34C: B5 CF    LDA  $CF,X
$C34E: 9D 01 04 STA  $0401,X
$C351: 10 02    BPL  $C355
$C353: A0 E0    LDY  #$E0
$C355: 98       TYA  
$C356: 75 CF    ADC  $CF,X
$C358: 95 58    STA  $58,X
$C35A: A9 03    LDA  #$03
$C35C: 9D 9A 04 STA  $049A,X
$C35F: A9 02    LDA  #$02
$C361: 95 46    STA  $46,X
$C363: A9 00    LDA  #$00
$C365: 95 A0    STA  $A0,X
$C367: 9D 34 04 STA  $0434,X
$C36A: 60       RTS  
$C36B: A9 02    LDA  #$02
$C36D: 95 46    STA  $46,X
$C36F: A9 09    LDA  #$09
$C371: 9D 9A 04 STA  $049A,X
$C374: 60       RTS  
$C375: 20 46 C3 JSR  $C346
$C378: BD A7 07 LDA  $07A7,X
$C37B: 29 10    AND  #$10
$C37D: 95 58    STA  $58,X
$C37F: B5 CF    LDA  $CF,X
$C381: 9D 34 04 STA  $0434,X
$C384: 60       RTS  
$C385: AD CB 06 LDA  $06CB
$C388: D0 0B    BNE  $C395
$C38A: A9 00    LDA  #$00
$C38C: 8D D1 06 STA  $06D1
$C38F: 20 3D C3 JSR  $C33D
$C392: 4C D9 C7 JMP  $C7D9
$C395: 4C 98 C9 JMP  $C998
$C398: 26 2C    ROL  $2C
$C39A: 32          .byte $32  ; غير معرّف
$C39B: 38       SEC  
$C39C: 20 22 24 JSR  $2422
$C39F: 26 13    ROL  $13
$C3A1: 14          .byte $14  ; غير معرّف
$C3A2: 15 16    ORA  $16,X
$C3A4: AD 8F 07 LDA  $078F
$C3A7: D0 3C    BNE  $C3E5
$C3A9: E0 05    CPX  #$05
$C3AB: B0 38    BCS  $C3E5
$C3AD: A9 80    LDA  #$80
$C3AF: 8D 8F 07 STA  $078F
$C3B2: A0 04    LDY  #$04
$C3B4: B9 16 00 LDA  $0016,Y
$C3B7: C9          .byte $C9  ; غير معرّف
$C3B8: 11 F0    ORA  ($F0),Y
$C3BA: 2B          .byte $2B  ; غير معرّف
$C3BB: 88       DEY  
$C3BC: 10 F6    BPL  $C3B4
$C3BE: EE D1 06 INC  $06D1
$C3C1: AD D1 06 LDA  $06D1
$C3C4: C9          .byte $C9  ; غير معرّف
$C3C5: 07          .byte $07  ; غير معرّف
$C3C6: 90 1D    BCC  $C3E5
$C3C8: A2 04    LDX  #$04
$C3CA: B5 0F    LDA  $0F,X
$C3CC: F0 05    BEQ  $C3D3
$C3CE: CA       DEX  
$C3CF: 10 F9    BPL  $C3CA
$C3D1: 30 10    BMI  $C3E3
$C3D3: A9 00    LDA  #$00
$C3D5: 95 1E    STA  $1E,X
$C3D7: A9 11    LDA  #$11
$C3D9: 95 16    STA  $16,X
$C3DB: 20 8A C3 JSR  $C38A
$C3DE: A9 20    LDA  #$20
$C3E0: 20 D8 C5 JSR  $C5D8
$C3E3: A6 08    LDX  $08
$C3E5: 60       RTS  
$C3E6: A5 CE    LDA  $CE
$C3E8: C9          .byte $C9  ; غير معرّف
$C3E9: 2C 90 F9 BIT  $F990
$C3EC: B9 1E 00 LDA  $001E,Y
$C3EF: D0 F4    BNE  $C3E5
$C3F1: B9 6E 00 LDA  $006E,Y
$C3F4: 95 6E    STA  $6E,X
$C3F6: B9 87 00 LDA  $0087,Y
$C3F9: 95 87    STA  $87,X
$C3FB: A9 01    LDA  #$01
$C3FD: 95 B6    STA  $B6,X
$C3FF: B9 CF 00 LDA  $00CF,Y
$C402: 38       SEC  
$C403: E9 08    SBC  #$08
$C405: 95 CF    STA  $CF,X
$C407: BD A7 07 LDA  $07A7,X
$C40A: 29 03    AND  #$03
$C40C: A8       TAY  
$C40D: A2 02    LDX  #$02
$C40F: B9 98 C3 LDA  $C398,Y
$C412: 95 01    STA  $01,X
$C414: C8       INY  
$C415: C8       INY  
$C416: C8       INY  
$C417: C8       INY  
$C418: CA       DEX  
$C419: 10 F4    BPL  $C40F
$C41B: A6 08    LDX  $08
$C41D: 20 6C CF JSR  $CF6C
$C420: A4 57    LDY  $57
$C422: C0 08    CPY  #$08
$C424: B0 0E    BCS  $C434
$C426: A8       TAY  
$C427: BD A8 07 LDA  $07A8,X
$C42A: 29 03    AND  #$03
$C42C: F0 05    BEQ  $C433
$C42E: 98       TYA  
$C42F: 49 FF    EOR  #$FF
$C431: A8       TAY  
$C432: C8       INY  
$C433: 98       TYA  
$C434: 20 46 C3 JSR  $C346
$C437: A0 02    LDY  #$02
$C439: 95 58    STA  $58,X
$C43B: C9          .byte $C9  ; غير معرّف
$C43C: 00       BRK  
$C43D: 30 01    BMI  $C440
$C43F: 88       DEY  
$C440: 94 46    STY  $46,X
$C442: A9 FD    LDA  #$FD
$C444: 95 A0    STA  $A0,X
$C446: A9 01    LDA  #$01
$C448: 95 0F    STA  $0F,X
$C44A: A9 05    LDA  #$05
$C44C: 95 1E    STA  $1E,X
$C44E: 60       RTS  
$C44F: 28       PLP  
$C450: 38       SEC  
$C451: 28       PLP  
$C452: 38       SEC  
$C453: 28       PLP  
$C454: 00       BRK  
$C455: 00       BRK  
$C456: 10 10    BPL  $C468
$C458: 00       BRK  
$C459: 20 75 C5 JSR  $C575
$C45C: A9 00    LDA  #$00
$C45E: 95 58    STA  $58,X
$C460: B5 16    LDA  $16,X
$C462: 38       SEC  
$C463: E9 1B    SBC  #$1B
$C465: A8       TAY  
$C466: B9 4F C4 LDA  $C44F,Y
$C469: 9D 88 03 STA  $0388,X
$C46C: B9 54 C4 LDA  $C454,Y
$C46F: 95 34    STA  $34,X
$C471: B5 CF    LDA  $CF,X
$C473: 18       CLC  
$C474: 69 04    ADC  #$04
$C476: 95 CF    STA  $CF,X
$C478: B5 87    LDA  $87,X
$C47A: 18       CLC  
$C47B: 69 04    ADC  #$04
$C47D: 95 87    STA  $87,X
$C47F: B5 6E    LDA  $6E,X
$C481: 69 00    ADC  #$00
$C483: 95 6E    STA  $6E,X
$C485: 4C D9 C7 JMP  $C7D9
$C488: 80          .byte $80  ; غير معرّف
$C489: 30 40    BMI  $C4CB
$C48B: 80          .byte $80  ; غير معرّف
$C48C: 30 50    BMI  $C4DE
$C48E: 50 70    BVC  $C500
$C490: 20 40 80 JSR  $8040
$C493: A0 70    LDY  #$70
$C495: 40       RTI  
$C496: 90 68    BCC  $C500
$C498: 0E 05 06 ASL  $0605
$C49B: 0E 1C 20 ASL  $201C
$C49E: 10 0C    BPL  $C4AC
$C4A0: 1E 22 18 ASL  $1822,X
$C4A3: 14          .byte $14  ; غير معرّف
$C4A4: 10 60    BPL  $C506
$C4A6: 20 48 AD JSR  $AD48
$C4A9: 8F          .byte $8F  ; غير معرّف
$C4AA: 07          .byte $07  ; غير معرّف
$C4AB: D0 A1    BNE  $C44E
$C4AD: 20 46 C3 JSR  $C346
$C4B0: BD A8 07 LDA  $07A8,X
$C4B3: 29 03    AND  #$03
$C4B5: A8       TAY  
$C4B6: B9 A4 C4 LDA  $C4A4,Y
$C4B9: 8D 8F 07 STA  $078F
$C4BC: A0 03    LDY  #$03
$C4BE: AD CC 06 LDA  $06CC
$C4C1: F0 01    BEQ  $C4C4
$C4C3: C8       INY  
$C4C4: 84 00    STY  $00
$C4C6: E4 00    CPX  $00
$C4C8: B0 84    BCS  $C44E
$C4CA: BD A7 07 LDA  $07A7,X
$C4CD: 29 03    AND  #$03
$C4CF: 85 00    STA  $00
$C4D1: 85 01    STA  $01
$C4D3: A9 FB    LDA  #$FB
$C4D5: 95 A0    STA  $A0,X
$C4D7: A9 00    LDA  #$00
$C4D9: A4 57    LDY  $57
$C4DB: F0 07    BEQ  $C4E4
$C4DD: A9 04    LDA  #$04
$C4DF: C0 19    CPY  #$19
$C4E1: 90 01    BCC  $C4E4
$C4E3: 0A       ASL  A
$C4E4: 48       PHA  
$C4E5: 18       CLC  
$C4E6: 65 00    ADC  $00
$C4E8: 85 00    STA  $00
$C4EA: BD A8 07 LDA  $07A8,X
$C4ED: 29 03    AND  #$03
$C4EF: F0 07    BEQ  $C4F8
$C4F1: BD A9 07 LDA  $07A9,X
$C4F4: 29 0F    AND  #$0F
$C4F6: 85 00    STA  $00
$C4F8: 68       PLA  
$C4F9: 18       CLC  
$C4FA: 65 01    ADC  $01
$C4FC: A8       TAY  
$C4FD: B9 98 C4 LDA  $C498,Y
$C500: 95 58    STA  $58,X
$C502: A9 01    LDA  #$01
$C504: 95 46    STA  $46,X
$C506: A5 57    LDA  $57
$C508: D0 12    BNE  $C51C
$C50A: A4 00    LDY  $00
$C50C: 98       TYA  
$C50D: 29 02    AND  #$02
$C50F: F0 0B    BEQ  $C51C
$C511: B5 58    LDA  $58,X
$C513: 49 FF    EOR  #$FF
$C515: 18       CLC  
$C516: 69 01    ADC  #$01
$C518: 95 58    STA  $58,X
$C51A: F6 46    INC  $46,X
$C51C: 98       TYA  
$C51D: 29 02    AND  #$02
$C51F: F0 0F    BEQ  $C530
$C521: A5 86    LDA  $86
$C523: 18       CLC  
$C524: 79 88 C4 ADC  $C488,Y
$C527: 95 87    STA  $87,X
$C529: A5 6D    LDA  $6D
$C52B: 69 00    ADC  #$00
$C52D: 4C 3C C5 JMP  $C53C
$C530: A5 86    LDA  $86
$C532: 38       SEC  
$C533: F9 88 C4 SBC  $C488,Y
$C536: 95 87    STA  $87,X
$C538: A5 6D    LDA  $6D
$C53A: E9 00    SBC  #$00
$C53C: 95 6E    STA  $6E,X
$C53E: A9 01    LDA  #$01
$C540: 95 0F    STA  $0F,X
$C542: 95 B6    STA  $B6,X
$C544: A9 F8    LDA  #$F8
$C546: 95 CF    STA  $CF,X
$C548: 60       RTS  
$C549: 20 75 C5 JSR  $C575
$C54C: 8E 68 03 STX  $0368
$C54F: A9 00    LDA  #$00
$C551: 8D 63 03 STA  $0363
$C554: 8D 69 03 STA  $0369
$C557: B5 87    LDA  $87,X
$C559: 8D 66 03 STA  $0366
$C55C: A9 DF    LDA  #$DF
$C55E: 8D 90 07 STA  $0790
$C561: 95 46    STA  $46,X
$C563: A9 20    LDA  #$20
$C565: 8D 64 03 STA  $0364
$C568: 9D 8A 07 STA  $078A,X
$C56B: A9 05    LDA  #$05
$C56D: 8D 83 04 STA  $0483
$C570: 4A       LSR  A
$C571: 8D 65 03 STA  $0365
$C574: 60       RTS  
$C575: A0 FF    LDY  #$FF
$C577: C8       INY  
$C578: B9 0F 00 LDA  $000F,Y
$C57B: D0 FA    BNE  $C577
$C57D: 8C CF 06 STY  $06CF
$C580: 8A       TXA  
$C581: 09 80    ORA  #$80
$C583: 99 0F 00 STA  $000F,Y
$C586: B5 6E    LDA  $6E,X
$C588: 99 6E 00 STA  $006E,Y
$C58B: B5 87    LDA  $87,X
$C58D: 99 87 00 STA  $0087,Y
$C590: A9 01    LDA  #$01
$C592: 95 0F    STA  $0F,X
$C594: 99 B6 00 STA  $00B6,Y
$C597: B5 CF    LDA  $CF,X
$C599: 99 CF 00 STA  $00CF,Y
$C59C: 60       RTS  
$C59D: 90 80    BCC  $C51F
$C59F: 70 90    BVS  $C531
$C5A1: FF          .byte $FF  ; غير معرّف
$C5A2: 01 AD    ORA  ($AD,X)
$C5A4: 8F          .byte $8F  ; غير معرّف
$C5A5: 07          .byte $07  ; غير معرّف
$C5A6: D0 F4    BNE  $C59C
$C5A8: 9D 34 04 STA  $0434,X
$C5AB: A5 FD    LDA  $FD
$C5AD: 09 02    ORA  #$02
$C5AF: 85 FD    STA  $FD
$C5B1: AC 68 03 LDY  $0368
$C5B4: B9 16 00 LDA  $0016,Y
$C5B7: C9          .byte $C9  ; غير معرّف
$C5B8: 2D F0 31 AND  $31F0
$C5BB: 20 D9 D1 JSR  $D1D9
$C5BE: 18       CLC  
$C5BF: 69 20    ADC  #$20
$C5C1: AC CC 06 LDY  $06CC
$C5C4: F0 03    BEQ  $C5C9
$C5C6: 38       SEC  
$C5C7: E9 10    SBC  #$10
$C5C9: 8D 8F 07 STA  $078F
$C5CC: BD A7 07 LDA  $07A7,X
$C5CF: 29 03    AND  #$03
$C5D1: 9D 17 04 STA  $0417,X
$C5D4: A8       TAY  
$C5D5: B9 9D C5 LDA  $C59D,Y
$C5D8: 95 CF    STA  $CF,X
$C5DA: AD 1D 07 LDA  $071D
$C5DD: 18       CLC  
$C5DE: 69 20    ADC  #$20
$C5E0: 95 87    STA  $87,X
$C5E2: AD 1B 07 LDA  $071B
$C5E5: 69 00    ADC  #$00
$C5E7: 95 6E    STA  $6E,X
$C5E9: 4C 1F C6 JMP  $C61F
$C5EC: B9 87 00 LDA  $0087,Y
$C5EF: 38       SEC  
$C5F0: E9 0E    SBC  #$0E
$C5F2: 95 87    STA  $87,X
$C5F4: B9 6E 00 LDA  $006E,Y
$C5F7: 95 6E    STA  $6E,X
$C5F9: B9 CF 00 LDA  $00CF,Y
$C5FC: 18       CLC  
$C5FD: 69 08    ADC  #$08
$C5FF: 95 CF    STA  $CF,X
$C601: BD A7 07 LDA  $07A7,X
$C604: 29 03    AND  #$03
$C606: 9D 17 04 STA  $0417,X
$C609: A8       TAY  
$C60A: B9 9D C5 LDA  $C59D,Y
$C60D: A0 00    LDY  #$00
$C60F: D5 CF    CMP  $CF,X
$C611: 90 01    BCC  $C614
$C613: C8       INY  
$C614: B9 A1 C5 LDA  $C5A1,Y
$C617: 9D 34 04 STA  $0434,X
$C61A: A9 00    LDA  #$00
$C61C: 8D CB 06 STA  $06CB
$C61F: A9 08    LDA  #$08
$C621: 9D 9A 04 STA  $049A,X
$C624: A9 01    LDA  #$01
$C626: 95 B6    STA  $B6,X
$C628: 95 0F    STA  $0F,X
$C62A: 4A       LSR  A
$C62B: 9D 01 04 STA  $0401,X
$C62E: 95 1E    STA  $1E,X
$C630: 60       RTS  
$C631: 00       BRK  
$C632: 30 60    BMI  $C694
$C634: 60       RTS  
$C635: 00       BRK  
$C636: 20 60 40 JSR  $4060
$C639: 70 40    BVS  $C67B
$C63B: 60       RTS  
$C63C: 30 AD    BMI  $C5EB
$C63E: 8F          .byte $8F  ; غير معرّف
$C63F: 07          .byte $07  ; غير معرّف
$C640: D0 47    BNE  $C689
$C642: A9 20    LDA  #$20
$C644: 8D 8F 07 STA  $078F
$C647: CE D7 06 DEC  $06D7
$C64A: A0 06    LDY  #$06
$C64C: 88       DEY  
$C64D: B9 16 00 LDA  $0016,Y
$C650: C9          .byte $C9  ; غير معرّف
$C651: 31 D0    AND  ($D0),Y
$C653: F8       SED  
$C654: B9 87 00 LDA  $0087,Y
$C657: 38       SEC  
$C658: E9 30    SBC  #$30
$C65A: 48       PHA  
$C65B: B9 6E 00 LDA  $006E,Y
$C65E: E9 00    SBC  #$00
$C660: 85 00    STA  $00
$C662: AD D7 06 LDA  $06D7
$C665: 18       CLC  
$C666: 79 1E 00 ADC  $001E,Y
$C669: A8       TAY  
$C66A: 68       PLA  
$C66B: 18       CLC  
$C66C: 79 31 C6 ADC  $C631,Y
$C66F: 95 87    STA  $87,X
$C671: A5 00    LDA  $00
$C673: 69 00    ADC  #$00
$C675: 95 6E    STA  $6E,X
$C677: B9 37 C6 LDA  $C637,Y
$C67A: 95 CF    STA  $CF,X
$C67C: A9 01    LDA  #$01
$C67E: 95 B6    STA  $B6,X
$C680: 95 0F    STA  $0F,X
$C682: 4A       LSR  A
$C683: 95 58    STA  $58,X
$C685: A9 08    LDA  #$08
$C687: 95 A0    STA  $A0,X
$C689: 60       RTS  
$C68A: 01 02    ORA  ($02,X)
$C68C: 04          .byte $04  ; غير معرّف
$C68D: 08       PHP  
$C68E: 10 20    BPL  $C6B0
$C690: 40       RTI  
$C691: 80          .byte $80  ; غير معرّف
$C692: 40       RTI  
$C693: 30 90    BMI  $C625
$C695: 50 20    BVC  $C6B7
$C697: 60       RTS  
$C698: A0 70    LDY  #$70
$C69A: 0A       ASL  A
$C69B: 0B          .byte $0B  ; غير معرّف
$C69C: AD 8F 07 LDA  $078F
$C69F: D0 6F    BNE  $C710
$C6A1: AD 4E 07 LDA  $074E
$C6A4: D0 57    BNE  $C6FD
$C6A6: E0 03    CPX  #$03
$C6A8: B0 66    BCS  $C710
$C6AA: A0 00    LDY  #$00
$C6AC: BD A7 07 LDA  $07A7,X
$C6AF: C9          .byte $C9  ; غير معرّف
$C6B0: AA       TAX  
$C6B1: 90 01    BCC  $C6B4
$C6B3: C8       INY  
$C6B4: AD 5F 07 LDA  $075F
$C6B7: C9          .byte $C9  ; غير معرّف
$C6B8: 01 F0    ORA  ($F0,X)
$C6BA: 01 C8    ORA  ($C8,X)
$C6BC: 98       TYA  
$C6BD: 29 01    AND  #$01
$C6BF: A8       TAY  
$C6C0: B9 9A C6 LDA  $C69A,Y
$C6C3: 95 16    STA  $16,X
$C6C5: AD DD 06 LDA  $06DD
$C6C8: C9          .byte $C9  ; غير معرّف
$C6C9: FF          .byte $FF  ; غير معرّف
$C6CA: D0 05    BNE  $C6D1
$C6CC: A9 00    LDA  #$00
$C6CE: 8D DD 06 STA  $06DD
$C6D1: BD A7 07 LDA  $07A7,X
$C6D4: 29 07    AND  #$07
$C6D6: A8       TAY  
$C6D7: B9 8A C6 LDA  $C68A,Y
$C6DA: 2C DD 06 BIT  $06DD
$C6DD: F0 07    BEQ  $C6E6
$C6DF: C8       INY  
$C6E0: 98       TYA  
$C6E1: 29 07    AND  #$07
$C6E3: 4C D6 C6 JMP  $C6D6
$C6E6: 0D DD 06 ORA  $06DD
$C6E9: 8D DD 06 STA  $06DD
$C6EC: B9 92 C6 LDA  $C692,Y
$C6EF: 20 D8 C5 JSR  $C5D8
$C6F2: 9D 17 04 STA  $0417,X
$C6F5: A9 20    LDA  #$20
$C6F7: 8D 8F 07 STA  $078F
$C6FA: 4C 6C C2 JMP  $C26C
$C6FD: A0 FF    LDY  #$FF
$C6FF: C8       INY  
$C700: C0 05    CPY  #$05
$C702: B0 0D    BCS  $C711
$C704: B9 0F 00 LDA  $000F,Y
$C707: F0 F6    BEQ  $C6FF
$C709: B9 16 00 LDA  $0016,Y
$C70C: C9          .byte $C9  ; غير معرّف
$C70D: 08       PHP  
$C70E: D0 EF    BNE  $C6FF
$C710: 60       RTS  
$C711: A5 FE    LDA  $FE
$C713: 09 08    ORA  #$08
$C715: 85 FE    STA  $FE
$C717: A9 08    LDA  #$08
$C719: D0 A8    BNE  $C6C3
$C71B: A0 00    LDY  #$00
$C71D: 38       SEC  
$C71E: E9 37    SBC  #$37
$C720: 48       PHA  
$C721: C9          .byte $C9  ; غير معرّف
$C722: 04          .byte $04  ; غير معرّف
$C723: B0 0B    BCS  $C730
$C725: 48       PHA  
$C726: A0 06    LDY  #$06
$C728: AD 6A 07 LDA  $076A
$C72B: F0 02    BEQ  $C72F
$C72D: A0 02    LDY  #$02
$C72F: 68       PLA  
$C730: 84 01    STY  $01
$C732: A0 B0    LDY  #$B0
$C734: 29 02    AND  #$02
$C736: F0 02    BEQ  $C73A
$C738: A0 70    LDY  #$70
$C73A: 84 00    STY  $00
$C73C: AD 1B 07 LDA  $071B
$C73F: 85 02    STA  $02
$C741: AD 1D 07 LDA  $071D
$C744: 85 03    STA  $03
$C746: A0 02    LDY  #$02
$C748: 68       PLA  
$C749: 4A       LSR  A
$C74A: 90 01    BCC  $C74D
$C74C: C8       INY  
$C74D: 8C D3 06 STY  $06D3
$C750: A2 FF    LDX  #$FF
$C752: E8       INX  
$C753: E0 05    CPX  #$05
$C755: B0 2D    BCS  $C784
$C757: B5 0F    LDA  $0F,X
$C759: D0 F7    BNE  $C752
$C75B: A5 01    LDA  $01
$C75D: 95 16    STA  $16,X
$C75F: A5 02    LDA  $02
$C761: 95 6E    STA  $6E,X
$C763: A5 03    LDA  $03
$C765: 95 87    STA  $87,X
$C767: 18       CLC  
$C768: 69 18    ADC  #$18
$C76A: 85 03    STA  $03
$C76C: A5 02    LDA  $02
$C76E: 69 00    ADC  #$00
$C770: 85 02    STA  $02
$C772: A5 00    LDA  $00
$C774: 95 CF    STA  $CF,X
$C776: A9 01    LDA  #$01
$C778: 95 B6    STA  $B6,X
$C77A: 95 0F    STA  $0F,X
$C77C: 20 6C C2 JSR  $C26C
$C77F: CE D3 06 DEC  $06D3
$C782: D0 CC    BNE  $C750
$C784: 4C 5E C2 JMP  $C25E
$C787: A9 01    LDA  #$01
$C789: 95 58    STA  $58,X
$C78B: 4A       LSR  A
$C78C: 95 1E    STA  $1E,X
$C78E: 95 A0    STA  $A0,X
$C790: B5 CF    LDA  $CF,X
$C792: 9D 34 04 STA  $0434,X
$C795: 38       SEC  
$C796: E9 18    SBC  #$18
$C798: 9D 17 04 STA  $0417,X
$C79B: A9 09    LDA  #$09
$C79D: 4C DB C7 JMP  $C7DB
$C7A0: B5 16    LDA  $16,X
$C7A2: 8D CB 06 STA  $06CB
$C7A5: 38       SEC  
$C7A6: E9 12    SBC  #$12
$C7A8: 20 04 8E JSR  $8E04
$C7AB: A4 C3    LDY  $C3
$C7AD: B7          .byte $B7  ; غير معرّف
$C7AE: C7          .byte $C7  ; غير معرّف
$C7AF: A8       TAY  
$C7B0: C4 A3    CPY  $A3
$C7B2: C5 3D    CMP  $3D
$C7B4: C6 9C    DEC  $9C
$C7B6: C6 60    DEC  $60
$C7B8: A0 05    LDY  #$05
$C7BA: B9 16 00 LDA  $0016,Y
$C7BD: C9          .byte $C9  ; غير معرّف
$C7BE: 11 D0    ORA  ($D0),Y
$C7C0: 05 A9    ORA  $A9
$C7C2: 01 99    ORA  ($99,X)
$C7C4: 1E 00 88 ASL  $8800,X
$C7C7: 10 F1    BPL  $C7BA
$C7C9: A9 00    LDA  #$00
$C7CB: 8D CB 06 STA  $06CB
$C7CE: 95 0F    STA  $0F,X
$C7D0: 60       RTS  
$C7D1: A9 02    LDA  #$02
$C7D3: 95 46    STA  $46,X
$C7D5: A9 F8    LDA  #$F8
$C7D7: 95 58    STA  $58,X
$C7D9: A9 03    LDA  #$03
$C7DB: 9D 9A 04 STA  $049A,X
$C7DE: 60       RTS  
$C7DF: D6 CF    DEC  $CF,X
$C7E1: D6 CF    DEC  $CF,X
$C7E3: AC CC 06 LDY  $06CC
$C7E6: D0 05    BNE  $C7ED
$C7E8: A0 02    LDY  #$02
$C7EA: 20 71 C8 JSR  $C871
$C7ED: A0 FF    LDY  #$FF
$C7EF: AD A0 03 LDA  $03A0
$C7F2: 95 1E    STA  $1E,X
$C7F4: 10 02    BPL  $C7F8
$C7F6: 8A       TXA  
$C7F7: A8       TAY  
$C7F8: 8C A0 03 STY  $03A0
$C7FB: A9 00    LDA  #$00
$C7FD: 95 46    STA  $46,X
$C7FF: A8       TAY  
$C800: 20 71 C8 JSR  $C871
$C803: A9 FF    LDA  #$FF
$C805: 9D A2 03 STA  $03A2,X
$C808: 4C 28 C8 JMP  $C828
$C80B: A9 00    LDA  #$00
$C80D: 95 58    STA  $58,X
$C80F: 4C 28 C8 JMP  $C828
$C812: A0 40    LDY  #$40
$C814: B5 CF    LDA  $CF,X
$C816: 10 07    BPL  $C81F
$C818: 49 FF    EOR  #$FF
$C81A: 18       CLC  
$C81B: 69 01    ADC  #$01
$C81D: A0 C0    LDY  #$C0
$C81F: 9D 01 04 STA  $0401,X
$C822: 98       TYA  
$C823: 18       CLC  
$C824: 75 CF    ADC  $CF,X
$C826: 95 58    STA  $58,X
$C828: 20 63 C3 JSR  $C363
$C82B: A9 05    LDA  #$05
$C82D: AC 4E 07 LDY  $074E
$C830: C0 03    CPY  #$03
$C832: F0 07    BEQ  $C83B
$C834: AC CC 06 LDY  $06CC
$C837: D0 02    BNE  $C83B
$C839: A9 06    LDA  #$06
$C83B: 9D 9A 04 STA  $049A,X
$C83E: 60       RTS  
$C83F: 20 4B C8 JSR  $C84B
$C842: 4C 48 C8 JMP  $C848
$C845: 20 57 C8 JSR  $C857
$C848: 4C 2B C8 JMP  $C82B
$C84B: A9 10    LDA  #$10
$C84D: 9D 34 04 STA  $0434,X
$C850: A9 FF    LDA  #$FF
$C852: 95 A0    STA  $A0,X
$C854: 4C 60 C8 JMP  $C860
$C857: A9 F0    LDA  #$F0
$C859: 9D 34 04 STA  $0434,X
$C85C: A9 00    LDA  #$00
$C85E: 95 A0    STA  $A0,X
$C860: A0 01    LDY  #$01
$C862: 20 71 C8 JSR  $C871
$C865: A9 04    LDA  #$04
$C867: 9D 9A 04 STA  $049A,X
$C86A: 60       RTS  
$C86B: 08       PHP  
$C86C: 0C          .byte $0C  ; غير معرّف
$C86D: F8       SED  
$C86E: 00       BRK  
$C86F: 00       BRK  
$C870: FF          .byte $FF  ; غير معرّف
$C871: B5 87    LDA  $87,X
$C873: 18       CLC  
$C874: 79 6B C8 ADC  $C86B,Y
$C877: 95 87    STA  $87,X
$C879: B5 6E    LDA  $6E,X
$C87B: 79 6E C8 ADC  $C86E,Y
$C87E: 95 6E    STA  $6E,X
$C880: 60       RTS  
$C881: 60       RTS  
$C882: A6 08    LDX  $08
$C884: A9 00    LDA  #$00
$C886: B4 16    LDY  $16,X
$C888: C0 15    CPY  #$15
$C88A: 90 03    BCC  $C88F
$C88C: 98       TYA  
$C88D: E9 14    SBC  #$14
$C88F: 20 04 8E JSR  $8E04
$C892: E0 C8    CPX  #$C8
$C894: 35 C9    AND  $C9,X
$C896: 95 D2    STA  $D2,X
$C898: D6 C8    DEC  $C8,X
$C89A: D6 C8    DEC  $C8,X
$C89C: D6 C8    DEC  $C8,X
$C89E: D6 C8    DEC  $C8,X
$C8A0: 47          .byte $47  ; غير معرّف
$C8A1: C9          .byte $C9  ; غير معرّف
$C8A2: 47          .byte $47  ; غير معرّف
$C8A3: C9          .byte $C9  ; غير معرّف
$C8A4: 47          .byte $47  ; غير معرّف
$C8A5: C9          .byte $C9  ; غير معرّف
$C8A6: 47          .byte $47  ; غير معرّف
$C8A7: C9          .byte $C9  ; غير معرّف
$C8A8: 47          .byte $47  ; غير معرّف
$C8A9: C9          .byte $C9  ; غير معرّف
$C8AA: 47          .byte $47  ; غير معرّف
$C8AB: C9          .byte $C9  ; غير معرّف
$C8AC: 47          .byte $47  ; غير معرّف
$C8AD: C9          .byte $C9  ; غير معرّف
$C8AE: 47          .byte $47  ; غير معرّف
$C8AF: C9          .byte $C9  ; غير معرّف
$C8B0: D6 C8    DEC  $C8,X
$C8B2: 65 C9    ADC  $C9
$C8B4: 65 C9    ADC  $C9
$C8B6: 65 C9    ADC  $C9
$C8B8: 65 C9    ADC  $C9
$C8BA: 65 C9    ADC  $C9
$C8BC: 65 C9    ADC  $C9
$C8BE: 65 C9    ADC  $C9
$C8C0: 4D C9 4D EOR  $4DC9
$C8C3: C9          .byte $C9  ; غير معرّف
$C8C4: 65 D0    ADC  $D0
$C8C6: 85 BC    STA  $BC
$C8C8: 4B          .byte $4B  ; غير معرّف
$C8C9: B9 D6 C8 LDA  $C8D6,Y
$C8CC: D9 D2 BA CMP  $BAD2,Y
$C8CF: B8       CLV  
$C8D0: D6 C8    DEC  $C8,X
$C8D2: A4 B7    LDY  $B7
$C8D4: D7          .byte $D7  ; غير معرّف
$C8D5: C8       INY  
$C8D6: 60       RTS  
$C8D7: 20 AF F1 JSR  $F1AF
$C8DA: 20 52 F1 JSR  $F152
$C8DD: 4C 7D E8 JMP  $E87D
$C8E0: A9 00    LDA  #$00
$C8E2: 9D C5 03 STA  $03C5,X
$C8E5: 20 AF F1 JSR  $F1AF
$C8E8: 20 52 F1 JSR  $F152
$C8EB: 20 7D E8 JSR  $E87D
$C8EE: 20 43 E2 JSR  $E243
$C8F1: 20 C1 DF JSR  $DFC1
$C8F4: 20 33 DA JSR  $DA33
$C8F7: 20 53 D8 JSR  $D853
$C8FA: AC 47 07 LDY  $0747
$C8FD: D0 03    BNE  $C902
$C8FF: 20 05 C9 JSR  $C905
$C902: 4C 7A D6 JMP  $D67A
$C905: B5 16    LDA  $16,X
$C907: 20 04 8E JSR  $8E04
$C90A: 77          .byte $77  ; غير معرّف
$C90B: CA       DEX  
$C90C: 77          .byte $77  ; غير معرّف
$C90D: CA       DEX  
$C90E: 77          .byte $77  ; غير معرّف
$C90F: CA       DEX  
$C910: 77          .byte $77  ; غير معرّف
$C911: CA       DEX  
$C912: 77          .byte $77  ; غير معرّف
$C913: CA       DEX  
$C914: D8       CLD  
$C915: C9          .byte $C9  ; غير معرّف
$C916: 77          .byte $77  ; غير معرّف
$C917: CA       DEX  
$C918: 89          .byte $89  ; غير معرّف
$C919: CB          .byte $CB  ; غير معرّف
$C91A: 36 CC    ROL  $CC,X
$C91C: 34          .byte $34  ; غير معرّف
$C91D: C9          .byte $C9  ; غير معرّف
$C91E: 4A       LSR  A
$C91F: CC 4A CC CPY  $CC4A
$C922: B0 C9    BCS  $C8ED
$C924: B0 D3    BCS  $C8F9
$C926: F9 CA FF SBC  $FFCA,Y
$C929: CA       DEX  
$C92A: 25 CB    AND  $CB
$C92C: 28       PLP  
$C92D: CF          .byte $CF  ; غير معرّف
$C92E: 77          .byte $77  ; غير معرّف
$C92F: CA       DEX  
$C930: 34          .byte $34  ; غير معرّف
$C931: C9          .byte $C9  ; غير معرّف
$C932: DF          .byte $DF  ; غير معرّف
$C933: CE 60 20 DEC  $2060
$C936: EB          .byte $EB  ; غير معرّف
$C937: D1 20    CMP  ($20),Y
$C939: AF          .byte $AF  ; غير معرّف
$C93A: F1 20    SBC  ($20),Y
$C93C: 52          .byte $52  ; غير معرّف
$C93D: F1 20    SBC  ($20),Y
$C93F: 43          .byte $43  ; غير معرّف
$C940: E2          .byte $E2  ; غير معرّف
$C941: 20 53 D8 JSR  $D853
$C944: 4C 7A D6 JMP  $D67A
$C947: 20 3C CD JSR  $CD3C
$C94A: 4C 7A D6 JMP  $D67A
$C94D: 20 AF F1 JSR  $F1AF
$C950: 20 52 F1 JSR  $F152
$C953: 20 4C E2 JSR  $E24C
$C956: 20 7B DB JSR  $DB7B
$C959: 20 52 F1 JSR  $F152
$C95C: 20 66 ED JSR  $ED66
$C95F: 20 55 D6 JSR  $D655
$C962: 4C 7A D6 JMP  $D67A
$C965: 20 AF F1 JSR  $F1AF
$C968: 20 52 F1 JSR  $F152
$C96B: 20 73 E2 JSR  $E273
$C96E: 20 45 DB JSR  $DB45
$C971: AD 47 07 LDA  $0747
$C974: D0 03    BNE  $C979
$C976: 20 82 C9 JSR  $C982
$C979: 20 52 F1 JSR  $F152
$C97C: 20 C8 E5 JSR  $E5C8
$C97F: 4C 7A D6 JMP  $D67A
$C982: B5 16    LDA  $16,X
$C984: 38       SEC  
$C985: E9 24    SBC  #$24
$C987: 20 04 8E JSR  $8E04
$C98A: 32          .byte $32  ; غير معرّف
$C98B: D4          .byte $D4  ; غير معرّف
$C98C: D3          .byte $D3  ; غير معرّف
$C98D: D5 4F    CMP  $4F,X
$C98F: D6 4F    DEC  $4F,X
$C991: D6 07    DEC  $07,X
$C993: D6 31    DEC  $31,X
$C995: D6 3D    DEC  $3D,X
$C997: D6 A9    DEC  $A9,X
$C999: 00       BRK  
$C99A: 95 0F    STA  $0F,X
$C99C: 95 16    STA  $16,X
$C99E: 95 1E    STA  $1E,X
$C9A0: 9D 10 01 STA  $0110,X
$C9A3: 9D 96 07 STA  $0796,X
$C9A6: 9D 25 01 STA  $0125,X
$C9A9: 9D C5 03 STA  $03C5,X
$C9AC: 9D 8A 07 STA  $078A,X
$C9AF: 60       RTS  
$C9B0: BD 96 07 LDA  $0796,X
$C9B3: D0 16    BNE  $C9CB
$C9B5: 20 F7 C2 JSR  $C2F7
$C9B8: BD A8 07 LDA  $07A8,X
$C9BB: 09 80    ORA  #$80
$C9BD: 9D 34 04 STA  $0434,X
$C9C0: 29 0F    AND  #$0F
$C9C2: 09 06    ORA  #$06
$C9C4: 9D 96 07 STA  $0796,X
$C9C7: A9 F9    LDA  #$F9
$C9C9: 95 A0    STA  $A0,X
$C9CB: 4C 92 BF JMP  $BF92
$C9CE: 30 1C    BMI  $C9EC
$C9D0: 00       BRK  
$C9D1: E8       INX  
$C9D2: 00       BRK  
$C9D3: 18       CLC  
$C9D4: 08       PHP  
$C9D5: F8       SED  
$C9D6: 0C          .byte $0C  ; غير معرّف
$C9D7: F4          .byte $F4  ; غير معرّف
$C9D8: B5 1E    LDA  $1E,X
$C9DA: 29 20    AND  #$20
$C9DC: F0 03    BEQ  $C9E1
$C9DE: 4C E5 CA JMP  $CAE5
$C9E1: B5 3C    LDA  $3C,X
$C9E3: F0 2D    BEQ  $CA12
$C9E5: D6 3C    DEC  $3C,X
$C9E7: AD D1 03 LDA  $03D1
$C9EA: 29 0C    AND  #$0C
$C9EC: D0 6A    BNE  $CA58
$C9EE: BD A2 03 LDA  $03A2,X
$C9F1: D0 17    BNE  $CA0A
$C9F3: AC CC 06 LDY  $06CC
$C9F6: B9 CE C9 LDA  $C9CE,Y
$C9F9: 9D A2 03 STA  $03A2,X
$C9FC: 20 94 BA JSR  $BA94
$C9FF: 90 09    BCC  $CA0A
$CA01: B5 1E    LDA  $1E,X
$CA03: 09 08    ORA  #$08
$CA05: 95 1E    STA  $1E,X
$CA07: 4C 58 CA JMP  $CA58
$CA0A: DE A2 03 DEC  $03A2,X
$CA0D: 4C 58 CA JMP  $CA58
$CA10: 20 37 B5 JSR  $B537
$CA13: 1E 29 07 ASL  $0729,X
$CA16: C9          .byte $C9  ; غير معرّف
$CA17: 01 F0    ORA  ($F0,X)
$CA19: 3E A9 00 ROL  $00A9,X
$CA1C: 85 00    STA  $00
$CA1E: A0 FA    LDY  #$FA
$CA20: B5 CF    LDA  $CF,X
$CA22: 30 13    BMI  $CA37
$CA24: A0 FD    LDY  #$FD
$CA26: C9          .byte $C9  ; غير معرّف
$CA27: 70 E6    BVS  $CA0F
$CA29: 00       BRK  
$CA2A: 90 0B    BCC  $CA37
$CA2C: C6 00    DEC  $00
$CA2E: BD A8 07 LDA  $07A8,X
$CA31: 29 01    AND  #$01
$CA33: D0 02    BNE  $CA37
$CA35: A0 FA    LDY  #$FA
$CA37: 94 A0    STY  $A0,X
$CA39: B5 1E    LDA  $1E,X
$CA3B: 09 01    ORA  #$01
$CA3D: 95 1E    STA  $1E,X
$CA3F: A5 00    LDA  $00
$CA41: 3D A9 07 AND  $07A9,X
$CA44: A8       TAY  
$CA45: AD CC 06 LDA  $06CC
$CA48: D0 01    BNE  $CA4B
$CA4A: A8       TAY  
$CA4B: B9 10 CA LDA  $CA10,Y
$CA4E: 9D 8A 07 STA  $078A,X
$CA51: BD A8 07 LDA  $07A8,X
$CA54: 09 C0    ORA  #$C0
$CA56: 95 3C    STA  $3C,X
$CA58: A0 FC    LDY  #$FC
$CA5A: A5 09    LDA  $09
$CA5C: 29 40    AND  #$40
$CA5E: D0 02    BNE  $CA62
$CA60: A0 04    LDY  #$04
$CA62: 94 58    STY  $58,X
$CA64: A0 01    LDY  #$01
$CA66: 20 43 E1 JSR  $E143
$CA69: 30 0A    BMI  $CA75
$CA6B: C8       INY  
$CA6C: BD 96 07 LDA  $0796,X
$CA6F: D0 04    BNE  $CA75
$CA71: A9 F8    LDA  #$F8
$CA73: 95 58    STA  $58,X
$CA75: 94 46    STY  $46,X
$CA77: A0 00    LDY  #$00
$CA79: B5 1E    LDA  $1E,X
$CA7B: 29 40    AND  #$40
$CA7D: D0 19    BNE  $CA98
$CA7F: B5 1E    LDA  $1E,X
$CA81: 0A       ASL  A
$CA82: B0 30    BCS  $CAB4
$CA84: B5 1E    LDA  $1E,X
$CA86: 29 20    AND  #$20
$CA88: D0 5B    BNE  $CAE5
$CA8A: B5 1E    LDA  $1E,X
$CA8C: 29 07    AND  #$07
$CA8E: F0 24    BEQ  $CAB4
$CA90: C9          .byte $C9  ; غير معرّف
$CA91: 05 F0    ORA  $F0
$CA93: 04          .byte $04  ; غير معرّف
$CA94: C9          .byte $C9  ; غير معرّف
$CA95: 03          .byte $03  ; غير معرّف
$CA96: B0 30    BCS  $CAC8
$CA98: 20 63 BF JSR  $BF63
$CA9B: A0 00    LDY  #$00
$CA9D: B5 1E    LDA  $1E,X
$CA9F: C9          .byte $C9  ; غير معرّف
$CAA0: 02          .byte $02  ; غير معرّف
$CAA1: F0 0C    BEQ  $CAAF
$CAA3: 29 40    AND  #$40
$CAA5: F0 0D    BEQ  $CAB4
$CAA7: B5 16    LDA  $16,X
$CAA9: C9          .byte $C9  ; غير معرّف
$CAAA: 2E F0 07 ROL  $07F0
$CAAD: D0 03    BNE  $CAB2
$CAAF: 4C 02 BF JMP  $BF02
$CAB2: A0 01    LDY  #$01
$CAB4: B5 58    LDA  $58,X
$CAB6: 48       PHA  
$CAB7: 10 02    BPL  $CABB
$CAB9: C8       INY  
$CABA: C8       INY  
$CABB: 18       CLC  
$CABC: 79 D0 C9 ADC  $C9D0,Y
$CABF: 95 58    STA  $58,X
$CAC1: 20 02 BF JSR  $BF02
$CAC4: 68       PLA  
$CAC5: 95 58    STA  $58,X
$CAC7: 60       RTS  
$CAC8: BD 96 07 LDA  $0796,X
$CACB: D0 1E    BNE  $CAEB
$CACD: 95 1E    STA  $1E,X
$CACF: A5 09    LDA  $09
$CAD1: 29 01    AND  #$01
$CAD3: A8       TAY  
$CAD4: C8       INY  
$CAD5: 94 46    STY  $46,X
$CAD7: 88       DEY  
$CAD8: AD 6A 07 LDA  $076A
$CADB: F0 02    BEQ  $CADF
$CADD: C8       INY  
$CADE: C8       INY  
$CADF: B9 D4 C9 LDA  $C9D4,Y
$CAE2: 95 58    STA  $58,X
$CAE4: 60       RTS  
$CAE5: 20 63 BF JSR  $BF63
$CAE8: 4C 02 BF JMP  $BF02
$CAEB: C9          .byte $C9  ; غير معرّف
$CAEC: 0E D0 09 ASL  $09D0
$CAEF: B5 16    LDA  $16,X
$CAF1: C9          .byte $C9  ; غير معرّف
$CAF2: 06 D0    ASL  $D0
$CAF4: 03          .byte $03  ; غير معرّف
$CAF5: 20 98 C9 JSR  $C998
$CAF8: 60       RTS  
$CAF9: 20 92 BF JSR  $BF92
$CAFC: 4C 02 BF JMP  $BF02
$CAFF: B5 A0    LDA  $A0,X
$CB01: 1D 34 04 ORA  $0434,X
$CB04: D0 13    BNE  $CB19
$CB06: 9D 17 04 STA  $0417,X
$CB09: B5 CF    LDA  $CF,X
$CB0B: DD 01 04 CMP  $0401,X
$CB0E: B0 09    BCS  $CB19
$CB10: A5 09    LDA  $09
$CB12: 29 07    AND  #$07
$CB14: D0 02    BNE  $CB18
$CB16: F6 CF    INC  $CF,X
$CB18: 60       RTS  
$CB19: B5 CF    LDA  $CF,X
$CB1B: D5 58    CMP  $58,X
$CB1D: 90 03    BCC  $CB22
$CB1F: 4C 75 BF JMP  $BF75
$CB22: 4C 70 BF JMP  $BF70
$CB25: 20 45 CB JSR  $CB45
$CB28: 20 66 CB JSR  $CB66
$CB2B: A0 01    LDY  #$01
$CB2D: A5 09    LDA  $09
$CB2F: 29 03    AND  #$03
$CB31: D0 11    BNE  $CB44
$CB33: A5 09    LDA  $09
$CB35: 29 40    AND  #$40
$CB37: D0 02    BNE  $CB3B
$CB39: A0 FF    LDY  #$FF
$CB3B: 84 00    STY  $00
$CB3D: B5 CF    LDA  $CF,X
$CB3F: 18       CLC  
$CB40: 65 00    ADC  $00
$CB42: 95 CF    STA  $CF,X
$CB44: 60       RTS  
$CB45: A9 13    LDA  #$13
$CB47: 85 01    STA  $01
$CB49: A5 09    LDA  $09
$CB4B: 29 03    AND  #$03
$CB4D: D0 0D    BNE  $CB5C
$CB4F: B4 58    LDY  $58,X
$CB51: B5 A0    LDA  $A0,X
$CB53: 4A       LSR  A
$CB54: B0 0A    BCS  $CB60
$CB56: C4 01    CPY  $01
$CB58: F0 03    BEQ  $CB5D
$CB5A: F6 58    INC  $58,X
$CB5C: 60       RTS  
$CB5D: F6 A0    INC  $A0,X
$CB5F: 60       RTS  
$CB60: 98       TYA  
$CB61: F0 FA    BEQ  $CB5D
$CB63: D6 58    DEC  $58,X
$CB65: 60       RTS  
$CB66: B5 58    LDA  $58,X
$CB68: 48       PHA  
$CB69: A0 01    LDY  #$01
$CB6B: B5 A0    LDA  $A0,X
$CB6D: 29 02    AND  #$02
$CB6F: D0 0B    BNE  $CB7C
$CB71: B5 58    LDA  $58,X
$CB73: 49 FF    EOR  #$FF
$CB75: 18       CLC  
$CB76: 69 01    ADC  #$01
$CB78: 95 58    STA  $58,X
$CB7A: A0 02    LDY  #$02
$CB7C: 94 46    STY  $46,X
$CB7E: 20 02 BF JSR  $BF02
$CB81: 85 00    STA  $00
$CB83: 68       PLA  
$CB84: 95 58    STA  $58,X
$CB86: 60       RTS  
$CB87: 3F          .byte $3F  ; غير معرّف
$CB88: 03          .byte $03  ; غير معرّف
$CB89: B5 1E    LDA  $1E,X
$CB8B: 29 20    AND  #$20
$CB8D: D0 4D    BNE  $CBDC
$CB8F: AC CC 06 LDY  $06CC
$CB92: BD A8 07 LDA  $07A8,X
$CB95: 39 87 CB AND  $CB87,Y
$CB98: D0 12    BNE  $CBAC
$CB9A: 8A       TXA  
$CB9B: 4A       LSR  A
$CB9C: 90 04    BCC  $CBA2
$CB9E: A4 45    LDY  $45
$CBA0: B0 08    BCS  $CBAA
$CBA2: A0 02    LDY  #$02
$CBA4: 20 43 E1 JSR  $E143
$CBA7: 10 01    BPL  $CBAA
$CBA9: 88       DEY  
$CBAA: 94 46    STY  $46,X
$CBAC: 20 DF CB JSR  $CBDF
$CBAF: B5 CF    LDA  $CF,X
$CBB1: 38       SEC  
$CBB2: FD 34 04 SBC  $0434,X
$CBB5: C9          .byte $C9  ; غير معرّف
$CBB6: 20 90 02 JSR  $0290
$CBB9: 95 CF    STA  $CF,X
$CBBB: B4 46    LDY  $46,X
$CBBD: 88       DEY  
$CBBE: D0 0E    BNE  $CBCE
$CBC0: B5 87    LDA  $87,X
$CBC2: 18       CLC  
$CBC3: 75 58    ADC  $58,X
$CBC5: 95 87    STA  $87,X
$CBC7: B5 6E    LDA  $6E,X
$CBC9: 69 00    ADC  #$00
$CBCB: 95 6E    STA  $6E,X
$CBCD: 60       RTS  
$CBCE: B5 87    LDA  $87,X
$CBD0: 38       SEC  
$CBD1: F5 58    SBC  $58,X
$CBD3: 95 87    STA  $87,X
$CBD5: B5 6E    LDA  $6E,X
$CBD7: E9 00    SBC  #$00
$CBD9: 95 6E    STA  $6E,X
$CBDB: 60       RTS  
$CBDC: 4C 8C BF JMP  $BF8C
$CBDF: B5 A0    LDA  $A0,X
$CBE1: 29 02    AND  #$02
$CBE3: D0 37    BNE  $CC1C
$CBE5: A5 09    LDA  $09
$CBE7: 29 07    AND  #$07
$CBE9: 48       PHA  
$CBEA: B5 A0    LDA  $A0,X
$CBEC: 4A       LSR  A
$CBED: B0 15    BCS  $CC04
$CBEF: 68       PLA  
$CBF0: D0 11    BNE  $CC03
$CBF2: BD 34 04 LDA  $0434,X
$CBF5: 18       CLC  
$CBF6: 69 01    ADC  #$01
$CBF8: 9D 34 04 STA  $0434,X
$CBFB: 95 58    STA  $58,X
$CBFD: C9          .byte $C9  ; غير معرّف
$CBFE: 02          .byte $02  ; غير معرّف
$CBFF: D0 02    BNE  $CC03
$CC01: F6 A0    INC  $A0,X
$CC03: 60       RTS  
$CC04: 68       PLA  
$CC05: D0 14    BNE  $CC1B
$CC07: BD 34 04 LDA  $0434,X
$CC0A: 38       SEC  
$CC0B: E9 01    SBC  #$01
$CC0D: 9D 34 04 STA  $0434,X
$CC10: 95 58    STA  $58,X
$CC12: D0 07    BNE  $CC1B
$CC14: F6 A0    INC  $A0,X
$CC16: A9 02    LDA  #$02
$CC18: 9D 96 07 STA  $0796,X
$CC1B: 60       RTS  
$CC1C: BD 96 07 LDA  $0796,X
$CC1F: F0 08    BEQ  $CC29
$CC21: A5 09    LDA  $09
$CC23: 4A       LSR  A
$CC24: B0 02    BCS  $CC28
$CC26: F6 CF    INC  $CF,X
$CC28: 60       RTS  
$CC29: B5 CF    LDA  $CF,X
$CC2B: 69 10    ADC  #$10
$CC2D: C5 CE    CMP  $CE
$CC2F: 90 F0    BCC  $CC21
$CC31: A9 00    LDA  #$00
$CC33: 95 A0    STA  $A0,X
$CC35: 60       RTS  
$CC36: B5 1E    LDA  $1E,X
$CC38: 29 20    AND  #$20
$CC3A: F0 03    BEQ  $CC3F
$CC3C: 4C 92 BF JMP  $BF92
$CC3F: A9 E8    LDA  #$E8
$CC41: 95 58    STA  $58,X
$CC43: 4C 02 BF JMP  $BF02
$CC46: 40       RTI  
$CC47: 80          .byte $80  ; غير معرّف
$CC48: 04          .byte $04  ; غير معرّف
$CC49: 04          .byte $04  ; غير معرّف
$CC4A: B5 1E    LDA  $1E,X
$CC4C: 29 20    AND  #$20
$CC4E: F0 03    BEQ  $CC53
$CC50: 4C 8C BF JMP  $BF8C
$CC53: 85 03    STA  $03
$CC55: B5 16    LDA  $16,X
$CC57: 38       SEC  
$CC58: E9 0A    SBC  #$0A
$CC5A: A8       TAY  
$CC5B: B9 46 CC LDA  $CC46,Y
$CC5E: 85 02    STA  $02
$CC60: BD 01 04 LDA  $0401,X
$CC63: 38       SEC  
$CC64: E5 02    SBC  $02
$CC66: 9D 01 04 STA  $0401,X
$CC69: B5 87    LDA  $87,X
$CC6B: E9 00    SBC  #$00
$CC6D: 95 87    STA  $87,X
$CC6F: B5 6E    LDA  $6E,X
$CC71: E9 00    SBC  #$00
$CC73: 95 6E    STA  $6E,X
$CC75: A9 20    LDA  #$20
$CC77: 85 02    STA  $02
$CC79: E0 02    CPX  #$02
$CC7B: 90 49    BCC  $CCC6
$CC7D: B5 58    LDA  $58,X
$CC7F: C9          .byte $C9  ; غير معرّف
$CC80: 10 90    BPL  $CC12
$CC82: 16 BD    ASL  $BD,X
$CC84: 17          .byte $17  ; غير معرّف
$CC85: 04          .byte $04  ; غير معرّف
$CC86: 18       CLC  
$CC87: 65 02    ADC  $02
$CC89: 9D 17 04 STA  $0417,X
$CC8C: B5 CF    LDA  $CF,X
$CC8E: 65 03    ADC  $03
$CC90: 95 CF    STA  $CF,X
$CC92: B5 B6    LDA  $B6,X
$CC94: 69 00    ADC  #$00
$CC96: 4C AC CC JMP  $CCAC
$CC99: BD 17 04 LDA  $0417,X
$CC9C: 38       SEC  
$CC9D: E5 02    SBC  $02
$CC9F: 9D 17 04 STA  $0417,X
$CCA2: B5 CF    LDA  $CF,X
$CCA4: E5 03    SBC  $03
$CCA6: 95 CF    STA  $CF,X
$CCA8: B5 B6    LDA  $B6,X
$CCAA: E9 00    SBC  #$00
$CCAC: 95 B6    STA  $B6,X
$CCAE: A0 00    LDY  #$00
$CCB0: B5 CF    LDA  $CF,X
$CCB2: 38       SEC  
$CCB3: FD 34 04 SBC  $0434,X
$CCB6: 10 07    BPL  $CCBF
$CCB8: A0 10    LDY  #$10
$CCBA: 49 FF    EOR  #$FF
$CCBC: 18       CLC  
$CCBD: 69 01    ADC  #$01
$CCBF: C9          .byte $C9  ; غير معرّف
$CCC0: 0F          .byte $0F  ; غير معرّف
$CCC1: 90 03    BCC  $CCC6
$CCC3: 98       TYA  
$CCC4: 95 58    STA  $58,X
$CCC6: 60       RTS  
$CCC7: 00       BRK  
$CCC8: 01 03    ORA  ($03,X)
$CCCA: 04          .byte $04  ; غير معرّف
$CCCB: 05 06    ORA  $06
$CCCD: 07          .byte $07  ; غير معرّف
$CCCE: 07          .byte $07  ; غير معرّف
$CCCF: 08       PHP  
$CCD0: 00       BRK  
$CCD1: 03          .byte $03  ; غير معرّف
$CCD2: 06 09    ASL  $09
$CCD4: 0B          .byte $0B  ; غير معرّف
$CCD5: 0D 0E 0F ORA  $0F0E
$CCD8: 10 00    BPL  $CCDA
$CCDA: 04          .byte $04  ; غير معرّف
$CCDB: 09 0D    ORA  #$0D
$CCDD: 10 13    BPL  $CCF2
$CCDF: 16 17    ASL  $17,X
$CCE1: 18       CLC  
$CCE2: 00       BRK  
$CCE3: 06 0C    ASL  $0C
$CCE5: 12          .byte $12  ; غير معرّف
$CCE6: 16 1A    ASL  $1A,X
$CCE8: 1D 1F 20 ORA  $201F,X
$CCEB: 00       BRK  
$CCEC: 07          .byte $07  ; غير معرّف
$CCED: 0F          .byte $0F  ; غير معرّف
$CCEE: 16 1C    ASL  $1C,X
$CCF0: 21 25    AND  ($25,X)
$CCF2: 27          .byte $27  ; غير معرّف
$CCF3: 28       PLP  
$CCF4: 00       BRK  
$CCF5: 09 12    ORA  #$12
$CCF7: 1B          .byte $1B  ; غير معرّف
$CCF8: 21 27    AND  ($27,X)
$CCFA: 2C 2F 30 BIT  $302F
$CCFD: 00       BRK  
$CCFE: 0B          .byte $0B  ; غير معرّف
$CCFF: 15 1F    ORA  $1F,X
$CD01: 27          .byte $27  ; غير معرّف
$CD02: 2E 33 37 ROL  $3733
$CD05: 38       SEC  
$CD06: 00       BRK  
$CD07: 0C          .byte $0C  ; غير معرّف
$CD08: 18       CLC  
$CD09: 24 2D    BIT  $2D
$CD0B: 35 3B    AND  $3B,X
$CD0D: 3E 40 00 ROL  $0040,X
$CD10: 0E 1B 28 ASL  $281B
$CD13: 32          .byte $32  ; غير معرّف
$CD14: 3B          .byte $3B  ; غير معرّف
$CD15: 42          .byte $42  ; غير معرّف
$CD16: 46 48    LSR  $48
$CD18: 00       BRK  
$CD19: 0F          .byte $0F  ; غير معرّف
$CD1A: 1F          .byte $1F  ; غير معرّف
$CD1B: 2D 38 42 AND  $4238
$CD1E: 4A       LSR  A
$CD1F: 4E 50 00 LSR  $0050
$CD22: 11 22    ORA  ($22),Y
$CD24: 31 3E    AND  ($3E),Y
$CD26: 49 51    EOR  #$51
$CD28: 56 58    LSR  $58,X
$CD2A: 01 03    ORA  ($03,X)
$CD2C: 02          .byte $02  ; غير معرّف
$CD2D: 00       BRK  
$CD2E: 00       BRK  
$CD2F: 09 12    ORA  #$12
$CD31: 1B          .byte $1B  ; غير معرّف
$CD32: 24 2D    BIT  $2D
$CD34: 36 3F    ROL  $3F,X
$CD36: 48       PHA  
$CD37: 51 5A    EOR  ($5A),Y
$CD39: 63          .byte $63  ; غير معرّف
$CD3A: 0C          .byte $0C  ; غير معرّف
$CD3B: 18       CLC  
$CD3C: 20 AF F1 JSR  $F1AF
$CD3F: AD D1 03 LDA  $03D1
$CD42: 29 08    AND  #$08
$CD44: D0 74    BNE  $CDBA
$CD46: AD 47 07 LDA  $0747
$CD49: D0 0A    BNE  $CD55
$CD4B: BD 88 03 LDA  $0388,X
$CD4E: 20 10 D4 JSR  $D410
$CD51: 29 1F    AND  #$1F
$CD53: 95 A0    STA  $A0,X
$CD55: B5 A0    LDA  $A0,X
$CD57: B4 16    LDY  $16,X
$CD59: C0 1F    CPY  #$1F
$CD5B: 90 0D    BCC  $CD6A
$CD5D: C9          .byte $C9  ; غير معرّف
$CD5E: 08       PHP  
$CD5F: F0 04    BEQ  $CD65
$CD61: C9          .byte $C9  ; غير معرّف
$CD62: 18       CLC  
$CD63: D0 05    BNE  $CD6A
$CD65: 18       CLC  
$CD66: 69 01    ADC  #$01
$CD68: 95 A0    STA  $A0,X
$CD6A: 85 EF    STA  $EF
$CD6C: 20 52 F1 JSR  $F152
$CD6F: 20 8E CE JSR  $CE8E
$CD72: BC E5 06 LDY  $06E5,X
$CD75: AD B9 03 LDA  $03B9
$CD78: 99 00 02 STA  $0200,Y
$CD7B: 85 07    STA  $07
$CD7D: AD AE 03 LDA  $03AE
$CD80: 99 03 02 STA  $0203,Y
$CD83: 85 06    STA  $06
$CD85: A9 01    LDA  #$01
$CD87: 85 00    STA  $00
$CD89: 20 08 CE JSR  $CE08
$CD8C: A0 05    LDY  #$05
$CD8E: B5 16    LDA  $16,X
$CD90: C9          .byte $C9  ; غير معرّف
$CD91: 1F          .byte $1F  ; غير معرّف
$CD92: 90 02    BCC  $CD96
$CD94: A0 0B    LDY  #$0B
$CD96: 84 ED    STY  $ED
$CD98: A9 00    LDA  #$00
$CD9A: 85 00    STA  $00
$CD9C: A5 EF    LDA  $EF
$CD9E: 20 8E CE JSR  $CE8E
$CDA1: 20 BB CD JSR  $CDBB
$CDA4: A5 00    LDA  $00
$CDA6: C9          .byte $C9  ; غير معرّف
$CDA7: 04          .byte $04  ; غير معرّف
$CDA8: D0 08    BNE  $CDB2
$CDAA: AC CF 06 LDY  $06CF
$CDAD: B9 E5 06 LDA  $06E5,Y
$CDB0: 85 06    STA  $06
$CDB2: E6 00    INC  $00
$CDB4: A5 00    LDA  $00
$CDB6: C5 ED    CMP  $ED
$CDB8: 90 E2    BCC  $CD9C
$CDBA: 60       RTS  
$CDBB: A5 03    LDA  $03
$CDBD: 85 05    STA  $05
$CDBF: A4 06    LDY  $06
$CDC1: A5 01    LDA  $01
$CDC3: 46 05    LSR  $05
$CDC5: B0 04    BCS  $CDCB
$CDC7: 49 FF    EOR  #$FF
$CDC9: 69 01    ADC  #$01
$CDCB: 18       CLC  
$CDCC: 6D AE 03 ADC  $03AE
$CDCF: 99 03 02 STA  $0203,Y
$CDD2: 85 06    STA  $06
$CDD4: CD AE 03 CMP  $03AE
$CDD7: B0 09    BCS  $CDE2
$CDD9: AD AE 03 LDA  $03AE
$CDDC: 38       SEC  
$CDDD: E5 06    SBC  $06
$CDDF: 4C E6 CD JMP  $CDE6
$CDE2: 38       SEC  
$CDE3: ED AE 03 SBC  $03AE
$CDE6: C9          .byte $C9  ; غير معرّف
$CDE7: 59 90 04 EOR  $0490,Y
$CDEA: A9 F8    LDA  #$F8
$CDEC: D0 15    BNE  $CE03
$CDEE: AD B9 03 LDA  $03B9
$CDF1: C9          .byte $C9  ; غير معرّف
$CDF2: F8       SED  
$CDF3: F0 0E    BEQ  $CE03
$CDF5: A5 02    LDA  $02
$CDF7: 46 05    LSR  $05
$CDF9: B0 04    BCS  $CDFF
$CDFB: 49 FF    EOR  #$FF
$CDFD: 69 01    ADC  #$01
$CDFF: 18       CLC  
$CE00: 6D B9 03 ADC  $03B9
$CE03: 99 00 02 STA  $0200,Y
$CE06: 85 07    STA  $07
$CE08: 20 ED EC JSR  $ECED
$CE0B: 98       TYA  
$CE0C: 48       PHA  
$CE0D: AD 9F 07 LDA  $079F
$CE10: 0D 47 07 ORA  $0747
$CE13: D0 70    BNE  $CE85
$CE15: 85 05    STA  $05
$CE17: A4 B5    LDY  $B5
$CE19: 88       DEY  
$CE1A: D0 69    BNE  $CE85
$CE1C: A4 CE    LDY  $CE
$CE1E: AD 54 07 LDA  $0754
$CE21: D0 05    BNE  $CE28
$CE23: AD 14 07 LDA  $0714
$CE26: F0 09    BEQ  $CE31
$CE28: E6 05    INC  $05
$CE2A: E6 05    INC  $05
$CE2C: 98       TYA  
$CE2D: 18       CLC  
$CE2E: 69 18    ADC  #$18
$CE30: A8       TAY  
$CE31: 98       TYA  
$CE32: 38       SEC  
$CE33: E5 07    SBC  $07
$CE35: 10 05    BPL  $CE3C
$CE37: 49 FF    EOR  #$FF
$CE39: 18       CLC  
$CE3A: 69 01    ADC  #$01
$CE3C: C9          .byte $C9  ; غير معرّف
$CE3D: 08       PHP  
$CE3E: B0 1C    BCS  $CE5C
$CE40: A5 06    LDA  $06
$CE42: C9          .byte $C9  ; غير معرّف
$CE43: F0 B0    BEQ  $CDF5
$CE45: 16 AD    ASL  $AD,X
$CE47: 07          .byte $07  ; غير معرّف
$CE48: 02          .byte $02  ; غير معرّف
$CE49: 18       CLC  
$CE4A: 69 04    ADC  #$04
$CE4C: 85 04    STA  $04
$CE4E: 38       SEC  
$CE4F: E5 06    SBC  $06
$CE51: 10 05    BPL  $CE58
$CE53: 49 FF    EOR  #$FF
$CE55: 18       CLC  
$CE56: 69 01    ADC  #$01
$CE58: C9          .byte $C9  ; غير معرّف
$CE59: 08       PHP  
$CE5A: 90 13    BCC  $CE6F
$CE5C: A5 05    LDA  $05
$CE5E: C9          .byte $C9  ; غير معرّف
$CE5F: 02          .byte $02  ; غير معرّف
$CE60: F0 23    BEQ  $CE85
$CE62: A4 05    LDY  $05
$CE64: A5 CE    LDA  $CE
$CE66: 18       CLC  
$CE67: 79 3A CD ADC  $CD3A,Y
$CE6A: E6 05    INC  $05
$CE6C: 4C 32 CE JMP  $CE32
$CE6F: A2 01    LDX  #$01
$CE71: A5 04    LDA  $04
$CE73: C5 06    CMP  $06
$CE75: B0 01    BCS  $CE78
$CE77: E8       INX  
$CE78: 86 46    STX  $46
$CE7A: A2 00    LDX  #$00
$CE7C: A5 00    LDA  $00
$CE7E: 48       PHA  
$CE7F: 20 2C D9 JSR  $D92C
$CE82: 68       PLA  
$CE83: 85 00    STA  $00
$CE85: 68       PLA  
$CE86: 18       CLC  
$CE87: 69 04    ADC  #$04
$CE89: 85 06    STA  $06
$CE8B: A6 08    LDX  $08
$CE8D: 60       RTS  
$CE8E: 48       PHA  
$CE8F: 29 0F    AND  #$0F
$CE91: C9          .byte $C9  ; غير معرّف
$CE92: 09 90    ORA  #$90
$CE94: 05 49    ORA  $49
$CE96: 0F          .byte $0F  ; غير معرّف
$CE97: 18       CLC  
$CE98: 69 01    ADC  #$01
$CE9A: 85 01    STA  $01
$CE9C: A4 00    LDY  $00
$CE9E: B9 2E CD LDA  $CD2E,Y
$CEA1: 18       CLC  
$CEA2: 65 01    ADC  $01
$CEA4: A8       TAY  
$CEA5: B9 C7 CC LDA  $CCC7,Y
$CEA8: 85 01    STA  $01
$CEAA: 68       PLA  
$CEAB: 48       PHA  
$CEAC: 18       CLC  
$CEAD: 69 08    ADC  #$08
$CEAF: 29 0F    AND  #$0F
$CEB1: C9          .byte $C9  ; غير معرّف
$CEB2: 09 90    ORA  #$90
$CEB4: 05 49    ORA  $49
$CEB6: 0F          .byte $0F  ; غير معرّف
$CEB7: 18       CLC  
$CEB8: 69 01    ADC  #$01
$CEBA: 85 02    STA  $02
$CEBC: A4 00    LDY  $00
$CEBE: B9 2E CD LDA  $CD2E,Y
$CEC1: 18       CLC  
$CEC2: 65 02    ADC  $02
$CEC4: A8       TAY  
$CEC5: B9 C7 CC LDA  $CCC7,Y
$CEC8: 85 02    STA  $02
$CECA: 68       PLA  
$CECB: 4A       LSR  A
$CECC: 4A       LSR  A
$CECD: 4A       LSR  A
$CECE: A8       TAY  
$CECF: B9 2A CD LDA  $CD2A,Y
$CED2: 85 03    STA  $03
$CED4: 60       RTS  
$CED5: F8       SED  
$CED6: A0 70    LDY  #$70
$CED8: BD 00 20 LDA  $2000,X
$CEDB: 20 20 00 JSR  $0020
$CEDE: 00       BRK  
$CEDF: B5 1E    LDA  $1E,X
$CEE1: 29 20    AND  #$20
$CEE3: F0 08    BEQ  $CEED
$CEE5: A9 00    LDA  #$00
$CEE7: 9D C5 03 STA  $03C5,X
$CEEA: 4C 92 BF JMP  $BF92
$CEED: 20 02 BF JSR  $BF02
$CEF0: A0 0D    LDY  #$0D
$CEF2: A9 05    LDA  #$05
$CEF4: 20 96 BF JSR  $BF96
$CEF7: BD 34 04 LDA  $0434,X
$CEFA: 4A       LSR  A
$CEFB: 4A       LSR  A
$CEFC: 4A       LSR  A
$CEFD: 4A       LSR  A
$CEFE: A8       TAY  
$CEFF: B5 CF    LDA  $CF,X
$CF01: 38       SEC  
$CF02: F9 D5 CE SBC  $CED5,Y
$CF05: 10 05    BPL  $CF0C
$CF07: 49 FF    EOR  #$FF
$CF09: 18       CLC  
$CF0A: 69 01    ADC  #$01
$CF0C: C9          .byte $C9  ; غير معرّف
$CF0D: 08       PHP  
$CF0E: B0 0E    BCS  $CF1E
$CF10: BD 34 04 LDA  $0434,X
$CF13: 18       CLC  
$CF14: 69 10    ADC  #$10
$CF16: 9D 34 04 STA  $0434,X
$CF19: 4A       LSR  A
$CF1A: 4A       LSR  A
$CF1B: 4A       LSR  A
$CF1C: 4A       LSR  A
$CF1D: A8       TAY  
$CF1E: B9 DA CE LDA  $CEDA,Y
$CF21: 9D C5 03 STA  $03C5,X
$CF24: 60       RTS  
$CF25: 15 30    ORA  $30,X
$CF27: 40       RTI  
$CF28: B5 1E    LDA  $1E,X
$CF2A: 29 20    AND  #$20
$CF2C: F0 03    BEQ  $CF31
$CF2E: 4C 63 BF JMP  $BF63
$CF31: B5 1E    LDA  $1E,X
$CF33: F0 0B    BEQ  $CF40
$CF35: A9 00    LDA  #$00
$CF37: 95 A0    STA  $A0,X
$CF39: 8D CB 06 STA  $06CB
$CF3C: A9 10    LDA  #$10
$CF3E: D0 13    BNE  $CF53
$CF40: A9 12    LDA  #$12
$CF42: 8D CB 06 STA  $06CB
$CF45: A0 02    LDY  #$02
$CF47: B9 25 CF LDA  $CF25,Y
$CF4A: 99 01 00 STA  $0001,Y
$CF4D: 88       DEY  
$CF4E: 10 F7    BPL  $CF47
$CF50: 20 6C CF JSR  $CF6C
$CF53: 95 58    STA  $58,X
$CF55: A0 01    LDY  #$01
$CF57: B5 A0    LDA  $A0,X
$CF59: 29 01    AND  #$01
$CF5B: D0 0A    BNE  $CF67
$CF5D: B5 58    LDA  $58,X
$CF5F: 49 FF    EOR  #$FF
$CF61: 18       CLC  
$CF62: 69 01    ADC  #$01
$CF64: 95 58    STA  $58,X
$CF66: C8       INY  
$CF67: 94 46    STY  $46,X
$CF69: 4C 02 BF JMP  $BF02
$CF6C: A0 00    LDY  #$00
$CF6E: 20 43 E1 JSR  $E143
$CF71: 10 0A    BPL  $CF7D
$CF73: C8       INY  
$CF74: A5 00    LDA  $00
$CF76: 49 FF    EOR  #$FF
$CF78: 18       CLC  
$CF79: 69 01    ADC  #$01
$CF7B: 85 00    STA  $00
$CF7D: A5 00    LDA  $00
$CF7F: C9          .byte $C9  ; غير معرّف
$CF80: 3C          .byte $3C  ; غير معرّف
$CF81: 90 1C    BCC  $CF9F
$CF83: A9 3C    LDA  #$3C
$CF85: 85 00    STA  $00
$CF87: B5 16    LDA  $16,X
$CF89: C9          .byte $C9  ; غير معرّف
$CF8A: 11 D0    ORA  ($D0),Y
$CF8C: 12          .byte $12  ; غير معرّف
$CF8D: 98       TYA  
$CF8E: D5 A0    CMP  $A0,X
$CF90: F0 0D    BEQ  $CF9F
$CF92: B5 A0    LDA  $A0,X
$CF94: F0 06    BEQ  $CF9C
$CF96: D6 58    DEC  $58,X
$CF98: B5 58    LDA  $58,X
$CF9A: D0 40    BNE  $CFDC
$CF9C: 98       TYA  
$CF9D: 95 A0    STA  $A0,X
$CF9F: A5 00    LDA  $00
$CFA1: 29 3C    AND  #$3C
$CFA3: 4A       LSR  A
$CFA4: 4A       LSR  A
$CFA5: 85 00    STA  $00
$CFA7: A0 00    LDY  #$00
$CFA9: A5 57    LDA  $57
$CFAB: F0 24    BEQ  $CFD1
$CFAD: AD 75 07 LDA  $0775
$CFB0: F0 1F    BEQ  $CFD1
$CFB2: C8       INY  
$CFB3: A5 57    LDA  $57
$CFB5: C9          .byte $C9  ; غير معرّف
$CFB6: 19 90 08 ORA  $0890,Y
$CFB9: AD 75 07 LDA  $0775
$CFBC: C9          .byte $C9  ; غير معرّف
$CFBD: 02          .byte $02  ; غير معرّف
$CFBE: 90 01    BCC  $CFC1
$CFC0: C8       INY  
$CFC1: B5 16    LDA  $16,X
$CFC3: C9          .byte $C9  ; غير معرّف
$CFC4: 12          .byte $12  ; غير معرّف
$CFC5: D0 04    BNE  $CFCB
$CFC7: A5 57    LDA  $57
$CFC9: D0 06    BNE  $CFD1
$CFCB: B5 A0    LDA  $A0,X
$CFCD: D0 02    BNE  $CFD1
$CFCF: A0 00    LDY  #$00
$CFD1: B9 01 00 LDA  $0001,Y
$CFD4: A4 00    LDY  $00
$CFD6: 38       SEC  
$CFD7: E9 01    SBC  #$01
$CFD9: 88       DEY  
$CFDA: 10 FA    BPL  $CFD6
$CFDC: 60       RTS  
$CFDD: 1A          .byte $1A  ; غير معرّف
$CFDE: 58       CLI  
$CFDF: 98       TYA  
$CFE0: 96 94    STX  $94,Y
$CFE2: 92          .byte $92  ; غير معرّف
$CFE3: 90 8E    BCC  $CF73
$CFE5: 8C 8A 88 STY  $888A
$CFE8: 86 84    STX  $84
$CFEA: 82          .byte $82  ; غير معرّف
$CFEB: 80          .byte $80  ; غير معرّف
$CFEC: AE 68 03 LDX  $0368
$CFEF: B5 16    LDA  $16,X
$CFF1: C9          .byte $C9  ; غير معرّف
$CFF2: 2D D0 10 AND  $10D0
$CFF5: 86 08    STX  $08
$CFF7: B5 1E    LDA  $1E,X
$CFF9: F0 1A    BEQ  $D015
$CFFB: 29 40    AND  #$40
$CFFD: F0 06    BEQ  $D005
$CFFF: B5 CF    LDA  $CF,X
$D001: C9          .byte $C9  ; غير معرّف
$D002: E0 90    CPX  #$90
$D004: 0A       ASL  A
$D005: A9 80    LDA  #$80
$D007: 85 FC    STA  $FC
$D009: EE 72 07 INC  $0772
$D00C: 4C 71 D0 JMP  $D071
$D00F: 20 8C BF JSR  $BF8C
$D012: 4C 7B D1 JMP  $D17B
$D015: CE 64 03 DEC  $0364
$D018: D0 44    BNE  $D05E
$D01A: A9 04    LDA  #$04
$D01C: 8D 64 03 STA  $0364
$D01F: AD 63 03 LDA  $0363
$D022: 49 01    EOR  #$01
$D024: 8D 63 03 STA  $0363
$D027: A9 22    LDA  #$22
$D029: 85 05    STA  $05
$D02B: AC 69 03 LDY  $0369
$D02E: B9 DD CF LDA  $CFDD,Y
$D031: 85 04    STA  $04
$D033: AC 00 03 LDY  $0300
$D036: C8       INY  
$D037: A2 0C    LDX  #$0C
$D039: 20 CD 8A JSR  $8ACD
$D03C: A6 08    LDX  $08
$D03E: 20 8F 8A JSR  $8A8F
$D041: A9 08    LDA  #$08
$D043: 85 FE    STA  $FE
$D045: A9 01    LDA  #$01
$D047: 85 FD    STA  $FD
$D049: EE 69 03 INC  $0369
$D04C: AD 69 03 LDA  $0369
$D04F: C9          .byte $C9  ; غير معرّف
$D050: 0F          .byte $0F  ; غير معرّف
$D051: D0 0B    BNE  $D05E
$D053: 20 63 C3 JSR  $C363
$D056: A9 40    LDA  #$40
$D058: 95 1E    STA  $1E,X
$D05A: A9 80    LDA  #$80
$D05C: 85 FE    STA  $FE
$D05E: 4C 7B D1 JMP  $D17B
$D061: 21 41    AND  ($41,X)
$D063: 11 31    ORA  ($31),Y
$D065: B5 1E    LDA  $1E,X
$D067: 29 20    AND  #$20
$D069: F0 14    BEQ  $D07F
$D06B: B5 CF    LDA  $CF,X
$D06D: C9          .byte $C9  ; غير معرّف
$D06E: E0 90    CPX  #$90
$D070: 9E          .byte $9E  ; غير معرّف
$D071: A2 04    LDX  #$04
$D073: 20 98 C9 JSR  $C998
$D076: CA       DEX  
$D077: 10 FA    BPL  $D073
$D079: 8D CB 06 STA  $06CB
$D07C: A6 08    LDX  $08
$D07E: 60       RTS  
$D07F: A9 00    LDA  #$00
$D081: 8D CB 06 STA  $06CB
$D084: AD 47 07 LDA  $0747
$D087: F0 03    BEQ  $D08C
$D089: 4C 39 D1 JMP  $D139
$D08C: AD 63 03 LDA  $0363
$D08F: 10 03    BPL  $D094
$D091: 4C 0F D1 JMP  $D10F
$D094: CE 64 03 DEC  $0364
$D097: D0 0D    BNE  $D0A6
$D099: A9 20    LDA  #$20
$D09B: 8D 64 03 STA  $0364
$D09E: AD 63 03 LDA  $0363
$D0A1: 49 01    EOR  #$01
$D0A3: 8D 63 03 STA  $0363
$D0A6: A5 09    LDA  $09
$D0A8: 29 0F    AND  #$0F
$D0AA: D0 04    BNE  $D0B0
$D0AC: A9 02    LDA  #$02
$D0AE: 95 46    STA  $46,X
$D0B0: BD 8A 07 LDA  $078A,X
$D0B3: F0 1C    BEQ  $D0D1
$D0B5: 20 43 E1 JSR  $E143
$D0B8: 10 17    BPL  $D0D1
$D0BA: A9 01    LDA  #$01
$D0BC: 95 46    STA  $46,X
$D0BE: A9 02    LDA  #$02
$D0C0: 8D 65 03 STA  $0365
$D0C3: A9 20    LDA  #$20
$D0C5: 9D 8A 07 STA  $078A,X
$D0C8: 8D 90 07 STA  $0790
$D0CB: B5 87    LDA  $87,X
$D0CD: C9          .byte $C9  ; غير معرّف
$D0CE: C8       INY  
$D0CF: B0 3E    BCS  $D10F
$D0D1: A5 09    LDA  $09
$D0D3: 29 03    AND  #$03
$D0D5: D0 38    BNE  $D10F
$D0D7: B5 87    LDA  $87,X
$D0D9: CD 66 03 CMP  $0366
$D0DC: D0 0C    BNE  $D0EA
$D0DE: BD A7 07 LDA  $07A7,X
$D0E1: 29 03    AND  #$03
$D0E3: A8       TAY  
$D0E4: B9 61 D0 LDA  $D061,Y
$D0E7: 8D DC 06 STA  $06DC
$D0EA: B5 87    LDA  $87,X
$D0EC: 18       CLC  
$D0ED: 6D 65 03 ADC  $0365
$D0F0: 95 87    STA  $87,X
$D0F2: B4 46    LDY  $46,X
$D0F4: C0 01    CPY  #$01
$D0F6: F0 17    BEQ  $D10F
$D0F8: A0 FF    LDY  #$FF
$D0FA: 38       SEC  
$D0FB: ED 66 03 SBC  $0366
$D0FE: 10 07    BPL  $D107
$D100: 49 FF    EOR  #$FF
$D102: 18       CLC  
$D103: 69 01    ADC  #$01
$D105: A0 01    LDY  #$01
$D107: CD DC 06 CMP  $06DC
$D10A: 90 03    BCC  $D10F
$D10C: 8C 65 03 STY  $0365
$D10F: BD 8A 07 LDA  $078A,X
$D112: D0 28    BNE  $D13C
$D114: 20 8C BF JSR  $BF8C
$D117: AD 5F 07 LDA  $075F
$D11A: C9          .byte $C9  ; غير معرّف
$D11B: 05 90    ORA  $90
$D11D: 09 A5    ORA  #$A5
$D11F: 09 29    ORA  #$29
$D121: 03          .byte $03  ; غير معرّف
$D122: D0 03    BNE  $D127
$D124: 20 94 BA JSR  $BA94
$D127: B5 CF    LDA  $CF,X
$D129: C9          .byte $C9  ; غير معرّف
$D12A: 80          .byte $80  ; غير معرّف
$D12B: 90 1C    BCC  $D149
$D12D: BD A7 07 LDA  $07A7,X
$D130: 29 03    AND  #$03
$D132: A8       TAY  
$D133: B9 61 D0 LDA  $D061,Y
$D136: 9D 8A 07 STA  $078A,X
$D139: 4C 49 D1 JMP  $D149
$D13C: C9          .byte $C9  ; غير معرّف
$D13D: 01 D0    ORA  ($D0,X)
$D13F: 09 D6    ORA  #$D6
$D141: CF          .byte $CF  ; غير معرّف
$D142: 20 63 C3 JSR  $C363
$D145: A9 FE    LDA  #$FE
$D147: 95 A0    STA  $A0,X
$D149: AD 5F 07 LDA  $075F
$D14C: C9          .byte $C9  ; غير معرّف
$D14D: 07          .byte $07  ; غير معرّف
$D14E: F0 04    BEQ  $D154
$D150: C9          .byte $C9  ; غير معرّف
$D151: 05 B0    ORA  $B0
$D153: 27          .byte $27  ; غير معرّف
$D154: AD 90 07 LDA  $0790
$D157: D0 22    BNE  $D17B
$D159: A9 20    LDA  #$20
$D15B: 8D 90 07 STA  $0790
$D15E: AD 63 03 LDA  $0363
$D161: 49 80    EOR  #$80
$D163: 8D 63 03 STA  $0363
$D166: 30 E1    BMI  $D149
$D168: 20 D9 D1 JSR  $D1D9
$D16B: AC CC 06 LDY  $06CC
$D16E: F0 03    BEQ  $D173
$D170: 38       SEC  
$D171: E9 10    SBC  #$10
$D173: 8D 90 07 STA  $0790
$D176: A9 15    LDA  #$15
$D178: 8D CB 06 STA  $06CB
$D17B: 20 BC D1 JSR  $D1BC
$D17E: A0 10    LDY  #$10
$D180: B5 46    LDA  $46,X
$D182: 4A       LSR  A
$D183: 90 02    BCC  $D187
$D185: A0 F0    LDY  #$F0
$D187: 98       TYA  
$D188: 18       CLC  
$D189: 75 87    ADC  $87,X
$D18B: AC CF 06 LDY  $06CF
$D18E: 99 87 00 STA  $0087,Y
$D191: B5 CF    LDA  $CF,X
$D193: 18       CLC  
$D194: 69 08    ADC  #$08
$D196: 99 CF 00 STA  $00CF,Y
$D199: B5 1E    LDA  $1E,X
$D19B: 99 1E 00 STA  $001E,Y
$D19E: B5 46    LDA  $46,X
$D1A0: 99 46 00 STA  $0046,Y
$D1A3: A5 08    LDA  $08
$D1A5: 48       PHA  
$D1A6: AE CF 06 LDX  $06CF
$D1A9: 86 08    STX  $08
$D1AB: A9 2D    LDA  #$2D
$D1AD: 95 16    STA  $16,X
$D1AF: 20 BC D1 JSR  $D1BC
$D1B2: 68       PLA  
$D1B3: 85 08    STA  $08
$D1B5: AA       TAX  
$D1B6: A9 00    LDA  #$00
$D1B8: 8D 6A 03 STA  $036A
$D1BB: 60       RTS  
$D1BC: EE 6A 03 INC  $036A
$D1BF: 20 D7 C8 JSR  $C8D7
$D1C2: B5 1E    LDA  $1E,X
$D1C4: D0 F5    BNE  $D1BB
$D1C6: A9 0A    LDA  #$0A
$D1C8: 9D 9A 04 STA  $049A,X
$D1CB: 20 43 E2 JSR  $E243
$D1CE: 4C 53 D8 JMP  $D853
$D1D1: BF          .byte $BF  ; غير معرّف
$D1D2: 40       RTI  
$D1D3: BF          .byte $BF  ; غير معرّف
$D1D4: BF          .byte $BF  ; غير معرّف
$D1D5: BF          .byte $BF  ; غير معرّف
$D1D6: 40       RTI  
$D1D7: 40       RTI  
$D1D8: BF          .byte $BF  ; غير معرّف
$D1D9: AC 67 03 LDY  $0367
$D1DC: EE 67 03 INC  $0367
$D1DF: AD 67 03 LDA  $0367
$D1E2: 29 07    AND  #$07
$D1E4: 8D 67 03 STA  $0367
$D1E7: B9 D1 D1 LDA  $D1D1,Y
$D1EA: 60       RTS  
$D1EB: AD 47 07 LDA  $0747
$D1EE: D0 30    BNE  $D220
$D1F0: A9 40    LDA  #$40
$D1F2: AC CC 06 LDY  $06CC
$D1F5: F0 02    BEQ  $D1F9
$D1F7: A9 60    LDA  #$60
$D1F9: 85 00    STA  $00
$D1FB: BD 01 04 LDA  $0401,X
$D1FE: 38       SEC  
$D1FF: E5 00    SBC  $00
$D201: 9D 01 04 STA  $0401,X
$D204: B5 87    LDA  $87,X
$D206: E9 01    SBC  #$01
$D208: 95 87    STA  $87,X
$D20A: B5 6E    LDA  $6E,X
$D20C: E9 00    SBC  #$00
$D20E: 95 6E    STA  $6E,X
$D210: BC 17 04 LDY  $0417,X
$D213: B5 CF    LDA  $CF,X
$D215: D9 9D C5 CMP  $C59D,Y
$D218: F0 06    BEQ  $D220
$D21A: 18       CLC  
$D21B: 7D 34 04 ADC  $0434,X
$D21E: 95 CF    STA  $CF,X
$D220: 20 52 F1 JSR  $F152
$D223: B5 1E    LDA  $1E,X
$D225: D0 C3    BNE  $D1EA
$D227: A9 51    LDA  #$51
$D229: 85 00    STA  $00
$D22B: A0 02    LDY  #$02
$D22D: A5 09    LDA  $09
$D22F: 29 02    AND  #$02
$D231: F0 02    BEQ  $D235
$D233: A0 82    LDY  #$82
$D235: 84 01    STY  $01
$D237: BC E5 06 LDY  $06E5,X
$D23A: A2 00    LDX  #$00
$D23C: AD B9 03 LDA  $03B9
$D23F: 99 00 02 STA  $0200,Y
$D242: A5 00    LDA  $00
$D244: 99 01 02 STA  $0201,Y
$D247: E6 00    INC  $00
$D249: A5 01    LDA  $01
$D24B: 99 02 02 STA  $0202,Y
$D24E: AD AE 03 LDA  $03AE
$D251: 99 03 02 STA  $0203,Y
$D254: 18       CLC  
$D255: 69 08    ADC  #$08
$D257: 8D AE 03 STA  $03AE
$D25A: C8       INY  
$D25B: C8       INY  
$D25C: C8       INY  
$D25D: C8       INY  
$D25E: E8       INX  
$D25F: E0 03    CPX  #$03
$D261: 90 D9    BCC  $D23C
$D263: A6 08    LDX  $08
$D265: 20 AF F1 JSR  $F1AF
$D268: BC E5 06 LDY  $06E5,X
$D26B: AD D1 03 LDA  $03D1
$D26E: 4A       LSR  A
$D26F: 48       PHA  
$D270: 90 05    BCC  $D277
$D272: A9 F8    LDA  #$F8
$D274: 99 0C 02 STA  $020C,Y
$D277: 68       PLA  
$D278: 4A       LSR  A
$D279: 48       PHA  
$D27A: 90 05    BCC  $D281
$D27C: A9 F8    LDA  #$F8
$D27E: 99 08 02 STA  $0208,Y
$D281: 68       PLA  
$D282: 4A       LSR  A
$D283: 48       PHA  
$D284: 90 05    BCC  $D28B
$D286: A9 F8    LDA  #$F8
$D288: 99 04 02 STA  $0204,Y
$D28B: 68       PLA  
$D28C: 4A       LSR  A
$D28D: 90 05    BCC  $D294
$D28F: A9 F8    LDA  #$F8
$D291: 99 00 02 STA  $0200,Y
$D294: 60       RTS  
$D295: D6 A0    DEC  $A0,X
$D297: D0 0C    BNE  $D2A5
$D299: A9 08    LDA  #$08
$D29B: 95 A0    STA  $A0,X
$D29D: F6 58    INC  $58,X
$D29F: B5 58    LDA  $58,X
$D2A1: C9          .byte $C9  ; غير معرّف
$D2A2: 03          .byte $03  ; غير معرّف
$D2A3: B0 18    BCS  $D2BD
$D2A5: 20 52 F1 JSR  $F152
$D2A8: AD B9 03 LDA  $03B9
$D2AB: 8D BA 03 STA  $03BA
$D2AE: AD AE 03 LDA  $03AE
$D2B1: 8D AF 03 STA  $03AF
$D2B4: BC E5 06 LDY  $06E5,X
$D2B7: B5 58    LDA  $58,X
$D2B9: 20 17 ED JSR  $ED17
$D2BC: 60       RTS  
$D2BD: A9 00    LDA  #$00
$D2BF: 95 0F    STA  $0F,X
$D2C1: A9 08    LDA  #$08
$D2C3: 85 FE    STA  $FE
$D2C5: A9 05    LDA  #$05
$D2C7: 8D 38 01 STA  $0138
$D2CA: 4C 36 D3 JMP  $D336
$D2CD: 00       BRK  
$D2CE: 00       BRK  
$D2CF: 08       PHP  
$D2D0: 08       PHP  
$D2D1: 00       BRK  
$D2D2: 08       PHP  
$D2D3: 00       BRK  
$D2D4: 08       PHP  
$D2D5: 54          .byte $54  ; غير معرّف
$D2D6: 55 56    EOR  $56,X
$D2D8: 57          .byte $57  ; غير معرّف
$D2D9: A9 00    LDA  #$00
$D2DB: 8D CB 06 STA  $06CB
$D2DE: AD 46 07 LDA  $0746
$D2E1: C9          .byte $C9  ; غير معرّف
$D2E2: 05 B0    ORA  $B0
$D2E4: 2C 20 04 BIT  $0420
$D2E7: 8E 11 D3 STX  $D311
$D2EA: F2          .byte $F2  ; غير معرّف
$D2EB: D2          .byte $D2  ; غير معرّف
$D2EC: 12          .byte $12  ; غير معرّف
$D2ED: D3          .byte $D3  ; غير معرّف
$D2EE: 4E D3 A2 LSR  $A2D3
$D2F1: D3          .byte $D3  ; غير معرّف
$D2F2: A0 05    LDY  #$05
$D2F4: AD FA 07 LDA  $07FA
$D2F7: C9          .byte $C9  ; غير معرّف
$D2F8: 01 F0    ORA  ($F0,X)
$D2FA: 0E A0 03 ASL  $03A0
$D2FD: C9          .byte $C9  ; غير معرّف
$D2FE: 03          .byte $03  ; غير معرّف
$D2FF: F0 08    BEQ  $D309
$D301: A0 00    LDY  #$00
$D303: C9          .byte $C9  ; غير معرّف
$D304: 06 F0    ASL  $F0
$D306: 02          .byte $02  ; غير معرّف
$D307: A9 FF    LDA  #$FF
$D309: 8D D7 06 STA  $06D7
$D30C: 94 1E    STY  $1E,X
$D30E: EE 46 07 INC  $0746
$D311: 60       RTS  
$D312: AD F8 07 LDA  $07F8
$D315: 0D F9 07 ORA  $07F9
$D318: 0D FA 07 ORA  $07FA
$D31B: F0 F1    BEQ  $D30E
$D31D: A5 09    LDA  $09
$D31F: 29 04    AND  #$04
$D321: F0 04    BEQ  $D327
$D323: A9 10    LDA  #$10
$D325: 85 FE    STA  $FE
$D327: A0 23    LDY  #$23
$D329: A9 FF    LDA  #$FF
$D32B: 8D 39 01 STA  $0139
$D32E: 20 5F 8F JSR  $8F5F
$D331: A9 05    LDA  #$05
$D333: 8D 39 01 STA  $0139
$D336: A0 0B    LDY  #$0B
$D338: AD 53 07 LDA  $0753
$D33B: F0 02    BEQ  $D33F
$D33D: A0 11    LDY  #$11
$D33F: 20 5F 8F JSR  $8F5F
$D342: AD 53 07 LDA  $0753
$D345: 0A       ASL  A
$D346: 0A       ASL  A
$D347: 0A       ASL  A
$D348: 0A       ASL  A
$D349: 09 04    ORA  #$04
$D34B: 4C 36 BC JMP  $BC36
$D34E: B5 CF    LDA  $CF,X
$D350: C9          .byte $C9  ; غير معرّف
$D351: 72          .byte $72  ; غير معرّف
$D352: 90 05    BCC  $D359
$D354: D6 CF    DEC  $CF,X
$D356: 4C 65 D3 JMP  $D365
$D359: AD D7 06 LDA  $06D7
$D35C: F0 38    BEQ  $D396
$D35E: 30 36    BMI  $D396
$D360: A9 16    LDA  #$16
$D362: 8D CB 06 STA  $06CB
$D365: 20 52 F1 JSR  $F152
$D368: BC E5 06 LDY  $06E5,X
$D36B: A2 03    LDX  #$03
$D36D: AD B9 03 LDA  $03B9
$D370: 18       CLC  
$D371: 7D CD D2 ADC  $D2CD,X
$D374: 99 00 02 STA  $0200,Y
$D377: BD D5 D2 LDA  $D2D5,X
$D37A: 99 01 02 STA  $0201,Y
$D37D: A9 22    LDA  #$22
$D37F: 99 02 02 STA  $0202,Y
$D382: AD AE 03 LDA  $03AE
$D385: 18       CLC  
$D386: 7D D1 D2 ADC  $D2D1,X
$D389: 99 03 02 STA  $0203,Y
$D38C: C8       INY  
$D38D: C8       INY  
$D38E: C8       INY  
$D38F: C8       INY  
$D390: CA       DEX  
$D391: 10 DA    BPL  $D36D
$D393: A6 08    LDX  $08
$D395: 60       RTS  
$D396: 20 65 D3 JSR  $D365
$D399: A9 06    LDA  #$06
$D39B: 9D 96 07 STA  $0796,X
$D39E: EE 46 07 INC  $0746
$D3A1: 60       RTS  
$D3A2: 20 65 D3 JSR  $D365
$D3A5: BD 96 07 LDA  $0796,X
$D3A8: D0 05    BNE  $D3AF
$D3AA: AD B1 07 LDA  $07B1
$D3AD: F0 EF    BEQ  $D39E
$D3AF: 60       RTS  
$D3B0: B5 1E    LDA  $1E,X
$D3B2: D0 56    BNE  $D40A
$D3B4: BD 8A 07 LDA  $078A,X
$D3B7: D0 51    BNE  $D40A
$D3B9: B5 A0    LDA  $A0,X
$D3BB: D0 23    BNE  $D3E0
$D3BD: B5 58    LDA  $58,X
$D3BF: 30 14    BMI  $D3D5
$D3C1: 20 43 E1 JSR  $E143
$D3C4: 10 09    BPL  $D3CF
$D3C6: A5 00    LDA  $00
$D3C8: 49 FF    EOR  #$FF
$D3CA: 18       CLC  
$D3CB: 69 01    ADC  #$01
$D3CD: 85 00    STA  $00
$D3CF: A5 00    LDA  $00
$D3D1: C9          .byte $C9  ; غير معرّف
$D3D2: 21 90    AND  ($90,X)
$D3D4: 35 B5    AND  $B5,X
$D3D6: 58       CLI  
$D3D7: 49 FF    EOR  #$FF
$D3D9: 18       CLC  
$D3DA: 69 01    ADC  #$01
$D3DC: 95 58    STA  $58,X
$D3DE: F6 A0    INC  $A0,X
$D3E0: BD 34 04 LDA  $0434,X
$D3E3: B4 58    LDY  $58,X
$D3E5: 10 03    BPL  $D3EA
$D3E7: BD 17 04 LDA  $0417,X
$D3EA: 85 00    STA  $00
$D3EC: A5 09    LDA  $09
$D3EE: 4A       LSR  A
$D3EF: 90 19    BCC  $D40A
$D3F1: AD 47 07 LDA  $0747
$D3F4: D0 14    BNE  $D40A
$D3F6: B5 CF    LDA  $CF,X
$D3F8: 18       CLC  
$D3F9: 75 58    ADC  $58,X
$D3FB: 95 CF    STA  $CF,X
$D3FD: C5 00    CMP  $00
$D3FF: D0 09    BNE  $D40A
$D401: A9 00    LDA  #$00
$D403: 95 A0    STA  $A0,X
$D405: A9 40    LDA  #$40
$D407: 9D 8A 07 STA  $078A,X
$D40A: A9 20    LDA  #$20
$D40C: 9D C5 03 STA  $03C5,X
$D40F: 60       RTS  
$D410: 85 07    STA  $07
$D412: B5 34    LDA  $34,X
$D414: D0 0E    BNE  $D424
$D416: A0 18    LDY  #$18
$D418: B5 58    LDA  $58,X
$D41A: 18       CLC  
$D41B: 65 07    ADC  $07
$D41D: 95 58    STA  $58,X
$D41F: B5 A0    LDA  $A0,X
$D421: 69 00    ADC  #$00
$D423: 60       RTS  
$D424: A0 08    LDY  #$08
$D426: B5 58    LDA  $58,X
$D428: 38       SEC  
$D429: E5 07    SBC  $07
$D42B: 95 58    STA  $58,X
$D42D: B5 A0    LDA  $A0,X
$D42F: E9 00    SBC  #$00
$D431: 60       RTS  
$D432: B5 B6    LDA  $B6,X
$D434: C9          .byte $C9  ; غير معرّف
$D435: 03          .byte $03  ; غير معرّف
$D436: D0 03    BNE  $D43B
$D438: 4C 98 C9 JMP  $C998
$D43B: B5 1E    LDA  $1E,X
$D43D: 10 01    BPL  $D440
$D43F: 60       RTS  
$D440: A8       TAY  
$D441: BD A2 03 LDA  $03A2,X
$D444: 85 00    STA  $00
$D446: B5 46    LDA  $46,X
$D448: F0 03    BEQ  $D44D
$D44A: 4C BB D5 JMP  $D5BB
$D44D: A9 2D    LDA  #$2D
$D44F: D5 CF    CMP  $CF,X
$D451: 90 0F    BCC  $D462
$D453: C4 00    CPY  $00
$D455: F0 08    BEQ  $D45F
$D457: 18       CLC  
$D458: 69 02    ADC  #$02
$D45A: 95 CF    STA  $CF,X
$D45C: 4C B1 D5 JMP  $D5B1
$D45F: 4C 98 D5 JMP  $D598
$D462: D9 CF 00 CMP  $00CF,Y
$D465: 90 0D    BCC  $D474
$D467: E4 00    CPX  $00
$D469: F0 F4    BEQ  $D45F
$D46B: 18       CLC  
$D46C: 69 02    ADC  #$02
$D46E: 99 CF 00 STA  $00CF,Y
$D471: 4C B1 D5 JMP  $D5B1
$D474: B5 CF    LDA  $CF,X
$D476: 48       PHA  
$D477: BD A2 03 LDA  $03A2,X
$D47A: 10 18    BPL  $D494
$D47C: BD 34 04 LDA  $0434,X
$D47F: 18       CLC  
$D480: 69 05    ADC  #$05
$D482: 85 00    STA  $00
$D484: B5 A0    LDA  $A0,X
$D486: 69 00    ADC  #$00
$D488: 30 1A    BMI  $D4A4
$D48A: D0 0C    BNE  $D498
$D48C: A5 00    LDA  $00
$D48E: C9          .byte $C9  ; غير معرّف
$D48F: 0B          .byte $0B  ; غير معرّف
$D490: 90 0C    BCC  $D49E
$D492: B0 04    BCS  $D498
$D494: C5 08    CMP  $08
$D496: F0 0C    BEQ  $D4A4
$D498: 20 B7 BF JSR  $BFB7
$D49B: 4C A7 D4 JMP  $D4A7
$D49E: 20 B1 D5 JSR  $D5B1
$D4A1: 4C A7 D4 JMP  $D4A7
$D4A4: 20 B4 BF JSR  $BFB4
$D4A7: B4 1E    LDY  $1E,X
$D4A9: 68       PLA  
$D4AA: 38       SEC  
$D4AB: F5 CF    SBC  $CF,X
$D4AD: 18       CLC  
$D4AE: 79 CF 00 ADC  $00CF,Y
$D4B1: 99 CF 00 STA  $00CF,Y
$D4B4: BD A2 03 LDA  $03A2,X
$D4B7: 30 04    BMI  $D4BD
$D4B9: AA       TAX  
$D4BA: 20 21 DC JSR  $DC21
$D4BD: A4 08    LDY  $08
$D4BF: B9 A0 00 LDA  $00A0,Y
$D4C2: 19 34 04 ORA  $0434,Y
$D4C5: F0 77    BEQ  $D53E
$D4C7: AE 00 03 LDX  $0300
$D4CA: E0 20    CPX  #$20
$D4CC: B0 70    BCS  $D53E
$D4CE: B9 A0 00 LDA  $00A0,Y
$D4D1: 48       PHA  
$D4D2: 48       PHA  
$D4D3: 20 41 D5 JSR  $D541
$D4D6: A5 01    LDA  $01
$D4D8: 9D 01 03 STA  $0301,X
$D4DB: A5 00    LDA  $00
$D4DD: 9D 02 03 STA  $0302,X
$D4E0: A9 02    LDA  #$02
$D4E2: 9D 03 03 STA  $0303,X
$D4E5: B9 A0 00 LDA  $00A0,Y
$D4E8: 30 0D    BMI  $D4F7
$D4EA: A9 A2    LDA  #$A2
$D4EC: 9D 04 03 STA  $0304,X
$D4EF: A9 A3    LDA  #$A3
$D4F1: 9D 05 03 STA  $0305,X
$D4F4: 4C FF D4 JMP  $D4FF
$D4F7: A9 24    LDA  #$24
$D4F9: 9D 04 03 STA  $0304,X
$D4FC: 9D 05 03 STA  $0305,X
$D4FF: B9 1E 00 LDA  $001E,Y
$D502: A8       TAY  
$D503: 68       PLA  
$D504: 49 FF    EOR  #$FF
$D506: 20 41 D5 JSR  $D541
$D509: A5 01    LDA  $01
$D50B: 9D 06 03 STA  $0306,X
$D50E: A5 00    LDA  $00
$D510: 9D 07 03 STA  $0307,X
$D513: A9 02    LDA  #$02
$D515: 9D 08 03 STA  $0308,X
$D518: 68       PLA  
$D519: 10 0D    BPL  $D528
$D51B: A9 A2    LDA  #$A2
$D51D: 9D 09 03 STA  $0309,X
$D520: A9 A3    LDA  #$A3
$D522: 9D 0A 03 STA  $030A,X
$D525: 4C 30 D5 JMP  $D530
$D528: A9 24    LDA  #$24
$D52A: 9D 09 03 STA  $0309,X
$D52D: 9D 0A 03 STA  $030A,X
$D530: A9 00    LDA  #$00
$D532: 9D 0B 03 STA  $030B,X
$D535: AD 00 03 LDA  $0300
$D538: 18       CLC  
$D539: 69 0A    ADC  #$0A
$D53B: 8D 00 03 STA  $0300
$D53E: A6 08    LDX  $08
$D540: 60       RTS  
$D541: 48       PHA  
$D542: B9 87 00 LDA  $0087,Y
$D545: 18       CLC  
$D546: 69 08    ADC  #$08
$D548: AE CC 06 LDX  $06CC
$D54B: D0 03    BNE  $D550
$D54D: 18       CLC  
$D54E: 69 10    ADC  #$10
$D550: 48       PHA  
$D551: B9 6E 00 LDA  $006E,Y
$D554: 69 00    ADC  #$00
$D556: 85 02    STA  $02
$D558: 68       PLA  
$D559: 29 F0    AND  #$F0
$D55B: 4A       LSR  A
$D55C: 4A       LSR  A
$D55D: 4A       LSR  A
$D55E: 85 00    STA  $00
$D560: B6 CF    LDX  $CF,Y
$D562: 68       PLA  
$D563: 10 05    BPL  $D56A
$D565: 8A       TXA  
$D566: 18       CLC  
$D567: 69 08    ADC  #$08
$D569: AA       TAX  
$D56A: 8A       TXA  
$D56B: AE 00 03 LDX  $0300
$D56E: 0A       ASL  A
$D56F: 2A       ROL  A
$D570: 48       PHA  
$D571: 2A       ROL  A
$D572: 29 03    AND  #$03
$D574: 09 20    ORA  #$20
$D576: 85 01    STA  $01
$D578: A5 02    LDA  $02
$D57A: 29 01    AND  #$01
$D57C: 0A       ASL  A
$D57D: 0A       ASL  A
$D57E: 05 01    ORA  $01
$D580: 85 01    STA  $01
$D582: 68       PLA  
$D583: 29 E0    AND  #$E0
$D585: 18       CLC  
$D586: 65 00    ADC  $00
$D588: 85 00    STA  $00
$D58A: B9 CF 00 LDA  $00CF,Y
$D58D: C9          .byte $C9  ; غير معرّف
$D58E: E8       INX  
$D58F: 90 06    BCC  $D597
$D591: A5 00    LDA  $00
$D593: 29 BF    AND  #$BF
$D595: 85 00    STA  $00
$D597: 60       RTS  
$D598: 98       TYA  
$D599: AA       TAX  
$D59A: 20 AF F1 JSR  $F1AF
$D59D: A9 06    LDA  #$06
$D59F: 20 11 DA JSR  $DA11
$D5A2: AD AD 03 LDA  $03AD
$D5A5: 9D 17 01 STA  $0117,X
$D5A8: A5 CE    LDA  $CE
$D5AA: 9D 1E 01 STA  $011E,X
$D5AD: A9 01    LDA  #$01
$D5AF: 95 46    STA  $46,X
$D5B1: 20 63 C3 JSR  $C363
$D5B4: 99 A0 00 STA  $00A0,Y
$D5B7: 99 34 04 STA  $0434,Y
$D5BA: 60       RTS  
$D5BB: 98       TYA  
$D5BC: 48       PHA  
$D5BD: 20 6B BF JSR  $BF6B
$D5C0: 68       PLA  
$D5C1: AA       TAX  
$D5C2: 20 6B BF JSR  $BF6B
$D5C5: A6 08    LDX  $08
$D5C7: BD A2 03 LDA  $03A2,X
$D5CA: 30 04    BMI  $D5D0
$D5CC: AA       TAX  
$D5CD: 20 21 DC JSR  $DC21
$D5D0: A6 08    LDX  $08
$D5D2: 60       RTS  
$D5D3: B5 A0    LDA  $A0,X
$D5D5: 1D 34 04 ORA  $0434,X
$D5D8: D0 15    BNE  $D5EF
$D5DA: 9D 17 04 STA  $0417,X
$D5DD: B5 CF    LDA  $CF,X
$D5DF: DD 01 04 CMP  $0401,X
$D5E2: B0 0B    BCS  $D5EF
$D5E4: A5 09    LDA  $09
$D5E6: 29 07    AND  #$07
$D5E8: D0 02    BNE  $D5EC
$D5EA: F6 CF    INC  $CF,X
$D5EC: 4C FE D5 JMP  $D5FE
$D5EF: B5 CF    LDA  $CF,X
$D5F1: D5 58    CMP  $58,X
$D5F3: 90 06    BCC  $D5FB
$D5F5: 20 B7 BF JSR  $BFB7
$D5F8: 4C FE D5 JMP  $D5FE
$D5FB: 20 B4 BF JSR  $BFB4
$D5FE: BD A2 03 LDA  $03A2,X
$D601: 30 03    BMI  $D606
$D603: 20 21 DC JSR  $DC21
$D606: 60       RTS  
$D607: A9 0E    LDA  #$0E
$D609: 20 47 CB JSR  $CB47
$D60C: 20 66 CB JSR  $CB66
$D60F: BD A2 03 LDA  $03A2,X
$D612: 30 1C    BMI  $D630
$D614: A5 86    LDA  $86
$D616: 18       CLC  
$D617: 65 00    ADC  $00
$D619: 85 86    STA  $86
$D61B: A5 6D    LDA  $6D
$D61D: A4 00    LDY  $00
$D61F: 30 05    BMI  $D626
$D621: 69 00    ADC  #$00
$D623: 4C 28 D6 JMP  $D628
$D626: E9 00    SBC  #$00
$D628: 85 6D    STA  $6D
$D62A: 8C A1 03 STY  $03A1
$D62D: 20 21 DC JSR  $DC21
$D630: 60       RTS  
$D631: BD A2 03 LDA  $03A2,X
$D634: 30 06    BMI  $D63C
$D636: 20 88 BF JSR  $BF88
$D639: 20 21 DC JSR  $DC21
$D63C: 60       RTS  
$D63D: 20 02 BF JSR  $BF02
$D640: 85 00    STA  $00
$D642: BD A2 03 LDA  $03A2,X
$D645: 30 07    BMI  $D64E
$D647: A9 10    LDA  #$10
$D649: 95 58    STA  $58,X
$D64B: 20 14 D6 JSR  $D614
$D64E: 60       RTS  
$D64F: 20 5B D6 JSR  $D65B
$D652: 4C FE D5 JMP  $D5FE
$D655: 20 5B D6 JSR  $D65B
$D658: 4C 71 D6 JMP  $D671
$D65B: AD 47 07 LDA  $0747
$D65E: D0 19    BNE  $D679
$D660: BD 17 04 LDA  $0417,X
$D663: 18       CLC  
$D664: 7D 34 04 ADC  $0434,X
$D667: 9D 17 04 STA  $0417,X
$D66A: B5 CF    LDA  $CF,X
$D66C: 75 A0    ADC  $A0,X
$D66E: 95 CF    STA  $CF,X
$D670: 60       RTS  
$D671: BD A2 03 LDA  $03A2,X
$D674: F0 03    BEQ  $D679
$D676: 20 19 DC JSR  $DC19
$D679: 60       RTS  
$D67A: B5 16    LDA  $16,X
$D67C: C9          .byte $C9  ; غير معرّف
$D67D: 14          .byte $14  ; غير معرّف
$D67E: F0 55    BEQ  $D6D5
$D680: AD 1C 07 LDA  $071C
$D683: B4 16    LDY  $16,X
$D685: C0 05    CPY  #$05
$D687: F0 04    BEQ  $D68D
$D689: C0 0D    CPY  #$0D
$D68B: D0 02    BNE  $D68F
$D68D: 69 38    ADC  #$38
$D68F: E9 48    SBC  #$48
$D691: 85 01    STA  $01
$D693: AD 1A 07 LDA  $071A
$D696: E9 00    SBC  #$00
$D698: 85 00    STA  $00
$D69A: AD 1D 07 LDA  $071D
$D69D: 69 48    ADC  #$48
$D69F: 85 03    STA  $03
$D6A1: AD 1B 07 LDA  $071B
$D6A4: 69 00    ADC  #$00
$D6A6: 85 02    STA  $02
$D6A8: B5 87    LDA  $87,X
$D6AA: C5 01    CMP  $01
$D6AC: B5 6E    LDA  $6E,X
$D6AE: E5 00    SBC  $00
$D6B0: 30 20    BMI  $D6D2
$D6B2: B5 87    LDA  $87,X
$D6B4: C5 03    CMP  $03
$D6B6: B5 6E    LDA  $6E,X
$D6B8: E5 02    SBC  $02
$D6BA: 30 19    BMI  $D6D5
$D6BC: B5 1E    LDA  $1E,X
$D6BE: C9          .byte $C9  ; غير معرّف
$D6BF: 05 F0    ORA  $F0
$D6C1: 13          .byte $13  ; غير معرّف
$D6C2: C0 0D    CPY  #$0D
$D6C4: F0 0F    BEQ  $D6D5
$D6C6: C0 30    CPY  #$30
$D6C8: F0 0B    BEQ  $D6D5
$D6CA: C0 31    CPY  #$31
$D6CC: F0 07    BEQ  $D6D5
$D6CE: C0 32    CPY  #$32
$D6D0: F0 03    BEQ  $D6D5
$D6D2: 20 98 C9 JSR  $C998
$D6D5: 60       RTS  
$D6D6: FF          .byte $FF  ; غير معرّف
$D6D7: FF          .byte $FF  ; غير معرّف
$D6D8: FF          .byte $FF  ; غير معرّف
$D6D9: B5 24    LDA  $24,X
$D6DB: F0 56    BEQ  $D733
$D6DD: 0A       ASL  A
$D6DE: B0 53    BCS  $D733
$D6E0: A5 09    LDA  $09
$D6E2: 4A       LSR  A
$D6E3: B0 4E    BCS  $D733
$D6E5: 8A       TXA  
$D6E6: 0A       ASL  A
$D6E7: 0A       ASL  A
$D6E8: 18       CLC  
$D6E9: 69 1C    ADC  #$1C
$D6EB: A8       TAY  
$D6EC: A2 04    LDX  #$04
$D6EE: 86 01    STX  $01
$D6F0: 98       TYA  
$D6F1: 48       PHA  
$D6F2: B5 1E    LDA  $1E,X
$D6F4: 29 20    AND  #$20
$D6F6: D0 34    BNE  $D72C
$D6F8: B5 0F    LDA  $0F,X
$D6FA: F0 30    BEQ  $D72C
$D6FC: B5 16    LDA  $16,X
$D6FE: C9          .byte $C9  ; غير معرّف
$D6FF: 24 90    BIT  $90
$D701: 04          .byte $04  ; غير معرّف
$D702: C9          .byte $C9  ; غير معرّف
$D703: 2B          .byte $2B  ; غير معرّف
$D704: 90 26    BCC  $D72C
$D706: C9          .byte $C9  ; غير معرّف
$D707: 06 D0    ASL  $D0
$D709: 06 B5    ASL  $B5
$D70B: 1E C9 02 ASL  $02C9,X
$D70E: B0 1C    BCS  $D72C
$D710: BD D8 03 LDA  $03D8,X
$D713: D0 17    BNE  $D72C
$D715: 8A       TXA  
$D716: 0A       ASL  A
$D717: 0A       ASL  A
$D718: 18       CLC  
$D719: 69 04    ADC  #$04
$D71B: AA       TAX  
$D71C: 20 27 E3 JSR  $E327
$D71F: A6 08    LDX  $08
$D721: 90 09    BCC  $D72C
$D723: A9 80    LDA  #$80
$D725: 95 24    STA  $24,X
$D727: A6 01    LDX  $01
$D729: 20 3E D7 JSR  $D73E
$D72C: 68       PLA  
$D72D: A8       TAY  
$D72E: A6 01    LDX  $01
$D730: CA       DEX  
$D731: 10 BB    BPL  $D6EE
$D733: A6 08    LDX  $08
$D735: 60       RTS  
$D736: 06 00    ASL  $00
$D738: 02          .byte $02  ; غير معرّف
$D739: 12          .byte $12  ; غير معرّف
$D73A: 11 07    ORA  ($07),Y
$D73C: 05 2D    ORA  $2D
$D73E: 20 52 F1 JSR  $F152
$D741: A6 01    LDX  $01
$D743: B5 0F    LDA  $0F,X
$D745: 10 0B    BPL  $D752
$D747: 29 0F    AND  #$0F
$D749: AA       TAX  
$D74A: B5 16    LDA  $16,X
$D74C: C9          .byte $C9  ; غير معرّف
$D74D: 2D F0 0C AND  $0CF0
$D750: A6 01    LDX  $01
$D752: B5 16    LDA  $16,X
$D754: C9          .byte $C9  ; غير معرّف
$D755: 02          .byte $02  ; غير معرّف
$D756: F0 6B    BEQ  $D7C3
$D758: C9          .byte $C9  ; غير معرّف
$D759: 2D D0 2D AND  $2DD0
$D75C: CE 83 04 DEC  $0483
$D75F: D0 62    BNE  $D7C3
$D761: 20 63 C3 JSR  $C363
$D764: 95 58    STA  $58,X
$D766: 8D CB 06 STA  $06CB
$D769: A9 FE    LDA  #$FE
$D76B: 95 A0    STA  $A0,X
$D76D: AC 5F 07 LDY  $075F
$D770: B9 36 D7 LDA  $D736,Y
$D773: 95 16    STA  $16,X
$D775: A9 20    LDA  #$20
$D777: C0 03    CPY  #$03
$D779: B0 02    BCS  $D77D
$D77B: 09 03    ORA  #$03
$D77D: 95 1E    STA  $1E,X
$D77F: A9 80    LDA  #$80
$D781: 85 FE    STA  $FE
$D783: A6 01    LDX  $01
$D785: A9 09    LDA  #$09
$D787: D0 33    BNE  $D7BC
$D789: C9          .byte $C9  ; غير معرّف
$D78A: 08       PHP  
$D78B: F0 36    BEQ  $D7C3
$D78D: C9          .byte $C9  ; غير معرّف
$D78E: 0C          .byte $0C  ; غير معرّف
$D78F: F0 32    BEQ  $D7C3
$D791: C9          .byte $C9  ; غير معرّف
$D792: 15 B0    ORA  $B0,X
$D794: 2E B5 16 ROL  $16B5
$D797: C9          .byte $C9  ; غير معرّف
$D798: 0D D0 06 ORA  $06D0
$D79B: B5 CF    LDA  $CF,X
$D79D: 69 18    ADC  #$18
$D79F: 95 CF    STA  $CF,X
$D7A1: 20 1B E0 JSR  $E01B
$D7A4: B5 1E    LDA  $1E,X
$D7A6: 29 1F    AND  #$1F
$D7A8: 09 20    ORA  #$20
$D7AA: 95 1E    STA  $1E,X
$D7AC: A9 02    LDA  #$02
$D7AE: B4 16    LDY  $16,X
$D7B0: C0 05    CPY  #$05
$D7B2: D0 02    BNE  $D7B6
$D7B4: A9 06    LDA  #$06
$D7B6: C0 06    CPY  #$06
$D7B8: D0 02    BNE  $D7BC
$D7BA: A9 01    LDA  #$01
$D7BC: 20 11 DA JSR  $DA11
$D7BF: A9 08    LDA  #$08
$D7C1: 85 FF    STA  $FF
$D7C3: 60       RTS  
$D7C4: A5 09    LDA  $09
$D7C6: 4A       LSR  A
$D7C7: 90 36    BCC  $D7FF
$D7C9: AD 47 07 LDA  $0747
$D7CC: 0D D6 03 ORA  $03D6
$D7CF: D0 2E    BNE  $D7FF
$D7D1: 8A       TXA  
$D7D2: 0A       ASL  A
$D7D3: 0A       ASL  A
$D7D4: 18       CLC  
$D7D5: 69 24    ADC  #$24
$D7D7: A8       TAY  
$D7D8: 20 25 E3 JSR  $E325
$D7DB: A6 08    LDX  $08
$D7DD: 90 1B    BCC  $D7FA
$D7DF: BD BE 06 LDA  $06BE,X
$D7E2: D0 1B    BNE  $D7FF
$D7E4: A9 01    LDA  #$01
$D7E6: 9D BE 06 STA  $06BE,X
$D7E9: B5 64    LDA  $64,X
$D7EB: 49 FF    EOR  #$FF
$D7ED: 18       CLC  
$D7EE: 69 01    ADC  #$01
$D7F0: 95 64    STA  $64,X
$D7F2: AD 9F 07 LDA  $079F
$D7F5: D0 08    BNE  $D7FF
$D7F7: 4C 2C D9 JMP  $D92C
$D7FA: A9 00    LDA  #$00
$D7FC: 9D BE 06 STA  $06BE,X
$D7FF: 60       RTS  
$D800: 20 98 C9 JSR  $C998
$D803: A9 06    LDA  #$06
$D805: 20 11 DA JSR  $DA11
$D808: A9 20    LDA  #$20
$D80A: 85 FE    STA  $FE
$D80C: A5 39    LDA  $39
$D80E: C9          .byte $C9  ; غير معرّف
$D80F: 02          .byte $02  ; غير معرّف
$D810: 90 0E    BCC  $D820
$D812: C9          .byte $C9  ; غير معرّف
$D813: 03          .byte $03  ; غير معرّف
$D814: F0 24    BEQ  $D83A
$D816: A9 23    LDA  #$23
$D818: 8D 9F 07 STA  $079F
$D81B: A9 40    LDA  #$40
$D81D: 85 FB    STA  $FB
$D81F: 60       RTS  
$D820: AD 56 07 LDA  $0756
$D823: F0 1B    BEQ  $D840
$D825: C9          .byte $C9  ; غير معرّف
$D826: 01 D0    ORA  ($D0,X)
$D828: 23          .byte $23  ; غير معرّف
$D829: A6 08    LDX  $08
$D82B: A9 02    LDA  #$02
$D82D: 8D 56 07 STA  $0756
$D830: 20 F1 85 JSR  $85F1
$D833: A6 08    LDX  $08
$D835: A9 0C    LDA  #$0C
$D837: 4C 47 D8 JMP  $D847
$D83A: A9 0B    LDA  #$0B
$D83C: 9D 10 01 STA  $0110,X
$D83F: 60       RTS  
$D840: A9 01    LDA  #$01
$D842: 8D 56 07 STA  $0756
$D845: A9 09    LDA  #$09
$D847: A0 00    LDY  #$00
$D849: 20 48 D9 JSR  $D948
$D84C: 60       RTS  
$D84D: 18       CLC  
$D84E: E8       INX  
$D84F: 30 D0    BMI  $D821
$D851: 08       PHP  
$D852: F8       SED  
$D853: A5 09    LDA  $09
$D855: 4A       LSR  A
$D856: B0 F4    BCS  $D84C
$D858: 20 41 DC JSR  $DC41
$D85B: B0 23    BCS  $D880
$D85D: BD D8 03 LDA  $03D8,X
$D860: D0 1E    BNE  $D880
$D862: A5 0E    LDA  $0E
$D864: C9          .byte $C9  ; غير معرّف
$D865: 08       PHP  
$D866: D0 18    BNE  $D880
$D868: B5 1E    LDA  $1E,X
$D86A: 29 20    AND  #$20
$D86C: D0 12    BNE  $D880
$D86E: 20 52 DC JSR  $DC52
$D871: 20 25 E3 JSR  $E325
$D874: A6 08    LDX  $08
$D876: B0 09    BCS  $D881
$D878: BD 91 04 LDA  $0491,X
$D87B: 29 FE    AND  #$FE
$D87D: 9D 91 04 STA  $0491,X
$D880: 60       RTS  
$D881: B4 16    LDY  $16,X
$D883: C0 2E    CPY  #$2E
$D885: D0 03    BNE  $D88A
$D887: 4C 00 D8 JMP  $D800
$D88A: AD 9F 07 LDA  $079F
$D88D: F0 06    BEQ  $D895
$D88F: 4C 95 D7 JMP  $D795
$D892: 0A       ASL  A
$D893: 06 04    ASL  $04
$D895: BD 91 04 LDA  $0491,X
$D898: 29 01    AND  #$01
$D89A: 1D D8 03 ORA  $03D8,X
$D89D: D0 59    BNE  $D8F8
$D89F: A9 01    LDA  #$01
$D8A1: 1D 91 04 ORA  $0491,X
$D8A4: 9D 91 04 STA  $0491,X
$D8A7: C0 12    CPY  #$12
$D8A9: F0 4E    BEQ  $D8F9
$D8AB: C0 0D    CPY  #$0D
$D8AD: F0 7D    BEQ  $D92C
$D8AF: C0 0C    CPY  #$0C
$D8B1: F0 79    BEQ  $D92C
$D8B3: C0 33    CPY  #$33
$D8B5: F0 42    BEQ  $D8F9
$D8B7: C0 15    CPY  #$15
$D8B9: B0 71    BCS  $D92C
$D8BB: AD 4E 07 LDA  $074E
$D8BE: F0 6C    BEQ  $D92C
$D8C0: B5 1E    LDA  $1E,X
$D8C2: 0A       ASL  A
$D8C3: B0 34    BCS  $D8F9
$D8C5: B5 1E    LDA  $1E,X
$D8C7: 29 07    AND  #$07
$D8C9: C9          .byte $C9  ; غير معرّف
$D8CA: 02          .byte $02  ; غير معرّف
$D8CB: 90 2C    BCC  $D8F9
$D8CD: B5 16    LDA  $16,X
$D8CF: C9          .byte $C9  ; غير معرّف
$D8D0: 06 F0    ASL  $F0
$D8D2: 25 A9    AND  $A9
$D8D4: 08       PHP  
$D8D5: 85 FF    STA  $FF
$D8D7: B5 1E    LDA  $1E,X
$D8D9: 09 80    ORA  #$80
$D8DB: 95 1E    STA  $1E,X
$D8DD: 20 05 DA JSR  $DA05
$D8E0: B9 4F D8 LDA  $D84F,Y
$D8E3: 95 58    STA  $58,X
$D8E5: A9 03    LDA  #$03
$D8E7: 18       CLC  
$D8E8: 6D 84 04 ADC  $0484
$D8EB: BC 96 07 LDY  $0796,X
$D8EE: C0 03    CPY  #$03
$D8F0: B0 03    BCS  $D8F5
$D8F2: B9 92 D8 LDA  $D892,Y
$D8F5: 20 11 DA JSR  $DA11
$D8F8: 60       RTS  
$D8F9: A5 9F    LDA  $9F
$D8FB: 30 02    BMI  $D8FF
$D8FD: D0 6A    BNE  $D969
$D8FF: B5 16    LDA  $16,X
$D901: C9          .byte $C9  ; غير معرّف
$D902: 07          .byte $07  ; غير معرّف
$D903: 90 09    BCC  $D90E
$D905: A5 CE    LDA  $CE
$D907: 18       CLC  
$D908: 69 0C    ADC  #$0C
$D90A: D5 CF    CMP  $CF,X
$D90C: 90 5B    BCC  $D969
$D90E: AD 91 07 LDA  $0791
$D911: D0 56    BNE  $D969
$D913: AD 9E 07 LDA  $079E
$D916: D0 3D    BNE  $D955
$D918: AD AD 03 LDA  $03AD
$D91B: CD AE 03 CMP  $03AE
$D91E: 90 03    BCC  $D923
$D920: 4C F6 D9 JMP  $D9F6
$D923: B5 46    LDA  $46,X
$D925: C9          .byte $C9  ; غير معرّف
$D926: 01 D0    ORA  ($D0,X)
$D928: 03          .byte $03  ; غير معرّف
$D929: 4C FF D9 JMP  $D9FF
$D92C: AD 9E 07 LDA  $079E
$D92F: D0 24    BNE  $D955
$D931: AE 56 07 LDX  $0756
$D934: F0 22    BEQ  $D958
$D936: 8D 56 07 STA  $0756
$D939: A9 08    LDA  #$08
$D93B: 8D 9E 07 STA  $079E
$D93E: 0A       ASL  A
$D93F: 85 FF    STA  $FF
$D941: 20 F1 85 JSR  $85F1
$D944: A9 0A    LDA  #$0A
$D946: A0 01    LDY  #$01
$D948: 85 0E    STA  $0E
$D94A: 84 1D    STY  $1D
$D94C: A0 FF    LDY  #$FF
$D94E: 8C 47 07 STY  $0747
$D951: C8       INY  
$D952: 8C 75 07 STY  $0775
$D955: A6 08    LDX  $08
$D957: 60       RTS  
$D958: 86 57    STX  $57
$D95A: E8       INX  
$D95B: 86 FC    STX  $FC
$D95D: A9 FC    LDA  #$FC
$D95F: 85 9F    STA  $9F
$D961: A9 0B    LDA  #$0B
$D963: D0 E1    BNE  $D946
$D965: 02          .byte $02  ; غير معرّف
$D966: 06 05    ASL  $05
$D968: 06 B5    ASL  $B5
$D96A: 16 C9    ASL  $C9,X
$D96C: 12          .byte $12  ; غير معرّف
$D96D: F0 BD    BEQ  $D92C
$D96F: A9 04    LDA  #$04
$D971: 85 FF    STA  $FF
$D973: B5 16    LDA  $16,X
$D975: A0 00    LDY  #$00
$D977: C9          .byte $C9  ; غير معرّف
$D978: 14          .byte $14  ; غير معرّف
$D979: F0 1B    BEQ  $D996
$D97B: C9          .byte $C9  ; غير معرّف
$D97C: 08       PHP  
$D97D: F0 17    BEQ  $D996
$D97F: C9          .byte $C9  ; غير معرّف
$D980: 33          .byte $33  ; غير معرّف
$D981: F0 13    BEQ  $D996
$D983: C9          .byte $C9  ; غير معرّف
$D984: 0C          .byte $0C  ; غير معرّف
$D985: F0 0F    BEQ  $D996
$D987: C8       INY  
$D988: C9          .byte $C9  ; غير معرّف
$D989: 05 F0    ORA  $F0
$D98B: 0A       ASL  A
$D98C: C8       INY  
$D98D: C9          .byte $C9  ; غير معرّف
$D98E: 11 F0    ORA  ($F0),Y
$D990: 05 C8    ORA  $C8
$D992: C9          .byte $C9  ; غير معرّف
$D993: 07          .byte $07  ; غير معرّف
$D994: D0 1D    BNE  $D9B3
$D996: B9 65 D9 LDA  $D965,Y
$D999: 20 11 DA JSR  $DA11
$D99C: B5 46    LDA  $46,X
$D99E: 48       PHA  
$D99F: 20 2F E0 JSR  $E02F
$D9A2: 68       PLA  
$D9A3: 95 46    STA  $46,X
$D9A5: A9 20    LDA  #$20
$D9A7: 95 1E    STA  $1E,X
$D9A9: 20 63 C3 JSR  $C363
$D9AC: 95 58    STA  $58,X
$D9AE: A9 FD    LDA  #$FD
$D9B0: 85 9F    STA  $9F
$D9B2: 60       RTS  
$D9B3: C9          .byte $C9  ; غير معرّف
$D9B4: 09 90    ORA  #$90
$D9B6: 1D 29 01 ORA  $0129,X
$D9B9: 95 16    STA  $16,X
$D9BB: A0 00    LDY  #$00
$D9BD: 94 1E    STY  $1E,X
$D9BF: A9 03    LDA  #$03
$D9C1: 20 11 DA JSR  $DA11
$D9C4: 20 63 C3 JSR  $C363
$D9C7: 20 05 DA JSR  $DA05
$D9CA: B9 51 D8 LDA  $D851,Y
$D9CD: 95 58    STA  $58,X
$D9CF: 4C F1 D9 JMP  $D9F1
$D9D2: 10 0B    BPL  $D9DF
$D9D4: A9 04    LDA  #$04
$D9D6: 95 1E    STA  $1E,X
$D9D8: EE 84 04 INC  $0484
$D9DB: AD 84 04 LDA  $0484
$D9DE: 18       CLC  
$D9DF: 6D 91 07 ADC  $0791
$D9E2: 20 11 DA JSR  $DA11
$D9E5: EE 91 07 INC  $0791
$D9E8: AC 6A 07 LDY  $076A
$D9EB: B9 D2 D9 LDA  $D9D2,Y
$D9EE: 9D 96 07 STA  $0796,X
$D9F1: A9 FC    LDA  #$FC
$D9F3: 85 9F    STA  $9F
$D9F5: 60       RTS  
$D9F6: B5 46    LDA  $46,X
$D9F8: C9          .byte $C9  ; غير معرّف
$D9F9: 01 D0    ORA  ($D0,X)
$D9FB: 03          .byte $03  ; غير معرّف
$D9FC: 4C 2C D9 JMP  $D92C
$D9FF: 20 1C DB JSR  $DB1C
$DA02: 4C 2C D9 JMP  $D92C
$DA05: A0 01    LDY  #$01
$DA07: 20 43 E1 JSR  $E143
$DA0A: 10 01    BPL  $DA0D
$DA0C: C8       INY  
$DA0D: 94 46    STY  $46,X
$DA0F: 88       DEY  
$DA10: 60       RTS  
$DA11: 9D 10 01 STA  $0110,X
$DA14: A9 30    LDA  #$30
$DA16: 9D 2C 01 STA  $012C,X
$DA19: B5 CF    LDA  $CF,X
$DA1B: 9D 1E 01 STA  $011E,X
$DA1E: AD AE 03 LDA  $03AE
$DA21: 9D 17 01 STA  $0117,X
$DA24: 60       RTS  
$DA25: 80          .byte $80  ; غير معرّف
$DA26: 40       RTI  
$DA27: 20 10 08 JSR  $0810
$DA2A: 04          .byte $04  ; غير معرّف
$DA2B: 02          .byte $02  ; غير معرّف
$DA2C: 7F          .byte $7F  ; غير معرّف
$DA2D: BF          .byte $BF  ; غير معرّف
$DA2E: DF          .byte $DF  ; غير معرّف
$DA2F: EF          .byte $EF  ; غير معرّف
$DA30: F7          .byte $F7  ; غير معرّف
$DA31: FB          .byte $FB  ; غير معرّف
$DA32: FD A5 09 SBC  $09A5,X
$DA35: 4A       LSR  A
$DA36: 90 EC    BCC  $DA24
$DA38: AD 4E 07 LDA  $074E
$DA3B: F0 E7    BEQ  $DA24
$DA3D: B5 16    LDA  $16,X
$DA3F: C9          .byte $C9  ; غير معرّف
$DA40: 15 B0    ORA  $B0,X
$DA42: 6E C9 11 ROR  $11C9
$DA45: F0 6A    BEQ  $DAB1
$DA47: C9          .byte $C9  ; غير معرّف
$DA48: 0D F0 66 ORA  $66F0
$DA4B: BD D8 03 LDA  $03D8,X
$DA4E: D0 61    BNE  $DAB1
$DA50: 20 52 DC JSR  $DC52
$DA53: CA       DEX  
$DA54: 30 5B    BMI  $DAB1
$DA56: 86 01    STX  $01
$DA58: 98       TYA  
$DA59: 48       PHA  
$DA5A: B5 0F    LDA  $0F,X
$DA5C: F0 4C    BEQ  $DAAA
$DA5E: B5 16    LDA  $16,X
$DA60: C9          .byte $C9  ; غير معرّف
$DA61: 15 B0    ORA  $B0,X
$DA63: 46 C9    LSR  $C9
$DA65: 11 F0    ORA  ($F0),Y
$DA67: 42          .byte $42  ; غير معرّف
$DA68: C9          .byte $C9  ; غير معرّف
$DA69: 0D F0 3E ORA  $3EF0
$DA6C: BD D8 03 LDA  $03D8,X
$DA6F: D0 39    BNE  $DAAA
$DA71: 8A       TXA  
$DA72: 0A       ASL  A
$DA73: 0A       ASL  A
$DA74: 18       CLC  
$DA75: 69 04    ADC  #$04
$DA77: AA       TAX  
$DA78: 20 27 E3 JSR  $E327
$DA7B: A6 08    LDX  $08
$DA7D: A4 01    LDY  $01
$DA7F: 90 20    BCC  $DAA1
$DA81: B5 1E    LDA  $1E,X
$DA83: 19 1E 00 ORA  $001E,Y
$DA86: 29 80    AND  #$80
$DA88: D0 11    BNE  $DA9B
$DA8A: B9 91 04 LDA  $0491,Y
$DA8D: 3D 25 DA AND  $DA25,X
$DA90: D0 18    BNE  $DAAA
$DA92: B9 91 04 LDA  $0491,Y
$DA95: 1D 25 DA ORA  $DA25,X
$DA98: 99 91 04 STA  $0491,Y
$DA9B: 20 B4 DA JSR  $DAB4
$DA9E: 4C AA DA JMP  $DAAA
$DAA1: B9 91 04 LDA  $0491,Y
$DAA4: 3D 2C DA AND  $DA2C,X
$DAA7: 99 91 04 STA  $0491,Y
$DAAA: 68       PLA  
$DAAB: A8       TAY  
$DAAC: A6 01    LDX  $01
$DAAE: CA       DEX  
$DAAF: 10 A5    BPL  $DA56
$DAB1: A6 08    LDX  $08
$DAB3: 60       RTS  
$DAB4: B9 1E 00 LDA  $001E,Y
$DAB7: 15 1E    ORA  $1E,X
$DAB9: 29 20    AND  #$20
$DABB: D0 33    BNE  $DAF0
$DABD: B5 1E    LDA  $1E,X
$DABF: C9          .byte $C9  ; غير معرّف
$DAC0: 06 90    ASL  $90
$DAC2: 2E B5 16 ROL  $16B5
$DAC5: C9          .byte $C9  ; غير معرّف
$DAC6: 05 F0    ORA  $F0
$DAC8: 27          .byte $27  ; غير معرّف
$DAC9: B9 1E 00 LDA  $001E,Y
$DACC: 0A       ASL  A
$DACD: 90 0A    BCC  $DAD9
$DACF: A9 06    LDA  #$06
$DAD1: 20 11 DA JSR  $DA11
$DAD4: 20 95 D7 JSR  $D795
$DAD7: A4 01    LDY  $01
$DAD9: 98       TYA  
$DADA: AA       TAX  
$DADB: 20 95 D7 JSR  $D795
$DADE: A6 08    LDX  $08
$DAE0: BD 25 01 LDA  $0125,X
$DAE3: 18       CLC  
$DAE4: 69 04    ADC  #$04
$DAE6: A6 01    LDX  $01
$DAE8: 20 11 DA JSR  $DA11
$DAEB: A6 08    LDX  $08
$DAED: FE 25 01 INC  $0125,X
$DAF0: 60       RTS  
$DAF1: B9 1E 00 LDA  $001E,Y
$DAF4: C9          .byte $C9  ; غير معرّف
$DAF5: 06 90    ASL  $90
$DAF7: 1D B9 16 ORA  $16B9,X
$DAFA: 00       BRK  
$DAFB: C9          .byte $C9  ; غير معرّف
$DAFC: 05 F0    ORA  $F0
$DAFE: F1 20    SBC  ($20),Y
$DB00: 95 D7    STA  $D7,X
$DB02: A4 01    LDY  $01
$DB04: B9 25 01 LDA  $0125,Y
$DB07: 18       CLC  
$DB08: 69 04    ADC  #$04
$DB0A: A6 08    LDX  $08
$DB0C: 20 11 DA JSR  $DA11
$DB0F: A6 01    LDX  $01
$DB11: FE 25 01 INC  $0125,X
$DB14: 60       RTS  
$DB15: 98       TYA  
$DB16: AA       TAX  
$DB17: 20 1C DB JSR  $DB1C
$DB1A: A6 08    LDX  $08
$DB1C: B5 16    LDA  $16,X
$DB1E: C9          .byte $C9  ; غير معرّف
$DB1F: 0D F0 22 ORA  $22F0
$DB22: C9          .byte $C9  ; غير معرّف
$DB23: 11 F0    ORA  ($F0),Y
$DB25: 1E C9 05 ASL  $05C9,X
$DB28: F0 1A    BEQ  $DB44
$DB2A: C9          .byte $C9  ; غير معرّف
$DB2B: 12          .byte $12  ; غير معرّف
$DB2C: F0 08    BEQ  $DB36
$DB2E: C9          .byte $C9  ; غير معرّف
$DB2F: 0E F0 04 ASL  $04F0
$DB32: C9          .byte $C9  ; غير معرّف
$DB33: 07          .byte $07  ; غير معرّف
$DB34: B0 0E    BCS  $DB44
$DB36: B5 58    LDA  $58,X
$DB38: 49 FF    EOR  #$FF
$DB3A: A8       TAY  
$DB3B: C8       INY  
$DB3C: 94 58    STY  $58,X
$DB3E: B5 46    LDA  $46,X
$DB40: 49 03    EOR  #$03
$DB42: 95 46    STA  $46,X
$DB44: 60       RTS  
$DB45: A9 FF    LDA  #$FF
$DB47: 9D A2 03 STA  $03A2,X
$DB4A: AD 47 07 LDA  $0747
$DB4D: D0 29    BNE  $DB78
$DB4F: B5 1E    LDA  $1E,X
$DB51: 30 25    BMI  $DB78
$DB53: B5 16    LDA  $16,X
$DB55: C9          .byte $C9  ; غير معرّف
$DB56: 24 D0    BIT  $D0
$DB58: 06 B5    ASL  $B5
$DB5A: 1E AA 20 ASL  $20AA,X
$DB5D: 5F          .byte $5F  ; غير معرّف
$DB5E: DB          .byte $DB  ; غير معرّف
$DB5F: 20 41 DC JSR  $DC41
$DB62: B0 14    BCS  $DB78
$DB64: 8A       TXA  
$DB65: 20 54 DC JSR  $DC54
$DB68: B5 CF    LDA  $CF,X
$DB6A: 85 00    STA  $00
$DB6C: 8A       TXA  
$DB6D: 48       PHA  
$DB6E: 20 25 E3 JSR  $E325
$DB71: 68       PLA  
$DB72: AA       TAX  
$DB73: 90 03    BCC  $DB78
$DB75: 20 BC DB JSR  $DBBC
$DB78: A6 08    LDX  $08
$DB7A: 60       RTS  
$DB7B: AD 47 07 LDA  $0747
$DB7E: D0 37    BNE  $DBB7
$DB80: 9D A2 03 STA  $03A2,X
$DB83: 20 41 DC JSR  $DC41
$DB86: B0 2F    BCS  $DBB7
$DB88: A9 02    LDA  #$02
$DB8A: 85 00    STA  $00
$DB8C: A6 08    LDX  $08
$DB8E: 20 52 DC JSR  $DC52
$DB91: 29 02    AND  #$02
$DB93: D0 22    BNE  $DBB7
$DB95: B9 AD 04 LDA  $04AD,Y
$DB98: C9          .byte $C9  ; غير معرّف
$DB99: 20 90 05 JSR  $0590
$DB9C: 20 25 E3 JSR  $E325
$DB9F: B0 19    BCS  $DBBA
$DBA1: B9 AD 04 LDA  $04AD,Y
$DBA4: 18       CLC  
$DBA5: 69 80    ADC  #$80
$DBA7: 99 AD 04 STA  $04AD,Y
$DBAA: B9 AF 04 LDA  $04AF,Y
$DBAD: 18       CLC  
$DBAE: 69 80    ADC  #$80
$DBB0: 99 AF 04 STA  $04AF,Y
$DBB3: C6 00    DEC  $00
$DBB5: D0 D5    BNE  $DB8C
$DBB7: A6 08    LDX  $08
$DBB9: 60       RTS  
$DBBA: A6 08    LDX  $08
$DBBC: B9 AF 04 LDA  $04AF,Y
$DBBF: 38       SEC  
$DBC0: ED AD 04 SBC  $04AD
$DBC3: C9          .byte $C9  ; غير معرّف
$DBC4: 04          .byte $04  ; غير معرّف
$DBC5: B0 08    BCS  $DBCF
$DBC7: A5 9F    LDA  $9F
$DBC9: 10 04    BPL  $DBCF
$DBCB: A9 01    LDA  #$01
$DBCD: 85 9F    STA  $9F
$DBCF: AD AF 04 LDA  $04AF
$DBD2: 38       SEC  
$DBD3: F9 AD 04 SBC  $04AD,Y
$DBD6: C9          .byte $C9  ; غير معرّف
$DBD7: 06 B0    ASL  $B0
$DBD9: 1B          .byte $1B  ; غير معرّف
$DBDA: A5 9F    LDA  $9F
$DBDC: 30 17    BMI  $DBF5
$DBDE: A5 00    LDA  $00
$DBE0: B4 16    LDY  $16,X
$DBE2: C0 2B    CPY  #$2B
$DBE4: F0 05    BEQ  $DBEB
$DBE6: C0 2C    CPY  #$2C
$DBE8: F0 01    BEQ  $DBEB
$DBEA: 8A       TXA  
$DBEB: A6 08    LDX  $08
$DBED: 9D A2 03 STA  $03A2,X
$DBF0: A9 00    LDA  #$00
$DBF2: 85 1D    STA  $1D
$DBF4: 60       RTS  
$DBF5: A9 01    LDA  #$01
$DBF7: 85 00    STA  $00
$DBF9: AD AE 04 LDA  $04AE
$DBFC: 38       SEC  
$DBFD: F9 AC 04 SBC  $04AC,Y
$DC00: C9          .byte $C9  ; غير معرّف
$DC01: 08       PHP  
$DC02: 90 0D    BCC  $DC11
$DC04: E6 00    INC  $00
$DC06: B9 AE 04 LDA  $04AE,Y
$DC09: 18       CLC  
$DC0A: ED AC 04 SBC  $04AC
$DC0D: C9          .byte $C9  ; غير معرّف
$DC0E: 09 B0    ORA  #$B0
$DC10: 03          .byte $03  ; غير معرّف
$DC11: 20 4B DF JSR  $DF4B
$DC14: A6 08    LDX  $08
$DC16: 60       RTS  
$DC17: 80          .byte $80  ; غير معرّف
$DC18: 00       BRK  
$DC19: A8       TAY  
$DC1A: B5 CF    LDA  $CF,X
$DC1C: 18       CLC  
$DC1D: 79 16 DC ADC  $DC16,Y
$DC20: 2C B5 CF BIT  $CFB5
$DC23: A4 0E    LDY  $0E
$DC25: C0 0B    CPY  #$0B
$DC27: F0 17    BEQ  $DC40
$DC29: B4 B6    LDY  $B6,X
$DC2B: C0 01    CPY  #$01
$DC2D: D0 11    BNE  $DC40
$DC2F: 38       SEC  
$DC30: E9 20    SBC  #$20
$DC32: 85 CE    STA  $CE
$DC34: 98       TYA  
$DC35: E9 00    SBC  #$00
$DC37: 85 B5    STA  $B5
$DC39: A9 00    LDA  #$00
$DC3B: 85 9F    STA  $9F
$DC3D: 8D 33 04 STA  $0433
$DC40: 60       RTS  
$DC41: AD D0 03 LDA  $03D0
$DC44: C9          .byte $C9  ; غير معرّف
$DC45: F0 B0    BEQ  $DBF7
$DC47: 09 A4    ORA  #$A4
$DC49: B5 88    LDA  $88,X
$DC4B: D0 04    BNE  $DC51
$DC4D: A5 CE    LDA  $CE
$DC4F: C9          .byte $C9  ; غير معرّف
$DC50: D0 60    BNE  $DCB2
$DC52: A5 08    LDA  $08
$DC54: 0A       ASL  A
$DC55: 0A       ASL  A
$DC56: 18       CLC  
$DC57: 69 04    ADC  #$04
$DC59: A8       TAY  
$DC5A: AD D1 03 LDA  $03D1
$DC5D: 29 0F    AND  #$0F
$DC5F: C9          .byte $C9  ; غير معرّف
$DC60: 0F          .byte $0F  ; غير معرّف
$DC61: 60       RTS  
$DC62: 20 10 AD JSR  $AD10
$DC65: 16 07    ASL  $07,X
$DC67: D0 2E    BNE  $DC97
$DC69: A5 0E    LDA  $0E
$DC6B: C9          .byte $C9  ; غير معرّف
$DC6C: 0B          .byte $0B  ; غير معرّف
$DC6D: F0 28    BEQ  $DC97
$DC6F: C9          .byte $C9  ; غير معرّف
$DC70: 04          .byte $04  ; غير معرّف
$DC71: 90 24    BCC  $DC97
$DC73: A9 01    LDA  #$01
$DC75: AC 04 07 LDY  $0704
$DC78: D0 0A    BNE  $DC84
$DC7A: A5 1D    LDA  $1D
$DC7C: F0 04    BEQ  $DC82
$DC7E: C9          .byte $C9  ; غير معرّف
$DC7F: 03          .byte $03  ; غير معرّف
$DC80: D0 04    BNE  $DC86
$DC82: A9 02    LDA  #$02
$DC84: 85 1D    STA  $1D
$DC86: A5 B5    LDA  $B5
$DC88: C9          .byte $C9  ; غير معرّف
$DC89: 01 D0    ORA  ($D0,X)
$DC8B: 0B          .byte $0B  ; غير معرّف
$DC8C: A9 FF    LDA  #$FF
$DC8E: 8D 90 04 STA  $0490
$DC91: A5 CE    LDA  $CE
$DC93: C9          .byte $C9  ; غير معرّف
$DC94: CF          .byte $CF  ; غير معرّف
$DC95: 90 01    BCC  $DC98
$DC97: 60       RTS  
$DC98: A0 02    LDY  #$02
$DC9A: AD 14 07 LDA  $0714
$DC9D: D0 0C    BNE  $DCAB
$DC9F: AD 54 07 LDA  $0754
$DCA2: D0 07    BNE  $DCAB
$DCA4: 88       DEY  
$DCA5: AD 04 07 LDA  $0704
$DCA8: D0 01    BNE  $DCAB
$DCAA: 88       DEY  
$DCAB: B9 AD E3 LDA  $E3AD,Y
$DCAE: 85 EB    STA  $EB
$DCB0: A8       TAY  
$DCB1: AE 54 07 LDX  $0754
$DCB4: AD 14 07 LDA  $0714
$DCB7: F0 01    BEQ  $DCBA
$DCB9: E8       INX  
$DCBA: A5 CE    LDA  $CE
$DCBC: DD 62 DC CMP  $DC62,X
$DCBF: 90 35    BCC  $DCF6
$DCC1: 20 E9 E3 JSR  $E3E9
$DCC4: F0 30    BEQ  $DCF6
$DCC6: 20 A1 DF JSR  $DFA1
$DCC9: B0 4F    BCS  $DD1A
$DCCB: A4 9F    LDY  $9F
$DCCD: 10 27    BPL  $DCF6
$DCCF: A4 04    LDY  $04
$DCD1: C0 04    CPY  #$04
$DCD3: 90 21    BCC  $DCF6
$DCD5: 20 8F DF JSR  $DF8F
$DCD8: B0 10    BCS  $DCEA
$DCDA: AC 4E 07 LDY  $074E
$DCDD: F0 13    BEQ  $DCF2
$DCDF: AC 84 07 LDY  $0784
$DCE2: D0 0E    BNE  $DCF2
$DCE4: 20 ED BC JSR  $BCED
$DCE7: 4C F6 DC JMP  $DCF6
$DCEA: C9          .byte $C9  ; غير معرّف
$DCEB: 26 F0    ROL  $F0
$DCED: 04          .byte $04  ; غير معرّف
$DCEE: A9 02    LDA  #$02
$DCF0: 85 FF    STA  $FF
$DCF2: A9 01    LDA  #$01
$DCF4: 85 9F    STA  $9F
$DCF6: A4 EB    LDY  $EB
$DCF8: A5 CE    LDA  $CE
$DCFA: C9          .byte $C9  ; غير معرّف
$DCFB: CF          .byte $CF  ; غير معرّف
$DCFC: B0 60    BCS  $DD5E
$DCFE: 20 E8 E3 JSR  $E3E8
$DD01: 20 A1 DF JSR  $DFA1
$DD04: B0 14    BCS  $DD1A
$DD06: 48       PHA  
$DD07: 20 E8 E3 JSR  $E3E8
$DD0A: 85 00    STA  $00
$DD0C: 68       PLA  
$DD0D: 85 01    STA  $01
$DD0F: D0 0C    BNE  $DD1D
$DD11: A5 00    LDA  $00
$DD13: F0 49    BEQ  $DD5E
$DD15: 20 A1 DF JSR  $DFA1
$DD18: 90 03    BCC  $DD1D
$DD1A: 4C 05 DE JMP  $DE05
$DD1D: 20 9A DF JSR  $DF9A
$DD20: B0 3C    BCS  $DD5E
$DD22: A4 9F    LDY  $9F
$DD24: 30 38    BMI  $DD5E
$DD26: C9          .byte $C9  ; غير معرّف
$DD27: C5 D0    CMP  $D0
$DD29: 03          .byte $03  ; غير معرّف
$DD2A: 4C 0E DE JMP  $DE0E
$DD2D: 20 BD DE JSR  $DEBD
$DD30: F0 2C    BEQ  $DD5E
$DD32: AC 0E 07 LDY  $070E
$DD35: D0 23    BNE  $DD5A
$DD37: A4 04    LDY  $04
$DD39: C0 05    CPY  #$05
$DD3B: 90 07    BCC  $DD44
$DD3D: A5 45    LDA  $45
$DD3F: 85 00    STA  $00
$DD41: 4C 4B DF JMP  $DF4B
$DD44: 20 C4 DE JSR  $DEC4
$DD47: A9 F0    LDA  #$F0
$DD49: 25 CE    AND  $CE
$DD4B: 85 CE    STA  $CE
$DD4D: 20 E8 DE JSR  $DEE8
$DD50: A9 00    LDA  #$00
$DD52: 85 9F    STA  $9F
$DD54: 8D 33 04 STA  $0433
$DD57: 8D 84 04 STA  $0484
$DD5A: A9 00    LDA  #$00
$DD5C: 85 1D    STA  $1D
$DD5E: A4 EB    LDY  $EB
$DD60: C8       INY  
$DD61: C8       INY  
$DD62: A9 02    LDA  #$02
$DD64: 85 00    STA  $00
$DD66: C8       INY  
$DD67: 84 EB    STY  $EB
$DD69: A5 CE    LDA  $CE
$DD6B: C9          .byte $C9  ; غير معرّف
$DD6C: 20 90 16 JSR  $1690
$DD6F: C9          .byte $C9  ; غير معرّف
$DD70: E4 B0    CPX  $B0
$DD72: 28       PLP  
$DD73: 20 EC E3 JSR  $E3EC
$DD76: F0 0D    BEQ  $DD85
$DD78: C9          .byte $C9  ; غير معرّف
$DD79: 1C          .byte $1C  ; غير معرّف
$DD7A: F0 09    BEQ  $DD85
$DD7C: C9          .byte $C9  ; غير معرّف
$DD7D: 6B          .byte $6B  ; غير معرّف
$DD7E: F0 05    BEQ  $DD85
$DD80: 20 9A DF JSR  $DF9A
$DD83: 90 17    BCC  $DD9C
$DD85: A4 EB    LDY  $EB
$DD87: C8       INY  
$DD88: A5 CE    LDA  $CE
$DD8A: C9          .byte $C9  ; غير معرّف
$DD8B: 08       PHP  
$DD8C: 90 0D    BCC  $DD9B
$DD8E: C9          .byte $C9  ; غير معرّف
$DD8F: D0 B0    BNE  $DD41
$DD91: 09 20    ORA  #$20
$DD93: EC E3 D0 CPX  $D0E3
$DD96: 05 C6    ORA  $C6
$DD98: 00       BRK  
$DD99: D0 CB    BNE  $DD66
$DD9B: 60       RTS  
$DD9C: 20 BD DE JSR  $DEBD
$DD9F: F0 61    BEQ  $DE02
$DDA1: 20 9A DF JSR  $DF9A
$DDA4: 90 03    BCC  $DDA9
$DDA6: 4C 2E DE JMP  $DE2E
$DDA9: 20 A1 DF JSR  $DFA1
$DDAC: B0 57    BCS  $DE05
$DDAE: 20 DD DE JSR  $DEDD
$DDB1: 90 08    BCC  $DDBB
$DDB3: AD 0E 07 LDA  $070E
$DDB6: D0 4A    BNE  $DE02
$DDB8: 4C FF DD JMP  $DDFF
$DDBB: A4 1D    LDY  $1D
$DDBD: C0 00    CPY  #$00
$DDBF: D0 3E    BNE  $DDFF
$DDC1: A4 33    LDY  $33
$DDC3: 88       DEY  
$DDC4: D0 39    BNE  $DDFF
$DDC6: C9          .byte $C9  ; غير معرّف
$DDC7: 6C F0 04 JMP  ($04F0)
$DDCA: C9          .byte $C9  ; غير معرّف
$DDCB: 1F          .byte $1F  ; غير معرّف
$DDCC: D0 31    BNE  $DDFF
$DDCE: AD C4 03 LDA  $03C4
$DDD1: D0 04    BNE  $DDD7
$DDD3: A0 10    LDY  #$10
$DDD5: 84 FF    STY  $FF
$DDD7: 09 20    ORA  #$20
$DDD9: 8D C4 03 STA  $03C4
$DDDC: A5 86    LDA  $86
$DDDE: 29 0F    AND  #$0F
$DDE0: F0 0E    BEQ  $DDF0
$DDE2: A0 00    LDY  #$00
$DDE4: AD 1A 07 LDA  $071A
$DDE7: F0 01    BEQ  $DDEA
$DDE9: C8       INY  
$DDEA: B9 03 DE LDA  $DE03,Y
$DDED: 8D DE 06 STA  $06DE
$DDF0: A5 0E    LDA  $0E
$DDF2: C9          .byte $C9  ; غير معرّف
$DDF3: 07          .byte $07  ; غير معرّف
$DDF4: F0 0C    BEQ  $DE02
$DDF6: C9          .byte $C9  ; غير معرّف
$DDF7: 08       PHP  
$DDF8: D0 08    BNE  $DE02
$DDFA: A9 02    LDA  #$02
$DDFC: 85 0E    STA  $0E
$DDFE: 60       RTS  
$DDFF: 20 4B DF JSR  $DF4B
$DE02: 60       RTS  
$DE03: A0 34    LDY  #$34
$DE05: 20 1C DE JSR  $DE1C
$DE08: EE 48 07 INC  $0748
$DE0B: 4C FE BB JMP  $BBFE
$DE0E: A9 00    LDA  #$00
$DE10: 8D 72 07 STA  $0772
$DE13: A9 02    LDA  #$02
$DE15: 8D 70 07 STA  $0770
$DE18: A9 18    LDA  #$18
$DE1A: 85 57    STA  $57
$DE1C: A4 02    LDY  $02
$DE1E: A9 00    LDA  #$00
$DE20: 91 06    STA  ($06),Y
$DE22: 4C 4D 8A JMP  $8A4D
$DE25: F9 07 FF SBC  $FF07,Y
$DE28: 00       BRK  
$DE29: 18       CLC  
$DE2A: 22          .byte $22  ; غير معرّف
$DE2B: 50 68    BVC  $DE95
$DE2D: 90 A4    BCC  $DDD3
$DE2F: 04          .byte $04  ; غير معرّف
$DE30: C0 06    CPY  #$06
$DE32: 90 04    BCC  $DE38
$DE34: C0 0A    CPY  #$0A
$DE36: 90 01    BCC  $DE39
$DE38: 60       RTS  
$DE39: C9          .byte $C9  ; غير معرّف
$DE3A: 24 F0    BIT  $F0
$DE3C: 04          .byte $04  ; غير معرّف
$DE3D: C9          .byte $C9  ; غير معرّف
$DE3E: 25 D0    AND  $D0
$DE40: 39 A5 0E AND  $0EA5,Y
$DE43: C9          .byte $C9  ; غير معرّف
$DE44: 05 F0    ORA  $F0
$DE46: 41 A9    EOR  ($A9,X)
$DE48: 01 85    ORA  ($85,X)
$DE4A: 33          .byte $33  ; غير معرّف
$DE4B: EE 23 07 INC  $0723
$DE4E: A5 0E    LDA  $0E
$DE50: C9          .byte $C9  ; غير معرّف
$DE51: 04          .byte $04  ; غير معرّف
$DE52: F0 1F    BEQ  $DE73
$DE54: A9 33    LDA  #$33
$DE56: 20 16 97 JSR  $9716
$DE59: A9 80    LDA  #$80
$DE5B: 85 FC    STA  $FC
$DE5D: 4A       LSR  A
$DE5E: 8D 13 07 STA  $0713
$DE61: A2 04    LDX  #$04
$DE63: A5 CE    LDA  $CE
$DE65: 8D 0F 07 STA  $070F
$DE68: DD 29 DE CMP  $DE29,X
$DE6B: B0 03    BCS  $DE70
$DE6D: CA       DEX  
$DE6E: D0 F8    BNE  $DE68
$DE70: 8E 0F 01 STX  $010F
$DE73: A9 04    LDA  #$04
$DE75: 85 0E    STA  $0E
$DE77: 4C 88 DE JMP  $DE88
$DE7A: C9          .byte $C9  ; غير معرّف
$DE7B: 26 D0    ROL  $D0
$DE7D: 0A       ASL  A
$DE7E: A5 CE    LDA  $CE
$DE80: C9          .byte $C9  ; غير معرّف
$DE81: 20 B0 04 JSR  $04B0
$DE84: A9 01    LDA  #$01
$DE86: 85 0E    STA  $0E
$DE88: A9 03    LDA  #$03
$DE8A: 85 1D    STA  $1D
$DE8C: A9 00    LDA  #$00
$DE8E: 85 57    STA  $57
$DE90: 8D 05 07 STA  $0705
$DE93: A5 86    LDA  $86
$DE95: 38       SEC  
$DE96: ED 1C 07 SBC  $071C
$DE99: C9          .byte $C9  ; غير معرّف
$DE9A: 10 B0    BPL  $DE4C
$DE9C: 04          .byte $04  ; غير معرّف
$DE9D: A9 02    LDA  #$02
$DE9F: 85 33    STA  $33
$DEA1: A4 33    LDY  $33
$DEA3: A5 06    LDA  $06
$DEA5: 0A       ASL  A
$DEA6: 0A       ASL  A
$DEA7: 0A       ASL  A
$DEA8: 0A       ASL  A
$DEA9: 18       CLC  
$DEAA: 79 24 DE ADC  $DE24,Y
$DEAD: 85 86    STA  $86
$DEAF: A5 06    LDA  $06
$DEB1: D0 09    BNE  $DEBC
$DEB3: AD 1B 07 LDA  $071B
$DEB6: 18       CLC  
$DEB7: 79 26 DE ADC  $DE26,Y
$DEBA: 85 6D    STA  $6D
$DEBC: 60       RTS  
$DEBD: C9          .byte $C9  ; غير معرّف
$DEBE: 5F          .byte $5F  ; غير معرّف
$DEBF: F0 02    BEQ  $DEC3
$DEC1: C9          .byte $C9  ; غير معرّف
$DEC2: 60       RTS  
$DEC3: 60       RTS  
$DEC4: 20 DD DE JSR  $DEDD
$DEC7: 90 13    BCC  $DEDC
$DEC9: A9 70    LDA  #$70
$DECB: 8D 09 07 STA  $0709
$DECE: A9 F9    LDA  #$F9
$DED0: 8D DB 06 STA  $06DB
$DED3: A9 03    LDA  #$03
$DED5: 8D 86 07 STA  $0786
$DED8: 4A       LSR  A
$DED9: 8D 0E 07 STA  $070E
$DEDC: 60       RTS  
$DEDD: C9          .byte $C9  ; غير معرّف
$DEDE: 67          .byte $67  ; غير معرّف
$DEDF: F0 05    BEQ  $DEE6
$DEE1: C9          .byte $C9  ; غير معرّف
$DEE2: 68       PLA  
$DEE3: 18       CLC  
$DEE4: D0 01    BNE  $DEE7
$DEE6: 38       SEC  
$DEE7: 60       RTS  
$DEE8: A5 0B    LDA  $0B
$DEEA: 29 04    AND  #$04
$DEEC: F0 5C    BEQ  $DF4A
$DEEE: A5 00    LDA  $00
$DEF0: C9          .byte $C9  ; غير معرّف
$DEF1: 11 D0    ORA  ($D0),Y
$DEF3: 56 A5    LSR  $A5,X
$DEF5: 01 C9    ORA  ($C9,X)
$DEF7: 10 D0    BPL  $DEC9
$DEF9: 50 A9    BVC  $DEA4
$DEFB: 30 8D    BMI  $DE8A
$DEFD: DE 06 A9 DEC  $A906,X
$DF00: 03          .byte $03  ; غير معرّف
$DF01: 85 0E    STA  $0E
$DF03: A9 10    LDA  #$10
$DF05: 85 FF    STA  $FF
$DF07: A9 20    LDA  #$20
$DF09: 8D C4 03 STA  $03C4
$DF0C: AD D6 06 LDA  $06D6
$DF0F: F0 39    BEQ  $DF4A
$DF11: 29 03    AND  #$03
$DF13: 0A       ASL  A
$DF14: 0A       ASL  A
$DF15: AA       TAX  
$DF16: A5 86    LDA  $86
$DF18: C9          .byte $C9  ; غير معرّف
$DF19: 60       RTS  
$DF1A: 90 06    BCC  $DF22
$DF1C: E8       INX  
$DF1D: C9          .byte $C9  ; غير معرّف
$DF1E: A0 90    LDY  #$90
$DF20: 01 E8    ORA  ($E8,X)
$DF22: BC F2 87 LDY  $87F2,X
$DF25: 88       DEY  
$DF26: 8C 5F 07 STY  $075F
$DF29: BE B4 9C LDX  $9CB4,Y
$DF2C: BD BC 9C LDA  $9CBC,X
$DF2F: 8D 50 07 STA  $0750
$DF32: A9 80    LDA  #$80
$DF34: 85 FC    STA  $FC
$DF36: A9 00    LDA  #$00
$DF38: 8D 51 07 STA  $0751
$DF3B: 8D 60 07 STA  $0760
$DF3E: 8D 5C 07 STA  $075C
$DF41: 8D 52 07 STA  $0752
$DF44: EE 5D 07 INC  $075D
$DF47: EE 57 07 INC  $0757
$DF4A: 60       RTS  
$DF4B: A9 00    LDA  #$00
$DF4D: A4 57    LDY  $57
$DF4F: A6 00    LDX  $00
$DF51: CA       DEX  
$DF52: D0 0A    BNE  $DF5E
$DF54: E8       INX  
$DF55: C0 00    CPY  #$00
$DF57: 30 28    BMI  $DF81
$DF59: A9 FF    LDA  #$FF
$DF5B: 4C 66 DF JMP  $DF66
$DF5E: A2 02    LDX  #$02
$DF60: C0 01    CPY  #$01
$DF62: 10 1D    BPL  $DF81
$DF64: A9 01    LDA  #$01
$DF66: A0 10    LDY  #$10
$DF68: 8C 85 07 STY  $0785
$DF6B: A0 00    LDY  #$00
$DF6D: 84 57    STY  $57
$DF6F: C9          .byte $C9  ; غير معرّف
$DF70: 00       BRK  
$DF71: 10 01    BPL  $DF74
$DF73: 88       DEY  
$DF74: 84 00    STY  $00
$DF76: 18       CLC  
$DF77: 65 86    ADC  $86
$DF79: 85 86    STA  $86
$DF7B: A5 6D    LDA  $6D
$DF7D: 65 00    ADC  $00
$DF7F: 85 6D    STA  $6D
$DF81: 8A       TXA  
$DF82: 49 FF    EOR  #$FF
$DF84: 2D 90 04 AND  $0490
$DF87: 8D 90 04 STA  $0490
$DF8A: 60       RTS  
$DF8B: 10 61    BPL  $DFEE
$DF8D: 88       DEY  
$DF8E: C4 20    CPY  $20
$DF90: B0 DF    BCS  $DF71
$DF92: DD 8B DF CMP  $DF8B,X
$DF95: 60       RTS  
$DF96: 24 6D    BIT  $6D
$DF98: 8A       TXA  
$DF99: C6 20    DEC  $20
$DF9B: B0 DF    BCS  $DF7C
$DF9D: DD 96 DF CMP  $DF96,X
$DFA0: 60       RTS  
$DFA1: C9          .byte $C9  ; غير معرّف
$DFA2: C2          .byte $C2  ; غير معرّف
$DFA3: F0 06    BEQ  $DFAB
$DFA5: C9          .byte $C9  ; غير معرّف
$DFA6: C3          .byte $C3  ; غير معرّف
$DFA7: F0 02    BEQ  $DFAB
$DFA9: 18       CLC  
$DFAA: 60       RTS  
$DFAB: A9 01    LDA  #$01
$DFAD: 85 FE    STA  $FE
$DFAF: 60       RTS  
$DFB0: A8       TAY  
$DFB1: 29 C0    AND  #$C0
$DFB3: 0A       ASL  A
$DFB4: 2A       ROL  A
$DFB5: 2A       ROL  A
$DFB6: AA       TAX  
$DFB7: 98       TYA  
$DFB8: 60       RTS  
$DFB9: 01 01    ORA  ($01,X)
$DFBB: 02          .byte $02  ; غير معرّف
$DFBC: 02          .byte $02  ; غير معرّف
$DFBD: 02          .byte $02  ; غير معرّف
$DFBE: 05 10    ORA  $10
$DFC0: F0 B5    BEQ  $DF77
$DFC2: 1E 29 20 ASL  $2029,X
$DFC5: D0 F1    BNE  $DFB8
$DFC7: 20 5B E1 JSR  $E15B
$DFCA: 90 EC    BCC  $DFB8
$DFCC: B4 16    LDY  $16,X
$DFCE: C0 12    CPY  #$12
$DFD0: D0 06    BNE  $DFD8
$DFD2: B5 CF    LDA  $CF,X
$DFD4: C9          .byte $C9  ; غير معرّف
$DFD5: 25 90    AND  $90
$DFD7: E0 C0    CPX  #$C0
$DFD9: 0E D0 03 ASL  $03D0
$DFDC: 4C 63 E1 JMP  $E163
$DFDF: C0 05    CPY  #$05
$DFE1: D0 03    BNE  $DFE6
$DFE3: 4C 85 E1 JMP  $E185
$DFE6: C0 12    CPY  #$12
$DFE8: F0 08    BEQ  $DFF2
$DFEA: C0 2E    CPY  #$2E
$DFEC: F0 04    BEQ  $DFF2
$DFEE: C0 07    CPY  #$07
$DFF0: B0 74    BCS  $E066
$DFF2: 20 AE E1 JSR  $E1AE
$DFF5: D0 03    BNE  $DFFA
$DFF7: 4C E2 E0 JMP  $E0E2
$DFFA: 20 B5 E1 JSR  $E1B5
$DFFD: F0 F8    BEQ  $DFF7
$DFFF: C9          .byte $C9  ; غير معرّف
$E000: 23          .byte $23  ; غير معرّف
$E001: D0 64    BNE  $E067
$E003: A4 02    LDY  $02
$E005: A9 00    LDA  #$00
$E007: 91 06    STA  ($06),Y
$E009: B5 16    LDA  $16,X
$E00B: C9          .byte $C9  ; غير معرّف
$E00C: 15 B0    ORA  $B0,X
$E00E: 0C          .byte $0C  ; غير معرّف
$E00F: C9          .byte $C9  ; غير معرّف
$E010: 06 D0    ASL  $D0
$E012: 03          .byte $03  ; غير معرّف
$E013: 20 8E E1 JSR  $E18E
$E016: A9 01    LDA  #$01
$E018: 20 11 DA JSR  $DA11
$E01B: C9          .byte $C9  ; غير معرّف
$E01C: 09 90    ORA  #$90
$E01E: 10 C9    BPL  $DFE9
$E020: 11 B0    ORA  ($B0),Y
$E022: 0C          .byte $0C  ; غير معرّف
$E023: C9          .byte $C9  ; غير معرّف
$E024: 0A       ASL  A
$E025: 90 04    BCC  $E02B
$E027: C9          .byte $C9  ; غير معرّف
$E028: 0D 90 04 ORA  $0490
$E02B: 29 01    AND  #$01
$E02D: 95 16    STA  $16,X
$E02F: B5 1E    LDA  $1E,X
$E031: 29 F0    AND  #$F0
$E033: 09 02    ORA  #$02
$E035: 95 1E    STA  $1E,X
$E037: D6 CF    DEC  $CF,X
$E039: D6 CF    DEC  $CF,X
$E03B: B5 16    LDA  $16,X
$E03D: C9          .byte $C9  ; غير معرّف
$E03E: 07          .byte $07  ; غير معرّف
$E03F: F0 07    BEQ  $E048
$E041: A9 FD    LDA  #$FD
$E043: AC 4E 07 LDY  $074E
$E046: D0 02    BNE  $E04A
$E048: A9 FF    LDA  #$FF
$E04A: 95 A0    STA  $A0,X
$E04C: A0 01    LDY  #$01
$E04E: 20 43 E1 JSR  $E143
$E051: 10 01    BPL  $E054
$E053: C8       INY  
$E054: B5 16    LDA  $16,X
$E056: C9          .byte $C9  ; غير معرّف
$E057: 33          .byte $33  ; غير معرّف
$E058: F0 06    BEQ  $E060
$E05A: C9          .byte $C9  ; غير معرّف
$E05B: 08       PHP  
$E05C: F0 02    BEQ  $E060
$E05E: 94 46    STY  $46,X
$E060: 88       DEY  
$E061: B9 BF DF LDA  $DFBF,Y
$E064: 95 58    STA  $58,X
$E066: 60       RTS  
$E067: A5 04    LDA  $04
$E069: 38       SEC  
$E06A: E9 08    SBC  #$08
$E06C: C9          .byte $C9  ; غير معرّف
$E06D: 05 B0    ORA  $B0
$E06F: 72          .byte $72  ; غير معرّف
$E070: B5 1E    LDA  $1E,X
$E072: 29 40    AND  #$40
$E074: D0 57    BNE  $E0CD
$E076: B5 1E    LDA  $1E,X
$E078: 0A       ASL  A
$E079: 90 03    BCC  $E07E
$E07B: 4C FE E0 JMP  $E0FE
$E07E: B5 1E    LDA  $1E,X
$E080: F0 F9    BEQ  $E07B
$E082: C9          .byte $C9  ; غير معرّف
$E083: 05 F0    ORA  $F0
$E085: 1F          .byte $1F  ; غير معرّف
$E086: C9          .byte $C9  ; غير معرّف
$E087: 03          .byte $03  ; غير معرّف
$E088: B0 1A    BCS  $E0A4
$E08A: B5 1E    LDA  $1E,X
$E08C: C9          .byte $C9  ; غير معرّف
$E08D: 02          .byte $02  ; غير معرّف
$E08E: D0 15    BNE  $E0A5
$E090: A9 10    LDA  #$10
$E092: B4 16    LDY  $16,X
$E094: C0 12    CPY  #$12
$E096: D0 02    BNE  $E09A
$E098: A9 00    LDA  #$00
$E09A: 9D 96 07 STA  $0796,X
$E09D: A9 03    LDA  #$03
$E09F: 95 1E    STA  $1E,X
$E0A1: 20 4F E1 JSR  $E14F
$E0A4: 60       RTS  
$E0A5: B5 16    LDA  $16,X
$E0A7: C9          .byte $C9  ; غير معرّف
$E0A8: 06 F0    ASL  $F0
$E0AA: 22          .byte $22  ; غير معرّف
$E0AB: C9          .byte $C9  ; غير معرّف
$E0AC: 12          .byte $12  ; غير معرّف
$E0AD: D0 0E    BNE  $E0BD
$E0AF: A9 01    LDA  #$01
$E0B1: 95 46    STA  $46,X
$E0B3: A9 08    LDA  #$08
$E0B5: 95 58    STA  $58,X
$E0B7: A5 09    LDA  $09
$E0B9: 29 07    AND  #$07
$E0BB: F0 10    BEQ  $E0CD
$E0BD: A0 01    LDY  #$01
$E0BF: 20 43 E1 JSR  $E143
$E0C2: 10 01    BPL  $E0C5
$E0C4: C8       INY  
$E0C5: 98       TYA  
$E0C6: D5 46    CMP  $46,X
$E0C8: D0 03    BNE  $E0CD
$E0CA: 20 24 E1 JSR  $E124
$E0CD: 20 4F E1 JSR  $E14F
$E0D0: B5 1E    LDA  $1E,X
$E0D2: 29 80    AND  #$80
$E0D4: D0 05    BNE  $E0DB
$E0D6: A9 00    LDA  #$00
$E0D8: 95 1E    STA  $1E,X
$E0DA: 60       RTS  
$E0DB: B5 1E    LDA  $1E,X
$E0DD: 29 BF    AND  #$BF
$E0DF: 95 1E    STA  $1E,X
$E0E1: 60       RTS  
$E0E2: B5 16    LDA  $16,X
$E0E4: C9          .byte $C9  ; غير معرّف
$E0E5: 03          .byte $03  ; غير معرّف
$E0E6: D0 04    BNE  $E0EC
$E0E8: B5 1E    LDA  $1E,X
$E0EA: F0 38    BEQ  $E124
$E0EC: B5 1E    LDA  $1E,X
$E0EE: A8       TAY  
$E0EF: 0A       ASL  A
$E0F0: 90 07    BCC  $E0F9
$E0F2: B5 1E    LDA  $1E,X
$E0F4: 09 40    ORA  #$40
$E0F6: 4C FC E0 JMP  $E0FC
$E0F9: B9 B9 DF LDA  $DFB9,Y
$E0FC: 95 1E    STA  $1E,X
$E0FE: B5 CF    LDA  $CF,X
$E100: C9          .byte $C9  ; غير معرّف
$E101: 20 90 1F JSR  $1F90
$E104: A0 16    LDY  #$16
$E106: A9 02    LDA  #$02
$E108: 85 EB    STA  $EB
$E10A: A5 EB    LDA  $EB
$E10C: D5 46    CMP  $46,X
$E10E: D0 0C    BNE  $E11C
$E110: A9 01    LDA  #$01
$E112: 20 88 E3 JSR  $E388
$E115: F0 05    BEQ  $E11C
$E117: 20 B5 E1 JSR  $E1B5
$E11A: D0 08    BNE  $E124
$E11C: C6 EB    DEC  $EB
$E11E: C8       INY  
$E11F: C0 18    CPY  #$18
$E121: 90 E7    BCC  $E10A
$E123: 60       RTS  
$E124: E0 05    CPX  #$05
$E126: F0 09    BEQ  $E131
$E128: B5 1E    LDA  $1E,X
$E12A: 0A       ASL  A
$E12B: 90 04    BCC  $E131
$E12D: A9 02    LDA  #$02
$E12F: 85 FF    STA  $FF
$E131: B5 16    LDA  $16,X
$E133: C9          .byte $C9  ; غير معرّف
$E134: 05 D0    ORA  $D0
$E136: 09 A9    ORA  #$A9
$E138: 00       BRK  
$E139: 85 00    STA  $00
$E13B: A0 FA    LDY  #$FA
$E13D: 4C 37 CA JMP  $CA37
$E140: 4C 36 DB JMP  $DB36
$E143: B5 87    LDA  $87,X
$E145: 38       SEC  
$E146: E5 86    SBC  $86
$E148: 85 00    STA  $00
$E14A: B5 6E    LDA  $6E,X
$E14C: E5 6D    SBC  $6D
$E14E: 60       RTS  
$E14F: 20 63 C3 JSR  $C363
$E152: B5 CF    LDA  $CF,X
$E154: 29 F0    AND  #$F0
$E156: 09 08    ORA  #$08
$E158: 95 CF    STA  $CF,X
$E15A: 60       RTS  
$E15B: B5 CF    LDA  $CF,X
$E15D: 18       CLC  
$E15E: 69 3E    ADC  #$3E
$E160: C9          .byte $C9  ; غير معرّف
$E161: 44          .byte $44  ; غير معرّف
$E162: 60       RTS  
$E163: 20 5B E1 JSR  $E15B
$E166: 90 1A    BCC  $E182
$E168: B5 A0    LDA  $A0,X
$E16A: 18       CLC  
$E16B: 69 02    ADC  #$02
$E16D: C9          .byte $C9  ; غير معرّف
$E16E: 03          .byte $03  ; غير معرّف
$E16F: 90 11    BCC  $E182
$E171: 20 AE E1 JSR  $E1AE
$E174: F0 0C    BEQ  $E182
$E176: 20 B5 E1 JSR  $E1B5
$E179: F0 07    BEQ  $E182
$E17B: 20 4F E1 JSR  $E14F
$E17E: A9 FD    LDA  #$FD
$E180: 95 A0    STA  $A0,X
$E182: 4C FE E0 JMP  $E0FE
$E185: 20 AE E1 JSR  $E1AE
$E188: F0 1D    BEQ  $E1A7
$E18A: C9          .byte $C9  ; غير معرّف
$E18B: 23          .byte $23  ; غير معرّف
$E18C: D0 08    BNE  $E196
$E18E: 20 95 D7 JSR  $D795
$E191: A9 FC    LDA  #$FC
$E193: 95 A0    STA  $A0,X
$E195: 60       RTS  
$E196: BD 8A 07 LDA  $078A,X
$E199: D0 0C    BNE  $E1A7
$E19B: B5 1E    LDA  $1E,X
$E19D: 29 88    AND  #$88
$E19F: 95 1E    STA  $1E,X
$E1A1: 20 4F E1 JSR  $E14F
$E1A4: 4C FE E0 JMP  $E0FE
$E1A7: B5 1E    LDA  $1E,X
$E1A9: 09 01    ORA  #$01
$E1AB: 95 1E    STA  $1E,X
$E1AD: 60       RTS  
$E1AE: A9 00    LDA  #$00
$E1B0: A0 15    LDY  #$15
$E1B2: 4C 88 E3 JMP  $E388
$E1B5: C9          .byte $C9  ; غير معرّف
$E1B6: 26 F0    ROL  $F0
$E1B8: 0E C9 C2 ASL  $C2C9
$E1BB: F0 0A    BEQ  $E1C7
$E1BD: C9          .byte $C9  ; غير معرّف
$E1BE: C3          .byte $C3  ; غير معرّف
$E1BF: F0 06    BEQ  $E1C7
$E1C1: C9          .byte $C9  ; غير معرّف
$E1C2: 5F          .byte $5F  ; غير معرّف
$E1C3: F0 02    BEQ  $E1C7
$E1C5: C9          .byte $C9  ; غير معرّف
$E1C6: 60       RTS  
$E1C7: 60       RTS  
$E1C8: B5 D5    LDA  $D5,X
$E1CA: C9          .byte $C9  ; غير معرّف
$E1CB: 18       CLC  
$E1CC: 90 21    BCC  $E1EF
$E1CE: 20 9C E3 JSR  $E39C
$E1D1: F0 1C    BEQ  $E1EF
$E1D3: 20 B5 E1 JSR  $E1B5
$E1D6: F0 17    BEQ  $E1EF
$E1D8: B5 A6    LDA  $A6,X
$E1DA: 30 18    BMI  $E1F4
$E1DC: B5 3A    LDA  $3A,X
$E1DE: D0 14    BNE  $E1F4
$E1E0: A9 FD    LDA  #$FD
$E1E2: 95 A6    STA  $A6,X
$E1E4: A9 01    LDA  #$01
$E1E6: 95 3A    STA  $3A,X
$E1E8: B5 D5    LDA  $D5,X
$E1EA: 29 F8    AND  #$F8
$E1EC: 95 D5    STA  $D5,X
$E1EE: 60       RTS  
$E1EF: A9 00    LDA  #$00
$E1F1: 95 3A    STA  $3A,X
$E1F3: 60       RTS  
$E1F4: A9 80    LDA  #$80
$E1F6: 95 24    STA  $24,X
$E1F8: A9 02    LDA  #$02
$E1FA: 85 FF    STA  $FF
$E1FC: 60       RTS  
$E1FD: 02          .byte $02  ; غير معرّف
$E1FE: 08       PHP  
$E1FF: 0E 20 03 ASL  $0320
$E202: 14          .byte $14  ; غير معرّف
$E203: 0D 20 02 ORA  $0220
$E206: 14          .byte $14  ; غير معرّف
$E207: 0E 20 02 ASL  $0220
$E20A: 09 0E    ORA  #$0E
$E20C: 15 00    ORA  $00,X
$E20E: 00       BRK  
$E20F: 18       CLC  
$E210: 06 00    ASL  $00
$E212: 00       BRK  
$E213: 20 0D 00 JSR  $000D
$E216: 00       BRK  
$E217: 30 0D    BMI  $E226
$E219: 00       BRK  
$E21A: 00       BRK  
$E21B: 08       PHP  
$E21C: 08       PHP  
$E21D: 06 04    ASL  $04
$E21F: 0A       ASL  A
$E220: 08       PHP  
$E221: 03          .byte $03  ; غير معرّف
$E222: 0E 0D 14 ASL  $140D
$E225: 00       BRK  
$E226: 02          .byte $02  ; غير معرّف
$E227: 10 15    BPL  $E23E
$E229: 04          .byte $04  ; غير معرّف
$E22A: 04          .byte $04  ; غير معرّف
$E22B: 0C          .byte $0C  ; غير معرّف
$E22C: 1C          .byte $1C  ; غير معرّف
$E22D: 8A       TXA  
$E22E: 18       CLC  
$E22F: 69 07    ADC  #$07
$E231: AA       TAX  
$E232: A0 02    LDY  #$02
$E234: D0 07    BNE  $E23D
$E236: 8A       TXA  
$E237: 18       CLC  
$E238: 69 09    ADC  #$09
$E23A: AA       TAX  
$E23B: A0 06    LDY  #$06
$E23D: 20 9C E2 JSR  $E29C
$E240: 4C DE E2 JMP  $E2DE
$E243: A0 48    LDY  #$48
$E245: 84 00    STY  $00
$E247: A0 44    LDY  #$44
$E249: 4C 52 E2 JMP  $E252
$E24C: A0 08    LDY  #$08
$E24E: 84 00    STY  $00
$E250: A0 04    LDY  #$04
$E252: B5 87    LDA  $87,X
$E254: 38       SEC  
$E255: ED 1C 07 SBC  $071C
$E258: 85 01    STA  $01
$E25A: B5 6E    LDA  $6E,X
$E25C: ED 1A 07 SBC  $071A
$E25F: 30 06    BMI  $E267
$E261: 05 01    ORA  $01
$E263: F0 02    BEQ  $E267
$E265: A4 00    LDY  $00
$E267: 98       TYA  
$E268: 2D D1 03 AND  $03D1
$E26B: 9D D8 03 STA  $03D8,X
$E26E: D0 19    BNE  $E289
$E270: 4C 7C E2 JMP  $E27C
$E273: E8       INX  
$E274: 20 F6 F1 JSR  $F1F6
$E277: CA       DEX  
$E278: C9          .byte $C9  ; غير معرّف
$E279: FE B0 0D INC  $0DB0,X
$E27C: 8A       TXA  
$E27D: 18       CLC  
$E27E: 69 01    ADC  #$01
$E280: AA       TAX  
$E281: A0 01    LDY  #$01
$E283: 20 9C E2 JSR  $E29C
$E286: 4C DE E2 JMP  $E2DE
$E289: 8A       TXA  
$E28A: 0A       ASL  A
$E28B: 0A       ASL  A
$E28C: A8       TAY  
$E28D: A9 FF    LDA  #$FF
$E28F: 99 B0 04 STA  $04B0,Y
$E292: 99 B1 04 STA  $04B1,Y
$E295: 99 B2 04 STA  $04B2,Y
$E298: 99 B3 04 STA  $04B3,Y
$E29B: 60       RTS  
$E29C: 86 00    STX  $00
$E29E: B9 B8 03 LDA  $03B8,Y
$E2A1: 85 02    STA  $02
$E2A3: B9 AD 03 LDA  $03AD,Y
$E2A6: 85 01    STA  $01
$E2A8: 8A       TXA  
$E2A9: 0A       ASL  A
$E2AA: 0A       ASL  A
$E2AB: 48       PHA  
$E2AC: A8       TAY  
$E2AD: BD 99 04 LDA  $0499,X
$E2B0: 0A       ASL  A
$E2B1: 0A       ASL  A
$E2B2: AA       TAX  
$E2B3: A5 01    LDA  $01
$E2B5: 18       CLC  
$E2B6: 7D FD E1 ADC  $E1FD,X
$E2B9: 99 AC 04 STA  $04AC,Y
$E2BC: A5 01    LDA  $01
$E2BE: 18       CLC  
$E2BF: 7D FF E1 ADC  $E1FF,X
$E2C2: 99 AE 04 STA  $04AE,Y
$E2C5: E8       INX  
$E2C6: C8       INY  
$E2C7: A5 02    LDA  $02
$E2C9: 18       CLC  
$E2CA: 7D FD E1 ADC  $E1FD,X
$E2CD: 99 AC 04 STA  $04AC,Y
$E2D0: A5 02    LDA  $02
$E2D2: 18       CLC  
$E2D3: 7D FF E1 ADC  $E1FF,X
$E2D6: 99 AE 04 STA  $04AE,Y
$E2D9: 68       PLA  
$E2DA: A8       TAY  
$E2DB: A6 00    LDX  $00
$E2DD: 60       RTS  
$E2DE: AD 1C 07 LDA  $071C
$E2E1: 18       CLC  
$E2E2: 69 80    ADC  #$80
$E2E4: 85 02    STA  $02
$E2E6: AD 1A 07 LDA  $071A
$E2E9: 69 00    ADC  #$00
$E2EB: 85 01    STA  $01
$E2ED: B5 86    LDA  $86,X
$E2EF: C5 02    CMP  $02
$E2F1: B5 6D    LDA  $6D,X
$E2F3: E5 01    SBC  $01
$E2F5: 90 15    BCC  $E30C
$E2F7: B9 AE 04 LDA  $04AE,Y
$E2FA: 30 0D    BMI  $E309
$E2FC: A9 FF    LDA  #$FF
$E2FE: BE AC 04 LDX  $04AC,Y
$E301: 30 03    BMI  $E306
$E303: 99 AC 04 STA  $04AC,Y
$E306: 99 AE 04 STA  $04AE,Y
$E309: A6 08    LDX  $08
$E30B: 60       RTS  
$E30C: B9 AC 04 LDA  $04AC,Y
$E30F: 10 11    BPL  $E322
$E311: C9          .byte $C9  ; غير معرّف
$E312: A0 90    LDY  #$90
$E314: 0D A9 00 ORA  $00A9
$E317: BE AE 04 LDX  $04AE,Y
$E31A: 10 03    BPL  $E31F
$E31C: 99 AE 04 STA  $04AE,Y
$E31F: 99 AC 04 STA  $04AC,Y
$E322: A6 08    LDX  $08
$E324: 60       RTS  
$E325: A2 00    LDX  #$00
$E327: 84 06    STY  $06
$E329: A9 01    LDA  #$01
$E32B: 85 07    STA  $07
$E32D: B9 AC 04 LDA  $04AC,Y
$E330: DD AC 04 CMP  $04AC,X
$E333: B0 2A    BCS  $E35F
$E335: DD AE 04 CMP  $04AE,X
$E338: 90 12    BCC  $E34C
$E33A: F0 42    BEQ  $E37E
$E33C: B9 AE 04 LDA  $04AE,Y
$E33F: D9 AC 04 CMP  $04AC,Y
$E342: 90 3A    BCC  $E37E
$E344: DD AC 04 CMP  $04AC,X
$E347: B0 35    BCS  $E37E
$E349: A4 06    LDY  $06
$E34B: 60       RTS  
$E34C: BD AE 04 LDA  $04AE,X
$E34F: DD AC 04 CMP  $04AC,X
$E352: 90 2A    BCC  $E37E
$E354: B9 AE 04 LDA  $04AE,Y
$E357: DD AC 04 CMP  $04AC,X
$E35A: B0 22    BCS  $E37E
$E35C: A4 06    LDY  $06
$E35E: 60       RTS  
$E35F: DD AC 04 CMP  $04AC,X
$E362: F0 1A    BEQ  $E37E
$E364: DD AE 04 CMP  $04AE,X
$E367: 90 15    BCC  $E37E
$E369: F0 13    BEQ  $E37E
$E36B: D9 AE 04 CMP  $04AE,Y
$E36E: 90 0A    BCC  $E37A
$E370: F0 08    BEQ  $E37A
$E372: B9 AE 04 LDA  $04AE,Y
$E375: DD AC 04 CMP  $04AC,X
$E378: B0 04    BCS  $E37E
$E37A: 18       CLC  
$E37B: A4 06    LDY  $06
$E37D: 60       RTS  
$E37E: E8       INX  
$E37F: C8       INY  
$E380: C6 07    DEC  $07
$E382: 10 A9    BPL  $E32D
$E384: 38       SEC  
$E385: A4 06    LDY  $06
$E387: 60       RTS  
$E388: 48       PHA  
$E389: 8A       TXA  
$E38A: 18       CLC  
$E38B: 69 01    ADC  #$01
$E38D: AA       TAX  
$E38E: 68       PLA  
$E38F: 4C A5 E3 JMP  $E3A5
$E392: 8A       TXA  
$E393: 18       CLC  
$E394: 69 0D    ADC  #$0D
$E396: AA       TAX  
$E397: A0 1B    LDY  #$1B
$E399: 4C A3 E3 JMP  $E3A3
$E39C: A0 1A    LDY  #$1A
$E39E: 8A       TXA  
$E39F: 18       CLC  
$E3A0: 69 07    ADC  #$07
$E3A2: AA       TAX  
$E3A3: A9 00    LDA  #$00
$E3A5: 20 F0 E3 JSR  $E3F0
$E3A8: A6 08    LDX  $08
$E3AA: C9          .byte $C9  ; غير معرّف
$E3AB: 00       BRK  
$E3AC: 60       RTS  
$E3AD: 00       BRK  
$E3AE: 07          .byte $07  ; غير معرّف
$E3AF: 0E 08 03 ASL  $0308
$E3B2: 0C          .byte $0C  ; غير معرّف
$E3B3: 02          .byte $02  ; غير معرّف
$E3B4: 02          .byte $02  ; غير معرّف
$E3B5: 0D 0D 08 ORA  $080D
$E3B8: 03          .byte $03  ; غير معرّف
$E3B9: 0C          .byte $0C  ; غير معرّف
$E3BA: 02          .byte $02  ; غير معرّف
$E3BB: 02          .byte $02  ; غير معرّف
$E3BC: 0D 0D 08 ORA  $080D
$E3BF: 03          .byte $03  ; غير معرّف
$E3C0: 0C          .byte $0C  ; غير معرّف
$E3C1: 02          .byte $02  ; غير معرّف
$E3C2: 02          .byte $02  ; غير معرّف
$E3C3: 0D 0D 08 ORA  $080D
$E3C6: 00       BRK  
$E3C7: 10 04    BPL  $E3CD
$E3C9: 14          .byte $14  ; غير معرّف
$E3CA: 04          .byte $04  ; غير معرّف
$E3CB: 04          .byte $04  ; غير معرّف
$E3CC: 04          .byte $04  ; غير معرّف
$E3CD: 20 20 08 JSR  $0820
$E3D0: 18       CLC  
$E3D1: 08       PHP  
$E3D2: 18       CLC  
$E3D3: 02          .byte $02  ; غير معرّف
$E3D4: 20 20 08 JSR  $0820
$E3D7: 18       CLC  
$E3D8: 08       PHP  
$E3D9: 18       CLC  
$E3DA: 12          .byte $12  ; غير معرّف
$E3DB: 20 20 18 JSR  $1820
$E3DE: 18       CLC  
$E3DF: 18       CLC  
$E3E0: 18       CLC  
$E3E1: 18       CLC  
$E3E2: 14          .byte $14  ; غير معرّف
$E3E3: 14          .byte $14  ; غير معرّف
$E3E4: 06 06    ASL  $06
$E3E6: 08       PHP  
$E3E7: 10 C8    BPL  $E3B1
$E3E9: A9 00    LDA  #$00
$E3EB: 2C A9 01 BIT  $01A9
$E3EE: A2 00    LDX  #$00
$E3F0: 48       PHA  
$E3F1: 84 04    STY  $04
$E3F3: B9 B0 E3 LDA  $E3B0,Y
$E3F6: 18       CLC  
$E3F7: 75 86    ADC  $86,X
$E3F9: 85 05    STA  $05
$E3FB: B5 6D    LDA  $6D,X
$E3FD: 69 00    ADC  #$00
$E3FF: 29 01    AND  #$01
$E401: 4A       LSR  A
$E402: 05 05    ORA  $05
$E404: 6A       ROR  A
$E405: 4A       LSR  A
$E406: 4A       LSR  A
$E407: 4A       LSR  A
$E408: 20 E1 9B JSR  $9BE1
$E40B: A4 04    LDY  $04
$E40D: B5 CE    LDA  $CE,X
$E40F: 18       CLC  
$E410: 79 CC E3 ADC  $E3CC,Y
$E413: 29 F0    AND  #$F0
$E415: 38       SEC  
$E416: E9 20    SBC  #$20
$E418: 85 02    STA  $02
$E41A: A8       TAY  
$E41B: B1 06    LDA  ($06),Y
$E41D: 85 03    STA  $03
$E41F: A4 04    LDY  $04
$E421: 68       PLA  
$E422: D0 05    BNE  $E429
$E424: B5 CE    LDA  $CE,X
$E426: 4C 2B E4 JMP  $E42B
$E429: B5 86    LDA  $86,X
$E42B: 29 0F    AND  #$0F
$E42D: 85 04    STA  $04
$E42F: A5 03    LDA  $03
$E431: 60       RTS  
$E432: FF          .byte $FF  ; غير معرّف
$E433: 00       BRK  
$E434: 30 84    BMI  $E3BA
$E436: 00       BRK  
$E437: AD B9 03 LDA  $03B9
$E43A: 18       CLC  
$E43B: 79 33 E4 ADC  $E433,Y
$E43E: BE 9A 03 LDX  $039A,Y
$E441: BC E5 06 LDY  $06E5,X
$E444: 84 02    STY  $02
$E446: 20 AE E4 JSR  $E4AE
$E449: AD AE 03 LDA  $03AE
$E44C: 99 03 02 STA  $0203,Y
$E44F: 99 0B 02 STA  $020B,Y
$E452: 99 13 02 STA  $0213,Y
$E455: 18       CLC  
$E456: 69 06    ADC  #$06
$E458: 99 07 02 STA  $0207,Y
$E45B: 99 0F 02 STA  $020F,Y
$E45E: 99 17 02 STA  $0217,Y
$E461: A9 21    LDA  #$21
$E463: 99 02 02 STA  $0202,Y
$E466: 99 0A 02 STA  $020A,Y
$E469: 99 12 02 STA  $0212,Y
$E46C: 09 40    ORA  #$40
$E46E: 99 06 02 STA  $0206,Y
$E471: 99 0E 02 STA  $020E,Y
$E474: 99 16 02 STA  $0216,Y
$E477: A2 05    LDX  #$05
$E479: A9 E1    LDA  #$E1
$E47B: 99 01 02 STA  $0201,Y
$E47E: C8       INY  
$E47F: C8       INY  
$E480: C8       INY  
$E481: C8       INY  
$E482: CA       DEX  
$E483: 10 F4    BPL  $E479
$E485: A4 02    LDY  $02
$E487: A5 00    LDA  $00
$E489: D0 05    BNE  $E490
$E48B: A9 E0    LDA  #$E0
$E48D: 99 01 02 STA  $0201,Y
$E490: A2 00    LDX  #$00
$E492: AD 9D 03 LDA  $039D
$E495: 38       SEC  
$E496: F9 00 02 SBC  $0200,Y
$E499: C9          .byte $C9  ; غير معرّف
$E49A: 64          .byte $64  ; غير معرّف
$E49B: 90 05    BCC  $E4A2
$E49D: A9 F8    LDA  #$F8
$E49F: 99 00 02 STA  $0200,Y
$E4A2: C8       INY  
$E4A3: C8       INY  
$E4A4: C8       INY  
$E4A5: C8       INY  
$E4A6: E8       INX  
$E4A7: E0 06    CPX  #$06
$E4A9: D0 E7    BNE  $E492
$E4AB: A4 00    LDY  $00
$E4AD: 60       RTS  
$E4AE: A2 06    LDX  #$06
$E4B0: 99 00 02 STA  $0200,Y
$E4B3: 18       CLC  
$E4B4: 69 08    ADC  #$08
$E4B6: C8       INY  
$E4B7: C8       INY  
$E4B8: C8       INY  
$E4B9: C8       INY  
$E4BA: CA       DEX  
$E4BB: D0 F3    BNE  $E4B0
$E4BD: A4 02    LDY  $02
$E4BF: 60       RTS  
$E4C0: 04          .byte $04  ; غير معرّف
$E4C1: 00       BRK  
$E4C2: 04          .byte $04  ; غير معرّف
$E4C3: 00       BRK  
$E4C4: 00       BRK  
$E4C5: 04          .byte $04  ; غير معرّف
$E4C6: 00       BRK  
$E4C7: 04          .byte $04  ; غير معرّف
$E4C8: 00       BRK  
$E4C9: 08       PHP  
$E4CA: 00       BRK  
$E4CB: 08       PHP  
$E4CC: 08       PHP  
$E4CD: 00       BRK  
$E4CE: 08       PHP  
$E4CF: 00       BRK  
$E4D0: 80          .byte $80  ; غير معرّف
$E4D1: 82          .byte $82  ; غير معرّف
$E4D2: 81 83    STA  ($83,X)
$E4D4: 81 83    STA  ($83,X)
$E4D6: 80          .byte $80  ; غير معرّف
$E4D7: 82          .byte $82  ; غير معرّف
$E4D8: 03          .byte $03  ; غير معرّف
$E4D9: 03          .byte $03  ; غير معرّف
$E4DA: C3          .byte $C3  ; غير معرّف
$E4DB: C3          .byte $C3  ; غير معرّف
$E4DC: BC F3 06 LDY  $06F3,X
$E4DF: AD 47 07 LDA  $0747
$E4E2: D0 08    BNE  $E4EC
$E4E4: B5 2A    LDA  $2A,X
$E4E6: 29 7F    AND  #$7F
$E4E8: C9          .byte $C9  ; غير معرّف
$E4E9: 01 F0    ORA  ($F0,X)
$E4EB: 04          .byte $04  ; غير معرّف
$E4EC: A2 00    LDX  #$00
$E4EE: F0 07    BEQ  $E4F7
$E4F0: A5 09    LDA  $09
$E4F2: 4A       LSR  A
$E4F3: 4A       LSR  A
$E4F4: 29 03    AND  #$03
$E4F6: AA       TAX  
$E4F7: AD BE 03 LDA  $03BE
$E4FA: 18       CLC  
$E4FB: 7D C4 E4 ADC  $E4C4,X
$E4FE: 99 00 02 STA  $0200,Y
$E501: 18       CLC  
$E502: 7D CC E4 ADC  $E4CC,X
$E505: 99 04 02 STA  $0204,Y
$E508: AD B3 03 LDA  $03B3
$E50B: 18       CLC  
$E50C: 7D C0 E4 ADC  $E4C0,X
$E50F: 99 03 02 STA  $0203,Y
$E512: 18       CLC  
$E513: 7D C8 E4 ADC  $E4C8,X
$E516: 99 07 02 STA  $0207,Y
$E519: BD D0 E4 LDA  $E4D0,X
$E51C: 99 01 02 STA  $0201,Y
$E51F: BD D4 E4 LDA  $E4D4,X
$E522: 99 05 02 STA  $0205,Y
$E525: BD D8 E4 LDA  $E4D8,X
$E528: 99 02 02 STA  $0202,Y
$E52B: 99 06 02 STA  $0206,Y
$E52E: A6 08    LDX  $08
$E530: AD D6 03 LDA  $03D6
$E533: 29 FC    AND  #$FC
$E535: F0 09    BEQ  $E540
$E537: A9 00    LDA  #$00
$E539: 95 2A    STA  $2A,X
$E53B: A9 F8    LDA  #$F8
$E53D: 20 C1 E5 JSR  $E5C1
$E540: 60       RTS  
$E541: F9 50 F7 SBC  $F750,Y
$E544: 50 FA    BVC  $E540
$E546: FB          .byte $FB  ; غير معرّف
$E547: F8       SED  
$E548: FB          .byte $FB  ; غير معرّف
$E549: F6 FB    INC  $FB,X
$E54B: BC E5 06 LDY  $06E5,X
$E54E: AD AE 03 LDA  $03AE
$E551: 99 03 02 STA  $0203,Y
$E554: 18       CLC  
$E555: 69 08    ADC  #$08
$E557: 99 07 02 STA  $0207,Y
$E55A: 99 0B 02 STA  $020B,Y
$E55D: 18       CLC  
$E55E: 69 0C    ADC  #$0C
$E560: 85 05    STA  $05
$E562: B5 CF    LDA  $CF,X
$E564: 20 C1 E5 JSR  $E5C1
$E567: 69 08    ADC  #$08
$E569: 99 08 02 STA  $0208,Y
$E56C: AD 0D 01 LDA  $010D
$E56F: 85 02    STA  $02
$E571: A9 01    LDA  #$01
$E573: 85 03    STA  $03
$E575: 85 04    STA  $04
$E577: 99 02 02 STA  $0202,Y
$E57A: 99 06 02 STA  $0206,Y
$E57D: 99 0A 02 STA  $020A,Y
$E580: A9 7E    LDA  #$7E
$E582: 99 01 02 STA  $0201,Y
$E585: 99 09 02 STA  $0209,Y
$E588: A9 7F    LDA  #$7F
$E58A: 99 05 02 STA  $0205,Y
$E58D: AD 0F 07 LDA  $070F
$E590: F0 15    BEQ  $E5A7
$E592: 98       TYA  
$E593: 18       CLC  
$E594: 69 0C    ADC  #$0C
$E596: A8       TAY  
$E597: AD 0F 01 LDA  $010F
$E59A: 0A       ASL  A
$E59B: AA       TAX  
$E59C: BD 41 E5 LDA  $E541,X
$E59F: 85 00    STA  $00
$E5A1: BD 42 E5 LDA  $E542,X
$E5A4: 20 B2 EB JSR  $EBB2
$E5A7: A6 08    LDX  $08
$E5A9: BC E5 06 LDY  $06E5,X
$E5AC: AD D1 03 LDA  $03D1
$E5AF: 29 0E    AND  #$0E
$E5B1: F0 14    BEQ  $E5C7
$E5B3: A9 F8    LDA  #$F8
$E5B5: 99 14 02 STA  $0214,Y
$E5B8: 99 10 02 STA  $0210,Y
$E5BB: 99 0C 02 STA  $020C,Y
$E5BE: 99 08 02 STA  $0208,Y
$E5C1: 99 04 02 STA  $0204,Y
$E5C4: 99 00 02 STA  $0200,Y
$E5C7: 60       RTS  
$E5C8: BC E5 06 LDY  $06E5,X
$E5CB: 84 02    STY  $02
$E5CD: C8       INY  
$E5CE: C8       INY  
$E5CF: C8       INY  
$E5D0: AD AE 03 LDA  $03AE
$E5D3: 20 AE E4 JSR  $E4AE
$E5D6: A6 08    LDX  $08
$E5D8: B5 CF    LDA  $CF,X
$E5DA: 20 BB E5 JSR  $E5BB
$E5DD: AC 4E 07 LDY  $074E
$E5E0: C0 03    CPY  #$03
$E5E2: F0 05    BEQ  $E5E9
$E5E4: AC CC 06 LDY  $06CC
$E5E7: F0 02    BEQ  $E5EB
$E5E9: A9 F8    LDA  #$F8
$E5EB: BC E5 06 LDY  $06E5,X
$E5EE: 99 10 02 STA  $0210,Y
$E5F1: 99 14 02 STA  $0214,Y
$E5F4: A9 5B    LDA  #$5B
$E5F6: AE 43 07 LDX  $0743
$E5F9: F0 02    BEQ  $E5FD
$E5FB: A9 75    LDA  #$75
$E5FD: A6 08    LDX  $08
$E5FF: C8       INY  
$E600: 20 B5 E5 JSR  $E5B5
$E603: A9 02    LDA  #$02
$E605: C8       INY  
$E606: 20 B5 E5 JSR  $E5B5
$E609: E8       INX  
$E60A: 20 F6 F1 JSR  $F1F6
$E60D: CA       DEX  
$E60E: BC E5 06 LDY  $06E5,X
$E611: 0A       ASL  A
$E612: 48       PHA  
$E613: 90 05    BCC  $E61A
$E615: A9 F8    LDA  #$F8
$E617: 99 00 02 STA  $0200,Y
$E61A: 68       PLA  
$E61B: 0A       ASL  A
$E61C: 48       PHA  
$E61D: 90 05    BCC  $E624
$E61F: A9 F8    LDA  #$F8
$E621: 99 04 02 STA  $0204,Y
$E624: 68       PLA  
$E625: 0A       ASL  A
$E626: 48       PHA  
$E627: 90 05    BCC  $E62E
$E629: A9 F8    LDA  #$F8
$E62B: 99 08 02 STA  $0208,Y
$E62E: 68       PLA  
$E62F: 0A       ASL  A
$E630: 48       PHA  
$E631: 90 05    BCC  $E638
$E633: A9 F8    LDA  #$F8
$E635: 99 0C 02 STA  $020C,Y
$E638: 68       PLA  
$E639: 0A       ASL  A
$E63A: 48       PHA  
$E63B: 90 05    BCC  $E642
$E63D: A9 F8    LDA  #$F8
$E63F: 99 10 02 STA  $0210,Y
$E642: 68       PLA  
$E643: 0A       ASL  A
$E644: 90 05    BCC  $E64B
$E646: A9 F8    LDA  #$F8
$E648: 99 14 02 STA  $0214,Y
$E64B: AD D1 03 LDA  $03D1
$E64E: 0A       ASL  A
$E64F: 90 03    BCC  $E654
$E651: 20 B3 E5 JSR  $E5B3
$E654: 60       RTS  
$E655: A5 09    LDA  $09
$E657: 4A       LSR  A
$E658: B0 02    BCS  $E65C
$E65A: D6 DB    DEC  $DB,X
$E65C: B5 DB    LDA  $DB,X
$E65E: 20 C1 E5 JSR  $E5C1
$E661: AD B3 03 LDA  $03B3
$E664: 99 03 02 STA  $0203,Y
$E667: 18       CLC  
$E668: 69 08    ADC  #$08
$E66A: 99 07 02 STA  $0207,Y
$E66D: A9 02    LDA  #$02
$E66F: 99 02 02 STA  $0202,Y
$E672: 99 06 02 STA  $0206,Y
$E675: A9 F7    LDA  #$F7
$E677: 99 01 02 STA  $0201,Y
$E67A: A9 FB    LDA  #$FB
$E67C: 99 05 02 STA  $0205,Y
$E67F: 4C BD E6 JMP  $E6BD
$E682: 60       RTS  
$E683: 61 62    ADC  ($62,X)
$E685: 63          .byte $63  ; غير معرّف
$E686: BC F3 06 LDY  $06F3,X
$E689: B5 2A    LDA  $2A,X
$E68B: C9          .byte $C9  ; غير معرّف
$E68C: 02          .byte $02  ; غير معرّف
$E68D: B0 C6    BCS  $E655
$E68F: B5 DB    LDA  $DB,X
$E691: 99 00 02 STA  $0200,Y
$E694: 18       CLC  
$E695: 69 08    ADC  #$08
$E697: 99 04 02 STA  $0204,Y
$E69A: AD B3 03 LDA  $03B3
$E69D: 99 03 02 STA  $0203,Y
$E6A0: 99 07 02 STA  $0207,Y
$E6A3: A5 09    LDA  $09
$E6A5: 4A       LSR  A
$E6A6: 29 03    AND  #$03
$E6A8: AA       TAX  
$E6A9: BD 82 E6 LDA  $E682,X
$E6AC: C8       INY  
$E6AD: 20 C1 E5 JSR  $E5C1
$E6B0: 88       DEY  
$E6B1: A9 02    LDA  #$02
$E6B3: 99 02 02 STA  $0202,Y
$E6B6: A9 82    LDA  #$82
$E6B8: 99 06 02 STA  $0206,Y
$E6BB: A6 08    LDX  $08
$E6BD: 60       RTS  
$E6BE: 76 77    ROR  $77,X
$E6C0: 78       SEI  
$E6C1: 79 D6 D6 ADC  $D6D6,Y
$E6C4: D9 D9 8D CMP  $8DD9,Y
$E6C7: 8D E4 E4 STA  $E4E4
$E6CA: 76 77    ROR  $77,X
$E6CC: 78       SEI  
$E6CD: 79 02 01 ADC  $0102,Y
$E6D0: 02          .byte $02  ; غير معرّف
$E6D1: 01 AC    ORA  ($AC,X)
$E6D3: EA       NOP  
$E6D4: 06 AD    ASL  $AD
$E6D6: B9 03 18 LDA  $1803,Y
$E6D9: 69 08    ADC  #$08
$E6DB: 85 02    STA  $02
$E6DD: AD AE 03 LDA  $03AE
$E6E0: 85 05    STA  $05
$E6E2: A6 39    LDX  $39
$E6E4: BD CE E6 LDA  $E6CE,X
$E6E7: 0D CA 03 ORA  $03CA
$E6EA: 85 04    STA  $04
$E6EC: 8A       TXA  
$E6ED: 48       PHA  
$E6EE: 0A       ASL  A
$E6EF: 0A       ASL  A
$E6F0: AA       TAX  
$E6F1: A9 01    LDA  #$01
$E6F3: 85 07    STA  $07
$E6F5: 85 03    STA  $03
$E6F7: BD BE E6 LDA  $E6BE,X
$E6FA: 85 00    STA  $00
$E6FC: BD BF E6 LDA  $E6BF,X
$E6FF: 20 B2 EB JSR  $EBB2
$E702: C6 07    DEC  $07
$E704: 10 F1    BPL  $E6F7
$E706: AC EA 06 LDY  $06EA
$E709: 68       PLA  
$E70A: F0 2F    BEQ  $E73B
$E70C: C9          .byte $C9  ; غير معرّف
$E70D: 03          .byte $03  ; غير معرّف
$E70E: F0 2B    BEQ  $E73B
$E710: 85 00    STA  $00
$E712: A5 09    LDA  $09
$E714: 4A       LSR  A
$E715: 29 03    AND  #$03
$E717: 0D CA 03 ORA  $03CA
$E71A: 99 02 02 STA  $0202,Y
$E71D: 99 06 02 STA  $0206,Y
$E720: A6 00    LDX  $00
$E722: CA       DEX  
$E723: F0 06    BEQ  $E72B
$E725: 99 0A 02 STA  $020A,Y
$E728: 99 0E 02 STA  $020E,Y
$E72B: B9 06 02 LDA  $0206,Y
$E72E: 09 40    ORA  #$40
$E730: 99 06 02 STA  $0206,Y
$E733: B9 0E 02 LDA  $020E,Y
$E736: 09 40    ORA  #$40
$E738: 99 0E 02 STA  $020E,Y
$E73B: 4C 64 EB JMP  $EB64
$E73E: FC          .byte $FC  ; غير معرّف
$E73F: FC          .byte $FC  ; غير معرّف
$E740: AA       TAX  
$E741: AB          .byte $AB  ; غير معرّف
$E742: AC AD FC LDY  $FCAD
$E745: FC          .byte $FC  ; غير معرّف
$E746: AE AF B0 LDX  $B0AF
$E749: B1 FC    LDA  ($FC),Y
$E74B: A5 A6    LDA  $A6
$E74D: A7          .byte $A7  ; غير معرّف
$E74E: A8       TAY  
$E74F: A9 FC    LDA  #$FC
$E751: A0 A1    LDY  #$A1
$E753: A2 A3    LDX  #$A3
$E755: A4 69    LDY  $69
$E757: A5 6A    LDA  $6A
$E759: A7          .byte $A7  ; غير معرّف
$E75A: A8       TAY  
$E75B: A9 6B    LDA  #$6B
$E75D: A0 6C    LDY  #$6C
$E75F: A2 A3    LDX  #$A3
$E761: A4 FC    LDY  $FC
$E763: FC          .byte $FC  ; غير معرّف
$E764: 96 97    STX  $97,Y
$E766: 98       TYA  
$E767: 99 FC FC STA  $FCFC,Y
$E76A: 9A       TXS  
$E76B: 9B          .byte $9B  ; غير معرّف
$E76C: 9C          .byte $9C  ; غير معرّف
$E76D: 9D FC FC STA  $FCFC,X
$E770: 8F          .byte $8F  ; غير معرّف
$E771: 8E 8E 8F STX  $8F8E
$E774: FC          .byte $FC  ; غير معرّف
$E775: FC          .byte $FC  ; غير معرّف
$E776: 95 94    STA  $94,X
$E778: 94 95    STY  $95,X
$E77A: FC          .byte $FC  ; غير معرّف
$E77B: FC          .byte $FC  ; غير معرّف
$E77C: DC          .byte $DC  ; غير معرّف
$E77D: DC          .byte $DC  ; غير معرّف
$E77E: DF          .byte $DF  ; غير معرّف
$E77F: DF          .byte $DF  ; غير معرّف
$E780: DC          .byte $DC  ; غير معرّف
$E781: DC          .byte $DC  ; غير معرّف
$E782: DD DD DE CMP  $DEDD,X
$E785: DE FC FC DEC  $FCFC,X
$E788: B2          .byte $B2  ; غير معرّف
$E789: B3          .byte $B3  ; غير معرّف
$E78A: B4 B5    LDY  $B5,X
$E78C: FC          .byte $FC  ; غير معرّف
$E78D: FC          .byte $FC  ; غير معرّف
$E78E: B6 B3    LDX  $B3,Y
$E790: B7          .byte $B7  ; غير معرّف
$E791: B5 FC    LDA  $FC,X
$E793: FC          .byte $FC  ; غير معرّف
$E794: 70 71    BVS  $E807
$E796: 72          .byte $72  ; غير معرّف
$E797: 73          .byte $73  ; غير معرّف
$E798: FC          .byte $FC  ; غير معرّف
$E799: FC          .byte $FC  ; غير معرّف
$E79A: 6E 6E 6F ROR  $6F6E
$E79D: 6F          .byte $6F  ; غير معرّف
$E79E: FC          .byte $FC  ; غير معرّف
$E79F: FC          .byte $FC  ; غير معرّف
$E7A0: 6D 6D 6F ADC  $6F6D
$E7A3: 6F          .byte $6F  ; غير معرّف
$E7A4: FC          .byte $FC  ; غير معرّف
$E7A5: FC          .byte $FC  ; غير معرّف
$E7A6: 6F          .byte $6F  ; غير معرّف
$E7A7: 6F          .byte $6F  ; غير معرّف
$E7A8: 6E 6E FC ROR  $FC6E
$E7AB: FC          .byte $FC  ; غير معرّف
$E7AC: 6F          .byte $6F  ; غير معرّف
$E7AD: 6F          .byte $6F  ; غير معرّف
$E7AE: 6D 6D FC ADC  $FC6D
$E7B1: FC          .byte $FC  ; غير معرّف
$E7B2: F4          .byte $F4  ; غير معرّف
$E7B3: F4          .byte $F4  ; غير معرّف
$E7B4: F5 F5    SBC  $F5,X
$E7B6: FC          .byte $FC  ; غير معرّف
$E7B7: FC          .byte $FC  ; غير معرّف
$E7B8: F4          .byte $F4  ; غير معرّف
$E7B9: F4          .byte $F4  ; غير معرّف
$E7BA: F5 F5    SBC  $F5,X
$E7BC: FC          .byte $FC  ; غير معرّف
$E7BD: FC          .byte $FC  ; غير معرّف
$E7BE: F5 F5    SBC  $F5,X
$E7C0: F4          .byte $F4  ; غير معرّف
$E7C1: F4          .byte $F4  ; غير معرّف
$E7C2: FC          .byte $FC  ; غير معرّف
$E7C3: FC          .byte $FC  ; غير معرّف
$E7C4: F5 F5    SBC  $F5,X
$E7C6: F4          .byte $F4  ; غير معرّف
$E7C7: F4          .byte $F4  ; غير معرّف
$E7C8: FC          .byte $FC  ; غير معرّف
$E7C9: FC          .byte $FC  ; غير معرّف
$E7CA: FC          .byte $FC  ; غير معرّف
$E7CB: FC          .byte $FC  ; غير معرّف
$E7CC: EF          .byte $EF  ; غير معرّف
$E7CD: EF          .byte $EF  ; غير معرّف
$E7CE: B9 B8 BB LDA  $BBB8,Y
$E7D1: BA       TSX  
$E7D2: BC BC FC LDY  $FCBC,X
$E7D5: FC          .byte $FC  ; غير معرّف
$E7D6: BD BD BC LDA  $BCBD,X
$E7D9: BC 7A 7B LDY  $7B7A,X
$E7DC: DA          .byte $DA  ; غير معرّف
$E7DD: DB          .byte $DB  ; غير معرّف
$E7DE: D8       CLD  
$E7DF: D8       CLD  
$E7E0: CD CD CE CMP  $CECD
$E7E3: CE CF CF DEC  $CFCF
$E7E6: 7D 7C D1 ADC  $D17C,X
$E7E9: 8C D3 D2 STY  $D2D3
$E7EC: 7D 7C 89 ADC  $897C,X
$E7EF: 88       DEY  
$E7F0: 8B          .byte $8B  ; غير معرّف
$E7F1: 8A       TXA  
$E7F2: D5 D4    CMP  $D4,X
$E7F4: E3          .byte $E3  ; غير معرّف
$E7F5: E2          .byte $E2  ; غير معرّف
$E7F6: D3          .byte $D3  ; غير معرّف
$E7F7: D2          .byte $D2  ; غير معرّف
$E7F8: D5 D4    CMP  $D4,X
$E7FA: E3          .byte $E3  ; غير معرّف
$E7FB: E2          .byte $E2  ; غير معرّف
$E7FC: 8B          .byte $8B  ; غير معرّف
$E7FD: 8A       TXA  
$E7FE: E5 E5    SBC  $E5
$E800: E6 E6    INC  $E6
$E802: EB          .byte $EB  ; غير معرّف
$E803: EB          .byte $EB  ; غير معرّف
$E804: EC EC ED CPX  $EDEC
$E807: ED EE EE SBC  $EEEE
$E80A: FC          .byte $FC  ; غير معرّف
$E80B: FC          .byte $FC  ; غير معرّف
$E80C: D0 D0    BNE  $E7DE
$E80E: D7          .byte $D7  ; غير معرّف
$E80F: D7          .byte $D7  ; غير معرّف
$E810: BF          .byte $BF  ; غير معرّف
$E811: BE C1 C0 LDX  $C0C1,Y
$E814: C2          .byte $C2  ; غير معرّف
$E815: FC          .byte $FC  ; غير معرّف
$E816: C4 C3    CPY  $C3
$E818: C6 C5    DEC  $C5
$E81A: C8       INY  
$E81B: C7          .byte $C7  ; غير معرّف
$E81C: BF          .byte $BF  ; غير معرّف
$E81D: BE CA C9 LDX  $C9CA,Y
$E820: C2          .byte $C2  ; غير معرّف
$E821: FC          .byte $FC  ; غير معرّف
$E822: C4 C3    CPY  $C3
$E824: C6 C5    DEC  $C5
$E826: CC CB FC CPY  $FCCB
$E829: FC          .byte $FC  ; غير معرّف
$E82A: E8       INX  
$E82B: E7          .byte $E7  ; غير معرّف
$E82C: EA       NOP  
$E82D: E9 F2    SBC  #$F2
$E82F: F2          .byte $F2  ; غير معرّف
$E830: F3          .byte $F3  ; غير معرّف
$E831: F3          .byte $F3  ; غير معرّف
$E832: F2          .byte $F2  ; غير معرّف
$E833: F2          .byte $F2  ; غير معرّف
$E834: F1 F1    SBC  ($F1),Y
$E836: F1 F1    SBC  ($F1),Y
$E838: FC          .byte $FC  ; غير معرّف
$E839: FC          .byte $FC  ; غير معرّف
$E83A: F0 F0    BEQ  $E82C
$E83C: FC          .byte $FC  ; غير معرّف
$E83D: FC          .byte $FC  ; غير معرّف
$E83E: FC          .byte $FC  ; غير معرّف
$E83F: FC          .byte $FC  ; غير معرّف
$E840: 0C          .byte $0C  ; غير معرّف
$E841: 0C          .byte $0C  ; غير معرّف
$E842: 00       BRK  
$E843: 0C          .byte $0C  ; غير معرّف
$E844: 0C          .byte $0C  ; غير معرّف
$E845: A8       TAY  
$E846: 54          .byte $54  ; غير معرّف
$E847: 3C          .byte $3C  ; غير معرّف
$E848: EA       NOP  
$E849: 18       CLC  
$E84A: 48       PHA  
$E84B: 48       PHA  
$E84C: CC C0 18 CPY  $18C0
$E84F: 18       CLC  
$E850: 18       CLC  
$E851: 90 24    BCC  $E877
$E853: FF          .byte $FF  ; غير معرّف
$E854: 48       PHA  
$E855: 9C          .byte $9C  ; غير معرّف
$E856: D2          .byte $D2  ; غير معرّف
$E857: D8       CLD  
$E858: F0 F6    BEQ  $E850
$E85A: FC          .byte $FC  ; غير معرّف
$E85B: 01 02    ORA  ($02,X)
$E85D: 03          .byte $03  ; غير معرّف
$E85E: 02          .byte $02  ; غير معرّف
$E85F: 01 01    ORA  ($01,X)
$E861: 03          .byte $03  ; غير معرّف
$E862: 03          .byte $03  ; غير معرّف
$E863: 03          .byte $03  ; غير معرّف
$E864: 01 01    ORA  ($01,X)
$E866: 02          .byte $02  ; غير معرّف
$E867: 02          .byte $02  ; غير معرّف
$E868: 21 01    AND  ($01,X)
$E86A: 02          .byte $02  ; غير معرّف
$E86B: 01 01    ORA  ($01,X)
$E86D: 02          .byte $02  ; غير معرّف
$E86E: FF          .byte $FF  ; غير معرّف
$E86F: 02          .byte $02  ; غير معرّف
$E870: 02          .byte $02  ; غير معرّف
$E871: 01 01    ORA  ($01,X)
$E873: 02          .byte $02  ; غير معرّف
$E874: 02          .byte $02  ; غير معرّف
$E875: 02          .byte $02  ; غير معرّف
$E876: 08       PHP  
$E877: 18       CLC  
$E878: 18       CLC  
$E879: 19 1A 19 ORA  $191A,Y
$E87C: 18       CLC  
$E87D: B5 CF    LDA  $CF,X
$E87F: 85 02    STA  $02
$E881: AD AE 03 LDA  $03AE
$E884: 85 05    STA  $05
$E886: BC E5 06 LDY  $06E5,X
$E889: 84 EB    STY  $EB
$E88B: A9 00    LDA  #$00
$E88D: 8D 09 01 STA  $0109
$E890: B5 46    LDA  $46,X
$E892: 85 03    STA  $03
$E894: BD C5 03 LDA  $03C5,X
$E897: 85 04    STA  $04
$E899: B5 16    LDA  $16,X
$E89B: C9          .byte $C9  ; غير معرّف
$E89C: 0D D0 0A ORA  $0AD0
$E89F: B4 58    LDY  $58,X
$E8A1: 30 06    BMI  $E8A9
$E8A3: BC 8A 07 LDY  $078A,X
$E8A6: F0 01    BEQ  $E8A9
$E8A8: 60       RTS  
$E8A9: B5 1E    LDA  $1E,X
$E8AB: 85 ED    STA  $ED
$E8AD: 29 1F    AND  #$1F
$E8AF: A8       TAY  
$E8B0: B5 16    LDA  $16,X
$E8B2: C9          .byte $C9  ; غير معرّف
$E8B3: 35 D0    AND  $D0,X
$E8B5: 08       PHP  
$E8B6: A0 00    LDY  #$00
$E8B8: A9 01    LDA  #$01
$E8BA: 85 03    STA  $03
$E8BC: A9 15    LDA  #$15
$E8BE: C9          .byte $C9  ; غير معرّف
$E8BF: 33          .byte $33  ; غير معرّف
$E8C0: D0 13    BNE  $E8D5
$E8C2: C6 02    DEC  $02
$E8C4: A9 03    LDA  #$03
$E8C6: BC 8A 07 LDY  $078A,X
$E8C9: F0 02    BEQ  $E8CD
$E8CB: 09 20    ORA  #$20
$E8CD: 85 04    STA  $04
$E8CF: A0 00    LDY  #$00
$E8D1: 84 ED    STY  $ED
$E8D3: A9 08    LDA  #$08
$E8D5: C9          .byte $C9  ; غير معرّف
$E8D6: 32          .byte $32  ; غير معرّف
$E8D7: D0 08    BNE  $E8E1
$E8D9: A0 03    LDY  #$03
$E8DB: AE 0E 07 LDX  $070E
$E8DE: BD 78 E8 LDA  $E878,X
$E8E1: 85 EF    STA  $EF
$E8E3: 84 EC    STY  $EC
$E8E5: A6 08    LDX  $08
$E8E7: C9          .byte $C9  ; غير معرّف
$E8E8: 0C          .byte $0C  ; غير معرّف
$E8E9: D0 07    BNE  $E8F2
$E8EB: B5 A0    LDA  $A0,X
$E8ED: 30 03    BMI  $E8F2
$E8EF: EE 09 01 INC  $0109
$E8F2: AD 6A 03 LDA  $036A
$E8F5: F0 09    BEQ  $E900
$E8F7: A0 16    LDY  #$16
$E8F9: C9          .byte $C9  ; غير معرّف
$E8FA: 01 F0    ORA  ($F0,X)
$E8FC: 01 C8    ORA  ($C8,X)
$E8FE: 84 EF    STY  $EF
$E900: A4 EF    LDY  $EF
$E902: C0 06    CPY  #$06
$E904: D0 1D    BNE  $E923
$E906: B5 1E    LDA  $1E,X
$E908: C9          .byte $C9  ; غير معرّف
$E909: 02          .byte $02  ; غير معرّف
$E90A: 90 04    BCC  $E910
$E90C: A2 04    LDX  #$04
$E90E: 86 EC    STX  $EC
$E910: 29 20    AND  #$20
$E912: 0D 47 07 ORA  $0747
$E915: D0 0C    BNE  $E923
$E917: A5 09    LDA  $09
$E919: 29 08    AND  #$08
$E91B: D0 06    BNE  $E923
$E91D: A5 03    LDA  $03
$E91F: 49 03    EOR  #$03
$E921: 85 03    STA  $03
$E923: B9 5B E8 LDA  $E85B,Y
$E926: 05 04    ORA  $04
$E928: 85 04    STA  $04
$E92A: B9 40 E8 LDA  $E840,Y
$E92D: AA       TAX  
$E92E: A4 EC    LDY  $EC
$E930: AD 6A 03 LDA  $036A
$E933: F0 30    BEQ  $E965
$E935: C9          .byte $C9  ; غير معرّف
$E936: 01 D0    ORA  ($D0,X)
$E938: 13          .byte $13  ; غير معرّف
$E939: AD 63 03 LDA  $0363
$E93C: 10 02    BPL  $E940
$E93E: A2 DE    LDX  #$DE
$E940: A5 ED    LDA  $ED
$E942: 29 20    AND  #$20
$E944: F0 03    BEQ  $E949
$E946: 8E 09 01 STX  $0109
$E949: 4C 4B EA JMP  $EA4B
$E94C: AD 63 03 LDA  $0363
$E94F: 29 01    AND  #$01
$E951: F0 02    BEQ  $E955
$E953: A2 E4    LDX  #$E4
$E955: A5 ED    LDA  $ED
$E957: 29 20    AND  #$20
$E959: F0 EE    BEQ  $E949
$E95B: A5 02    LDA  $02
$E95D: 38       SEC  
$E95E: E9 10    SBC  #$10
$E960: 85 02    STA  $02
$E962: 4C 46 E9 JMP  $E946
$E965: E0 24    CPX  #$24
$E967: D0 11    BNE  $E97A
$E969: C0 05    CPY  #$05
$E96B: D0 0A    BNE  $E977
$E96D: A2 30    LDX  #$30
$E96F: A9 02    LDA  #$02
$E971: 85 03    STA  $03
$E973: A9 05    LDA  #$05
$E975: 85 EC    STA  $EC
$E977: 4C CA E9 JMP  $E9CA
$E97A: E0 90    CPX  #$90
$E97C: D0 12    BNE  $E990
$E97E: A5 ED    LDA  $ED
$E980: 29 20    AND  #$20
$E982: D0 09    BNE  $E98D
$E984: AD 8F 07 LDA  $078F
$E987: C9          .byte $C9  ; غير معرّف
$E988: 10 B0    BPL  $E93A
$E98A: 02          .byte $02  ; غير معرّف
$E98B: A2 96    LDX  #$96
$E98D: 4C 37 EA JMP  $EA37
$E990: A5 EF    LDA  $EF
$E992: C9          .byte $C9  ; غير معرّف
$E993: 04          .byte $04  ; غير معرّف
$E994: B0 10    BCS  $E9A6
$E996: C0 02    CPY  #$02
$E998: 90 0C    BCC  $E9A6
$E99A: A2 5A    LDX  #$5A
$E99C: A4 EF    LDY  $EF
$E99E: C0 02    CPY  #$02
$E9A0: D0 04    BNE  $E9A6
$E9A2: A2 7E    LDX  #$7E
$E9A4: E6 02    INC  $02
$E9A6: A5 EC    LDA  $EC
$E9A8: C9          .byte $C9  ; غير معرّف
$E9A9: 04          .byte $04  ; غير معرّف
$E9AA: D0 1E    BNE  $E9CA
$E9AC: A2 72    LDX  #$72
$E9AE: E6 02    INC  $02
$E9B0: A4 EF    LDY  $EF
$E9B2: C0 02    CPY  #$02
$E9B4: F0 04    BEQ  $E9BA
$E9B6: A2 66    LDX  #$66
$E9B8: E6 02    INC  $02
$E9BA: C0 06    CPY  #$06
$E9BC: D0 0C    BNE  $E9CA
$E9BE: A2 54    LDX  #$54
$E9C0: A5 ED    LDA  $ED
$E9C2: 29 20    AND  #$20
$E9C4: D0 04    BNE  $E9CA
$E9C6: A2 8A    LDX  #$8A
$E9C8: C6 02    DEC  $02
$E9CA: A4 08    LDY  $08
$E9CC: A5 EF    LDA  $EF
$E9CE: C9          .byte $C9  ; غير معرّف
$E9CF: 05 D0    ORA  $D0
$E9D1: 0C          .byte $0C  ; غير معرّف
$E9D2: A5 ED    LDA  $ED
$E9D4: F0 24    BEQ  $E9FA
$E9D6: 29 08    AND  #$08
$E9D8: F0 5D    BEQ  $EA37
$E9DA: A2 B4    LDX  #$B4
$E9DC: D0 1C    BNE  $E9FA
$E9DE: E0 48    CPX  #$48
$E9E0: F0 18    BEQ  $E9FA
$E9E2: B9 96 07 LDA  $0796,Y
$E9E5: C9          .byte $C9  ; غير معرّف
$E9E6: 05 B0    ORA  $B0
$E9E8: 4E E0 3C LSR  $3CE0
$E9EB: D0 0D    BNE  $E9FA
$E9ED: C9          .byte $C9  ; غير معرّف
$E9EE: 01 F0    ORA  ($F0,X)
$E9F0: 46 E6    LSR  $E6
$E9F2: 02          .byte $02  ; غير معرّف
$E9F3: E6 02    INC  $02
$E9F5: E6 02    INC  $02
$E9F7: 4C 29 EA JMP  $EA29
$E9FA: A5 EF    LDA  $EF
$E9FC: C9          .byte $C9  ; غير معرّف
$E9FD: 06 F0    ASL  $F0
$E9FF: 37          .byte $37  ; غير معرّف
$EA00: C9          .byte $C9  ; غير معرّف
$EA01: 08       PHP  
$EA02: F0 33    BEQ  $EA37
$EA04: C9          .byte $C9  ; غير معرّف
$EA05: 0C          .byte $0C  ; غير معرّف
$EA06: F0 2F    BEQ  $EA37
$EA08: C9          .byte $C9  ; غير معرّف
$EA09: 18       CLC  
$EA0A: B0 2B    BCS  $EA37
$EA0C: A0 00    LDY  #$00
$EA0E: C9          .byte $C9  ; غير معرّف
$EA0F: 15 D0    ORA  $D0,X
$EA11: 10 C8    BPL  $E9DB
$EA13: AD 5F 07 LDA  $075F
$EA16: C9          .byte $C9  ; غير معرّف
$EA17: 07          .byte $07  ; غير معرّف
$EA18: B0 1D    BCS  $EA37
$EA1A: A2 A2    LDX  #$A2
$EA1C: A9 03    LDA  #$03
$EA1E: 85 EC    STA  $EC
$EA20: D0 15    BNE  $EA37
$EA22: A5 09    LDA  $09
$EA24: 39 76 E8 AND  $E876,Y
$EA27: D0 0E    BNE  $EA37
$EA29: A5 ED    LDA  $ED
$EA2B: 29 A0    AND  #$A0
$EA2D: 0D 47 07 ORA  $0747
$EA30: D0 05    BNE  $EA37
$EA32: 8A       TXA  
$EA33: 18       CLC  
$EA34: 69 06    ADC  #$06
$EA36: AA       TAX  
$EA37: A5 ED    LDA  $ED
$EA39: 29 20    AND  #$20
$EA3B: F0 0E    BEQ  $EA4B
$EA3D: A5 EF    LDA  $EF
$EA3F: C9          .byte $C9  ; غير معرّف
$EA40: 04          .byte $04  ; غير معرّف
$EA41: 90 08    BCC  $EA4B
$EA43: A0 01    LDY  #$01
$EA45: 8C 09 01 STY  $0109
$EA48: 88       DEY  
$EA49: 84 EC    STY  $EC
$EA4B: A4 EB    LDY  $EB
$EA4D: 20 AA EB JSR  $EBAA
$EA50: 20 AA EB JSR  $EBAA
$EA53: 20 AA EB JSR  $EBAA
$EA56: A6 08    LDX  $08
$EA58: BC E5 06 LDY  $06E5,X
$EA5B: A5 EF    LDA  $EF
$EA5D: C9          .byte $C9  ; غير معرّف
$EA5E: 08       PHP  
$EA5F: D0 03    BNE  $EA64
$EA61: 4C 64 EB JMP  $EB64
$EA64: AD 09 01 LDA  $0109
$EA67: F0 3D    BEQ  $EAA6
$EA69: B9 02 02 LDA  $0202,Y
$EA6C: 09 80    ORA  #$80
$EA6E: C8       INY  
$EA6F: C8       INY  
$EA70: 20 B5 E5 JSR  $E5B5
$EA73: 88       DEY  
$EA74: 88       DEY  
$EA75: 98       TYA  
$EA76: AA       TAX  
$EA77: A5 EF    LDA  $EF
$EA79: C9          .byte $C9  ; غير معرّف
$EA7A: 05 F0    ORA  $F0
$EA7C: 0D C9 11 ORA  $11C9
$EA7F: F0 09    BEQ  $EA8A
$EA81: C9          .byte $C9  ; غير معرّف
$EA82: 15 B0    ORA  $B0,X
$EA84: 05 8A    ORA  $8A
$EA86: 18       CLC  
$EA87: 69 08    ADC  #$08
$EA89: AA       TAX  
$EA8A: BD 01 02 LDA  $0201,X
$EA8D: 48       PHA  
$EA8E: BD 05 02 LDA  $0205,X
$EA91: 48       PHA  
$EA92: B9 11 02 LDA  $0211,Y
$EA95: 9D 01 02 STA  $0201,X
$EA98: B9 15 02 LDA  $0215,Y
$EA9B: 9D 05 02 STA  $0205,X
$EA9E: 68       PLA  
$EA9F: 99 15 02 STA  $0215,Y
$EAA2: 68       PLA  
$EAA3: 99 11 02 STA  $0211,Y
$EAA6: AD 6A 03 LDA  $036A
$EAA9: D0 B6    BNE  $EA61
$EAAB: A5 EF    LDA  $EF
$EAAD: A6 EC    LDX  $EC
$EAAF: C9          .byte $C9  ; غير معرّف
$EAB0: 05 D0    ORA  $D0
$EAB2: 03          .byte $03  ; غير معرّف
$EAB3: 4C 64 EB JMP  $EB64
$EAB6: C9          .byte $C9  ; غير معرّف
$EAB7: 07          .byte $07  ; غير معرّف
$EAB8: F0 1D    BEQ  $EAD7
$EABA: C9          .byte $C9  ; غير معرّف
$EABB: 0D F0 19 ORA  $19F0
$EABE: C9          .byte $C9  ; غير معرّف
$EABF: 0C          .byte $0C  ; غير معرّف
$EAC0: F0 15    BEQ  $EAD7
$EAC2: C9          .byte $C9  ; غير معرّف
$EAC3: 12          .byte $12  ; غير معرّف
$EAC4: D0 04    BNE  $EACA
$EAC6: E0 05    CPX  #$05
$EAC8: D0 48    BNE  $EB12
$EACA: C9          .byte $C9  ; غير معرّف
$EACB: 15 D0    ORA  $D0,X
$EACD: 05 A9    ORA  $A9
$EACF: 42          .byte $42  ; غير معرّف
$EAD0: 99 16 02 STA  $0216,Y
$EAD3: E0 02    CPX  #$02
$EAD5: 90 3B    BCC  $EB12
$EAD7: AD 6A 03 LDA  $036A
$EADA: D0 36    BNE  $EB12
$EADC: B9 02 02 LDA  $0202,Y
$EADF: 29 A3    AND  #$A3
$EAE1: 99 02 02 STA  $0202,Y
$EAE4: 99 0A 02 STA  $020A,Y
$EAE7: 99 12 02 STA  $0212,Y
$EAEA: 09 40    ORA  #$40
$EAEC: E0 05    CPX  #$05
$EAEE: D0 02    BNE  $EAF2
$EAF0: 09 80    ORA  #$80
$EAF2: 99 06 02 STA  $0206,Y
$EAF5: 99 0E 02 STA  $020E,Y
$EAF8: 99 16 02 STA  $0216,Y
$EAFB: E0 04    CPX  #$04
$EAFD: D0 13    BNE  $EB12
$EAFF: B9 0A 02 LDA  $020A,Y
$EB02: 09 80    ORA  #$80
$EB04: 99 0A 02 STA  $020A,Y
$EB07: 99 12 02 STA  $0212,Y
$EB0A: 09 40    ORA  #$40
$EB0C: 99 0E 02 STA  $020E,Y
$EB0F: 99 16 02 STA  $0216,Y
$EB12: A5 EF    LDA  $EF
$EB14: C9          .byte $C9  ; غير معرّف
$EB15: 11 D0    ORA  ($D0),Y
$EB17: 36 AD    ROL  $AD,X
$EB19: 09 01    ORA  #$01
$EB1B: D0 21    BNE  $EB3E
$EB1D: B9 12 02 LDA  $0212,Y
$EB20: 29 81    AND  #$81
$EB22: 99 12 02 STA  $0212,Y
$EB25: B9 16 02 LDA  $0216,Y
$EB28: 09 41    ORA  #$41
$EB2A: 99 16 02 STA  $0216,Y
$EB2D: AE 8F 07 LDX  $078F
$EB30: E0 10    CPX  #$10
$EB32: B0 30    BCS  $EB64
$EB34: 99 0E 02 STA  $020E,Y
$EB37: 29 81    AND  #$81
$EB39: 99 0A 02 STA  $020A,Y
$EB3C: 90 26    BCC  $EB64
$EB3E: B9 02 02 LDA  $0202,Y
$EB41: 29 81    AND  #$81
$EB43: 99 02 02 STA  $0202,Y
$EB46: B9 06 02 LDA  $0206,Y
$EB49: 09 41    ORA  #$41
$EB4B: 99 06 02 STA  $0206,Y
$EB4E: A5 EF    LDA  $EF
$EB50: C9          .byte $C9  ; غير معرّف
$EB51: 18       CLC  
$EB52: 90 10    BCC  $EB64
$EB54: A9 82    LDA  #$82
$EB56: 99 0A 02 STA  $020A,Y
$EB59: 99 12 02 STA  $0212,Y
$EB5C: 09 40    ORA  #$40
$EB5E: 99 0E 02 STA  $020E,Y
$EB61: 99 16 02 STA  $0216,Y
$EB64: A6 08    LDX  $08
$EB66: AD D1 03 LDA  $03D1
$EB69: 4A       LSR  A
$EB6A: 4A       LSR  A
$EB6B: 4A       LSR  A
$EB6C: 48       PHA  
$EB6D: 90 05    BCC  $EB74
$EB6F: A9 04    LDA  #$04
$EB71: 20 C1 EB JSR  $EBC1
$EB74: 68       PLA  
$EB75: 4A       LSR  A
$EB76: 48       PHA  
$EB77: 90 05    BCC  $EB7E
$EB79: A9 00    LDA  #$00
$EB7B: 20 C1 EB JSR  $EBC1
$EB7E: 68       PLA  
$EB7F: 4A       LSR  A
$EB80: 4A       LSR  A
$EB81: 48       PHA  
$EB82: 90 05    BCC  $EB89
$EB84: A9 10    LDA  #$10
$EB86: 20 B7 EB JSR  $EBB7
$EB89: 68       PLA  
$EB8A: 4A       LSR  A
$EB8B: 48       PHA  
$EB8C: 90 05    BCC  $EB93
$EB8E: A9 08    LDA  #$08
$EB90: 20 B7 EB JSR  $EBB7
$EB93: 68       PLA  
$EB94: 4A       LSR  A
$EB95: 90 12    BCC  $EBA9
$EB97: 20 B7 EB JSR  $EBB7
$EB9A: B5 16    LDA  $16,X
$EB9C: C9          .byte $C9  ; غير معرّف
$EB9D: 0C          .byte $0C  ; غير معرّف
$EB9E: F0 09    BEQ  $EBA9
$EBA0: B5 B6    LDA  $B6,X
$EBA2: C9          .byte $C9  ; غير معرّف
$EBA3: 02          .byte $02  ; غير معرّف
$EBA4: D0 03    BNE  $EBA9
$EBA6: 20 98 C9 JSR  $C998
$EBA9: 60       RTS  
$EBAA: BD 3E E7 LDA  $E73E,X
$EBAD: 85 00    STA  $00
$EBAF: BD 3F E7 LDA  $E73F,X
$EBB2: 85 01    STA  $01
$EBB4: 4C 82 F2 JMP  $F282
$EBB7: 18       CLC  
$EBB8: 7D E5 06 ADC  $06E5,X
$EBBB: A8       TAY  
$EBBC: A9 F8    LDA  #$F8
$EBBE: 4C C1 E5 JMP  $E5C1
$EBC1: 18       CLC  
$EBC2: 7D E5 06 ADC  $06E5,X
$EBC5: A8       TAY  
$EBC6: 20 4A EC JSR  $EC4A
$EBC9: 99 10 02 STA  $0210,Y
$EBCC: 60       RTS  
$EBCD: 85 85    STA  $85
$EBCF: 86 86    STX  $86
$EBD1: AD BC 03 LDA  $03BC
$EBD4: 85 02    STA  $02
$EBD6: AD B1 03 LDA  $03B1
$EBD9: 85 05    STA  $05
$EBDB: A9 03    LDA  #$03
$EBDD: 85 04    STA  $04
$EBDF: 4A       LSR  A
$EBE0: 85 03    STA  $03
$EBE2: BC EC 06 LDY  $06EC,X
$EBE5: A2 00    LDX  #$00
$EBE7: BD CD EB LDA  $EBCD,X
$EBEA: 85 00    STA  $00
$EBEC: BD CE EB LDA  $EBCE,X
$EBEF: 20 B2 EB JSR  $EBB2
$EBF2: E0 04    CPX  #$04
$EBF4: D0 F1    BNE  $EBE7
$EBF6: A6 08    LDX  $08
$EBF8: BC EC 06 LDY  $06EC,X
$EBFB: AD 4E 07 LDA  $074E
$EBFE: C9          .byte $C9  ; غير معرّف
$EBFF: 01 F0    ORA  ($F0,X)
$EC01: 08       PHP  
$EC02: A9 86    LDA  #$86
$EC04: 99 01 02 STA  $0201,Y
$EC07: 99 05 02 STA  $0205,Y
$EC0A: BD E8 03 LDA  $03E8,X
$EC0D: C9          .byte $C9  ; غير معرّف
$EC0E: C4 D0    CPY  $D0
$EC10: 24 A9    BIT  $A9
$EC12: 87          .byte $87  ; غير معرّف
$EC13: C8       INY  
$EC14: 20 BB E5 JSR  $E5BB
$EC17: 88       DEY  
$EC18: A9 03    LDA  #$03
$EC1A: AE 4E 07 LDX  $074E
$EC1D: CA       DEX  
$EC1E: F0 01    BEQ  $EC21
$EC20: 4A       LSR  A
$EC21: A6 08    LDX  $08
$EC23: 99 02 02 STA  $0202,Y
$EC26: 09 40    ORA  #$40
$EC28: 99 06 02 STA  $0206,Y
$EC2B: 09 80    ORA  #$80
$EC2D: 99 0E 02 STA  $020E,Y
$EC30: 29 83    AND  #$83
$EC32: 99 0A 02 STA  $020A,Y
$EC35: AD D4 03 LDA  $03D4
$EC38: 48       PHA  
$EC39: 29 04    AND  #$04
$EC3B: F0 08    BEQ  $EC45
$EC3D: A9 F8    LDA  #$F8
$EC3F: 99 04 02 STA  $0204,Y
$EC42: 99 0C 02 STA  $020C,Y
$EC45: 68       PLA  
$EC46: 29 08    AND  #$08
$EC48: F0 08    BEQ  $EC52
$EC4A: A9 F8    LDA  #$F8
$EC4C: 99 00 02 STA  $0200,Y
$EC4F: 99 08 02 STA  $0208,Y
$EC52: 60       RTS  
$EC53: A9 02    LDA  #$02
$EC55: 85 00    STA  $00
$EC57: A9 75    LDA  #$75
$EC59: A4 0E    LDY  $0E
$EC5B: C0 05    CPY  #$05
$EC5D: F0 06    BEQ  $EC65
$EC5F: A9 03    LDA  #$03
$EC61: 85 00    STA  $00
$EC63: A9 84    LDA  #$84
$EC65: BC EC 06 LDY  $06EC,X
$EC68: C8       INY  
$EC69: 20 BB E5 JSR  $E5BB
$EC6C: A5 09    LDA  $09
$EC6E: 0A       ASL  A
$EC6F: 0A       ASL  A
$EC70: 0A       ASL  A
$EC71: 0A       ASL  A
$EC72: 29 C0    AND  #$C0
$EC74: 05 00    ORA  $00
$EC76: C8       INY  
$EC77: 20 BB E5 JSR  $E5BB
$EC7A: 88       DEY  
$EC7B: 88       DEY  
$EC7C: AD BC 03 LDA  $03BC
$EC7F: 20 C1 E5 JSR  $E5C1
$EC82: AD B1 03 LDA  $03B1
$EC85: 99 03 02 STA  $0203,Y
$EC88: BD F1 03 LDA  $03F1,X
$EC8B: 38       SEC  
$EC8C: ED 1C 07 SBC  $071C
$EC8F: 85 00    STA  $00
$EC91: 38       SEC  
$EC92: ED B1 03 SBC  $03B1
$EC95: 65 00    ADC  $00
$EC97: 69 06    ADC  #$06
$EC99: 99 07 02 STA  $0207,Y
$EC9C: AD BD 03 LDA  $03BD
$EC9F: 99 08 02 STA  $0208,Y
$ECA2: 99 0C 02 STA  $020C,Y
$ECA5: AD B2 03 LDA  $03B2
$ECA8: 99 0B 02 STA  $020B,Y
$ECAB: A5 00    LDA  $00
$ECAD: 38       SEC  
$ECAE: ED B2 03 SBC  $03B2
$ECB1: 65 00    ADC  $00
$ECB3: 69 06    ADC  #$06
$ECB5: 99 0F 02 STA  $020F,Y
$ECB8: AD D4 03 LDA  $03D4
$ECBB: 20 46 EC JSR  $EC46
$ECBE: AD D4 03 LDA  $03D4
$ECC1: 0A       ASL  A
$ECC2: 90 05    BCC  $ECC9
$ECC4: A9 F8    LDA  #$F8
$ECC6: 20 C1 E5 JSR  $E5C1
$ECC9: A5 00    LDA  $00
$ECCB: 10 10    BPL  $ECDD
$ECCD: B9 03 02 LDA  $0203,Y
$ECD0: D9 07 02 CMP  $0207,Y
$ECD3: 90 08    BCC  $ECDD
$ECD5: A9 F8    LDA  #$F8
$ECD7: 99 04 02 STA  $0204,Y
$ECDA: 99 0C 02 STA  $020C,Y
$ECDD: 60       RTS  
$ECDE: BC F1 06 LDY  $06F1,X
$ECE1: AD BA 03 LDA  $03BA
$ECE4: 99 00 02 STA  $0200,Y
$ECE7: AD AF 03 LDA  $03AF
$ECEA: 99 03 02 STA  $0203,Y
$ECED: A5 09    LDA  $09
$ECEF: 4A       LSR  A
$ECF0: 4A       LSR  A
$ECF1: 48       PHA  
$ECF2: 29 01    AND  #$01
$ECF4: 49 64    EOR  #$64
$ECF6: 99 01 02 STA  $0201,Y
$ECF9: 68       PLA  
$ECFA: 4A       LSR  A
$ECFB: 4A       LSR  A
$ECFC: A9 02    LDA  #$02
$ECFE: 90 02    BCC  $ED02
$ED00: 09 C0    ORA  #$C0
$ED02: 99 02 02 STA  $0202,Y
$ED05: 60       RTS  
$ED06: 68       PLA  
$ED07: 67          .byte $67  ; غير معرّف
$ED08: 66 BC    ROR  $BC
$ED0A: EC 06 B5 CPX  $B506
$ED0D: 24 F6    BIT  $F6
$ED0F: 24 4A    BIT  $4A
$ED11: 29 07    AND  #$07
$ED13: C9          .byte $C9  ; غير معرّف
$ED14: 03          .byte $03  ; غير معرّف
$ED15: B0 4A    BCS  $ED61
$ED17: AA       TAX  
$ED18: BD 06 ED LDA  $ED06,X
$ED1B: C8       INY  
$ED1C: 20 BB E5 JSR  $E5BB
$ED1F: 88       DEY  
$ED20: A6 08    LDX  $08
$ED22: AD BA 03 LDA  $03BA
$ED25: 38       SEC  
$ED26: E9 04    SBC  #$04
$ED28: 99 00 02 STA  $0200,Y
$ED2B: 99 08 02 STA  $0208,Y
$ED2E: 18       CLC  
$ED2F: 69 08    ADC  #$08
$ED31: 99 04 02 STA  $0204,Y
$ED34: 99 0C 02 STA  $020C,Y
$ED37: AD AF 03 LDA  $03AF
$ED3A: 38       SEC  
$ED3B: E9 04    SBC  #$04
$ED3D: 99 03 02 STA  $0203,Y
$ED40: 99 07 02 STA  $0207,Y
$ED43: 18       CLC  
$ED44: 69 08    ADC  #$08
$ED46: 99 0B 02 STA  $020B,Y
$ED49: 99 0F 02 STA  $020F,Y
$ED4C: A9 02    LDA  #$02
$ED4E: 99 02 02 STA  $0202,Y
$ED51: A9 82    LDA  #$82
$ED53: 99 06 02 STA  $0206,Y
$ED56: A9 42    LDA  #$42
$ED58: 99 0A 02 STA  $020A,Y
$ED5B: A9 C2    LDA  #$C2
$ED5D: 99 0E 02 STA  $020E,Y
$ED60: 60       RTS  
$ED61: A9 00    LDA  #$00
$ED63: 95 24    STA  $24,X
$ED65: 60       RTS  
$ED66: BC E5 06 LDY  $06E5,X
$ED69: A9 5B    LDA  #$5B
$ED6B: C8       INY  
$ED6C: 20 B5 E5 JSR  $E5B5
$ED6F: C8       INY  
$ED70: A9 02    LDA  #$02
$ED72: 20 B5 E5 JSR  $E5B5
$ED75: 88       DEY  
$ED76: 88       DEY  
$ED77: AD AE 03 LDA  $03AE
$ED7A: 99 03 02 STA  $0203,Y
$ED7D: 99 0F 02 STA  $020F,Y
$ED80: 18       CLC  
$ED81: 69 08    ADC  #$08
$ED83: 99 07 02 STA  $0207,Y
$ED86: 99 13 02 STA  $0213,Y
$ED89: 18       CLC  
$ED8A: 69 08    ADC  #$08
$ED8C: 99 0B 02 STA  $020B,Y
$ED8F: 99 17 02 STA  $0217,Y
$ED92: B5 CF    LDA  $CF,X
$ED94: AA       TAX  
$ED95: 48       PHA  
$ED96: E0 20    CPX  #$20
$ED98: B0 02    BCS  $ED9C
$ED9A: A9 F8    LDA  #$F8
$ED9C: 20 BE E5 JSR  $E5BE
$ED9F: 68       PLA  
$EDA0: 18       CLC  
$EDA1: 69 80    ADC  #$80
$EDA3: AA       TAX  
$EDA4: E0 20    CPX  #$20
$EDA6: B0 02    BCS  $EDAA
$EDA8: A9 F8    LDA  #$F8
$EDAA: 99 0C 02 STA  $020C,Y
$EDAD: 99 10 02 STA  $0210,Y
$EDB0: 99 14 02 STA  $0214,Y
$EDB3: AD D1 03 LDA  $03D1
$EDB6: 48       PHA  
$EDB7: 29 08    AND  #$08
$EDB9: F0 08    BEQ  $EDC3
$EDBB: A9 F8    LDA  #$F8
$EDBD: 99 00 02 STA  $0200,Y
$EDC0: 99 0C 02 STA  $020C,Y
$EDC3: 68       PLA  
$EDC4: 48       PHA  
$EDC5: 29 04    AND  #$04
$EDC7: F0 08    BEQ  $EDD1
$EDC9: A9 F8    LDA  #$F8
$EDCB: 99 04 02 STA  $0204,Y
$EDCE: 99 10 02 STA  $0210,Y
$EDD1: 68       PLA  
$EDD2: 29 02    AND  #$02
$EDD4: F0 08    BEQ  $EDDE
$EDD6: A9 F8    LDA  #$F8
$EDD8: 99 08 02 STA  $0208,Y
$EDDB: 99 14 02 STA  $0214,Y
$EDDE: A6 08    LDX  $08
$EDE0: 60       RTS  
$EDE1: A4 B5    LDY  $B5
$EDE3: 88       DEY  
$EDE4: D0 20    BNE  $EE06
$EDE6: AD D3 03 LDA  $03D3
$EDE9: 29 08    AND  #$08
$EDEB: D0 19    BNE  $EE06
$EDED: BC EE 06 LDY  $06EE,X
$EDF0: AD B0 03 LDA  $03B0
$EDF3: 99 03 02 STA  $0203,Y
$EDF6: AD BB 03 LDA  $03BB
$EDF9: 99 00 02 STA  $0200,Y
$EDFC: A9 74    LDA  #$74
$EDFE: 99 01 02 STA  $0201,Y
$EE01: A9 02    LDA  #$02
$EE03: 99 02 02 STA  $0202,Y
$EE06: 60       RTS  
$EE07: 20 28 C8 JSR  $C828
$EE0A: 18       CLC  
$EE0B: 00       BRK  
$EE0C: 40       RTI  
$EE0D: 50 58    BVC  $EE67
$EE0F: 80          .byte $80  ; غير معرّف
$EE10: 88       DEY  
$EE11: B8       CLV  
$EE12: 78       SEI  
$EE13: 60       RTS  
$EE14: A0 B0    LDY  #$B0
$EE16: B8       CLV  
$EE17: 00       BRK  
$EE18: 01 02    ORA  ($02,X)
$EE1A: 03          .byte $03  ; غير معرّف
$EE1B: 04          .byte $04  ; غير معرّف
$EE1C: 05 06    ORA  $06
$EE1E: 07          .byte $07  ; غير معرّف
$EE1F: 08       PHP  
$EE20: 09 0A    ORA  #$0A
$EE22: 0B          .byte $0B  ; غير معرّف
$EE23: 0C          .byte $0C  ; غير معرّف
$EE24: 0D 0E 0F ORA  $0F0E
$EE27: 10 11    BPL  $EE3A
$EE29: 12          .byte $12  ; غير معرّف
$EE2A: 13          .byte $13  ; غير معرّف
$EE2B: 14          .byte $14  ; غير معرّف
$EE2C: 15 16    ORA  $16,X
$EE2E: 17          .byte $17  ; غير معرّف
$EE2F: 18       CLC  
$EE30: 19 1A 1B ORA  $1B1A,Y
$EE33: 1C          .byte $1C  ; غير معرّف
$EE34: 1D 1E 1F ORA  $1F1E,X
$EE37: 20 21 22 JSR  $2221
$EE3A: 23          .byte $23  ; غير معرّف
$EE3B: 24 25    BIT  $25
$EE3D: 26 27    ROL  $27
$EE3F: 08       PHP  
$EE40: 09 28    ORA  #$28
$EE42: 29 2A    AND  #$2A
$EE44: 2B          .byte $2B  ; غير معرّف
$EE45: 2C 2D 08 BIT  $082D
$EE48: 09 0A    ORA  #$0A
$EE4A: 0B          .byte $0B  ; غير معرّف
$EE4B: 0C          .byte $0C  ; غير معرّف
$EE4C: 30 2C    BMI  $EE7A
$EE4E: 2D 08 09 AND  $0908
$EE51: 0A       ASL  A
$EE52: 0B          .byte $0B  ; غير معرّف
$EE53: 2E 2F 2C ROL  $2C2F
$EE56: 2D 08 09 AND  $0908
$EE59: 28       PLP  
$EE5A: 29 2A    AND  #$2A
$EE5C: 2B          .byte $2B  ; غير معرّف
$EE5D: 5C          .byte $5C  ; غير معرّف
$EE5E: 5D 08 09 EOR  $0908,X
$EE61: 0A       ASL  A
$EE62: 0B          .byte $0B  ; غير معرّف
$EE63: 0C          .byte $0C  ; غير معرّف
$EE64: 0D 5E 5F ORA  $5F5E
$EE67: FC          .byte $FC  ; غير معرّف
$EE68: FC          .byte $FC  ; غير معرّف
$EE69: 08       PHP  
$EE6A: 09 58    ORA  #$58
$EE6C: 59 5A 5A EOR  $5A5A,Y
$EE6F: 08       PHP  
$EE70: 09 28    ORA  #$28
$EE72: 29 2A    AND  #$2A
$EE74: 2B          .byte $2B  ; غير معرّف
$EE75: 0E 0F FC ASL  $FC0F
$EE78: FC          .byte $FC  ; غير معرّف
$EE79: FC          .byte $FC  ; غير معرّف
$EE7A: FC          .byte $FC  ; غير معرّف
$EE7B: 32          .byte $32  ; غير معرّف
$EE7C: 33          .byte $33  ; غير معرّف
$EE7D: 34          .byte $34  ; غير معرّف
$EE7E: 35 FC    AND  $FC,X
$EE80: FC          .byte $FC  ; غير معرّف
$EE81: FC          .byte $FC  ; غير معرّف
$EE82: FC          .byte $FC  ; غير معرّف
$EE83: 36 37    ROL  $37,X
$EE85: 38       SEC  
$EE86: 39 FC FC AND  $FCFC,Y
$EE89: FC          .byte $FC  ; غير معرّف
$EE8A: FC          .byte $FC  ; غير معرّف
$EE8B: 3A          .byte $3A  ; غير معرّف
$EE8C: 37          .byte $37  ; غير معرّف
$EE8D: 3B          .byte $3B  ; غير معرّف
$EE8E: 3C          .byte $3C  ; غير معرّف
$EE8F: FC          .byte $FC  ; غير معرّف
$EE90: FC          .byte $FC  ; غير معرّف
$EE91: FC          .byte $FC  ; غير معرّف
$EE92: FC          .byte $FC  ; غير معرّف
$EE93: 3D 3E 3F AND  $3F3E,X
$EE96: 40       RTI  
$EE97: FC          .byte $FC  ; غير معرّف
$EE98: FC          .byte $FC  ; غير معرّف
$EE99: FC          .byte $FC  ; غير معرّف
$EE9A: FC          .byte $FC  ; غير معرّف
$EE9B: 32          .byte $32  ; غير معرّف
$EE9C: 41 42    EOR  ($42,X)
$EE9E: 43          .byte $43  ; غير معرّف
$EE9F: FC          .byte $FC  ; غير معرّف
$EEA0: FC          .byte $FC  ; غير معرّف
$EEA1: FC          .byte $FC  ; غير معرّف
$EEA2: FC          .byte $FC  ; غير معرّف
$EEA3: 32          .byte $32  ; غير معرّف
$EEA4: 33          .byte $33  ; غير معرّف
$EEA5: 44          .byte $44  ; غير معرّف
$EEA6: 45 FC    EOR  $FC
$EEA8: FC          .byte $FC  ; غير معرّف
$EEA9: FC          .byte $FC  ; غير معرّف
$EEAA: FC          .byte $FC  ; غير معرّف
$EEAB: 32          .byte $32  ; غير معرّف
$EEAC: 33          .byte $33  ; غير معرّف
$EEAD: 44          .byte $44  ; غير معرّف
$EEAE: 47          .byte $47  ; غير معرّف
$EEAF: FC          .byte $FC  ; غير معرّف
$EEB0: FC          .byte $FC  ; غير معرّف
$EEB1: FC          .byte $FC  ; غير معرّف
$EEB2: FC          .byte $FC  ; غير معرّف
$EEB3: 32          .byte $32  ; غير معرّف
$EEB4: 33          .byte $33  ; غير معرّف
$EEB5: 48       PHA  
$EEB6: 49 FC    EOR  #$FC
$EEB8: FC          .byte $FC  ; غير معرّف
$EEB9: FC          .byte $FC  ; غير معرّف
$EEBA: FC          .byte $FC  ; غير معرّف
$EEBB: 32          .byte $32  ; غير معرّف
$EEBC: 33          .byte $33  ; غير معرّف
$EEBD: 90 91    BCC  $EE50
$EEBF: FC          .byte $FC  ; غير معرّف
$EEC0: FC          .byte $FC  ; غير معرّف
$EEC1: FC          .byte $FC  ; غير معرّف
$EEC2: FC          .byte $FC  ; غير معرّف
$EEC3: 3A          .byte $3A  ; غير معرّف
$EEC4: 37          .byte $37  ; غير معرّف
$EEC5: 92          .byte $92  ; غير معرّف
$EEC6: 93          .byte $93  ; غير معرّف
$EEC7: FC          .byte $FC  ; غير معرّف
$EEC8: FC          .byte $FC  ; غير معرّف
$EEC9: FC          .byte $FC  ; غير معرّف
$EECA: FC          .byte $FC  ; غير معرّف
$EECB: 9E          .byte $9E  ; غير معرّف
$EECC: 9E          .byte $9E  ; غير معرّف
$EECD: 9F          .byte $9F  ; غير معرّف
$EECE: 9F          .byte $9F  ; غير معرّف
$EECF: FC          .byte $FC  ; غير معرّف
$EED0: FC          .byte $FC  ; غير معرّف
$EED1: FC          .byte $FC  ; غير معرّف
$EED2: FC          .byte $FC  ; غير معرّف
$EED3: 3A          .byte $3A  ; غير معرّف
$EED4: 37          .byte $37  ; غير معرّف
$EED5: 4F          .byte $4F  ; غير معرّف
$EED6: 4F          .byte $4F  ; غير معرّف
$EED7: FC          .byte $FC  ; غير معرّف
$EED8: FC          .byte $FC  ; غير معرّف
$EED9: 00       BRK  
$EEDA: 01 4C    ORA  ($4C,X)
$EEDC: 4D 4E 4E EOR  $4E4E
$EEDF: 00       BRK  
$EEE0: 01 4C    ORA  ($4C,X)
$EEE2: 4D 4A 4A EOR  $4A4A
$EEE5: 4B          .byte $4B  ; غير معرّف
$EEE6: 4B          .byte $4B  ; غير معرّف
$EEE7: 31 46    AND  ($46),Y
$EEE9: AD 9E 07 LDA  $079E
$EEEC: F0 05    BEQ  $EEF3
$EEEE: A5 09    LDA  $09
$EEF0: 4A       LSR  A
$EEF1: B0 40    BCS  $EF33
$EEF3: A5 0E    LDA  $0E
$EEF5: C9          .byte $C9  ; غير معرّف
$EEF6: 0B          .byte $0B  ; غير معرّف
$EEF7: F0 47    BEQ  $EF40
$EEF9: AD 0B 07 LDA  $070B
$EEFC: D0 3C    BNE  $EF3A
$EEFE: AC 04 07 LDY  $0704
$EF01: F0 31    BEQ  $EF34
$EF03: A5 1D    LDA  $1D
$EF05: C9          .byte $C9  ; غير معرّف
$EF06: 00       BRK  
$EF07: F0 2B    BEQ  $EF34
$EF09: 20 34 EF JSR  $EF34
$EF0C: A5 09    LDA  $09
$EF0E: 29 04    AND  #$04
$EF10: D0 21    BNE  $EF33
$EF12: AA       TAX  
$EF13: AC E4 06 LDY  $06E4
$EF16: A5 33    LDA  $33
$EF18: 4A       LSR  A
$EF19: B0 04    BCS  $EF1F
$EF1B: C8       INY  
$EF1C: C8       INY  
$EF1D: C8       INY  
$EF1E: C8       INY  
$EF1F: AD 54 07 LDA  $0754
$EF22: F0 09    BEQ  $EF2D
$EF24: B9 19 02 LDA  $0219,Y
$EF27: CD B5 EE CMP  $EEB5
$EF2A: F0 07    BEQ  $EF33
$EF2C: E8       INX  
$EF2D: BD E7 EE LDA  $EEE7,X
$EF30: 99 19 02 STA  $0219,Y
$EF33: 60       RTS  
$EF34: 20 EC EF JSR  $EFEC
$EF37: 4C 45 EF JMP  $EF45
$EF3A: 20 B0 F0 JSR  $F0B0
$EF3D: 4C 45 EF JMP  $EF45
$EF40: A0 0E    LDY  #$0E
$EF42: B9 07 EE LDA  $EE07,Y
$EF45: 8D D5 06 STA  $06D5
$EF48: A9 04    LDA  #$04
$EF4A: 20 BE EF JSR  $EFBE
$EF4D: 20 E9 F0 JSR  $F0E9
$EF50: AD 11 07 LDA  $0711
$EF53: F0 25    BEQ  $EF7A
$EF55: A0 00    LDY  #$00
$EF57: AD 81 07 LDA  $0781
$EF5A: CD 11 07 CMP  $0711
$EF5D: 8C 11 07 STY  $0711
$EF60: B0 18    BCS  $EF7A
$EF62: 8D 11 07 STA  $0711
$EF65: A0 07    LDY  #$07
$EF67: B9 07 EE LDA  $EE07,Y
$EF6A: 8D D5 06 STA  $06D5
$EF6D: A0 04    LDY  #$04
$EF6F: A5 57    LDA  $57
$EF71: 05 0C    ORA  $0C
$EF73: F0 01    BEQ  $EF76
$EF75: 88       DEY  
$EF76: 98       TYA  
$EF77: 20 BE EF JSR  $EFBE
$EF7A: AD D0 03 LDA  $03D0
$EF7D: 4A       LSR  A
$EF7E: 4A       LSR  A
$EF7F: 4A       LSR  A
$EF80: 4A       LSR  A
$EF81: 85 00    STA  $00
$EF83: A2 03    LDX  #$03
$EF85: AD E4 06 LDA  $06E4
$EF88: 18       CLC  
$EF89: 69 18    ADC  #$18
$EF8B: A8       TAY  
$EF8C: A9 F8    LDA  #$F8
$EF8E: 46 00    LSR  $00
$EF90: 90 03    BCC  $EF95
$EF92: 20 C1 E5 JSR  $E5C1
$EF95: 98       TYA  
$EF96: 38       SEC  
$EF97: E9 08    SBC  #$08
$EF99: A8       TAY  
$EF9A: CA       DEX  
$EF9B: 10 EF    BPL  $EF8C
$EF9D: 60       RTS  
$EF9E: 58       CLI  
$EF9F: 01 00    ORA  ($00,X)
$EFA1: 60       RTS  
$EFA2: FF          .byte $FF  ; غير معرّف
$EFA3: 04          .byte $04  ; غير معرّف
$EFA4: A2 05    LDX  #$05
$EFA6: BD 9E EF LDA  $EF9E,X
$EFA9: 95 02    STA  $02,X
$EFAB: CA       DEX  
$EFAC: 10 F8    BPL  $EFA6
$EFAE: A2 B8    LDX  #$B8
$EFB0: A0 04    LDY  #$04
$EFB2: 20 DC EF JSR  $EFDC
$EFB5: AD 26 02 LDA  $0226
$EFB8: 09 40    ORA  #$40
$EFBA: 8D 22 02 STA  $0222
$EFBD: 60       RTS  
$EFBE: 85 07    STA  $07
$EFC0: AD AD 03 LDA  $03AD
$EFC3: 8D 55 07 STA  $0755
$EFC6: 85 05    STA  $05
$EFC8: AD B8 03 LDA  $03B8
$EFCB: 85 02    STA  $02
$EFCD: A5 33    LDA  $33
$EFCF: 85 03    STA  $03
$EFD1: AD C4 03 LDA  $03C4
$EFD4: 85 04    STA  $04
$EFD6: AE D5 06 LDX  $06D5
$EFD9: AC E4 06 LDY  $06E4
$EFDC: BD 17 EE LDA  $EE17,X
$EFDF: 85 00    STA  $00
$EFE1: BD 18 EE LDA  $EE18,X
$EFE4: 20 B2 EB JSR  $EBB2
$EFE7: C6 07    DEC  $07
$EFE9: D0 F1    BNE  $EFDC
$EFEB: 60       RTS  
$EFEC: A5 1D    LDA  $1D
$EFEE: C9          .byte $C9  ; غير معرّف
$EFEF: 03          .byte $03  ; غير معرّف
$EFF0: F0 52    BEQ  $F044
$EFF2: C9          .byte $C9  ; غير معرّف
$EFF3: 02          .byte $02  ; غير معرّف
$EFF4: F0 3E    BEQ  $F034
$EFF6: C9          .byte $C9  ; غير معرّف
$EFF7: 01 D0    ORA  ($D0,X)
$EFF9: 11 AD    ORA  ($AD),Y
$EFFB: 04          .byte $04  ; غير معرّف
$EFFC: 07          .byte $07  ; غير معرّف
$EFFD: D0 51    BNE  $F050
$EFFF: A0 06    LDY  #$06
$F001: AD 14 07 LDA  $0714
$F004: D0 22    BNE  $F028
$F006: A0 00    LDY  #$00
$F008: 4C 28 F0 JMP  $F028
$F00B: A0 06    LDY  #$06
$F00D: AD 14 07 LDA  $0714
$F010: D0 16    BNE  $F028
$F012: A0 02    LDY  #$02
$F014: A5 57    LDA  $57
$F016: 05 0C    ORA  $0C
$F018: F0 0E    BEQ  $F028
$F01A: AD 00 07 LDA  $0700
$F01D: C9          .byte $C9  ; غير معرّف
$F01E: 09 90    ORA  #$90
$F020: 1B          .byte $1B  ; غير معرّف
$F021: A5 45    LDA  $45
$F023: 25 33    AND  $33
$F025: D0 15    BNE  $F03C
$F027: C8       INY  
$F028: 20 91 F0 JSR  $F091
$F02B: A9 00    LDA  #$00
$F02D: 8D 0D 07 STA  $070D
$F030: B9 07 EE LDA  $EE07,Y
$F033: 60       RTS  
$F034: A0 04    LDY  #$04
$F036: 20 91 F0 JSR  $F091
$F039: 4C 62 F0 JMP  $F062
$F03C: A0 04    LDY  #$04
$F03E: 20 91 F0 JSR  $F091
$F041: 4C 68 F0 JMP  $F068
$F044: A0 05    LDY  #$05
$F046: A5 9F    LDA  $9F
$F048: F0 DE    BEQ  $F028
$F04A: 20 91 F0 JSR  $F091
$F04D: 4C 6D F0 JMP  $F06D
$F050: A0 01    LDY  #$01
$F052: 20 91 F0 JSR  $F091
$F055: AD 82 07 LDA  $0782
$F058: 0D 0D 07 ORA  $070D
$F05B: D0 0B    BNE  $F068
$F05D: A5 0A    LDA  $0A
$F05F: 0A       ASL  A
$F060: B0 06    BCS  $F068
$F062: AD 0D 07 LDA  $070D
$F065: 4C D0 F0 JMP  $F0D0
$F068: A9 03    LDA  #$03
$F06A: 4C 6F F0 JMP  $F06F
$F06D: A9 02    LDA  #$02
$F06F: 85 00    STA  $00
$F071: 20 62 F0 JSR  $F062
$F074: 48       PHA  
$F075: AD 81 07 LDA  $0781
$F078: D0 15    BNE  $F08F
$F07A: AD 0C 07 LDA  $070C
$F07D: 8D 81 07 STA  $0781
$F080: AD 0D 07 LDA  $070D
$F083: 18       CLC  
$F084: 69 01    ADC  #$01
$F086: C5 00    CMP  $00
$F088: 90 02    BCC  $F08C
$F08A: A9 00    LDA  #$00
$F08C: 8D 0D 07 STA  $070D
$F08F: 68       PLA  
$F090: 60       RTS  
$F091: AD 54 07 LDA  $0754
$F094: F0 05    BEQ  $F09B
$F096: 98       TYA  
$F097: 18       CLC  
$F098: 69 08    ADC  #$08
$F09A: A8       TAY  
$F09B: 60       RTS  
$F09C: 00       BRK  
$F09D: 01 00    ORA  ($00,X)
$F09F: 01 00    ORA  ($00,X)
$F0A1: 01 02    ORA  ($02,X)
$F0A3: 00       BRK  
$F0A4: 01 02    ORA  ($02,X)
$F0A6: 02          .byte $02  ; غير معرّف
$F0A7: 00       BRK  
$F0A8: 02          .byte $02  ; غير معرّف
$F0A9: 00       BRK  
$F0AA: 02          .byte $02  ; غير معرّف
$F0AB: 00       BRK  
$F0AC: 02          .byte $02  ; غير معرّف
$F0AD: 00       BRK  
$F0AE: 02          .byte $02  ; غير معرّف
$F0AF: 00       BRK  
$F0B0: AC 0D 07 LDY  $070D
$F0B3: A5 09    LDA  $09
$F0B5: 29 03    AND  #$03
$F0B7: D0 0D    BNE  $F0C6
$F0B9: C8       INY  
$F0BA: C0 0A    CPY  #$0A
$F0BC: 90 05    BCC  $F0C3
$F0BE: A0 00    LDY  #$00
$F0C0: 8C 0B 07 STY  $070B
$F0C3: 8C 0D 07 STY  $070D
$F0C6: AD 54 07 LDA  $0754
$F0C9: D0 0C    BNE  $F0D7
$F0CB: B9 9C F0 LDA  $F09C,Y
$F0CE: A0 0F    LDY  #$0F
$F0D0: 0A       ASL  A
$F0D1: 0A       ASL  A
$F0D2: 0A       ASL  A
$F0D3: 79 07 EE ADC  $EE07,Y
$F0D6: 60       RTS  
$F0D7: 98       TYA  
$F0D8: 18       CLC  
$F0D9: 69 0A    ADC  #$0A
$F0DB: AA       TAX  
$F0DC: A0 09    LDY  #$09
$F0DE: BD 9C F0 LDA  $F09C,X
$F0E1: D0 02    BNE  $F0E5
$F0E3: A0 01    LDY  #$01
$F0E5: B9 07 EE LDA  $EE07,Y
$F0E8: 60       RTS  
$F0E9: AC E4 06 LDY  $06E4
$F0EC: A5 0E    LDA  $0E
$F0EE: C9          .byte $C9  ; غير معرّف
$F0EF: 0B          .byte $0B  ; غير معرّف
$F0F0: F0 13    BEQ  $F105
$F0F2: AD D5 06 LDA  $06D5
$F0F5: C9          .byte $C9  ; غير معرّف
$F0F6: 50 F0    BVC  $F0E8
$F0F8: 1E C9 B8 ASL  $B8C9,X
$F0FB: F0 1A    BEQ  $F117
$F0FD: C9          .byte $C9  ; غير معرّف
$F0FE: C0 F0    CPY  #$F0
$F100: 16 C9    ASL  $C9,X
$F102: C8       INY  
$F103: D0 24    BNE  $F129
$F105: B9 12 02 LDA  $0212,Y
$F108: 29 3F    AND  #$3F
$F10A: 99 12 02 STA  $0212,Y
$F10D: B9 16 02 LDA  $0216,Y
$F110: 29 3F    AND  #$3F
$F112: 09 40    ORA  #$40
$F114: 99 16 02 STA  $0216,Y
$F117: B9 1A 02 LDA  $021A,Y
$F11A: 29 3F    AND  #$3F
$F11C: 99 1A 02 STA  $021A,Y
$F11F: B9 1E 02 LDA  $021E,Y
$F122: 29 3F    AND  #$3F
$F124: 09 40    ORA  #$40
$F126: 99 1E 02 STA  $021E,Y
$F129: 60       RTS  
$F12A: A2 00    LDX  #$00
$F12C: A0 00    LDY  #$00
$F12E: 4C 42 F1 JMP  $F142
$F131: A0 01    LDY  #$01
$F133: 20 A8 F1 JSR  $F1A8
$F136: A0 03    LDY  #$03
$F138: 4C 42 F1 JMP  $F142
$F13B: A0 00    LDY  #$00
$F13D: 20 A8 F1 JSR  $F1A8
$F140: A0 02    LDY  #$02
$F142: 20 71 F1 JSR  $F171
$F145: A6 08    LDX  $08
$F147: 60       RTS  
$F148: A0 02    LDY  #$02
$F14A: 20 A8 F1 JSR  $F1A8
$F14D: A0 06    LDY  #$06
$F14F: 4C 42 F1 JMP  $F142
$F152: A9 01    LDA  #$01
$F154: A0 01    LDY  #$01
$F156: 4C 65 F1 JMP  $F165
$F159: A9 09    LDA  #$09
$F15B: A0 04    LDY  #$04
$F15D: 20 65 F1 JSR  $F165
$F160: E8       INX  
$F161: E8       INX  
$F162: A9 09    LDA  #$09
$F164: C8       INY  
$F165: 86 00    STX  $00
$F167: 18       CLC  
$F168: 65 00    ADC  $00
$F16A: AA       TAX  
$F16B: 20 71 F1 JSR  $F171
$F16E: A6 08    LDX  $08
$F170: 60       RTS  
$F171: B5 CE    LDA  $CE,X
$F173: 99 B8 03 STA  $03B8,Y
$F176: B5 86    LDA  $86,X
$F178: 38       SEC  
$F179: ED 1C 07 SBC  $071C
$F17C: 99 AD 03 STA  $03AD,Y
$F17F: 60       RTS  
$F180: A2 00    LDX  #$00
$F182: A0 00    LDY  #$00
$F184: 4C C0 F1 JMP  $F1C0
$F187: A0 00    LDY  #$00
$F189: 20 A8 F1 JSR  $F1A8
$F18C: A0 02    LDY  #$02
$F18E: 4C C0 F1 JMP  $F1C0
$F191: A0 01    LDY  #$01
$F193: 20 A8 F1 JSR  $F1A8
$F196: A0 03    LDY  #$03
$F198: 4C C0 F1 JMP  $F1C0
$F19B: A0 02    LDY  #$02
$F19D: 20 A8 F1 JSR  $F1A8
$F1A0: A0 06    LDY  #$06
$F1A2: 4C C0 F1 JMP  $F1C0
$F1A5: 07          .byte $07  ; غير معرّف
$F1A6: 16 0D    ASL  $0D,X
$F1A8: 8A       TXA  
$F1A9: 18       CLC  
$F1AA: 79 A5 F1 ADC  $F1A5,Y
$F1AD: AA       TAX  
$F1AE: 60       RTS  
$F1AF: A9 01    LDA  #$01
$F1B1: A0 01    LDY  #$01
$F1B3: 4C BA F1 JMP  $F1BA
$F1B6: A9 09    LDA  #$09
$F1B8: A0 04    LDY  #$04
$F1BA: 86 00    STX  $00
$F1BC: 18       CLC  
$F1BD: 65 00    ADC  $00
$F1BF: AA       TAX  
$F1C0: 98       TYA  
$F1C1: 48       PHA  
$F1C2: 20 D7 F1 JSR  $F1D7
$F1C5: 0A       ASL  A
$F1C6: 0A       ASL  A
$F1C7: 0A       ASL  A
$F1C8: 0A       ASL  A
$F1C9: 05 00    ORA  $00
$F1CB: 85 00    STA  $00
$F1CD: 68       PLA  
$F1CE: A8       TAY  
$F1CF: A5 00    LDA  $00
$F1D1: 99 D0 03 STA  $03D0,Y
$F1D4: A6 08    LDX  $08
$F1D6: 60       RTS  
$F1D7: 20 F6 F1 JSR  $F1F6
$F1DA: 4A       LSR  A
$F1DB: 4A       LSR  A
$F1DC: 4A       LSR  A
$F1DD: 4A       LSR  A
$F1DE: 85 00    STA  $00
$F1E0: 4C 39 F2 JMP  $F239
$F1E3: 7F          .byte $7F  ; غير معرّف
$F1E4: 3F          .byte $3F  ; غير معرّف
$F1E5: 1F          .byte $1F  ; غير معرّف
$F1E6: 0F          .byte $0F  ; غير معرّف
$F1E7: 07          .byte $07  ; غير معرّف
$F1E8: 03          .byte $03  ; غير معرّف
$F1E9: 01 00    ORA  ($00,X)
$F1EB: 80          .byte $80  ; غير معرّف
$F1EC: C0 E0    CPY  #$E0
$F1EE: F0 F8    BEQ  $F1E8
$F1F0: FC          .byte $FC  ; غير معرّف
$F1F1: FE FF 07 INC  $07FF,X
$F1F4: 0F          .byte $0F  ; غير معرّف
$F1F5: 07          .byte $07  ; غير معرّف
$F1F6: 86 04    STX  $04
$F1F8: A0 01    LDY  #$01
$F1FA: B9 1C 07 LDA  $071C,Y
$F1FD: 38       SEC  
$F1FE: F5 86    SBC  $86,X
$F200: 85 07    STA  $07
$F202: B9 1A 07 LDA  $071A,Y
$F205: F5 6D    SBC  $6D,X
$F207: BE F3 F1 LDX  $F1F3,Y
$F20A: C9          .byte $C9  ; غير معرّف
$F20B: 00       BRK  
$F20C: 30 10    BMI  $F21E
$F20E: BE F4 F1 LDX  $F1F4,Y
$F211: C9          .byte $C9  ; غير معرّف
$F212: 01 10    ORA  ($10,X)
$F214: 09 A9    ORA  #$A9
$F216: 38       SEC  
$F217: 85 06    STA  $06
$F219: A9 08    LDA  #$08
$F21B: 20 6D F2 JSR  $F26D
$F21E: BD E3 F1 LDA  $F1E3,X
$F221: A6 04    LDX  $04
$F223: C9          .byte $C9  ; غير معرّف
$F224: 00       BRK  
$F225: D0 03    BNE  $F22A
$F227: 88       DEY  
$F228: 10 D0    BPL  $F1FA
$F22A: 60       RTS  
$F22B: 00       BRK  
$F22C: 08       PHP  
$F22D: 0C          .byte $0C  ; غير معرّف
$F22E: 0E 0F 07 ASL  $070F
$F231: 03          .byte $03  ; غير معرّف
$F232: 01 00    ORA  ($00,X)
$F234: 04          .byte $04  ; غير معرّف
$F235: 00       BRK  
$F236: 04          .byte $04  ; غير معرّف
$F237: FF          .byte $FF  ; غير معرّف
$F238: 00       BRK  
$F239: 86 04    STX  $04
$F23B: A0 01    LDY  #$01
$F23D: B9 37 F2 LDA  $F237,Y
$F240: 38       SEC  
$F241: F5 CE    SBC  $CE,X
$F243: 85 07    STA  $07
$F245: A9 01    LDA  #$01
$F247: F5 B5    SBC  $B5,X
$F249: BE 34 F2 LDX  $F234,Y
$F24C: C9          .byte $C9  ; غير معرّف
$F24D: 00       BRK  
$F24E: 30 10    BMI  $F260
$F250: BE 35 F2 LDX  $F235,Y
$F253: C9          .byte $C9  ; غير معرّف
$F254: 01 10    ORA  ($10,X)
$F256: 09 A9    ORA  #$A9
$F258: 20 85 06 JSR  $0685
$F25B: A9 04    LDA  #$04
$F25D: 20 6D F2 JSR  $F26D
$F260: BD 2B F2 LDA  $F22B,X
$F263: A6 04    LDX  $04
$F265: C9          .byte $C9  ; غير معرّف
$F266: 00       BRK  
$F267: D0 03    BNE  $F26C
$F269: 88       DEY  
$F26A: 10 D1    BPL  $F23D
$F26C: 60       RTS  
$F26D: 85 05    STA  $05
$F26F: A5 07    LDA  $07
$F271: C5 06    CMP  $06
$F273: B0 0C    BCS  $F281
$F275: 4A       LSR  A
$F276: 4A       LSR  A
$F277: 4A       LSR  A
$F278: 29 07    AND  #$07
$F27A: C0 01    CPY  #$01
$F27C: B0 02    BCS  $F280
$F27E: 65 05    ADC  $05
$F280: AA       TAX  
$F281: 60       RTS  
$F282: A5 03    LDA  $03
$F284: 4A       LSR  A
$F285: 4A       LSR  A
$F286: A5 00    LDA  $00
$F288: 90 0C    BCC  $F296
$F28A: 99 05 02 STA  $0205,Y
$F28D: A5 01    LDA  $01
$F28F: 99 01 02 STA  $0201,Y
$F292: A9 40    LDA  #$40
$F294: D0 0A    BNE  $F2A0
$F296: 99 01 02 STA  $0201,Y
$F299: A5 01    LDA  $01
$F29B: 99 05 02 STA  $0205,Y
$F29E: A9 00    LDA  #$00
$F2A0: 05 04    ORA  $04
$F2A2: 99 02 02 STA  $0202,Y
$F2A5: 99 06 02 STA  $0206,Y
$F2A8: A5 02    LDA  $02
$F2AA: 99 00 02 STA  $0200,Y
$F2AD: 99 04 02 STA  $0204,Y
$F2B0: A5 05    LDA  $05
$F2B2: 99 03 02 STA  $0203,Y
$F2B5: 18       CLC  
$F2B6: 69 08    ADC  #$08
$F2B8: 99 07 02 STA  $0207,Y
$F2BB: A5 02    LDA  $02
$F2BD: 18       CLC  
$F2BE: 69 08    ADC  #$08
$F2C0: 85 02    STA  $02
$F2C2: 98       TYA  
$F2C3: 18       CLC  
$F2C4: 69 08    ADC  #$08
$F2C6: A8       TAY  
$F2C7: E8       INX  
$F2C8: E8       INX  
$F2C9: 60       RTS  
$F2CA: FF          .byte $FF  ; غير معرّف
$F2CB: FF          .byte $FF  ; غير معرّف
$F2CC: FF          .byte $FF  ; غير معرّف
$F2CD: FF          .byte $FF  ; غير معرّف
$F2CE: FF          .byte $FF  ; غير معرّف
$F2CF: FF          .byte $FF  ; غير معرّف
$F2D0: AD 70 07 LDA  $0770
$F2D3: D0 04    BNE  $F2D9
$F2D5: 8D 15 40 STA  $4015
$F2D8: 60       RTS  
$F2D9: A9 FF    LDA  #$FF
$F2DB: 8D 17 40 STA  $4017
$F2DE: A9 0F    LDA  #$0F
$F2E0: 8D 15 40 STA  $4015
$F2E3: AD C6 07 LDA  $07C6
$F2E6: D0 06    BNE  $F2EE
$F2E8: A5 FA    LDA  $FA
$F2EA: C9          .byte $C9  ; غير معرّف
$F2EB: 01 D0    ORA  ($D0,X)
$F2ED: 5D AD B2 EOR  $B2AD,X
$F2F0: 07          .byte $07  ; غير معرّف
$F2F1: D0 23    BNE  $F316
$F2F3: A5 FA    LDA  $FA
$F2F5: F0 66    BEQ  $F35D
$F2F7: 8D B2 07 STA  $07B2
$F2FA: 8D C6 07 STA  $07C6
$F2FD: A9 00    LDA  #$00
$F2FF: 8D 15 40 STA  $4015
$F302: 85 F1    STA  $F1
$F304: 85 F2    STA  $F2
$F306: 85 F3    STA  $F3
$F308: A9 0F    LDA  #$0F
$F30A: 8D 15 40 STA  $4015
$F30D: A9 2A    LDA  #$2A
$F30F: 8D BB 07 STA  $07BB
$F312: A9 44    LDA  #$44
$F314: D0 11    BNE  $F327
$F316: AD BB 07 LDA  $07BB
$F319: C9          .byte $C9  ; غير معرّف
$F31A: 24 F0    BIT  $F0
$F31C: 08       PHP  
$F31D: C9          .byte $C9  ; غير معرّف
$F31E: 1E F0 F1 ASL  $F1F0,X
$F321: C9          .byte $C9  ; غير معرّف
$F322: 18       CLC  
$F323: D0 09    BNE  $F32E
$F325: A9 64    LDA  #$64
$F327: A2 84    LDX  #$84
$F329: A0 7F    LDY  #$7F
$F32B: 20 88 F3 JSR  $F388
$F32E: CE BB 07 DEC  $07BB
$F331: D0 2A    BNE  $F35D
$F333: A9 00    LDA  #$00
$F335: 8D 15 40 STA  $4015
$F338: AD B2 07 LDA  $07B2
$F33B: C9          .byte $C9  ; غير معرّف
$F33C: 02          .byte $02  ; غير معرّف
$F33D: D0 05    BNE  $F344
$F33F: A9 00    LDA  #$00
$F341: 8D C6 07 STA  $07C6
$F344: A9 00    LDA  #$00
$F346: 8D B2 07 STA  $07B2
$F349: F0 12    BEQ  $F35D
$F34B: 20 1B F4 JSR  $F41B
$F34E: 20 7C F5 JSR  $F57C
$F351: 20 67 F6 JSR  $F667
$F354: 20 94 F6 JSR  $F694
$F357: A9 00    LDA  #$00
$F359: 85 FB    STA  $FB
$F35B: 85 FC    STA  $FC
$F35D: A9 00    LDA  #$00
$F35F: 85 FF    STA  $FF
$F361: 85 FE    STA  $FE
$F363: 85 FD    STA  $FD
$F365: 85 FA    STA  $FA
$F367: AC C0 07 LDY  $07C0
$F36A: A5 F4    LDA  $F4
$F36C: 29 03    AND  #$03
$F36E: F0 07    BEQ  $F377
$F370: EE C0 07 INC  $07C0
$F373: C0 30    CPY  #$30
$F375: 90 06    BCC  $F37D
$F377: 98       TYA  
$F378: F0 03    BEQ  $F37D
$F37A: CE C0 07 DEC  $07C0
$F37D: 8C 11 40 STY  $4011
$F380: 60       RTS  
$F381: 8C 01 40 STY  $4001
$F384: 8E 00 40 STX  $4000
$F387: 60       RTS  
$F388: 20 81 F3 JSR  $F381
$F38B: A2 00    LDX  #$00
$F38D: A8       TAY  
$F38E: B9 01 FF LDA  $FF01,Y
$F391: F0 0B    BEQ  $F39E
$F393: 9D 02 40 STA  $4002,X
$F396: B9 00 FF LDA  $FF00,Y
$F399: 09 08    ORA  #$08
$F39B: 9D 03 40 STA  $4003,X
$F39E: 60       RTS  
$F39F: 8E 04 40 STX  $4004
$F3A2: 8C 05 40 STY  $4005
$F3A5: 60       RTS  
$F3A6: 20 9F F3 JSR  $F39F
$F3A9: A2 04    LDX  #$04
$F3AB: D0 E0    BNE  $F38D
$F3AD: A2 08    LDX  #$08
$F3AF: D0 DC    BNE  $F38D
$F3B1: 9F          .byte $9F  ; غير معرّف
$F3B2: 9B          .byte $9B  ; غير معرّف
$F3B3: 98       TYA  
$F3B4: 96 95    STX  $95,Y
$F3B6: 94 92    STY  $92,X
$F3B8: 90 90    BCC  $F34A
$F3BA: 9A       TXS  
$F3BB: 97          .byte $97  ; غير معرّف
$F3BC: 95 93    STA  $93,X
$F3BE: 92          .byte $92  ; غير معرّف
$F3BF: A9 40    LDA  #$40
$F3C1: 8D BB 07 STA  $07BB
$F3C4: A9 62    LDA  #$62
$F3C6: 20 8B F3 JSR  $F38B
$F3C9: A2 99    LDX  #$99
$F3CB: D0 25    BNE  $F3F2
$F3CD: A9 26    LDA  #$26
$F3CF: D0 02    BNE  $F3D3
$F3D1: A9 18    LDA  #$18
$F3D3: A2 82    LDX  #$82
$F3D5: A0 A7    LDY  #$A7
$F3D7: 20 88 F3 JSR  $F388
$F3DA: A9 28    LDA  #$28
$F3DC: 8D BB 07 STA  $07BB
$F3DF: AD BB 07 LDA  $07BB
$F3E2: C9          .byte $C9  ; غير معرّف
$F3E3: 25 D0    AND  $D0
$F3E5: 06 A2    ASL  $A2
$F3E7: 5F          .byte $5F  ; غير معرّف
$F3E8: A0 F6    LDY  #$F6
$F3EA: D0 08    BNE  $F3F4
$F3EC: C9          .byte $C9  ; غير معرّف
$F3ED: 20 D0 29 JSR  $29D0
$F3F0: A2 48    LDX  #$48
$F3F2: A0 BC    LDY  #$BC
$F3F4: 20 81 F3 JSR  $F381
$F3F7: D0 20    BNE  $F419
$F3F9: A9 05    LDA  #$05
$F3FB: A0 99    LDY  #$99
$F3FD: D0 04    BNE  $F403
$F3FF: A9 0A    LDA  #$0A
$F401: A0 93    LDY  #$93
$F403: A2 9E    LDX  #$9E
$F405: 8D BB 07 STA  $07BB
$F408: A9 0C    LDA  #$0C
$F40A: 20 88 F3 JSR  $F388
$F40D: AD BB 07 LDA  $07BB
$F410: C9          .byte $C9  ; غير معرّف
$F411: 06 D0    ASL  $D0
$F413: 05 A9    ORA  $A9
$F415: BB          .byte $BB  ; غير معرّف
$F416: 8D 01 40 STA  $4001
$F419: D0 60    BNE  $F47B
$F41B: A4 FF    LDY  $FF
$F41D: F0 20    BEQ  $F43F
$F41F: 84 F1    STY  $F1
$F421: 30 AA    BMI  $F3CD
$F423: 46 FF    LSR  $FF
$F425: B0 AA    BCS  $F3D1
$F427: 46 FF    LSR  $FF
$F429: B0 D4    BCS  $F3FF
$F42B: 46 FF    LSR  $FF
$F42D: B0 2C    BCS  $F45B
$F42F: 46 FF    LSR  $FF
$F431: B0 4A    BCS  $F47D
$F433: 46 FF    LSR  $FF
$F435: B0 7F    BCS  $F4B6
$F437: 46 FF    LSR  $FF
$F439: B0 BE    BCS  $F3F9
$F43B: 46 FF    LSR  $FF
$F43D: B0 80    BCS  $F3BF
$F43F: A5 F1    LDA  $F1
$F441: F0 17    BEQ  $F45A
$F443: 30 9A    BMI  $F3DF
$F445: 4A       LSR  A
$F446: B0 97    BCS  $F3DF
$F448: 4A       LSR  A
$F449: B0 C2    BCS  $F40D
$F44B: 4A       LSR  A
$F44C: B0 1B    BCS  $F469
$F44E: 4A       LSR  A
$F44F: B0 3C    BCS  $F48D
$F451: 4A       LSR  A
$F452: B0 67    BCS  $F4BB
$F454: 4A       LSR  A
$F455: B0 B6    BCS  $F40D
$F457: 4A       LSR  A
$F458: B0 48    BCS  $F4A2
$F45A: 60       RTS  
$F45B: A9 0E    LDA  #$0E
$F45D: 8D BB 07 STA  $07BB
$F460: A0 9C    LDY  #$9C
$F462: A2 9E    LDX  #$9E
$F464: A9 26    LDA  #$26
$F466: 20 88 F3 JSR  $F388
$F469: AC BB 07 LDY  $07BB
$F46C: B9 B0 F3 LDA  $F3B0,Y
$F46F: 8D 00 40 STA  $4000
$F472: C0 06    CPY  #$06
$F474: D0 05    BNE  $F47B
$F476: A9 9E    LDA  #$9E
$F478: 8D 02 40 STA  $4002
$F47B: D0 25    BNE  $F4A2
$F47D: A9 0E    LDA  #$0E
$F47F: A0 CB    LDY  #$CB
$F481: A2 9F    LDX  #$9F
$F483: 8D BB 07 STA  $07BB
$F486: A9 28    LDA  #$28
$F488: 20 88 F3 JSR  $F388
$F48B: D0 15    BNE  $F4A2
$F48D: AC BB 07 LDY  $07BB
$F490: C0 08    CPY  #$08
$F492: D0 09    BNE  $F49D
$F494: A9 A0    LDA  #$A0
$F496: 8D 02 40 STA  $4002
$F499: A9 9F    LDA  #$9F
$F49B: D0 02    BNE  $F49F
$F49D: A9 90    LDA  #$90
$F49F: 8D 00 40 STA  $4000
$F4A2: CE BB 07 DEC  $07BB
$F4A5: D0 0E    BNE  $F4B5
$F4A7: A2 00    LDX  #$00
$F4A9: 86 F1    STX  $F1
$F4AB: A2 0E    LDX  #$0E
$F4AD: 8E 15 40 STX  $4015
$F4B0: A2 0F    LDX  #$0F
$F4B2: 8E 15 40 STX  $4015
$F4B5: 60       RTS  
$F4B6: A9 2F    LDA  #$2F
$F4B8: 8D BB 07 STA  $07BB
$F4BB: AD BB 07 LDA  $07BB
$F4BE: 4A       LSR  A
$F4BF: B0 10    BCS  $F4D1
$F4C1: 4A       LSR  A
$F4C2: B0 0D    BCS  $F4D1
$F4C4: 29 02    AND  #$02
$F4C6: F0 09    BEQ  $F4D1
$F4C8: A0 91    LDY  #$91
$F4CA: A2 9A    LDX  #$9A
$F4CC: A9 44    LDA  #$44
$F4CE: 20 88 F3 JSR  $F388
$F4D1: 4C A2 F4 JMP  $F4A2
$F4D4: 58       CLI  
$F4D5: 02          .byte $02  ; غير معرّف
$F4D6: 54          .byte $54  ; غير معرّف
$F4D7: 56 4E    LSR  $4E,X
$F4D9: 44          .byte $44  ; غير معرّف
$F4DA: 4C 52 4C JMP  $4C52
$F4DD: 48       PHA  
$F4DE: 3E 36 3E ROL  $3E36,X
$F4E1: 36 30    ROL  $30,X
$F4E3: 28       PLP  
$F4E4: 4A       LSR  A
$F4E5: 50 4A    BVC  $F531
$F4E7: 64          .byte $64  ; غير معرّف
$F4E8: 3C          .byte $3C  ; غير معرّف
$F4E9: 32          .byte $32  ; غير معرّف
$F4EA: 3C          .byte $3C  ; غير معرّف
$F4EB: 32          .byte $32  ; غير معرّف
$F4EC: 2C 24 3A BIT  $3A24
$F4EF: 64          .byte $64  ; غير معرّف
$F4F0: 3A          .byte $3A  ; غير معرّف
$F4F1: 34          .byte $34  ; غير معرّف
$F4F2: 2C 22 2C BIT  $2C22
$F4F5: 22          .byte $22  ; غير معرّف
$F4F6: 1C          .byte $1C  ; غير معرّف
$F4F7: 14          .byte $14  ; غير معرّف
$F4F8: 14          .byte $14  ; غير معرّف
$F4F9: 04          .byte $04  ; غير معرّف
$F4FA: 22          .byte $22  ; غير معرّف
$F4FB: 24 16    BIT  $16
$F4FD: 04          .byte $04  ; غير معرّف
$F4FE: 24 26    BIT  $26
$F500: 18       CLC  
$F501: 04          .byte $04  ; غير معرّف
$F502: 26 28    ROL  $28
$F504: 1A          .byte $1A  ; غير معرّف
$F505: 04          .byte $04  ; غير معرّف
$F506: 28       PLP  
$F507: 2A       ROL  A
$F508: 1C          .byte $1C  ; غير معرّف
$F509: 04          .byte $04  ; غير معرّف
$F50A: 2A       ROL  A
$F50B: 2C 1E 04 BIT  $041E
$F50E: 2C 2E 20 BIT  $202E
$F511: 04          .byte $04  ; غير معرّف
$F512: 2E 30 22 ROL  $2230
$F515: 04          .byte $04  ; غير معرّف
$F516: 30 32    BMI  $F54A
$F518: A9 35    LDA  #$35
$F51A: A2 8D    LDX  #$8D
$F51C: D0 04    BNE  $F522
$F51E: A9 06    LDA  #$06
$F520: A2 98    LDX  #$98
$F522: 8D BD 07 STA  $07BD
$F525: A0 7F    LDY  #$7F
$F527: A9 42    LDA  #$42
$F529: 20 A6 F3 JSR  $F3A6
$F52C: AD BD 07 LDA  $07BD
$F52F: C9          .byte $C9  ; غير معرّف
$F530: 30 D0    BMI  $F502
$F532: 05 A9    ORA  $A9
$F534: 54          .byte $54  ; غير معرّف
$F535: 8D 06 40 STA  $4006
$F538: D0 2E    BNE  $F568
$F53A: A9 20    LDA  #$20
$F53C: 8D BD 07 STA  $07BD
$F53F: A0 94    LDY  #$94
$F541: A9 5E    LDA  #$5E
$F543: D0 0B    BNE  $F550
$F545: AD BD 07 LDA  $07BD
$F548: C9          .byte $C9  ; غير معرّف
$F549: 18       CLC  
$F54A: D0 1C    BNE  $F568
$F54C: A0 93    LDY  #$93
$F54E: A9 18    LDA  #$18
$F550: D0 7F    BNE  $F5D1
$F552: A9 36    LDA  #$36
$F554: 8D BD 07 STA  $07BD
$F557: AD BD 07 LDA  $07BD
$F55A: 4A       LSR  A
$F55B: B0 0B    BCS  $F568
$F55D: A8       TAY  
$F55E: B9 D9 F4 LDA  $F4D9,Y
$F561: A2 5D    LDX  #$5D
$F563: A0 7F    LDY  #$7F
$F565: 20 A6 F3 JSR  $F3A6
$F568: CE BD 07 DEC  $07BD
$F56B: D0 0E    BNE  $F57B
$F56D: A2 00    LDX  #$00
$F56F: 86 F2    STX  $F2
$F571: A2 0D    LDX  #$0D
$F573: 8E 15 40 STX  $4015
$F576: A2 0F    LDX  #$0F
$F578: 8E 15 40 STX  $4015
$F57B: 60       RTS  
$F57C: A5 F2    LDA  $F2
$F57E: 29 40    AND  #$40
$F580: D0 65    BNE  $F5E7
$F582: A4 FE    LDY  $FE
$F584: F0 20    BEQ  $F5A6
$F586: 84 F2    STY  $F2
$F588: 30 3E    BMI  $F5C8
$F58A: 46 FE    LSR  $FE
$F58C: B0 8A    BCS  $F518
$F58E: 46 FE    LSR  $FE
$F590: B0 6A    BCS  $F5FC
$F592: 46 FE    LSR  $FE
$F594: B0 6A    BCS  $F600
$F596: 46 FE    LSR  $FE
$F598: B0 A0    BCS  $F53A
$F59A: 46 FE    LSR  $FE
$F59C: B0 80    BCS  $F51E
$F59E: 46 FE    LSR  $FE
$F5A0: B0 B0    BCS  $F552
$F5A2: 46 FE    LSR  $FE
$F5A4: B0 3C    BCS  $F5E2
$F5A6: A5 F2    LDA  $F2
$F5A8: F0 17    BEQ  $F5C1
$F5AA: 30 27    BMI  $F5D3
$F5AC: 4A       LSR  A
$F5AD: B0 13    BCS  $F5C2
$F5AF: 4A       LSR  A
$F5B0: B0 5D    BCS  $F60F
$F5B2: 4A       LSR  A
$F5B3: B0 5A    BCS  $F60F
$F5B5: 4A       LSR  A
$F5B6: B0 8D    BCS  $F545
$F5B8: 4A       LSR  A
$F5B9: B0 07    BCS  $F5C2
$F5BB: 4A       LSR  A
$F5BC: B0 99    BCS  $F557
$F5BE: 4A       LSR  A
$F5BF: B0 26    BCS  $F5E7
$F5C1: 60       RTS  
$F5C2: 4C 2C F5 JMP  $F52C
$F5C5: 4C 68 F5 JMP  $F568
$F5C8: A9 38    LDA  #$38
$F5CA: 8D BD 07 STA  $07BD
$F5CD: A0 C4    LDY  #$C4
$F5CF: A9 18    LDA  #$18
$F5D1: D0 0B    BNE  $F5DE
$F5D3: AD BD 07 LDA  $07BD
$F5D6: C9          .byte $C9  ; غير معرّف
$F5D7: 08       PHP  
$F5D8: D0 8E    BNE  $F568
$F5DA: A0 A4    LDY  #$A4
$F5DC: A9 5A    LDA  #$5A
$F5DE: A2 9F    LDX  #$9F
$F5E0: D0 83    BNE  $F565
$F5E2: A9 30    LDA  #$30
$F5E4: 8D BD 07 STA  $07BD
$F5E7: AD BD 07 LDA  $07BD
$F5EA: A2 03    LDX  #$03
$F5EC: 4A       LSR  A
$F5ED: B0 D6    BCS  $F5C5
$F5EF: CA       DEX  
$F5F0: D0 FA    BNE  $F5EC
$F5F2: A8       TAY  
$F5F3: B9 D3 F4 LDA  $F4D3,Y
$F5F6: A2 82    LDX  #$82
$F5F8: A0 7F    LDY  #$7F
$F5FA: D0 E4    BNE  $F5E0
$F5FC: A9 10    LDA  #$10
$F5FE: D0 02    BNE  $F602
$F600: A9 20    LDA  #$20
$F602: 8D BD 07 STA  $07BD
$F605: A9 7F    LDA  #$7F
$F607: 8D 05 40 STA  $4005
$F60A: A9 00    LDA  #$00
$F60C: 8D BE 07 STA  $07BE
$F60F: EE BE 07 INC  $07BE
$F612: AD BE 07 LDA  $07BE
$F615: 4A       LSR  A
$F616: A8       TAY  
$F617: CC BD 07 CPY  $07BD
$F61A: F0 0C    BEQ  $F628
$F61C: A9 9D    LDA  #$9D
$F61E: 8D 04 40 STA  $4004
$F621: B9 F8 F4 LDA  $F4F8,Y
$F624: 20 A9 F3 JSR  $F3A9
$F627: 60       RTS  
$F628: 4C 6D F5 JMP  $F56D
$F62B: 01 0E    ORA  ($0E,X)
$F62D: 0E 0D 0B ASL  $0B0D
$F630: 06 0C    ASL  $0C
$F632: 0F          .byte $0F  ; غير معرّف
$F633: 0A       ASL  A
$F634: 09 03    ORA  #$03
$F636: 0D 08 0D ORA  $0D08
$F639: 06 0C    ASL  $0C
$F63B: A9 20    LDA  #$20
$F63D: 8D BF 07 STA  $07BF
$F640: AD BF 07 LDA  $07BF
$F643: 4A       LSR  A
$F644: 90 12    BCC  $F658
$F646: A8       TAY  
$F647: BE 2B F6 LDX  $F62B,Y
$F64A: B9 EA FF LDA  $FFEA,Y
$F64D: 8D 0C 40 STA  $400C
$F650: 8E 0E 40 STX  $400E
$F653: A9 18    LDA  #$18
$F655: 8D 0F 40 STA  $400F
$F658: CE BF 07 DEC  $07BF
$F65B: D0 09    BNE  $F666
$F65D: A9 F0    LDA  #$F0
$F65F: 8D 0C 40 STA  $400C
$F662: A9 00    LDA  #$00
$F664: 85 F3    STA  $F3
$F666: 60       RTS  
$F667: A4 FD    LDY  $FD
$F669: F0 0A    BEQ  $F675
$F66B: 84 F3    STY  $F3
$F66D: 46 FD    LSR  $FD
$F66F: B0 CA    BCS  $F63B
$F671: 46 FD    LSR  $FD
$F673: B0 0B    BCS  $F680
$F675: A5 F3    LDA  $F3
$F677: F0 06    BEQ  $F67F
$F679: 4A       LSR  A
$F67A: B0 C4    BCS  $F640
$F67C: 4A       LSR  A
$F67D: B0 06    BCS  $F685
$F67F: 60       RTS  
$F680: A9 40    LDA  #$40
$F682: 8D BF 07 STA  $07BF
$F685: AD BF 07 LDA  $07BF
$F688: 4A       LSR  A
$F689: A8       TAY  
$F68A: A2 0F    LDX  #$0F
$F68C: B9 C9 FF LDA  $FFC9,Y
$F68F: D0 BC    BNE  $F64D
$F691: 4C 3A F7 JMP  $F73A
$F694: A5 FC    LDA  $FC
$F696: D0 0C    BNE  $F6A4
$F698: A5 FB    LDA  $FB
$F69A: D0 2C    BNE  $F6C8
$F69C: AD B1 07 LDA  $07B1
$F69F: 05 F4    ORA  $F4
$F6A1: D0 EE    BNE  $F691
$F6A3: 60       RTS  
$F6A4: 8D B1 07 STA  $07B1
$F6A7: C9          .byte $C9  ; غير معرّف
$F6A8: 01 D0    ORA  ($D0,X)
$F6AA: 06 20    ASL  $20
$F6AC: A7          .byte $A7  ; غير معرّف
$F6AD: F4          .byte $F4  ; غير معرّف
$F6AE: 20 71 F5 JSR  $F571
$F6B1: A6 F4    LDX  $F4
$F6B3: 8E C5 07 STX  $07C5
$F6B6: A0 00    LDY  #$00
$F6B8: 8C C4 07 STY  $07C4
$F6BB: 84 F4    STY  $F4
$F6BD: C9          .byte $C9  ; غير معرّف
$F6BE: 40       RTI  
$F6BF: D0 30    BNE  $F6F1
$F6C1: A2 08    LDX  #$08
$F6C3: 8E C4 07 STX  $07C4
$F6C6: D0 29    BNE  $F6F1
$F6C8: C9          .byte $C9  ; غير معرّف
$F6C9: 04          .byte $04  ; غير معرّف
$F6CA: D0 03    BNE  $F6CF
$F6CC: 20 A7 F4 JSR  $F4A7
$F6CF: A0 10    LDY  #$10
$F6D1: 8C C7 07 STY  $07C7
$F6D4: A0 00    LDY  #$00
$F6D6: 8C B1 07 STY  $07B1
$F6D9: 85 F4    STA  $F4
$F6DB: C9          .byte $C9  ; غير معرّف
$F6DC: 01 D0    ORA  ($D0,X)
$F6DE: 0E EE C7 ASL  $C7EE
$F6E1: 07          .byte $07  ; غير معرّف
$F6E2: AC C7 07 LDY  $07C7
$F6E5: C0 32    CPY  #$32
$F6E7: D0 0C    BNE  $F6F5
$F6E9: A0 11    LDY  #$11
$F6EB: D0 E4    BNE  $F6D1
$F6ED: A0 08    LDY  #$08
$F6EF: 84 F7    STY  $F7
$F6F1: C8       INY  
$F6F2: 4A       LSR  A
$F6F3: 90 FC    BCC  $F6F1
$F6F5: B9 0C F9 LDA  $F90C,Y
$F6F8: A8       TAY  
$F6F9: B9 0D F9 LDA  $F90D,Y
$F6FC: 85 F0    STA  $F0
$F6FE: B9 0E F9 LDA  $F90E,Y
$F701: 85 F5    STA  $F5
$F703: B9 0F F9 LDA  $F90F,Y
$F706: 85 F6    STA  $F6
$F708: B9 10 F9 LDA  $F910,Y
$F70B: 85 F9    STA  $F9
$F70D: B9 11 F9 LDA  $F911,Y
$F710: 85 F8    STA  $F8
$F712: B9 12 F9 LDA  $F912,Y
$F715: 8D B0 07 STA  $07B0
$F718: 8D C1 07 STA  $07C1
$F71B: A9 01    LDA  #$01
$F71D: 8D B4 07 STA  $07B4
$F720: 8D B6 07 STA  $07B6
$F723: 8D B9 07 STA  $07B9
$F726: 8D BA 07 STA  $07BA
$F729: A9 00    LDA  #$00
$F72B: 85 F7    STA  $F7
$F72D: 8D CA 07 STA  $07CA
$F730: A9 0B    LDA  #$0B
$F732: 8D 15 40 STA  $4015
$F735: A9 0F    LDA  #$0F
$F737: 8D 15 40 STA  $4015
$F73A: CE B4 07 DEC  $07B4
$F73D: D0 5F    BNE  $F79E
$F73F: A4 F7    LDY  $F7
$F741: E6 F7    INC  $F7
$F743: B1 F5    LDA  ($F5),Y
$F745: F0 04    BEQ  $F74B
$F747: 10 3D    BPL  $F786
$F749: D0 2F    BNE  $F77A
$F74B: AD B1 07 LDA  $07B1
$F74E: C9          .byte $C9  ; غير معرّف
$F74F: 40       RTI  
$F750: D0 05    BNE  $F757
$F752: AD C5 07 LDA  $07C5
$F755: D0 1D    BNE  $F774
$F757: 29 04    AND  #$04
$F759: D0 1C    BNE  $F777
$F75B: A5 F4    LDA  $F4
$F75D: 29 5F    AND  #$5F
$F75F: D0 13    BNE  $F774
$F761: A9 00    LDA  #$00
$F763: 85 F4    STA  $F4
$F765: 8D B1 07 STA  $07B1
$F768: 8D 08 40 STA  $4008
$F76B: A9 90    LDA  #$90
$F76D: 8D 00 40 STA  $4000
$F770: 8D 04 40 STA  $4004
$F773: 60       RTS  
$F774: 4C D4 F6 JMP  $F6D4
$F777: 4C A4 F6 JMP  $F6A4
$F77A: 20 CB F8 JSR  $F8CB
$F77D: 8D B3 07 STA  $07B3
$F780: A4 F7    LDY  $F7
$F782: E6 F7    INC  $F7
$F784: B1 F5    LDA  ($F5),Y
$F786: A6 F2    LDX  $F2
$F788: D0 0E    BNE  $F798
$F78A: 20 A9 F3 JSR  $F3A9
$F78D: F0 03    BEQ  $F792
$F78F: 20 D8 F8 JSR  $F8D8
$F792: 8D B5 07 STA  $07B5
$F795: 20 9F F3 JSR  $F39F
$F798: AD B3 07 LDA  $07B3
$F79B: 8D B4 07 STA  $07B4
$F79E: A5 F2    LDA  $F2
$F7A0: D0 1A    BNE  $F7BC
$F7A2: AD B1 07 LDA  $07B1
$F7A5: 29 91    AND  #$91
$F7A7: D0 13    BNE  $F7BC
$F7A9: AC B5 07 LDY  $07B5
$F7AC: F0 03    BEQ  $F7B1
$F7AE: CE B5 07 DEC  $07B5
$F7B1: 20 F4 F8 JSR  $F8F4
$F7B4: 8D 04 40 STA  $4004
$F7B7: A2 7F    LDX  #$7F
$F7B9: 8E 05 40 STX  $4005
$F7BC: A4 F8    LDY  $F8
$F7BE: F0 5A    BEQ  $F81A
$F7C0: CE B6 07 DEC  $07B6
$F7C3: D0 32    BNE  $F7F7
$F7C5: A4 F8    LDY  $F8
$F7C7: E6 F8    INC  $F8
$F7C9: B1 F5    LDA  ($F5),Y
$F7CB: D0 0F    BNE  $F7DC
$F7CD: A9 83    LDA  #$83
$F7CF: 8D 00 40 STA  $4000
$F7D2: A9 94    LDA  #$94
$F7D4: 8D 01 40 STA  $4001
$F7D7: 8D CA 07 STA  $07CA
$F7DA: D0 E9    BNE  $F7C5
$F7DC: 20 C5 F8 JSR  $F8C5
$F7DF: 8D B6 07 STA  $07B6
$F7E2: A4 F1    LDY  $F1
$F7E4: D0 34    BNE  $F81A
$F7E6: 8A       TXA  
$F7E7: 29 3E    AND  #$3E
$F7E9: 20 8B F3 JSR  $F38B
$F7EC: F0 03    BEQ  $F7F1
$F7EE: 20 D8 F8 JSR  $F8D8
$F7F1: 8D B7 07 STA  $07B7
$F7F4: 20 81 F3 JSR  $F381
$F7F7: A5 F1    LDA  $F1
$F7F9: D0 1F    BNE  $F81A
$F7FB: AD B1 07 LDA  $07B1
$F7FE: 29 91    AND  #$91
$F800: D0 0E    BNE  $F810
$F802: AC B7 07 LDY  $07B7
$F805: F0 03    BEQ  $F80A
$F807: CE B7 07 DEC  $07B7
$F80A: 20 F4 F8 JSR  $F8F4
$F80D: 8D 00 40 STA  $4000
$F810: AD CA 07 LDA  $07CA
$F813: D0 02    BNE  $F817
$F815: A9 7F    LDA  #$7F
$F817: 8D 01 40 STA  $4001
$F81A: A5 F9    LDA  $F9
$F81C: CE B9 07 DEC  $07B9
$F81F: D0 4C    BNE  $F86D
$F821: A4 F9    LDY  $F9
$F823: E6 F9    INC  $F9
$F825: B1 F5    LDA  ($F5),Y
$F827: F0 41    BEQ  $F86A
$F829: 10 13    BPL  $F83E
$F82B: 20 CB F8 JSR  $F8CB
$F82E: 8D B8 07 STA  $07B8
$F831: A9 1F    LDA  #$1F
$F833: 8D 08 40 STA  $4008
$F836: A4 F9    LDY  $F9
$F838: E6 F9    INC  $F9
$F83A: B1 F5    LDA  ($F5),Y
$F83C: F0 2C    BEQ  $F86A
$F83E: 20 AD F3 JSR  $F3AD
$F841: AE B8 07 LDX  $07B8
$F844: 8E B9 07 STX  $07B9
$F847: AD B1 07 LDA  $07B1
$F84A: 29 6E    AND  #$6E
$F84C: D0 06    BNE  $F854
$F84E: A5 F4    LDA  $F4
$F850: 29 0A    AND  #$0A
$F852: F0 19    BEQ  $F86D
$F854: 8A       TXA  
$F855: C9          .byte $C9  ; غير معرّف
$F856: 12          .byte $12  ; غير معرّف
$F857: B0 0F    BCS  $F868
$F859: AD B1 07 LDA  $07B1
$F85C: 29 08    AND  #$08
$F85E: F0 04    BEQ  $F864
$F860: A9 0F    LDA  #$0F
$F862: D0 06    BNE  $F86A
$F864: A9 1F    LDA  #$1F
$F866: D0 02    BNE  $F86A
$F868: A9 FF    LDA  #$FF
$F86A: 8D 08 40 STA  $4008
$F86D: A5 F4    LDA  $F4
$F86F: 29 F3    AND  #$F3
$F871: F0 51    BEQ  $F8C4
$F873: CE BA 07 DEC  $07BA
$F876: D0 4C    BNE  $F8C4
$F878: AC B0 07 LDY  $07B0
$F87B: EE B0 07 INC  $07B0
$F87E: B1 F5    LDA  ($F5),Y
$F880: D0 08    BNE  $F88A
$F882: AD C1 07 LDA  $07C1
$F885: 8D B0 07 STA  $07B0
$F888: D0 EE    BNE  $F878
$F88A: 20 C5 F8 JSR  $F8C5
$F88D: 8D BA 07 STA  $07BA
$F890: 8A       TXA  
$F891: 29 3E    AND  #$3E
$F893: F0 24    BEQ  $F8B9
$F895: C9          .byte $C9  ; غير معرّف
$F896: 30 F0    BMI  $F888
$F898: 18       CLC  
$F899: C9          .byte $C9  ; غير معرّف
$F89A: 20 F0 0C JSR  $0CF0
$F89D: 29 10    AND  #$10
$F89F: F0 18    BEQ  $F8B9
$F8A1: A9 1C    LDA  #$1C
$F8A3: A2 03    LDX  #$03
$F8A5: A0 18    LDY  #$18
$F8A7: D0 12    BNE  $F8BB
$F8A9: A9 1C    LDA  #$1C
$F8AB: A2 0C    LDX  #$0C
$F8AD: A0 18    LDY  #$18
$F8AF: D0 0A    BNE  $F8BB
$F8B1: A9 1C    LDA  #$1C
$F8B3: A2 03    LDX  #$03
$F8B5: A0 58    LDY  #$58
$F8B7: D0 02    BNE  $F8BB
$F8B9: A9 10    LDA  #$10
$F8BB: 8D 0C 40 STA  $400C
$F8BE: 8E 0E 40 STX  $400E
$F8C1: 8C 0F 40 STY  $400F
$F8C4: 60       RTS  
$F8C5: AA       TAX  
$F8C6: 6A       ROR  A
$F8C7: 8A       TXA  
$F8C8: 2A       ROL  A
$F8C9: 2A       ROL  A
$F8CA: 2A       ROL  A
$F8CB: 29 07    AND  #$07
$F8CD: 18       CLC  
$F8CE: 65 F0    ADC  $F0
$F8D0: 6D C4 07 ADC  $07C4
$F8D3: A8       TAY  
$F8D4: B9 66 FF LDA  $FF66,Y
$F8D7: 60       RTS  
$F8D8: AD B1 07 LDA  $07B1
$F8DB: 29 08    AND  #$08
$F8DD: F0 04    BEQ  $F8E3
$F8DF: A9 04    LDA  #$04
$F8E1: D0 0C    BNE  $F8EF
$F8E3: A5 F4    LDA  $F4
$F8E5: 29 7D    AND  #$7D
$F8E7: F0 04    BEQ  $F8ED
$F8E9: A9 08    LDA  #$08
$F8EB: D0 02    BNE  $F8EF
$F8ED: A9 28    LDA  #$28
$F8EF: A2 82    LDX  #$82
$F8F1: A0 7F    LDY  #$7F
$F8F3: 60       RTS  
$F8F4: AD B1 07 LDA  $07B1
$F8F7: 29 08    AND  #$08
$F8F9: F0 04    BEQ  $F8FF
$F8FB: B9 96 FF LDA  $FF96,Y
$F8FE: 60       RTS  
$F8FF: A5 F4    LDA  $F4
$F901: 29 7D    AND  #$7D
$F903: F0 04    BEQ  $F909
$F905: B9 9A FF LDA  $FF9A,Y
$F908: 60       RTS  
$F909: B9 A2 FF LDA  $FFA2,Y
$F90C: 60       RTS  
$F90D: A5 59    LDA  $59
$F90F: 54          .byte $54  ; غير معرّف
$F910: 64          .byte $64  ; غير معرّف
$F911: 59 3C 31 EOR  $313C,Y
$F914: 4B          .byte $4B  ; غير معرّف
$F915: 69 5E    ADC  #$5E
$F917: 46 4F    LSR  $4F
$F919: 36 8D    ROL  $8D,X
$F91B: 36 4B    ROL  $4B,X
$F91D: 8D 69 69 STA  $6969
$F920: 6F          .byte $6F  ; غير معرّف
$F921: 75 6F    ADC  $6F,X
$F923: 7B          .byte $7B  ; غير معرّف
$F924: 6F          .byte $6F  ; غير معرّف
$F925: 75 6F    ADC  $6F,X
$F927: 7B          .byte $7B  ; غير معرّف
$F928: 81 87    STA  ($87,X)
$F92A: 81 8D    STA  ($8D,X)
$F92C: 69 69    ADC  #$69
$F92E: 93          .byte $93  ; غير معرّف
$F92F: 99 93 9F STA  $9F93,Y
$F932: 93          .byte $93  ; غير معرّف
$F933: 99 93 9F STA  $9F93,Y
$F936: 81 87    STA  ($87,X)
$F938: 81 8D    STA  ($8D,X)
$F93A: 93          .byte $93  ; غير معرّف
$F93B: 99 93 9F STA  $9F93,Y
$F93E: 08       PHP  
$F93F: 72          .byte $72  ; غير معرّف
$F940: FC          .byte $FC  ; غير معرّف
$F941: 27          .byte $27  ; غير معرّف
$F942: 18       CLC  
$F943: 20 B8 F9 JSR  $F9B8
$F946: 2E 1A 40 ROL  $401A
$F949: 20 B0 FC JSR  $FCB0
$F94C: 3D 21 20 AND  $2021,X
$F94F: C4 FC    CPY  $FC
$F951: 3F          .byte $3F  ; غير معرّف
$F952: 1D 18 11 ORA  $1118,X
$F955: FD 00 00 SBC  $0000,X
$F958: 08       PHP  
$F959: 1C          .byte $1C  ; غير معرّف
$F95A: FA          .byte $FA  ; غير معرّف
$F95B: 00       BRK  
$F95C: 00       BRK  
$F95D: A4 FB    LDY  $FB
$F95F: 93          .byte $93  ; غير معرّف
$F960: 62          .byte $62  ; غير معرّف
$F961: 10 C8    BPL  $F92B
$F963: FE 24 14 INC  $1424,X
$F966: 18       CLC  
$F967: 45 FC    EOR  $FC
$F969: 1E 14 08 ASL  $0814,X
$F96C: 52          .byte $52  ; غير معرّف
$F96D: FD A0 70 SBC  $70A0,X
$F970: 68       PLA  
$F971: 08       PHP  
$F972: 51 FE    EOR  ($FE),Y
$F974: 4C 24 18 JMP  $1824
$F977: 01 FA    ORA  ($FA,X)
$F979: 2D 1C B8 AND  $B81C
$F97C: 18       CLC  
$F97D: 49 FA    EOR  #$FA
$F97F: 20 12 70 JSR  $7012
$F982: 18       CLC  
$F983: 75 FA    ADC  $FA,X
$F985: 1B          .byte $1B  ; غير معرّف
$F986: 10 44    BPL  $F9CC
$F988: 18       CLC  
$F989: 9D FA 11 STA  $11FA,X
$F98C: 0A       ASL  A
$F98D: 1C          .byte $1C  ; غير معرّف
$F98E: 18       CLC  
$F98F: C2          .byte $C2  ; غير معرّف
$F990: FA          .byte $FA  ; غير معرّف
$F991: 2D 10 58 AND  $5810
$F994: 18       CLC  
$F995: DB          .byte $DB  ; غير معرّف
$F996: FA          .byte $FA  ; غير معرّف
$F997: 14          .byte $14  ; غير معرّف
$F998: 0D 3F 18 ORA  $183F
$F99B: F9 FA 15 SBC  $15FA,Y
$F99E: 0D 21 18 ORA  $1821
$F9A1: 25 FB    AND  $FB
$F9A3: 18       CLC  
$F9A4: 10 7A    BPL  $FA20
$F9A6: 18       CLC  
$F9A7: 4B          .byte $4B  ; غير معرّف
$F9A8: FB          .byte $FB  ; غير معرّف
$F9A9: 19 0F 54 ORA  $540F,Y
$F9AC: 18       CLC  
$F9AD: 74          .byte $74  ; غير معرّف
$F9AE: FB          .byte $FB  ; غير معرّف
$F9AF: 1E 12 2B ASL  $2B12,X
$F9B2: 18       CLC  
$F9B3: 72          .byte $72  ; غير معرّف
$F9B4: FB          .byte $FB  ; غير معرّف
$F9B5: 1E 0F 2D ASL  $2D0F,X
$F9B8: 84 2C    STY  $2C
$F9BA: 2C 2C 82 BIT  $822C
$F9BD: 04          .byte $04  ; غير معرّف
$F9BE: 2C 04 85 BIT  $8504
$F9C1: 2C 84 2C BIT  $2C84
$F9C4: 2C 2A 2A BIT  $2A2A
$F9C7: 2A       ROL  A
$F9C8: 82          .byte $82  ; غير معرّف
$F9C9: 04          .byte $04  ; غير معرّف
$F9CA: 2A       ROL  A
$F9CB: 04          .byte $04  ; غير معرّف
$F9CC: 85 2A    STA  $2A
$F9CE: 84 2A    STY  $2A
$F9D0: 2A       ROL  A
$F9D1: 00       BRK  
$F9D2: 1F          .byte $1F  ; غير معرّف
$F9D3: 1F          .byte $1F  ; غير معرّف
$F9D4: 1F          .byte $1F  ; غير معرّف
$F9D5: 98       TYA  
$F9D6: 1F          .byte $1F  ; غير معرّف
$F9D7: 1F          .byte $1F  ; غير معرّف
$F9D8: 98       TYA  
$F9D9: 9E          .byte $9E  ; غير معرّف
$F9DA: 98       TYA  
$F9DB: 1F          .byte $1F  ; غير معرّف
$F9DC: 1D 1D 1D ORA  $1D1D,X
$F9DF: 94 1D    STY  $1D,X
$F9E1: 1D 94 9C ORA  $9C94,X
$F9E4: 94 1D    STY  $1D,X
$F9E6: 86 18    STX  $18
$F9E8: 85 26    STA  $26
$F9EA: 30 84    BMI  $F970
$F9EC: 04          .byte $04  ; غير معرّف
$F9ED: 26 30    ROL  $30
$F9EF: 86 14    STX  $14
$F9F1: 85 22    STA  $22
$F9F3: 2C 84 04 BIT  $0484
$F9F6: 22          .byte $22  ; غير معرّف
$F9F7: 2C 21 D0 BIT  $D021
$F9FA: C4 D0    CPY  $D0
$F9FC: 31 D0    AND  ($D0),Y
$F9FE: C4 D0    CPY  $D0
$FA00: 00       BRK  
$FA01: 85 2C    STA  $2C
$FA03: 22          .byte $22  ; غير معرّف
$FA04: 1C          .byte $1C  ; غير معرّف
$FA05: 84 26    STY  $26
$FA07: 2A       ROL  A
$FA08: 82          .byte $82  ; غير معرّف
$FA09: 28       PLP  
$FA0A: 26 04    ROL  $04
$FA0C: 87          .byte $87  ; غير معرّف
$FA0D: 22          .byte $22  ; غير معرّف
$FA0E: 34          .byte $34  ; غير معرّف
$FA0F: 3A          .byte $3A  ; غير معرّف
$FA10: 82          .byte $82  ; غير معرّف
$FA11: 40       RTI  
$FA12: 04          .byte $04  ; غير معرّف
$FA13: 36 84    ROL  $84,X
$FA15: 3A          .byte $3A  ; غير معرّف
$FA16: 34          .byte $34  ; غير معرّف
$FA17: 82          .byte $82  ; غير معرّف
$FA18: 2C 30 85 BIT  $8530
$FA1B: 2A       ROL  A
$FA1C: 00       BRK  
$FA1D: 5D 55 4D EOR  $4D55,X
$FA20: 15 19    ORA  $19,X
$FA22: 96 15    STX  $15,Y
$FA24: D5 E3    CMP  $E3,X
$FA26: EB          .byte $EB  ; غير معرّف
$FA27: 2D A6 2B AND  $2BA6
$FA2A: 27          .byte $27  ; غير معرّف
$FA2B: 9C          .byte $9C  ; غير معرّف
$FA2C: 9E          .byte $9E  ; غير معرّف
$FA2D: 59 85 22 EOR  $2285,Y
$FA30: 1C          .byte $1C  ; غير معرّف
$FA31: 14          .byte $14  ; غير معرّف
$FA32: 84 1E    STY  $1E
$FA34: 22          .byte $22  ; غير معرّف
$FA35: 82          .byte $82  ; غير معرّف
$FA36: 20 1E 04 JSR  $041E
$FA39: 87          .byte $87  ; غير معرّف
$FA3A: 1C          .byte $1C  ; غير معرّف
$FA3B: 2C 34 82 BIT  $8234
$FA3E: 36 04    ROL  $04,X
$FA40: 30 34    BMI  $FA76
$FA42: 04          .byte $04  ; غير معرّف
$FA43: 2C 04 26 BIT  $2604
$FA46: 2A       ROL  A
$FA47: 85 22    STA  $22
$FA49: 84 04    STY  $04
$FA4B: 82          .byte $82  ; غير معرّف
$FA4C: 3A          .byte $3A  ; غير معرّف
$FA4D: 38       SEC  
$FA4E: 36 32    ROL  $32,X
$FA50: 04          .byte $04  ; غير معرّف
$FA51: 34          .byte $34  ; غير معرّف
$FA52: 04          .byte $04  ; غير معرّف
$FA53: 24 26    BIT  $26
$FA55: 2C 04 26 BIT  $2604
$FA58: 2C 30 00 BIT  $0030
$FA5B: 05 B4    ORA  $B4
$FA5D: B2          .byte $B2  ; غير معرّف
$FA5E: B0 2B    BCS  $FA8B
$FA60: AC 84 9C LDY  $9C84
$FA63: 9E          .byte $9E  ; غير معرّف
$FA64: A2 84    LDX  #$84
$FA66: 94 9C    STY  $9C,X
$FA68: 9E          .byte $9E  ; غير معرّف
$FA69: 85 14    STA  $14
$FA6B: 22          .byte $22  ; غير معرّف
$FA6C: 84 2C    STY  $2C
$FA6E: 85 1E    STA  $1E
$FA70: 82          .byte $82  ; غير معرّف
$FA71: 2C 84 2C BIT  $2C84
$FA74: 1E 84 04 ASL  $0484,X
$FA77: 82          .byte $82  ; غير معرّف
$FA78: 3A          .byte $3A  ; غير معرّف
$FA79: 38       SEC  
$FA7A: 36 32    ROL  $32,X
$FA7C: 04          .byte $04  ; غير معرّف
$FA7D: 34          .byte $34  ; غير معرّف
$FA7E: 04          .byte $04  ; غير معرّف
$FA7F: 64          .byte $64  ; غير معرّف
$FA80: 04          .byte $04  ; غير معرّف
$FA81: 64          .byte $64  ; غير معرّف
$FA82: 86 64    STX  $64
$FA84: 00       BRK  
$FA85: 05 B4    ORA  $B4
$FA87: B2          .byte $B2  ; غير معرّف
$FA88: B0 2B    BCS  $FAB5
$FA8A: AC 84 37 LDY  $3784
$FA8D: B6 B6    LDX  $B6,Y
$FA8F: 45 85    EOR  $85
$FA91: 14          .byte $14  ; غير معرّف
$FA92: 1C          .byte $1C  ; غير معرّف
$FA93: 82          .byte $82  ; غير معرّف
$FA94: 22          .byte $22  ; غير معرّف
$FA95: 84 2C    STY  $2C
$FA97: 4E 82 4E LSR  $4E82
$FA9A: 84 4E    STY  $4E
$FA9C: 22          .byte $22  ; غير معرّف
$FA9D: 84 04    STY  $04
$FA9F: 85 32    STA  $32
$FAA1: 85 30    STA  $30
$FAA3: 86 2C    STX  $2C
$FAA5: 04          .byte $04  ; غير معرّف
$FAA6: 00       BRK  
$FAA7: 05 A4    ORA  $A4
$FAA9: 05 9E    ORA  $9E
$FAAB: 05 9D    ORA  $9D
$FAAD: 85 84    STA  $84
$FAAF: 14          .byte $14  ; غير معرّف
$FAB0: 85 24    STA  $24
$FAB2: 28       PLP  
$FAB3: 2C 82 22 BIT  $2282
$FAB6: 84 22    STY  $22
$FAB8: 14          .byte $14  ; غير معرّف
$FAB9: 21 D0    AND  ($D0,X)
$FABB: C4 D0    CPY  $D0
$FABD: 31 D0    AND  ($D0),Y
$FABF: C4 D0    CPY  $D0
$FAC1: 00       BRK  
$FAC2: 82          .byte $82  ; غير معرّف
$FAC3: 2C 84 2C BIT  $2C84
$FAC6: 2C 82 2C BIT  $2C82
$FAC9: 30 04    BMI  $FACF
$FACB: 34          .byte $34  ; غير معرّف
$FACC: 2C 04 26 BIT  $2604
$FACF: 86 22    STX  $22
$FAD1: 00       BRK  
$FAD2: A4 25    LDY  $25
$FAD4: 25 A4    AND  $A4
$FAD6: 29 A2    AND  #$A2
$FAD8: 1D 9C 95 ORA  $959C,X
$FADB: 82          .byte $82  ; غير معرّف
$FADC: 2C 2C 04 BIT  $042C
$FADF: 2C 04 2C BIT  $2C04
$FAE2: 30 85    BMI  $FA69
$FAE4: 34          .byte $34  ; غير معرّف
$FAE5: 04          .byte $04  ; غير معرّف
$FAE6: 04          .byte $04  ; غير معرّف
$FAE7: 00       BRK  
$FAE8: A4 25    LDY  $25
$FAEA: 25 A4    AND  $A4
$FAEC: A8       TAY  
$FAED: 63          .byte $63  ; غير معرّف
$FAEE: 04          .byte $04  ; غير معرّف
$FAEF: 85 0E    STA  $0E
$FAF1: 1A          .byte $1A  ; غير معرّف
$FAF2: 84 24    STY  $24
$FAF4: 85 22    STA  $22
$FAF6: 14          .byte $14  ; غير معرّف
$FAF7: 84 0C    STY  $0C
$FAF9: 82          .byte $82  ; غير معرّف
$FAFA: 34          .byte $34  ; غير معرّف
$FAFB: 84 34    STY  $34
$FAFD: 34          .byte $34  ; غير معرّف
$FAFE: 82          .byte $82  ; غير معرّف
$FAFF: 2C 84 34 BIT  $3484
$FB02: 86 3A    STX  $3A
$FB04: 04          .byte $04  ; غير معرّف
$FB05: 00       BRK  
$FB06: A0 21    LDY  #$21
$FB08: 21 A0    AND  ($A0,X)
$FB0A: 21 2B    AND  ($2B,X)
$FB0C: 05 A3    ORA  $A3
$FB0E: 82          .byte $82  ; غير معرّف
$FB0F: 18       CLC  
$FB10: 84 18    STY  $18
$FB12: 18       CLC  
$FB13: 82          .byte $82  ; غير معرّف
$FB14: 18       CLC  
$FB15: 18       CLC  
$FB16: 04          .byte $04  ; غير معرّف
$FB17: 86 3A    STX  $3A
$FB19: 22          .byte $22  ; غير معرّف
$FB1A: 31 90    AND  ($90),Y
$FB1C: 31 90    AND  ($90),Y
$FB1E: 31 71    AND  ($71),Y
$FB20: 31 90    AND  ($90),Y
$FB22: 90 90    BCC  $FAB4
$FB24: 00       BRK  
$FB25: 82          .byte $82  ; غير معرّف
$FB26: 34          .byte $34  ; غير معرّف
$FB27: 84 2C    STY  $2C
$FB29: 85 22    STA  $22
$FB2B: 84 24    STY  $24
$FB2D: 82          .byte $82  ; غير معرّف
$FB2E: 26 36    ROL  $36
$FB30: 04          .byte $04  ; غير معرّف
$FB31: 36 86    ROL  $86,X
$FB33: 26 00    ROL  $00
$FB35: AC 27 5D LDY  $5D27
$FB38: 1D 9E 2D ORA  $2D9E,X
$FB3B: AC 9F 85 LDY  $859F
$FB3E: 14          .byte $14  ; غير معرّف
$FB3F: 82          .byte $82  ; غير معرّف
$FB40: 20 84 22 JSR  $2284
$FB43: 2C 1E 1E BIT  $1E1E
$FB46: 82          .byte $82  ; غير معرّف
$FB47: 2C 2C 1E BIT  $1E2C
$FB4A: 04          .byte $04  ; غير معرّف
$FB4B: 87          .byte $87  ; غير معرّف
$FB4C: 2A       ROL  A
$FB4D: 40       RTI  
$FB4E: 40       RTI  
$FB4F: 40       RTI  
$FB50: 3A          .byte $3A  ; غير معرّف
$FB51: 36 82    ROL  $82,X
$FB53: 34          .byte $34  ; غير معرّف
$FB54: 2C 04 26 BIT  $2604
$FB57: 86 22    STX  $22
$FB59: 00       BRK  
$FB5A: E3          .byte $E3  ; غير معرّف
$FB5B: F7          .byte $F7  ; غير معرّف
$FB5C: F7          .byte $F7  ; غير معرّف
$FB5D: F7          .byte $F7  ; غير معرّف
$FB5E: F5 F1    SBC  $F1,X
$FB60: AC 27 9E LDY  $9E27
$FB63: 9D 85 18 STA  $1885,X
$FB66: 82          .byte $82  ; غير معرّف
$FB67: 1E 84 22 ASL  $2284,X
$FB6A: 2A       ROL  A
$FB6B: 22          .byte $22  ; غير معرّف
$FB6C: 22          .byte $22  ; غير معرّف
$FB6D: 82          .byte $82  ; غير معرّف
$FB6E: 2C 2C 22 BIT  $222C
$FB71: 04          .byte $04  ; غير معرّف
$FB72: 86 04    STX  $04
$FB74: 82          .byte $82  ; غير معرّف
$FB75: 2A       ROL  A
$FB76: 36 04    ROL  $04,X
$FB78: 36 87    ROL  $87,X
$FB7A: 36 34    ROL  $34,X
$FB7C: 30 86    BMI  $FB04
$FB7E: 2C 04 00 BIT  $0004
$FB81: 00       BRK  
$FB82: 68       PLA  
$FB83: 6A       ROR  A
$FB84: 6C 45 A2 JMP  ($A245)
$FB87: 31 B0    AND  ($B0),Y
$FB89: F1 ED    SBC  ($ED),Y
$FB8B: EB          .byte $EB  ; غير معرّف
$FB8C: A2 1D    LDX  #$1D
$FB8E: 9C          .byte $9C  ; غير معرّف
$FB8F: 95 86    STA  $86,X
$FB91: 04          .byte $04  ; غير معرّف
$FB92: 85 22    STA  $22
$FB94: 82          .byte $82  ; غير معرّف
$FB95: 22          .byte $22  ; غير معرّف
$FB96: 87          .byte $87  ; غير معرّف
$FB97: 22          .byte $22  ; غير معرّف
$FB98: 26 2A    ROL  $2A
$FB9A: 84 2C    STY  $2C
$FB9C: 22          .byte $22  ; غير معرّف
$FB9D: 86 14    STX  $14
$FB9F: 51 90    EOR  ($90),Y
$FBA1: 31 11    AND  ($11),Y
$FBA3: 00       BRK  
$FBA4: 80          .byte $80  ; غير معرّف
$FBA5: 22          .byte $22  ; غير معرّف
$FBA6: 28       PLP  
$FBA7: 22          .byte $22  ; غير معرّف
$FBA8: 26 22    ROL  $22
$FBAA: 24 22    BIT  $22
$FBAC: 26 22    ROL  $22
$FBAE: 28       PLP  
$FBAF: 22          .byte $22  ; غير معرّف
$FBB0: 2A       ROL  A
$FBB1: 22          .byte $22  ; غير معرّف
$FBB2: 28       PLP  
$FBB3: 22          .byte $22  ; غير معرّف
$FBB4: 26 22    ROL  $22
$FBB6: 28       PLP  
$FBB7: 22          .byte $22  ; غير معرّف
$FBB8: 26 22    ROL  $22
$FBBA: 24 22    BIT  $22
$FBBC: 26 22    ROL  $22
$FBBE: 28       PLP  
$FBBF: 22          .byte $22  ; غير معرّف
$FBC0: 2A       ROL  A
$FBC1: 22          .byte $22  ; غير معرّف
$FBC2: 28       PLP  
$FBC3: 22          .byte $22  ; غير معرّف
$FBC4: 26 20    ROL  $20
$FBC6: 26 20    ROL  $20
$FBC8: 24 20    BIT  $20
$FBCA: 26 20    ROL  $20
$FBCC: 28       PLP  
$FBCD: 20 26 20 JSR  $2026
$FBD0: 28       PLP  
$FBD1: 20 26 20 JSR  $2026
$FBD4: 24 20    BIT  $20
$FBD6: 26 20    ROL  $20
$FBD8: 24 20    BIT  $20
$FBDA: 26 20    ROL  $20
$FBDC: 28       PLP  
$FBDD: 20 26 20 JSR  $2026
$FBE0: 28       PLP  
$FBE1: 20 26 20 JSR  $2026
$FBE4: 24 28    BIT  $28
$FBE6: 30 28    BMI  $FC10
$FBE8: 32          .byte $32  ; غير معرّف
$FBE9: 28       PLP  
$FBEA: 30 28    BMI  $FC14
$FBEC: 2E 28 30 ROL  $3028
$FBEF: 28       PLP  
$FBF0: 2E 28 2C ROL  $2C28
$FBF3: 28       PLP  
$FBF4: 2E 28 30 ROL  $3028
$FBF7: 28       PLP  
$FBF8: 32          .byte $32  ; غير معرّف
$FBF9: 28       PLP  
$FBFA: 30 28    BMI  $FC24
$FBFC: 2E 28 30 ROL  $3028
$FBFF: 28       PLP  
$FC00: 2E 28 2C ROL  $2C28
$FC03: 28       PLP  
$FC04: 2E 00 04 ROL  $0400
$FC07: 70 6E    BVS  $FC77
$FC09: 6C 6E 70 JMP  ($706E)
$FC0C: 72          .byte $72  ; غير معرّف
$FC0D: 70 6E    BVS  $FC7D
$FC0F: 70 6E    BVS  $FC7F
$FC11: 6C 6E 70 JMP  ($706E)
$FC14: 72          .byte $72  ; غير معرّف
$FC15: 70 6E    BVS  $FC85
$FC17: 6E 6C 6E ROR  $6E6C
$FC1A: 70 6E    BVS  $FC8A
$FC1C: 70 6E    BVS  $FC8C
$FC1E: 6C 6E 6C JMP  ($6C6E)
$FC21: 6E 70 6E ROR  $6E70
$FC24: 70 6E    BVS  $FC94
$FC26: 6C 76 78 JMP  ($7876)
$FC29: 76 74    ROR  $74,X
$FC2B: 76 74    ROR  $74,X
$FC2D: 72          .byte $72  ; غير معرّف
$FC2E: 74          .byte $74  ; غير معرّف
$FC2F: 76 78    ROR  $78,X
$FC31: 76 74    ROR  $74,X
$FC33: 76 74    ROR  $74,X
$FC35: 72          .byte $72  ; غير معرّف
$FC36: 74          .byte $74  ; غير معرّف
$FC37: 84 1A    STY  $1A
$FC39: 83          .byte $83  ; غير معرّف
$FC3A: 18       CLC  
$FC3B: 20 84 1E JSR  $1E84
$FC3E: 83          .byte $83  ; غير معرّف
$FC3F: 1C          .byte $1C  ; غير معرّف
$FC40: 28       PLP  
$FC41: 26 1C    ROL  $1C
$FC43: 1A          .byte $1A  ; غير معرّف
$FC44: 1C          .byte $1C  ; غير معرّف
$FC45: 82          .byte $82  ; غير معرّف
$FC46: 2C 04 04 BIT  $0404
$FC49: 22          .byte $22  ; غير معرّف
$FC4A: 04          .byte $04  ; غير معرّف
$FC4B: 04          .byte $04  ; غير معرّف
$FC4C: 84 1C    STY  $1C
$FC4E: 87          .byte $87  ; غير معرّف
$FC4F: 26 2A    ROL  $2A
$FC51: 26 84    ROL  $84
$FC53: 24 28    BIT  $28
$FC55: 24 80    BIT  $80
$FC57: 22          .byte $22  ; غير معرّف
$FC58: 00       BRK  
$FC59: 9C          .byte $9C  ; غير معرّف
$FC5A: 05 94    ORA  $94
$FC5C: 05 0D    ORA  $0D
$FC5E: 9F          .byte $9F  ; غير معرّف
$FC5F: 1E 9C 98 ASL  $989C,X
$FC62: 9D 82 22 STA  $2282,X
$FC65: 04          .byte $04  ; غير معرّف
$FC66: 04          .byte $04  ; غير معرّف
$FC67: 1C          .byte $1C  ; غير معرّف
$FC68: 04          .byte $04  ; غير معرّف
$FC69: 04          .byte $04  ; غير معرّف
$FC6A: 84 14    STY  $14
$FC6C: 86 1E    STX  $1E
$FC6E: 80          .byte $80  ; غير معرّف
$FC6F: 16 80    ASL  $80,X
$FC71: 14          .byte $14  ; غير معرّف
$FC72: 81 1C    STA  ($1C,X)
$FC74: 30 04    BMI  $FC7A
$FC76: 30 30    BMI  $FCA8
$FC78: 04          .byte $04  ; غير معرّف
$FC79: 1E 32 04 ASL  $0432,X
$FC7C: 32          .byte $32  ; غير معرّف
$FC7D: 32          .byte $32  ; غير معرّف
$FC7E: 04          .byte $04  ; غير معرّف
$FC7F: 20 34 04 JSR  $0434
$FC82: 34          .byte $34  ; غير معرّف
$FC83: 34          .byte $34  ; غير معرّف
$FC84: 04          .byte $04  ; غير معرّف
$FC85: 36 04    ROL  $04,X
$FC87: 84 36    STY  $36
$FC89: 00       BRK  
$FC8A: 46 A4    LSR  $A4
$FC8C: 64          .byte $64  ; غير معرّف
$FC8D: A4 48    LDY  $48
$FC8F: A6 66    LDX  $66
$FC91: A6 4A    LDX  $4A
$FC93: A8       TAY  
$FC94: 68       PLA  
$FC95: A8       TAY  
$FC96: 6A       ROR  A
$FC97: 44          .byte $44  ; غير معرّف
$FC98: 2B          .byte $2B  ; غير معرّف
$FC99: 81 2A    STA  ($2A,X)
$FC9B: 42          .byte $42  ; غير معرّف
$FC9C: 04          .byte $04  ; غير معرّف
$FC9D: 42          .byte $42  ; غير معرّف
$FC9E: 42          .byte $42  ; غير معرّف
$FC9F: 04          .byte $04  ; غير معرّف
$FCA0: 2C 64 04 BIT  $0464
$FCA3: 64          .byte $64  ; غير معرّف
$FCA4: 64          .byte $64  ; غير معرّف
$FCA5: 04          .byte $04  ; غير معرّف
$FCA6: 2E 46 04 ROL  $0446
$FCA9: 46 46    LSR  $46
$FCAB: 04          .byte $04  ; غير معرّف
$FCAC: 22          .byte $22  ; غير معرّف
$FCAD: 04          .byte $04  ; غير معرّف
$FCAE: 84 22    STY  $22
$FCB0: 87          .byte $87  ; غير معرّف
$FCB1: 04          .byte $04  ; غير معرّف
$FCB2: 06 0C    ASL  $0C
$FCB4: 14          .byte $14  ; غير معرّف
$FCB5: 1C          .byte $1C  ; غير معرّف
$FCB6: 22          .byte $22  ; غير معرّف
$FCB7: 86 2C    STX  $2C
$FCB9: 22          .byte $22  ; غير معرّف
$FCBA: 87          .byte $87  ; غير معرّف
$FCBB: 04          .byte $04  ; غير معرّف
$FCBC: 60       RTS  
$FCBD: 0E 14 1A ASL  $1A14
$FCC0: 24 86    BIT  $86
$FCC2: 2C 24 87 BIT  $8724
$FCC5: 04          .byte $04  ; غير معرّف
$FCC6: 08       PHP  
$FCC7: 10 18    BPL  $FCE1
$FCC9: 1E 28 86 ASL  $8628,X
$FCCC: 30 30    BMI  $FCFE
$FCCE: 80          .byte $80  ; غير معرّف
$FCCF: 64          .byte $64  ; غير معرّف
$FCD0: 00       BRK  
$FCD1: CD D5 DD CMP  $DDD5
$FCD4: E3          .byte $E3  ; غير معرّف
$FCD5: ED F5 BB SBC  $BBF5
$FCD8: B5 CF    LDA  $CF,X
$FCDA: D5 DB    CMP  $DB,X
$FCDC: E5 ED    SBC  $ED
$FCDE: F3          .byte $F3  ; غير معرّف
$FCDF: BD B3 D1 LDA  $D1B3,X
$FCE2: D9 DF E9 CMP  $E9DF,Y
$FCE5: F1 F7    SBC  ($F7),Y
$FCE7: BF          .byte $BF  ; غير معرّف
$FCE8: FF          .byte $FF  ; غير معرّف
$FCE9: FF          .byte $FF  ; غير معرّف
$FCEA: FF          .byte $FF  ; غير معرّف
$FCEB: 34          .byte $34  ; غير معرّف
$FCEC: 00       BRK  
$FCED: 86 04    STX  $04
$FCEF: 87          .byte $87  ; غير معرّف
$FCF0: 14          .byte $14  ; غير معرّف
$FCF1: 1C          .byte $1C  ; غير معرّف
$FCF2: 22          .byte $22  ; غير معرّف
$FCF3: 86 34    STX  $34
$FCF5: 84 2C    STY  $2C
$FCF7: 04          .byte $04  ; غير معرّف
$FCF8: 04          .byte $04  ; غير معرّف
$FCF9: 04          .byte $04  ; غير معرّف
$FCFA: 87          .byte $87  ; غير معرّف
$FCFB: 14          .byte $14  ; غير معرّف
$FCFC: 1A          .byte $1A  ; غير معرّف
$FCFD: 24 86    BIT  $86
$FCFF: 32          .byte $32  ; غير معرّف
$FD00: 84 2C    STY  $2C
$FD02: 04          .byte $04  ; غير معرّف
$FD03: 86 04    STX  $04
$FD05: 87          .byte $87  ; غير معرّف
$FD06: 18       CLC  
$FD07: 1E 28 86 ASL  $8628,X
$FD0A: 36 87    ROL  $87,X
$FD0C: 30 30    BMI  $FD3E
$FD0E: 30 80    BMI  $FC90
$FD10: 2C 82 14 BIT  $1482
$FD13: 2C 62 26 BIT  $2662
$FD16: 10 28    BPL  $FD40
$FD18: 80          .byte $80  ; غير معرّف
$FD19: 04          .byte $04  ; غير معرّف
$FD1A: 82          .byte $82  ; غير معرّف
$FD1B: 14          .byte $14  ; غير معرّف
$FD1C: 2C 62 26 BIT  $2662
$FD1F: 10 28    BPL  $FD49
$FD21: 80          .byte $80  ; غير معرّف
$FD22: 04          .byte $04  ; غير معرّف
$FD23: 82          .byte $82  ; غير معرّف
$FD24: 08       PHP  
$FD25: 1E 5E 18 ASL  $185E,X
$FD28: 60       RTS  
$FD29: 1A          .byte $1A  ; غير معرّف
$FD2A: 80          .byte $80  ; غير معرّف
$FD2B: 04          .byte $04  ; غير معرّف
$FD2C: 82          .byte $82  ; غير معرّف
$FD2D: 08       PHP  
$FD2E: 1E 5E 18 ASL  $185E,X
$FD31: 60       RTS  
$FD32: 1A          .byte $1A  ; غير معرّف
$FD33: 86 04    STX  $04
$FD35: 83          .byte $83  ; غير معرّف
$FD36: 1A          .byte $1A  ; غير معرّف
$FD37: 18       CLC  
$FD38: 16 84    ASL  $84,X
$FD3A: 14          .byte $14  ; غير معرّف
$FD3B: 1A          .byte $1A  ; غير معرّف
$FD3C: 18       CLC  
$FD3D: 0E 0C 16 ASL  $160C
$FD40: 83          .byte $83  ; غير معرّف
$FD41: 14          .byte $14  ; غير معرّف
$FD42: 20 1E 1C JSR  $1C1E
$FD45: 28       PLP  
$FD46: 26 87    ROL  $87
$FD48: 24 1A    BIT  $1A
$FD4A: 12          .byte $12  ; غير معرّف
$FD4B: 10 62    BPL  $FDAF
$FD4D: 0E 80 04 ASL  $0480
$FD50: 04          .byte $04  ; غير معرّف
$FD51: 00       BRK  
$FD52: 82          .byte $82  ; غير معرّف
$FD53: 18       CLC  
$FD54: 1C          .byte $1C  ; غير معرّف
$FD55: 20 22 26 JSR  $2622
$FD58: 28       PLP  
$FD59: 81 2A    STA  ($2A,X)
$FD5B: 2A       ROL  A
$FD5C: 2A       ROL  A
$FD5D: 04          .byte $04  ; غير معرّف
$FD5E: 2A       ROL  A
$FD5F: 04          .byte $04  ; غير معرّف
$FD60: 83          .byte $83  ; غير معرّف
$FD61: 2A       ROL  A
$FD62: 82          .byte $82  ; غير معرّف
$FD63: 22          .byte $22  ; غير معرّف
$FD64: 86 34    STX  $34
$FD66: 32          .byte $32  ; غير معرّف
$FD67: 34          .byte $34  ; غير معرّف
$FD68: 81 04    STA  ($04,X)
$FD6A: 22          .byte $22  ; غير معرّف
$FD6B: 26 2A    ROL  $2A
$FD6D: 2C 30 86 BIT  $8630
$FD70: 34          .byte $34  ; غير معرّف
$FD71: 83          .byte $83  ; غير معرّف
$FD72: 32          .byte $32  ; غير معرّف
$FD73: 82          .byte $82  ; غير معرّف
$FD74: 36 84    ROL  $84,X
$FD76: 34          .byte $34  ; غير معرّف
$FD77: 85 04    STA  $04
$FD79: 81 22    STA  ($22,X)
$FD7B: 86 30    STX  $30
$FD7D: 2E 30 81 ROL  $8130
$FD80: 04          .byte $04  ; غير معرّف
$FD81: 22          .byte $22  ; غير معرّف
$FD82: 26 2A    ROL  $2A
$FD84: 2C 2E 86 BIT  $862E
$FD87: 30 83    BMI  $FD0C
$FD89: 22          .byte $22  ; غير معرّف
$FD8A: 82          .byte $82  ; غير معرّف
$FD8B: 36 84    ROL  $84,X
$FD8D: 34          .byte $34  ; غير معرّف
$FD8E: 85 04    STA  $04
$FD90: 81 22    STA  ($22,X)
$FD92: 86 3A    STX  $3A
$FD94: 3A          .byte $3A  ; غير معرّف
$FD95: 3A          .byte $3A  ; غير معرّف
$FD96: 82          .byte $82  ; غير معرّف
$FD97: 3A          .byte $3A  ; غير معرّف
$FD98: 81 40    STA  ($40,X)
$FD9A: 82          .byte $82  ; غير معرّف
$FD9B: 04          .byte $04  ; غير معرّف
$FD9C: 81 3A    STA  ($3A,X)
$FD9E: 86 36    STX  $36
$FDA0: 36 36    ROL  $36,X
$FDA2: 82          .byte $82  ; غير معرّف
$FDA3: 36 81    ROL  $81,X
$FDA5: 3A          .byte $3A  ; غير معرّف
$FDA6: 82          .byte $82  ; غير معرّف
$FDA7: 04          .byte $04  ; غير معرّف
$FDA8: 81 36    STA  ($36,X)
$FDAA: 86 34    STX  $34
$FDAC: 82          .byte $82  ; غير معرّف
$FDAD: 26 2A    ROL  $2A
$FDAF: 36 81    ROL  $81,X
$FDB1: 34          .byte $34  ; غير معرّف
$FDB2: 34          .byte $34  ; غير معرّف
$FDB3: 85 34    STA  $34
$FDB5: 81 2A    STA  ($2A,X)
$FDB7: 86 2C    STX  $2C
$FDB9: 00       BRK  
$FDBA: 84 90    STY  $90
$FDBC: B0 84    BCS  $FD42
$FDBE: 50 50    BVC  $FE10
$FDC0: B0 00    BCS  $FDC2
$FDC2: 98       TYA  
$FDC3: 96 94    STX  $94,Y
$FDC5: 92          .byte $92  ; غير معرّف
$FDC6: 94 96    STY  $96,X
$FDC8: 58       CLI  
$FDC9: 58       CLI  
$FDCA: 58       CLI  
$FDCB: 44          .byte $44  ; غير معرّف
$FDCC: 5C          .byte $5C  ; غير معرّف
$FDCD: 44          .byte $44  ; غير معرّف
$FDCE: 9F          .byte $9F  ; غير معرّف
$FDCF: A3          .byte $A3  ; غير معرّف
$FDD0: A1 A3    LDA  ($A3,X)
$FDD2: 85 A3    STA  $A3
$FDD4: E0 A6    CPX  #$A6
$FDD6: 23          .byte $23  ; غير معرّف
$FDD7: C4 9F    CPY  $9F
$FDD9: 9D 9F 85 STA  $859F,X
$FDDC: 9F          .byte $9F  ; غير معرّف
$FDDD: D2          .byte $D2  ; غير معرّف
$FDDE: A6 23    LDX  $23
$FDE0: C4 B5    CPY  $B5
$FDE2: B1 AF    LDA  ($AF),Y
$FDE4: 85 B1    STA  $B1
$FDE6: AF          .byte $AF  ; غير معرّف
$FDE7: AD 85 95 LDA  $9585
$FDEA: 9E          .byte $9E  ; غير معرّف
$FDEB: A2 AA    LDX  #$AA
$FDED: 6A       ROR  A
$FDEE: 6A       ROR  A
$FDEF: 6B          .byte $6B  ; غير معرّف
$FDF0: 5E 9D 84 LSR  $849D,X
$FDF3: 04          .byte $04  ; غير معرّف
$FDF4: 04          .byte $04  ; غير معرّف
$FDF5: 82          .byte $82  ; غير معرّف
$FDF6: 22          .byte $22  ; غير معرّف
$FDF7: 86 22    STX  $22
$FDF9: 82          .byte $82  ; غير معرّف
$FDFA: 14          .byte $14  ; غير معرّف
$FDFB: 22          .byte $22  ; غير معرّف
$FDFC: 2C 12 22 BIT  $2212
$FDFF: 2A       ROL  A
$FE00: 14          .byte $14  ; غير معرّف
$FE01: 22          .byte $22  ; غير معرّف
$FE02: 2C 1C 22 BIT  $221C
$FE05: 2C 14 22 BIT  $2214
$FE08: 2C 12 22 BIT  $2212
$FE0B: 2A       ROL  A
$FE0C: 14          .byte $14  ; غير معرّف
$FE0D: 22          .byte $22  ; غير معرّف
$FE0E: 2C 1C 22 BIT  $221C
$FE11: 2C 18 22 BIT  $2218
$FE14: 2A       ROL  A
$FE15: 16 20    ASL  $20,X
$FE17: 28       PLP  
$FE18: 18       CLC  
$FE19: 22          .byte $22  ; غير معرّف
$FE1A: 2A       ROL  A
$FE1B: 12          .byte $12  ; غير معرّف
$FE1C: 22          .byte $22  ; غير معرّف
$FE1D: 2A       ROL  A
$FE1E: 18       CLC  
$FE1F: 22          .byte $22  ; غير معرّف
$FE20: 2A       ROL  A
$FE21: 12          .byte $12  ; غير معرّف
$FE22: 22          .byte $22  ; غير معرّف
$FE23: 2A       ROL  A
$FE24: 14          .byte $14  ; غير معرّف
$FE25: 22          .byte $22  ; غير معرّف
$FE26: 2C 0C 22 BIT  $220C
$FE29: 2C 14 22 BIT  $2214
$FE2C: 34          .byte $34  ; غير معرّف
$FE2D: 12          .byte $12  ; غير معرّف
$FE2E: 22          .byte $22  ; غير معرّف
$FE2F: 30 10    BMI  $FE41
$FE31: 22          .byte $22  ; غير معرّف
$FE32: 2E 16 22 ROL  $2216
$FE35: 34          .byte $34  ; غير معرّف
$FE36: 18       CLC  
$FE37: 26 36    ROL  $36
$FE39: 16 26    ASL  $26,X
$FE3B: 36 14    ROL  $14,X
$FE3D: 26 36    ROL  $36
$FE3F: 12          .byte $12  ; غير معرّف
$FE40: 22          .byte $22  ; غير معرّف
$FE41: 36 5C    ROL  $5C,X
$FE43: 22          .byte $22  ; غير معرّف
$FE44: 34          .byte $34  ; غير معرّف
$FE45: 0C          .byte $0C  ; غير معرّف
$FE46: 22          .byte $22  ; غير معرّف
$FE47: 22          .byte $22  ; غير معرّف
$FE48: 81 1E    STA  ($1E,X)
$FE4A: 1E 85 1E ASL  $1E85,X
$FE4D: 81 12    STA  ($12,X)
$FE4F: 86 14    STX  $14
$FE51: 81 2C    STA  ($2C,X)
$FE53: 22          .byte $22  ; غير معرّف
$FE54: 1C          .byte $1C  ; غير معرّف
$FE55: 2C 22 1C BIT  $1C22
$FE58: 85 2C    STA  $2C
$FE5A: 04          .byte $04  ; غير معرّف
$FE5B: 81 2E    STA  ($2E,X)
$FE5D: 24 1E    BIT  $1E
$FE5F: 2E 24 1E ROL  $1E24
$FE62: 85 2E    STA  $2E
$FE64: 04          .byte $04  ; غير معرّف
$FE65: 81 32    STA  ($32,X)
$FE67: 28       PLP  
$FE68: 22          .byte $22  ; غير معرّف
$FE69: 32          .byte $32  ; غير معرّف
$FE6A: 28       PLP  
$FE6B: 22          .byte $22  ; غير معرّف
$FE6C: 85 32    STA  $32
$FE6E: 87          .byte $87  ; غير معرّف
$FE6F: 36 36    ROL  $36,X
$FE71: 36 84    ROL  $84,X
$FE73: 3A          .byte $3A  ; غير معرّف
$FE74: 00       BRK  
$FE75: 5C          .byte $5C  ; غير معرّف
$FE76: 54          .byte $54  ; غير معرّف
$FE77: 4C 5C 54 JMP  $545C
$FE7A: 4C 5C 1C JMP  $1C5C
$FE7D: 1C          .byte $1C  ; غير معرّف
$FE7E: 5C          .byte $5C  ; غير معرّف
$FE7F: 5C          .byte $5C  ; غير معرّف
$FE80: 5C          .byte $5C  ; غير معرّف
$FE81: 5C          .byte $5C  ; غير معرّف
$FE82: 5E 56 4E LSR  $4E56,X
$FE85: 5E 56 4E LSR  $4E56,X
$FE88: 5E 1E 1E LSR  $1E1E,X
$FE8B: 5E 5E 5E LSR  $5E5E,X
$FE8E: 5E 62 5A LSR  $5A62,X
$FE91: 50 62    BVC  $FEF5
$FE93: 5A          .byte $5A  ; غير معرّف
$FE94: 50 62    BVC  $FEF8
$FE96: 22          .byte $22  ; غير معرّف
$FE97: 22          .byte $22  ; غير معرّف
$FE98: 62          .byte $62  ; غير معرّف
$FE99: E7          .byte $E7  ; غير معرّف
$FE9A: E7          .byte $E7  ; غير معرّف
$FE9B: E7          .byte $E7  ; غير معرّف
$FE9C: 2B          .byte $2B  ; غير معرّف
$FE9D: 86 14    STX  $14
$FE9F: 81 14    STA  ($14,X)
$FEA1: 80          .byte $80  ; غير معرّف
$FEA2: 14          .byte $14  ; غير معرّف
$FEA3: 14          .byte $14  ; غير معرّف
$FEA4: 81 14    STA  ($14,X)
$FEA6: 14          .byte $14  ; غير معرّف
$FEA7: 14          .byte $14  ; غير معرّف
$FEA8: 14          .byte $14  ; غير معرّف
$FEA9: 86 16    STX  $16
$FEAB: 81 16    STA  ($16,X)
$FEAD: 80          .byte $80  ; غير معرّف
$FEAE: 16 16    ASL  $16,X
$FEB0: 81 16    STA  ($16,X)
$FEB2: 16 16    ASL  $16,X
$FEB4: 16 81    ASL  $81,X
$FEB6: 28       PLP  
$FEB7: 22          .byte $22  ; غير معرّف
$FEB8: 1A          .byte $1A  ; غير معرّف
$FEB9: 28       PLP  
$FEBA: 22          .byte $22  ; غير معرّف
$FEBB: 1A          .byte $1A  ; غير معرّف
$FEBC: 28       PLP  
$FEBD: 80          .byte $80  ; غير معرّف
$FEBE: 28       PLP  
$FEBF: 28       PLP  
$FEC0: 81 28    STA  ($28,X)
$FEC2: 87          .byte $87  ; غير معرّف
$FEC3: 2C 2C 2C BIT  $2C2C
$FEC6: 84 30    STY  $30
$FEC8: 83          .byte $83  ; غير معرّف
$FEC9: 04          .byte $04  ; غير معرّف
$FECA: 84 0C    STY  $0C
$FECC: 83          .byte $83  ; غير معرّف
$FECD: 62          .byte $62  ; غير معرّف
$FECE: 10 84    BPL  $FE54
$FED0: 12          .byte $12  ; غير معرّف
$FED1: 83          .byte $83  ; غير معرّف
$FED2: 1C          .byte $1C  ; غير معرّف
$FED3: 22          .byte $22  ; غير معرّف
$FED4: 1E 22 26 ASL  $2622,X
$FED7: 18       CLC  
$FED8: 1E 04 1C ASL  $1C04,X
$FEDB: 00       BRK  
$FEDC: E3          .byte $E3  ; غير معرّف
$FEDD: E1 E3    SBC  ($E3,X)
$FEDF: 1D DE E0 ORA  $E0DE,X
$FEE2: 23          .byte $23  ; غير معرّف
$FEE3: EC 75 74 CPX  $7475
$FEE6: F0 F4    BEQ  $FEDC
$FEE8: F6 EA    INC  $EA,X
$FEEA: 31 2D    AND  ($2D),Y
$FEEC: 83          .byte $83  ; غير معرّف
$FEED: 12          .byte $12  ; غير معرّف
$FEEE: 14          .byte $14  ; غير معرّف
$FEEF: 04          .byte $04  ; غير معرّف
$FEF0: 18       CLC  
$FEF1: 1A          .byte $1A  ; غير معرّف
$FEF2: 1C          .byte $1C  ; غير معرّف
$FEF3: 14          .byte $14  ; غير معرّف
$FEF4: 26 22    ROL  $22
$FEF6: 1E 1C 18 ASL  $181C,X
$FEF9: 1E 22 0C ASL  $0C22,X
$FEFC: 14          .byte $14  ; غير معرّف
$FEFD: FF          .byte $FF  ; غير معرّف
$FEFE: FF          .byte $FF  ; غير معرّف
$FEFF: FF          .byte $FF  ; غير معرّف
$FF00: 00       BRK  
$FF01: 88       DEY  
$FF02: 00       BRK  
$FF03: 2F          .byte $2F  ; غير معرّف
$FF04: 00       BRK  
$FF05: 00       BRK  
$FF06: 02          .byte $02  ; غير معرّف
$FF07: A6 02    LDX  $02
$FF09: 80          .byte $80  ; غير معرّف
$FF0A: 02          .byte $02  ; غير معرّف
$FF0B: 5C          .byte $5C  ; غير معرّف
$FF0C: 02          .byte $02  ; غير معرّف
$FF0D: 3A          .byte $3A  ; غير معرّف
$FF0E: 02          .byte $02  ; غير معرّف
$FF0F: 1A          .byte $1A  ; غير معرّف
$FF10: 01 DF    ORA  ($DF,X)
$FF12: 01 C4    ORA  ($C4,X)
$FF14: 01 AB    ORA  ($AB,X)
$FF16: 01 93    ORA  ($93,X)
$FF18: 01 7C    ORA  ($7C,X)
$FF1A: 01 67    ORA  ($67,X)
$FF1C: 01 53    ORA  ($53,X)
$FF1E: 01 40    ORA  ($40,X)
$FF20: 01 2E    ORA  ($2E,X)
$FF22: 01 1D    ORA  ($1D,X)
$FF24: 01 0D    ORA  ($0D,X)
$FF26: 00       BRK  
$FF27: FE 00 EF INC  $EF00,X
$FF2A: 00       BRK  
$FF2B: E2          .byte $E2  ; غير معرّف
$FF2C: 00       BRK  
$FF2D: D5 00    CMP  $00,X
$FF2F: C9          .byte $C9  ; غير معرّف
$FF30: 00       BRK  
$FF31: BE 00 B3 LDX  $B300,Y
$FF34: 00       BRK  
$FF35: A9 00    LDA  #$00
$FF37: A0 00    LDY  #$00
$FF39: 97          .byte $97  ; غير معرّف
$FF3A: 00       BRK  
$FF3B: 8E 00 86 STX  $8600
$FF3E: 00       BRK  
$FF3F: 77          .byte $77  ; غير معرّف
$FF40: 00       BRK  
$FF41: 7E 00 71 ROR  $7100,X
$FF44: 00       BRK  
$FF45: 54          .byte $54  ; غير معرّف
$FF46: 00       BRK  
$FF47: 64          .byte $64  ; غير معرّف
$FF48: 00       BRK  
$FF49: 5F          .byte $5F  ; غير معرّف
$FF4A: 00       BRK  
$FF4B: 59 00 50 EOR  $5000,Y
$FF4E: 00       BRK  
$FF4F: 47          .byte $47  ; غير معرّف
$FF50: 00       BRK  
$FF51: 43          .byte $43  ; غير معرّف
$FF52: 00       BRK  
$FF53: 3B          .byte $3B  ; غير معرّف
$FF54: 00       BRK  
$FF55: 35 00    AND  $00,X
$FF57: 2A       ROL  A
$FF58: 00       BRK  
$FF59: 23          .byte $23  ; غير معرّف
$FF5A: 04          .byte $04  ; غير معرّف
$FF5B: 75 03    ADC  $03,X
$FF5D: 57          .byte $57  ; غير معرّف
$FF5E: 02          .byte $02  ; غير معرّف
$FF5F: F9 02 CF SBC  $CF02,Y
$FF62: 01 FC    ORA  ($FC,X)
$FF64: 00       BRK  
$FF65: 6A       ROR  A
$FF66: 05 0A    ORA  $0A
$FF68: 14          .byte $14  ; غير معرّف
$FF69: 28       PLP  
$FF6A: 50 1E    BVC  $FF8A
$FF6C: 3C          .byte $3C  ; غير معرّف
$FF6D: 02          .byte $02  ; غير معرّف
$FF6E: 04          .byte $04  ; غير معرّف
$FF6F: 08       PHP  
$FF70: 10 20    BPL  $FF92
$FF72: 40       RTI  
$FF73: 18       CLC  
$FF74: 30 0C    BMI  $FF82
$FF76: 03          .byte $03  ; غير معرّف
$FF77: 06 0C    ASL  $0C
$FF79: 18       CLC  
$FF7A: 30 12    BMI  $FF8E
$FF7C: 24 08    BIT  $08
$FF7E: 36 03    ROL  $03,X
$FF80: 09 06    ORA  #$06
$FF82: 12          .byte $12  ; غير معرّف
$FF83: 1B          .byte $1B  ; غير معرّف
$FF84: 24 0C    BIT  $0C
$FF86: 24 02    BIT  $02
$FF88: 06 04    ASL  $04
$FF8A: 0C          .byte $0C  ; غير معرّف
$FF8B: 12          .byte $12  ; غير معرّف
$FF8C: 18       CLC  
$FF8D: 08       PHP  
$FF8E: 12          .byte $12  ; غير معرّف
$FF8F: 01 03    ORA  ($03,X)
$FF91: 02          .byte $02  ; غير معرّف
$FF92: 06 09    ASL  $09
$FF94: 0C          .byte $0C  ; غير معرّف
$FF95: 04          .byte $04  ; غير معرّف
$FF96: 98       TYA  
$FF97: 99 9A 9B STA  $9B9A,Y
$FF9A: 90 94    BCC  $FF30
$FF9C: 94 95    STY  $95,X
$FF9E: 95 96    STA  $96,X
$FFA0: 97          .byte $97  ; غير معرّف
$FFA1: 98       TYA  
$FFA2: 90 91    BCC  $FF35
$FFA4: 92          .byte $92  ; غير معرّف
$FFA5: 92          .byte $92  ; غير معرّف
$FFA6: 93          .byte $93  ; غير معرّف
$FFA7: 93          .byte $93  ; غير معرّف
$FFA8: 93          .byte $93  ; غير معرّف
$FFA9: 94 94    STY  $94,X
$FFAB: 94 94    STY  $94,X
$FFAD: 94 94    STY  $94,X
$FFAF: 95 95    STA  $95,X
$FFB1: 95 95    STA  $95,X
$FFB3: 95 95    STA  $95,X
$FFB5: 96 96    STX  $96,Y
$FFB7: 96 96    STX  $96,Y
$FFB9: 96 96    STX  $96,Y
$FFBB: 96 96    STX  $96,Y
$FFBD: 96 96    STX  $96,Y
$FFBF: 96 96    STX  $96,Y
$FFC1: 96 96    STX  $96,Y
$FFC3: 96 96    STX  $96,Y
$FFC5: 96 95    STX  $95,Y
$FFC7: 95 94    STA  $94,X
$FFC9: 93          .byte $93  ; غير معرّف
$FFCA: 15 16    ORA  $16,X
$FFCC: 16 17    ASL  $17,X
$FFCE: 17          .byte $17  ; غير معرّف
$FFCF: 18       CLC  
$FFD0: 19 19 1A ORA  $1A19,Y
$FFD3: 1A          .byte $1A  ; غير معرّف
$FFD4: 1C          .byte $1C  ; غير معرّف
$FFD5: 1D 1D 1E ORA  $1E1D,X
$FFD8: 1E 1F 1F ASL  $1F1F,X
$FFDB: 1F          .byte $1F  ; غير معرّف
$FFDC: 1F          .byte $1F  ; غير معرّف
$FFDD: 1E 1D 1C ASL  $1C1D,X
$FFE0: 1E 1F 1F ASL  $1F1F,X
$FFE3: 1E 1D 1C ASL  $1C1D,X
$FFE6: 1A          .byte $1A  ; غير معرّف
$FFE7: 18       CLC  
$FFE8: 16 14    ASL  $14,X
$FFEA: 15 16    ORA  $16,X
$FFEC: 16 17    ASL  $17,X
$FFEE: 17          .byte $17  ; غير معرّف
$FFEF: 18       CLC  
$FFF0: 19 19 1A ORA  $1A19,Y
$FFF3: 1A          .byte $1A  ; غير معرّف
$FFF4: 1C          .byte $1C  ; غير معرّف
$FFF5: 1D 1D 1E ORA  $1E1D,X
$FFF8: 1E 1F 82 ASL  $821F,X
$FFFB: 80          .byte $80  ; غير معرّف
$FFFC: 00       BRK  
$FFFD: 80          .byte $80  ; غير معرّف
$FFFE: F0 FF    BEQ  $FFFF