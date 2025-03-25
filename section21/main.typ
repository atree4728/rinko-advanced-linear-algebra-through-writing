#import "@preview/touying:0.5.5": *
#import themes.university: *
#import "@preview/physica:0.9.4": *
#import "@preview/ctheorems:1.1.3": *

#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5": *

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "定理", fill: rgb("#eeffee")).with(number: none)
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong,
)
#let definition = thmbox("definition", "定義", fill: rgb("#eeff")).with(number: none)
#let example = thmplain("example", "例", titlefmt: strong).with(numbering: none)
#let proof = thmproof("proof", "Proof", titlefmt: strong)
#let red(expr) = text(fill: color.red)[$#expr$]
#let Ker = $op("Ker")$

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(
    title: [§21. 双対空間],
    subtitle: [輪講 \#10],
    date: datetime.today(),
  ),
)


#set text(font: "Noto Sans CJK JP", size: 20pt)

#show "、": "，"
#show "。": "．"

#set heading(numbering: none)

#title-slide()

== 一次形式と双対空間

/ Remark: もうベクトルを太字にしません。

体 $K$ 上の線型空間 $V$ から、新たな線型空間を作り出す。

線型写像 $f: V -> K$ を、*1 次形式（線型形式、線型汎関数）*という。

#definition[
  $ V^* = "Hom"(V, K) = {"線型写像" f: V -> K} $
  は $K$ 上の線型空間をなし、これを $V$ の*双対空間(dual space)*という。
]

/ Remark: 線型空間 $V, W$ に対し、線型写像 $V -> W$ 全体のなす線型空間を $"Hom"(V, W)$ と書くことがある。準同型 homomorphic の頭文字。

== 一次形式の例

#example[
  $f_a: (x_1, dots.c, x_n) |-> a_1 x_1 + dots.c + a_n x_n; K^n -> K$ は $K^n$ 上の一次形式。\
  $a in K^n$ に $f_a$ を対応させる写像は可逆。
]
#example[
  実関数 $f(x)$ に対して $f(a) in RR$ を対応させる写像は $C(RR)$ 上の一次形式。
]

== 双対基底

$n < oo$ を $V$ の次元とする。

$V$ の基底 $x_1, dots.c, x_n$ に対し、
次によって双対空間 $V^*$ の $n$ 個の元 $f_1, dots.c, f_n$ を定める。

$ f_i (x_j) = delta_(i j). $

#theorem[
  $f_1, dots.c, f_n$ は $V^*$ の基底をなす。特に、$dim V = dim^* = n.$
  - 線型独立性：$sum_i c_i f_i = 0_(V^*)$ とする。両辺を $x_j$ に適用すると $c_j = 0$ を得る。
  - 生成すること：任意の $f in V^*$ に対し、$f = sum_i f(x_i) f_i$ なる表示が定まる。実際、$x = sum_j c_j x_j in V$ を代入すると、$ f(x) = f(sum_i c_i x_i) = sum_i f(x_i) c_i = sum_i f(x_i) f_i (x). $
]

#definition[
  $V^*$ の基底 $f_1, dots.c, f_n$ を $x_1, dots.c, x_n$ の*双対基底(dual basis)*という。
]

/ Remark: $V$ と $V^*$ の次元は等しいから、2 つの線型空間は同型である。つまり、\ 全単射 $V -->^tilde V^*$ が存在する。

/ 伏線: $V ->^tilde V^*$ は基底に依存した同型である。実際、$K = RR$ 上の線形空間 $V = RR$ の\ 基底として $1$ をとったとき、$f_1 = id$ だが、基底として $2$ をとると、 $f_2$ は $1 slash 2$ 倍写像になる。

/ Remark: 無限次元線型空間においても双対空間は存在するが、必ずしも基底が存在しないかもしれないので、$dim V = dim V^*$ は有限次元でないと言えない。ここまで有限次元を仮定していたが、以降この仮定を取り払う。

== 双線型形式

$V$ と $V^*$ がいずれも線型空間であるということは、
#align(center)[*$f(bold(x))$ という形式において $f$ と $bold(x)$ いずれにも線型性があるということ。*]
$~~>$ 双線型形式 $b: (f, x) |-> f(x)$ を考えることができる。

$~~> f, x$ は単なるベクトルであり、もはや関数 / 引数という違いは意識されない。

引数がペアなのは扱いにくいので、片方を固定して 1 変数の線型写像にしてみる。

$
  "app"_f = b(f, dot):& V -> K,\
  "ev"_x = b(dot, x):& V^* -> K.
$

$b$ が非退化な双線型形式だとすると、
$
  f |-> "app"_f; & V^* -> V^*, &\
  x |-> "ev"_x; & V -> (V^*)^* &
$
はいずれも同型。前者は恒等写像なので、後者について考察してみる。

== 第 2 双対空間

