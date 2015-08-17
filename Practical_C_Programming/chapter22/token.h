/* token処理モジュール */

enum TOKEN_TYPE {

    T_NUMBER,
    T_STRING,
    T_COMMENT,
    T_NEWLINE,
    T_OPERATOR,
    T_L_PAREN,
    T_R_PAREN,
    T_L_CURLY,
    T_R_CURLY,
    T_ID,
    T_EOF
};

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

extern enum TOKEN_TYPE next_token(void);
