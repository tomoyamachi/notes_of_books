# 書式から逆引き
- 値からポインタを取得 : &VALUE
- ポインタから値を取得 : *POINTER
  - つまり VALUE = *(&VALUE)

- 指定されたタイプだったら値を返却 : DATA.(targetTYPE)

- map宣言 : map[keyType]valueType
- mapからvalueを返却 : map[key]
- mapを作成 : make([]int, 0, 5)
- 0個以上のパラメータが利用できる: ...targetTYPE

- 関数呼び出し : func(parameter)
- struct作成 : struct{P1: 5, P2: "TEST"}
- 空interface作成 : interface{}

- 返り値を関数内で変数として利用する  : func (v *VPointer) FuncName(parameters) (returnVarName returnTYPE) {}

# ポインタを引数とする理由
1. 高速化
2. 組み込み系でアドレスを指定したい場合
(ポインタを利用する理由)[http://note.chiebukuro.yahoo.co.jp/detail/n3121]

## ポインタとしてのreceiver

ではここで、SetColorのメソッドを見なおしてみましょう。このreceiverはBoxのポインタをさしています。そうです。*Boxを使えるのです。どうしてBox本体ではなくポインタを使うのでしょうか？

SetColorを定義した本当の目的はこのBoxの色を変更することです。もしBoxのポインタを渡さなければ、SetColorが受け取るのは実はBoxのコピーになってしまいます。つまり、メソッド内で色の変更を行うと、Boxのコピーを操作しているだけで、本当のBoxではないのです。そのため、ポインタを渡す必要があります。

ここではreceiverをメソッドの第一引数にしました。こうすれば前の関数で説明した値渡しと参照渡しも難しくなくなるでしょう。

もしかしたらSetColor関数の中で以下のように定義すべきじゃないかと思われたかもしれません。*b.Color=c、ところがb.Color=cでよいのです。ポインタに対応する値を読み込むことが必要ですから。

そのとおりです。Goの中ではこの２つの方法はどちらも正しいのです。ポインタを使って対応するフィールドにアクセスした場合（ポインタになんのフィールドがなかったとしても）、Goはあなたがポインタを通してその値を必要としていることを知っています。
(https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/02.5.md)[https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/02.5.md]


# Errorについての追記
エラーのタイプによって挙動を変更する際は以下のようにするといい。
```
if err != nil {
    switch e := err.(type) {
    case *os.PathError:
        if errno, ok := e.Err.(syscall.Errno); ok {
            switch errno {
            case syscall.ENOENT:
                fmt.Fprintln(os.Stderr, "ファイルが存在しない")
            case syscall.ENOTDIR:
                fmt.Fprintln(os.Stderr, "ディレクトリが存在しない")
            default:
                fmt.Fprintln(os.Stderr, "Errno =", errno)
            }
        } else {
            fmt.Fprintln(os.Stderr, "その他の PathError")
        }
    default:
        fmt.Fprintln(os.Stderr, "その他のエラー")
    }
    return
}
```

# `interface{}` 空のinterface
https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/02.6.md#%E7%A9%BA%E3%81%AEinterface
空のinterface(interface{})にはなんのメソッドも含まれていません。この通り、すべての型は空のinterfaceを実装しています。空のinterfaceはそれ自体はなんの意味もありません（何のメソッドも含まれていませんから）が、任意の型の数値を保存する際にはかなり役にたちます。これはあらゆる型の数値を保存することができるため、C言語のvoid*型に似ています。

```
// aを空のインターフェースとして定義
var a interface{}
var i int = 5
s := "Hello world"
// aは任意の型の数値を保存できます。
a = i
a = s
```

ある関数がinterface{}を引数にとると、任意の型の値を引数にとることができます。もし関数がinterface{}を返せば、任意の型の値を返すことができるのです。とても便利ですね！

# ... と [] の違い

... は variadic parameter (可変長引数)
引数をいくつでも渡していいということ。

Link : (Passing arguments to ...parameters)[https://golang.org/ref/spec#Passing_arguments_to_..._parameters]
Link : (dot dot dot in golang. interface with empty braces)[http://stackoverflow.com/questions/23669720/dot-dot-dot-in-golang-interface-with-empty-braces]

```
package main

import "fmt"
const f = "%T(%v)\n"

func main() {
    // variadic parameterは0個でも動く
	Greeting("nobody")
	Greeting("hello:", "Joe", "Anna", "Eileen")

    // mapで同じことをしようとしたらこの通り
    GreetingMap("hello:", []string{"Joe", "Anna", "Eileen"})
    // GreetingMap("hello:") // #=> mapの場合、引数不足でエラーになる

    // mapを variadic parameterにするには以下のとおり
    s := []string{"James", "Jasmine"}
    Greeting("goodbye:", s...)
}


func Greeting(prefix string, who ...string) {
	fmt.Printf(f, prefix, prefix)
	fmt.Printf(f, who, who)
}

func GreetingMap(prefix string, who []string) {
	fmt.Printf(f, prefix, prefix)
	fmt.Printf(f, who, who)
}
```

出力結果
```
string(nobody)
[]string([])
string(hello:)
[]string([Joe Anna Eileen])
string(hello:)
[]string([Joe Anna Eileen])
string(goodbye:)
[]string([James Jasmine])
```
# メソッドの継承など
structのpropertyではメソッドのoverrideが行える。
```
package main
import "fmt"

type Human struct {
    name string
    age int
    phone string
}

type Student struct {
    Human //匿名フィールド
    school string
}

type Employee struct {
    Human //匿名フィールド
    company string
}

//human上でメソッドを定義
func (h *Human) SayHi() {
    fmt.Printf("Hi, I am %s you can call me on %s\n", h.name, h.phone)
}

//EmployeeのmethodでHumanのmethodを書き直す。
func (e *Employee) SayHi() {
    fmt.Printf("Hi, I am %s, I work at %s. Call me on %s\n", e.name,
        e.company, e.phone) //Yes you can split into 2 lines here.
}

func main() {
    mark := Student{Human{"Mark", 25, "222-222-YYYY"}, "MIT"}
    sam := Employee{Human{"Sam", 45, "111-888-XXXX"}, "Golang Inc"}

    mark.SayHi() // 自身に定義されていないmethod, propertyの場合、propertyのmethodを利用する
    sam.SayHi() // overrideしたメソッドを自動で呼び出し
    sam.Human.SayHi() // propertyのmethod, propertyを使いたい場合は明示的に利用する
}
```