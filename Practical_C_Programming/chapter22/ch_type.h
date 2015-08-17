/* char_type 文字列モジュール */
enum CHAR_TYPE {
    C_EOF,
    C_WHITE,
    C_NEWLINE,
    C_ALPHA,                    /* 文字 */
    C_DIGIT,                    /* 数値 */
    C_OPERATOR,
    C_SLASH,
    C_L_PAREN,
    C_R_PAREN,
    C_L_CURLY,
    C_R_CURLY,
    C_SINGLE,
    C_DOUBLE,
    /* ここから複雑な型 */
    C_HEX_DIGIT,
    C_ALPHA_NUMERIC
};

/* 文字が指定された文字列に属するかどうかを決定

   parameter
     チェックする文字列
     チェックすべき文字型

   戻り値
     0 -- 指定された型ではない
     1 -- 指定された型である

 */
extern int is_char_type(int ch, enum CHAR_TYPE kind);


/* 指定された文字の型を返す。複雑な型は例外。
   parameter
     文字
   戻り値
     文字の型
 */
extern enum CHAR_TYPE get_char_type(int ch);
