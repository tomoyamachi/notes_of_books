/*
 input_file -- 入力ファイルから取得したデータ
 2つの現在の文字はcur_charとnext_charに格納される
 各業は組み立てられた後、画面に出力可能なように
 バッファに蓄えられる

関数

in_open -- 入力ファイルをオープン
in_close -- 入力ファイルをクローズ
read_char -- 次の文字を読む
in_char_char -- 現在の文字を返す
in_next_char -- 次の文字を返す
in_flush -- 行を画面に表示する
*/


/* in_open
   parameters  name -- ディスク・ファイルの名前

   戻り値
     0 -- 正しくオープンできた
     nonzero -- オープンできなかった
 */

extern int in_open(const char name[]);

/* in_close ファイルをクローズ */
extern void in_close(void);

/* in_read_char 次の文字を読む
 */
extern void in_read_char(void);


/* in_cur_char
   戻り値
     現在の文字
 */
extern int in_cur_char(void);


/* in_next_char
   戻り値
     次の文字
 */
extern int in_next_char(void);

/* in_flush -- バッファに蓄えた入力業を画面にフラッシュ
 */
extern void in_flush(void);
