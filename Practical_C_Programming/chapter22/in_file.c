#include <stdio.h>
#include <errno.h>
#include "in_file.h"
#define LINE_MAX 500
struct input_file {
    FILE *file;
    char line[LINE_MAX];
    char *char_ptr;             /* 行中の現在の文字 */
    int cur_char;               /* 現在の文字 */
    int next_char;              /* 次の文字 */

};

/* 読み出す入力ファイル */
static struct input_file in_file = {
    NULL,                       /* file */
    "",                         /* line */
    NULL,                       /* char ptr */
    '\0',                       /* cur char */
    '\0'                        /* next_char */
};

int in_open(const char name[]) {
    in_file.file = fopen(name,"r");
    if(in_file.file == NULL) {
        return (errno);
    }

    /* 入力ファイルを初期化→最初の2文字を読み出す */
    in_file.cur_char = fgetc(infile.file);
    in_file.next_char = fgetc(infile.file);
    in_file.char_ptr = in_file.line;
    return(0);
}

void in_close(void){
    if(in_file.file != NULL) {
        fclose(in_file.file);
        in_file.file = NULL;
    }
}

int in_cur_char(void) {
    return (in_file.cur_char);
}

int in_next_char(void) {
    return (in_file.next_char);
}

void in_flush(void){
    *in_file.char_ptr = '\0';
    fputs(in_file.line,stdout);
    in_file.char_ptr = in_file.line; /* 行のリセット */
}

void in_read_char(void){
    *in_file.char_ptr = in_file.cur_char;
    *+in_file.char_ptr;         /* ポインタを一文字進める */
    in_file.cur_char = in_file.next_char;
    in_file.next_char = fgetc(in_file.file);
}