$K$ 上の線型空間 $V$ の双対空間 $V^*$ 自身も線型空間であるから、その「双対空間の双対空間」を考えることができる。

#definition[ $V^(**) = (V^*)^*$ を $V$ の*第 2 双対空間(bidual space)*という。]

$e_V: x |-> "ev"_x$ は同型 $V ->^tilde V^(**)$ を定める。

#align(
  center,
  diagram(
    spacing: 1.5em,
    node((0, 0), $e_V:$),
    node((1, 1), $x$),
    node((2, 1), $"ev"_x:$),
    node((1, 0), $V$),
    node((2, 0), $V^(**)$),
    edge((1, 1), (2, 1), "|->"),
    edge((1, 0), (2, 0), "->"),
    node((3, 1), $V^*$),
    edge((3, 1), (4, 1), "->"),
    node((4, 1), $K$),
    node((3, 2), $f$),
    edge((3, 2), (4, 2), "->"),
    node((4, 2), $f(x)$),
  ),
)

== $"ev"_x: V^* -> K$

（さすがに線型写像でしょう）と思いながらここまで来たので、このあたりで証明。
#theorem[
  $"ev"_x: V^* -> K$ は線型写像である。

  #proof[
    / 和について: 任意に $f, g in V^*$ をとる。このとき、$ "ev"_x (f + g) = (f + g)x = f(x) + g(x) = "ev"_x (f) + "ev"_x (g). $
    / スカラー倍について: 任意に $c in K, f in V^*$ をとる。このとき、$ "ev"_x (c f) = (c f)(x) = c dot f(x) = c dot "ev"_x (f). $
  ]
]


== $e_V: V -> V^(**)$

#theorem[
  $e_V: x |-> "ev"_x$ は線型写像である。
  #proof[
    / 和について: 任意に $x, y in V$ をとる。このとき、$ e_V (x + y) &= "ev"_(x+y) = f |-> f(x+y) = f |-> (f(x) + f(y)) \ &= (f |-> f(x)) + (f |-> f(y)) = "ev"_x + "ev"_y = e_V (x) + e_V (y). $
    / スカラー倍について: 任意に $c in K, x in V$ をとる。このとき、$ e_V (c x) &= "ev"_(c x) = f |-> f(c x) = f |-> c dot f(x) \ &= c dot (f |-> f(x)) = c dot "ev"_x = c dot e_V (x). $
  ]
]

#theorem[
  $e_V$ は単射である。
  $V$ が有限次元ならば、さらに同型でもある。
  #proof[
    $x != 0$ に対して $"ev"_x != 0$ を示す。
    直和分解 $V = K x plus.circle V'$ をとり、一次形式 $p$ を部分空間 $K x$ への射影 $V -> K x$ と $K x in.rev k x |-> k in K$ の合成とすると、$"ev"_x (p) = 1$ だから、$"ev"_x != 0$ である。

    また、$V$ が有限次元なら $e_V$ は基底を基底にうつすから同型である。実際、$V$ の基底 $x_1, dots.c, x_n$ の双対基底 $f_1, dots.c, f_n$ に対し、$e_V (x_i)(f_j) = f_j (x_i) = delta_(i j)$ だから、$e_V (x_1), dots.c, e_V (x_n)$ は $f_1, dots.c, f_n$ の双対基底になっている。
  ]
]

== 標準的な同型

線型空間に対して基底をとるときはつねに恣意性が伴う。
/ Remark: $K^n$ に対しては標準基底が"全会一致"の基底なように思われるが、例えば関数空間や多項式の空間を考えてみると "全開一致" の基底をとるのは自明でない。

$V -> V^*$ の同型は基底に依存していたという意味で、*標準的*でない。

一方、$e_V: V ->^tilde V^(**)$ は基底に依存せず、*標準的（自然、cannonical）な同型*である。

$V$ と $V^(**)$ は集合論的に等しいわけではないが、二つの集合の間に標準的な同型があるという意味で、リベラルに $V = V^(**)$ と書くこともある。

== 標準的な同型による同一視

#example[
  有限次元線型空間 $V, W$ とその基底 $E, F$ がある。
  線型写像と行列は異なるものだが、「$E, F$ に関する表現行列をとる」という標準的な同型 $"Hom"(V, W) ->^tilde M_(m n)$ が存在するため、これらを同一視したりする。
]

#example[
  線型空間 $V$ とその部分空間 $W_1, W_2$ について、*集合論的な直和* $W_1 plus.circle W_2 = {(w_1, w_2)}$ と*和* $W_1 + W_2 = {w_1 + w_2}$ はいずれも線型空間をなす。

  $W_1 inter W_2 = {0}$ が成り立っているとき、$+: (w_1, w_2) -> w_1 + w_2$ は標準的な同型 $W_1 plus.circle W_2 ->^tilde W_1 + W_2$ を与えるから、二つの空間を同一視して*部分空間のとしての直和* $W_1 plus.circle W_2$ が定義される。
]

