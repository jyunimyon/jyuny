#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define TRUE 1
#define FALSE 0
struct opcode_table { // 연산코드 테이블
    char name[8];
    int code;
}optab[] = {//명령어
    { "ADD",0x18 },{ "ADDF",0x58 },{ "ADDR",0x90 },{ "AND",0x40 },{ "CLEAR",0xB4 },
    { "COMP",0x28 },{ "COMPF",0x88 },{ "COMPR",0xA0 },{ "DIV",0x24 },{ "DIVF",0x64 },
    { "DIVR",0x9C },{ "FIX",0xC4 },{ "FLOAT",0xC0 },{ "HIO",0xF4 },{ "J",0x3C },
    { "JEQ",0x30 },{ "JGT",0x34 },{ "JLT",0x38 },{ "JSUB",0x48 },{ "LDA",0x00 },
    { "LDB",0x68 },{ "LDCH",0x50 },{ "LDF",0x70 },{ "LDL",0x08 },{ "LDS",0x6C },
    { "LDT",0x74 },{ "LDX",0x04 },{ "LPS",0xD0 },{ "MUL",0x20 },{ "MULF",0x60 },
    { "MULR",0x98 },{ "NORM",0xC8 },{ "OR",0x44 },{ "RD",0xD8 },{ "RMO",0xAC },
    { "RSUB",0x4C },{ "SHIFTL",0xA4 },{ "SHIFTR",0xA8 },{ "SIO",0xF0 },{ "SSK",0xEC },
    { "STA",0x0C },{ "STB",0x78 },{ "STCH",0x54 },{ "STF",0x80 },{ "STI",0xD4 },
    { "STL",0x14 },{ "STS",0x7C },{ "STSW",0xE8 },{ "STT",0x84 },{ "STX",0x10 },
    { "SUB",0x1C },{ "SUBF",0x5C },{ "SUBR",0x94 },{ "SVC",0xB0 },{ "TD",0xE0 },
    { "TIO",0xF8 },{ "TIX",0x2C },{ "TIXR",0xB8 },{ "WD",0xDC },
    //지시어
    { "START",5 },{ "END",2 },{ "BYTE",1 },{ "RESW",4 },{ "RESB",3 },{ "WORD",6 }
};
int symtabsize = 0;
int startaddress;
char opcode[10], label[10], operand[10];
int locctr = 0;
int opcodeindex = 0;
int symtabindex = 0;
struct SYMTAB { // symtab
    char symtab_label[10]; //label
    int loc; //locctr의 값
    char data_type[10]; //byte or word
}symtab_[200];
int search_op(char* cp) {
    int i;
    for (i = 0; i < sizeof(optab) / sizeof(optab[0]); ++i) {
        if (strcmp(cp, optab[i].name) == 0) {
            opcodeindex = i;
            return TRUE;
        }
    }
    return FALSE;
}
int search_symbol(char* cp) {
    int i;
    char* dp = malloc(sizeof(char) * 10);
    strcpy(dp, cp);
    if (cp[strlen(cp) - 2] == ',') // X비트 사용할 때
        dp = strtok(dp, ",");
    for (i = 0; i < symtabsize; ++i) {
        if (strcmp(dp, symtab_[i].symtab_label) == 0) {
            symtabindex = i;
            free(dp);
            return TRUE;
        }
    }
    free(dp);
    return FALSE;
}
void get_Code(char* buf) {
    char* cp;
    int a, i, sw = FALSE;
    strcpy(opcode, ""); strcpy(label, ""); strcpy(operand, "");
    for (cp = strtok(buf, " \t\n"); cp != NULL;) {
        a = atoi(cp);
        if (!a) { 
            for (i = 0; i < strlen(cp); ++i) {
                if (cp[i] < 65 || cp[i]>90) {
                    sw = TRUE;
                    break;
                }
            }
            if (sw == FALSE) { //명령어
                if (search_op(cp) == TRUE) { 
                    strcpy(opcode, cp);
                    if (strcmp(opcode, "RSUB") != 0) { 
                        cp = strtok(NULL, " \t\n");
                        strcpy(operand, cp);
                    }
                }
                else { //지시어
                    strcpy(label, cp);
                    cp = strtok(NULL, " \t\n");
                    strcpy(opcode, cp);
                    cp = strtok(NULL, " \t\n");
                    strcpy(operand, cp);
                }
            }
        }
        cp = strtok(NULL, " \t\n");
    }
}
void location_counter(char* opcode) {
    if (strcmp(opcode, "WORD") == 0) {
        locctr += 3;
    }
    else if (strcmp(opcode, "RESW") == 0) {
        locctr += 3 * atoi(operand);
    }
    else if (strcmp(opcode, "RESB") == 0) {
        locctr += atoi(operand);
    }
    else if (strcmp(opcode, "BYTE") == 0) {
        if (operand[0] == 'C')
            locctr += strlen(operand) - 3;
        else if (operand[0] == 'X')
            locctr += (strlen(operand) - 3) / 2;
    }
    else {
        locctr += 3;
    }
}
void pass_one(FILE* fp) {
    char buf[80];
    while (fgets(buf, sizeof(buf), fp) != NULL) {
        get_Code(buf);
        if (strcmp(opcode, "START") == 0) {
            locctr = strtoul(operand, NULL, 16);
            startaddress = locctr;
            continue;
        }
        if (strcmp(opcode, "END") != 0) {
            if (buf[0] != '.') {
                if (search_symbol(label) == TRUE) { // 이미 SYMTAB에 존재
                    fprintf(stderr, "\n");
                }
                else {
                    if (strcmp(label, "") != 0) { //레이블 등록
                        strcpy(symtab_[symtabsize].symtab_label, label);
                        symtab_[symtabsize].loc = locctr;
                        if (strcmp(opcode, "BYTE") == 0 || strcmp(opcode, "RESB")) {
                            strcpy(symtab_[symtabsize].data_type, "BYTE");
                        }
                        else
                            strcpy(symtab_[symtabsize].data_type, "WORD");
                    }
                    ++symtabsize;
                }
                if (search_op(opcode) == TRUE) { // locctr증가
                    location_counter(opcode);
                }
            }
        }
    }
}
int main() {
    FILE* f;
    f = fopen("C:\\Users\\user\\Desktop\\sample.txt", "r");
    pass_one(f);
    printf("Label\tLoc\tData Type\n");
    for (int i = 0; i < symtabsize; i++)
        printf("%s\t%x\t%s\n",symtab_[i].symtab_label,symtab_[i].loc,symtab_[i].data_type);
    fclose(f);
    return 0;
	
}