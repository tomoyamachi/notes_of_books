# Tour of go
[tour link](https://tour.golang.org/flowcontrol)

## defer
その場で実行はされるが、
functionがreturnを返す状況になるまで返答しない。
複数個定義がされている場合は、FILO (First In, Last Out)として返答される。

## pointer
`*T`はポインタTの値を取得する。
変数のポインタは以下の方法で設定できる。
ポインタでも変数でもどちらでも同じ操作ができる(要確認s)
```
k := "world"
q := &k
fmt.Println(*q) # => world
```

## structs
構造体のフィールドを指定することができる。
structを作る際は、Struct{param, param}の形で渡す必要がある。
```
package main

import "fmt"

type Vertex struct {
	X int
	Y int
}

var (
	v1 = Vertex{1, 2}  // has type Vertex
	v2 = Vertex{X: 1}  // Y:0 is implicit
	v3 = Vertex{}      // X:0 and Y:0
	p  = &Vertex{1, 2} // has type *Vertex
)

func main() {
	v := Vertex{1, 2}
	v.X = 4
  p := &v
  p.Y = 100
	fmt.Println(v) # => {4 100}
}
```

## slice
```
primes := [6]int(2,3,5,7)
var s []int = primes[1:3] # => 3,5
```

sliceされたものはリファレンスが生きているので、変更した場合、元の配列から切り出したものすべてに影響がある。

```
array[:] # => スライスせず全て
array[2:] # => index以降の要素を戻す
array[:5] # => indexまでの要素を戻す
```
The length and capacity of a slice s can be obtained using the expressions len(s) and cap(s).
スライスされた配列からは、長さと容量を取ってくることができる。

## array#make
```
b := make([]int, 0, 5) // len(b)=0, cap(b)=5
```
↑の方法でつくった配列は中身がないが容量は5あるので、5までの配列の要素にはアクセス可能。

## slices of slices
```
func main() {
	// Create a tic-tac-toe board.
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}

	// The players take turns.
	board[0][0] = "X"
	board[2][2] = "O"
	board[1][2] = "X"
	board[1][0] = "O"
	board[0][2] = "X"

	for i := 0; i < len(board); i++ {
		fmt.Printf("%s\n", strings.Join(board[i], " "))
	}
}
```

## range#slice
```
var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}

func main() {
	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}

  // indexを指定しない場合
  for _, v := range pow{
    fmt.Println($v)
  }
}
```

## maps
A map maps keys to values.
mapsにはキーとバリューを紐付けて保存する。

```
type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"Bell Labs": Vertex{
		40.68433, -74.39967,
	},
	"Google": Vertex{
		37.42202, -122.08408,
	},
}

func main() {
	fmt.Println(m) # => map[Bell Labs:{40.68433 -74.39967} Google:{37.42202 -122.08408}]
}

```

## mapsへの追加/削除/参照
追加`m[key] = elem`
取得`elem = m[key]`
参照`elem,ok = m[key]`
keyがなければfalseが返る

削除`delete(m,key)`

## 関数への関数適用
```
func compute(fn func(float64, float64) float64) float64 {
	return fn(3, 4)
}

func main() {
	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}
	fmt.Println(hypot(5, 12)) // => 13

	fmt.Println(compute(hypot)) // => Sqrt(3*3+4*4) => 5
	fmt.Println(compute(math.Pow)) // => 3^4 => 81
}
```
closureを返却することもできる
```
func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}

func main() {
	pos, neg := adder(), adder()
	for i := 0; i < 10; i++ {
		fmt.Println(
			pos(i), # => 1, 3, 6, 10 ...
			neg(-2*i), => -2, -6, -12 ...
		)
	}
}
```

# Methods
## クラス・メソッド？
GolangはClassを持たないが、typesにメソッドを持たせることはできる。
ただしこのメソッドはただ引数としてtypeを指定するだけの関数。
structで囲わない場合でもタイプ関数は設定できる。

```
type Vertex struct {
	X, Y float64
}

func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
// ↑と↓は同じ関数
func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(v.Abs())
}
```
## ポインタを対象にするメソッド
```
func (v *Vertex) ScaleWithPointer(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func (v *Vertex) ScaleWithValue(f float64) {
  v.X = v.X * f
  v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
  v.ScaleWithValue(10)
  fmt.Println(v) #=> {3 4}
	v.ScaleWithPointer(10)
  fmt.Println(v) #=> {30 40}
}
```

## Interface
インターフェイス型はメソッドのつながりで指定できる。
メソッドの集まりをInterface型として定義できる
Interfaceを直接よんでも値がないからエラーになる。
```
type Abser interface {
	Abs() float64
}

func main() {
	var a Abser
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f  // a MyFloat implements Abser
	a = &v // a *Vertex implements Abser

	// In the following line, v is a Vertex (not *Vertex)
	// Abs()が指定できない。 func (v Vertex) Abs() {...} にすれば動く
	a = v

	fmt.Println(a.Abs())
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
```
## Typeによるswitch
```

func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("%q is %v bytes long\n", v, len(v))
	default:
		fmt.Printf("I don't know about type %T!\n", v)
	}
}

func main() {
	do(21)
	do("hello")
	do(true)
}
```
## Errors
Error や fmt.Stringerは初期から入っているインターフェース。


```
type MyError struct {
	When time.Time
	What string
}

func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s",
		e.When, e.What)
}

func run() error {
	return &MyError{
		time.Now(),
		"it didn't work",
	}
}

func main() {
	if err := run(); err != nil {
		fmt.Println(err)
	}
}
```

## Readers
io.Readerから読み取るデータのインターフェイスを指定できる。
[Readersにはいくつもの振る舞いを設定できる。](https://golang.org/search?q=Read#Global)

io.ReaderにはReadメソッドがあり、以下のように定義されている。
`func (T) Read(b [byte]) (n int, err error)`

Readには`io.EOF`がストリームの終わりを表している。
```
if err == io.EOF {
  break
}
```

# Goroutines
Goのランタイムに管理される英領スレッド

`go f(x,y,z)`で新しいgoroutineが始まる。
f,x,y,zの評価は実行元のgoroutineで実行され、fの実行は新しいgoroutineで実行される。

goroutineは、同じアドレス空間で実行されるため、共有メモリへのアクセスは必ず同期する必要がある。