== 双対写像

#theorem[
  $V, W$ を $K$ 上の線型空間とし、$f in "Hom"(V, W)$ とする。このとき、\
  $phi in W^*$ を $phi compose f in V^*$ に対応させる写像 $f^*: W^* -> V^*$ は線型写像である。
  #proof[
    / 和について: 任意に $phi, psi in W^*$ をとる。このとき、$ f^* (phi + psi) = (phi + psi) compose f = phi compose f + psi compose f = f^* (phi) + f^* (psi). $
    / スカラー倍について: 任意に $ c in K, phi in W^*$ をとる。このとき、$ f^* (c phi) = (c phi) compose f = c (phi compose f) = c f^*(phi). $
  ]
]

\

#definition[
  線型写像 $f: V -> W$ に対し、先の線型写像 $f^*: W^* -> V^*$ を*双対写像(dual mapping)*という。
]

#{
  let (V, W, K) = ((0, 0), (1, 0), (1, 1))
  let h = 0.1
  let (phf, ph) = ((0.5 + h, 0.5), (1 - h, 0.5))
  align(
    center,
    diagram(
      spacing: 6em,
      node(V, $V$),
      node(W, $W$),
      node(K, $K$),
      edge(V, W, "->", $f$),
      edge(W, K, "->", $phi$, bend: 0.1deg),
      edge(V, K, "->", $phi compose f$, bend: -0.1deg),
      edge(ph, phf, "|~>", $f^*$),
    ),
  )
}

== 双対写像の基本的な性質

#theorem[
  + $*: (V -> W) -> (V^* -> W^*)$ は線型写像。
  + $(id_V)^* = id_(V^*).$
  + $(g compose f)^* = f^* compose g^*.$（*反変性 contravariant*）
  #proof[
    + 略。
    + #diagram(
        // spacing: 6em,
        node((0, 0), $V$),
        node((1, 0), $V$),
        node((1, 1), $K$),
        edge((0, 0), (1, 0), "->", $id_V$),
        edge((1, 0), (1, 1), "->", $phi$, bend: 0.1deg),
        edge((0, 0), (1, 1), "->", $id_V compose phi$, bend: -0.1deg),
        edge((0.9, 0.5), (0.6, 0.5), "="),
      )
    + $(g compose f)^*(phi) = phi compose g compose f = f^* (g compose phi) = f^* (g^* (phi)).$
  ]
]

== 線型写像の転置

#theorem[
  $V, W$ の各基底 $E, F$ に対し、$E^*, F^*$ をそれぞれの双対基底とする。
  線型写像 $f: V -> W$ の $E, F$ に関する表現行列を $A$ とすると、$f^*: W^* -> V^*$ の $F^*, E^*$ に関する表現行列は $A^TT$ である。
  #proof[
    次の図式が可換であることによる。
    #align(
      center,
      diagram(
        node((0, 0), $W^*$),
        node((3, 0), $V^*$),
        node((1, 1), $(K^m)^*$),
        node((2, 1), $(K^n)^*$),
        node((0, 2), $K^m$),
        node((3, 2), $K^n$),
        edge((0, 0), (3, 0), $f^*$, "->"),
        edge((0, 0), (0, 2), $phi_(F^*)$, "->"),
        edge((3, 0), (3, 2), $phi_(E^*)$, "->", label-side: left),
        edge((1, 1), (2, 1), $(A times)^*$, "->"),
        edge((1, 1), (0, 0), $(phi_F)^*$, "->"),
        edge((2, 1), (3, 0), $(phi_E)^*$, "->"),
        edge((0, 2), (1, 1), $TT$, "<-"),
        edge((3, 2), (2, 1), $TT$, "<-"),
        edge((0, 2), (3, 2), $A^TT$, "->"),
      ),
    )
  ]
]

実際、それぞれの可換性は次のようにして示される。
/ 上側の台形:
  表現行列の定義から $(A times) compose phi_E = phi_F compose f$ で、両辺の双対をとる。
/ 右側の三角形: $E = (x_1, dots.c, x_n), E^* = (f_1, dots.c, f_n)$ とする。$a^TT in (K^n)^*$ に対して、$ (phi_(E^*) compose (phi_E)^*) (a^TT) = phi_(E^*)(a^TT compose phi_E) = phi_(E^*)(sum_i a_i f_i) = a. $
/ 左側の三角形: 右側の三角形と同様。
/ 下側の三角形: $a^TT in (K^m)^*$ として、$K^n$ 上の等式 $(A^TT compose TT)(a^TT) = (TT compose (A times)^*)(a^TT) $ であればよい。両辺は $A^TT a$ において一致する。


/ Point: 上・右・左の可換性により $V = K^n, W = K^m$ で基底が標準基底の場合に帰着できるということを示している。

/ Remark: この性質に由来して、双対写像のことを*転置写像*と呼ぶこともある。
