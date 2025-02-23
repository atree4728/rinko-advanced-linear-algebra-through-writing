#import "@preview/touying:0.5.5": *
#import themes.university: *
#import "@preview/physica:0.9.4": *
#import "@preview/ctheorems:1.1.3": *

#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5": *

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "定理", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong,
)
#let definition = thmbox("definition", "定義", fill: rgb("#eeff"))
#let example = thmplain("example", "例", titlefmt: strong).with(numbering: none)
#let proof = thmproof("proof", "Proof", titlefmt: strong)
#let red(expr) = text(fill: color.red)[$#expr$]
#let Ker = $op("Ker")$

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(
    title: [§6. Jordan 標準形（べき零行列の場合） ],
    subtitle: [輪講 \#3],
    date: datetime.today(),
  ),
)

#set text(font: "Noto Sans CJK JP", size: 20pt)

#show "、": "，"
#show "。": "．"

#set heading(numbering: none)

#title-slide()

= べき零行列

== べき零行列

- 正方行列 $N$ が*べき零*であるというのは、$N^k = O$ となるような $k$ が存在すること。
#example[
  $mat(0, a; 0, 0), mat(0, a, b; 0, 0, c; 0, 0, 0)$ はべき零。
]

#theorem(number: "6.1")[
  $N in M_n (CC)$ がべき零 $<=>$ $N$ のすべての固有値が $0.$
  #proof[
    / $(=>)$: 固有値 $lambda$ の固有ベクトル $bold(v)$ に $N$ を左から然るべき回数掛けると、$bold(0) = N^k bold(v) = lambda^k bold(v)$ より $lambda = 0.$
    / $(arrow.l.double)$: 固有多項式は $phi.alt_N (x) = x^n.$ Cayley-Hamilton の定理より $N^n = O.$
  ]
]

/ Remark: 対角化可能なべき零行列は零行列に限る。

== べき零行列のべきの上界

#theorem(number: "6.2")[
  $N in M_n (CC)$ をべき零行列とする。
  $k$ を $N^k = O$ となる最小の自然数とすると、$k <= n.$
  #proof[
    $N^(k-1) != O$ より $N^(k-1) bold(x) != bold(0)$ なる $bold(x) in CC^n$ がとれる。
    / Claim: $bold(x), N bold(x), dots.c, N^(k-1) bold(x)$ は一次独立。
      - 線型関係式 $sum_(0 <= i < k) c_i N^i bold(x) = bold(0)$ を考える。
      - 両辺に $N^(k-1)$ を左から掛けることで $c_0 = 0$ を得る。
      - 同様に $N^(k-2), dots.c, N, I$ を左から掛けることで線型関係式が自明であることがいえる。
    したがって、特に $k <= n$ がいえる。
  ]
]

= べき零行列の Jordan 標準形

== Jordan 細胞、Jordan 標準形

#definition(number: "6.1")[
  $lambda in CC$ に対して、次の $J(lambda; n)$ を *Jordan 細胞*という：
  $
    J(lambda; n) = mat(
    lambda, 1, 0, dots.c, 0, 0;
    0, lambda, 1, dots.c, 0, 0;
    dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
    0, 0, 0, dots.c, lambda, 1;
    0, 0, 0, dots.c, 0, lambda
    ) in M_n (CC).
  $
  Jordan 細胞を用いて、次のように表される正方行列を *Jordan 標準形* という：
  $
    dmat(J(lambda_1; m_1), J(lambda_2; m_2), dots.down, J(lambda_r; m_r)) in M_(m_1 + dots.c + m_r)(CC).
  $
]
== べき零行列の Jordan 標準形の存在定理

#theorem(number: "6.3")[
  $N in M_n (CC)$ がべき零行列ならば、ある正則な $P in M_n (CC)$ が存在し、
  $
    P^(-1) N P = dmat(J(0; m_1), J(0; m_2), dots.down, J(0; m_r)).
  $
]

証明の流れはおおまかには次のようになる：
+ べき零行列 $N$ には、増大列 ${bold(0)} subset.neq Ker N subset.eq dots.c subset.eq Ker N^k = CC^n$ が付随する。
+ 増大列に"沿う"ような良い具合の基底をとっていく。
+ $A$ をこの基底で取り換えると Jordan 標準形になっている。

== Setup

$N = O$ なら始めから Jordan 標準形になっているので、以下では $N != O$ とする。

- $k$ を、$N^k = O$ となるような最小の自然数とする。$~> 2 <= k <= n.$
- $W_j = Ker N^j$ を "$j$ 次の Kernel" と呼ぶことにする（これは一般的でない名称）。

次のような増大列をイメージする：
$ {bold(0)} = W_0 subset.eq W_1 subset.eq dots.c subset.eq W_(k-1) subset.eq W_k = CC^n. $
$N$ は正則でない $(because N text(font: "Noto Sans CJK JP", "の固有値はすべて") 0 ~> det N = 0)$ から、

$ {bold(0)} = W_0 red(subset.neq) W_1 subset.eq dots.c subset.eq W_(k-1) subset.eq W_k = CC^n. $

- $1 <= j <= k$ について $d_j = dim W_j - dim W_(j-1)$ とすると、$d_j$ はつねに非負。
  - $~> sum_(j=1)^k d_j = dim CC^n - dim {bold(0)} = n.$

== 増大列の様子


#align(
  center,
  cetz.canvas(
    length: 9%,
    {
      import cetz.draw: *
      rect((0, 0), (1, 0), name: "W0")
      rect((2, 0), (3, 2), name: "W1")
      rect((5, 0), (6, 3.5), name: "Wk-2")
      rect((7, 0), (8, 4.5), name: "Wk-1")
      rect((9, 0), (10, 5), name: "Wk")
      content((-0.2, 0), anchor: "north", padding: .1, ${bold(0)} =$)
      content((0.5, 0), anchor: "north", padding: .1, $W_0$)
      content((1.5, 0), anchor: "north", padding: .1, $subset.neq$)
      content((2.5, 0), anchor: "north", padding: .1, $W_1$)
      content((3.25, 0), anchor: "north", padding: .1, $subset.eq$)
      content((4, 0), anchor: "north", padding: .1, $dots.c$)
      content((4, 1.5), anchor: "north", padding: .1, text(size: 40pt)[$dots.c$])
      content((4.75, 0), anchor: "north", padding: .1, $subset.eq$)
      content((5.5, 0), anchor: "north", padding: .1, $W_(k-2)$)
      content((6.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((7.5, 0), anchor: "north", padding: .1, $W_(k-1)$)
      content((8.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((9.5, 0), anchor: "north", padding: .1, $W_k$)
      content((10.2, 0), anchor: "north", padding: .1, $= CC^n$)
      line((1.5, 0), (1.5, 2), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_1$)
      line((4.5, 2.5), (4.5, 3.5), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_(k-2)$)
      line((6.5, 3.5), (6.5, 4.5), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_(k-1)$)
      line((8.5, 4.5), (8.5, 5), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, text(size: 15pt)[$d_k$])
      content(
        (4, 2),
        (11, 2.2),
        box(for _ in range(31) [$tilde.triple$], fill: white),
      )
    },
  ),
)

== 増大列の直和分割

/ Remark: $V$ の部分空間 $W$ に対して、$V = W plus.circle tilde(W)$ なる $tilde(W)$ が存在する。

#align(
  center,
  cetz.canvas(
    length: 8%,
    {
      import cetz.draw: *
      rect((0, 0), (1, 0), name: "W0")
      rect((2, 0), (3, 2), name: "W1")
      rect((5, 0), (6, 3.5), name: "Wk-2")
      rect((7, 0), (8, 4.5), name: "Wk-1")
      rect((9, 0), (10, 5), name: "Wk")
      content((0.5, 0), anchor: "north", padding: .1, $W_0$)
      content((1.5, 0), anchor: "north", padding: .1, $subset.neq$)
      content((2.5, 0), anchor: "north", padding: .1, $W_1$)
      content((3.25, 0), anchor: "north", padding: .1, $subset.eq$)
      content((4, 0), anchor: "north", padding: .1, $dots.c$)
      content((4, 1.5), anchor: "north", padding: .1, text(size: 40pt)[$dots.c$])
      content((4.75, 0), anchor: "north", padding: .1, $subset.eq$)
      content((5.5, 0), anchor: "north", padding: .1, $W_(k-2)$)
      content((6.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((7.5, 0), anchor: "north", padding: .1, $W_(k-1)$)
      content((8.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((9.5, 0), anchor: "north", padding: .1, $W_k$)
      line((5, 2), (6, 2), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((7, 2), (8, 2), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 2), (10, 2), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((5, 2.5), (6, 2.5), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((7, 2.5), (8, 2.5), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 2.5), (10, 2.5), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((7, 3.5), (8, 3.5), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 3.5), (10, 3.5), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 4.5), (10, 4.5), stroke: color.red, name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      content(
        (4, 2.2),
        (11, 2.38),
        box(for _ in range(27) [$tilde.triple$], fill: white),
      )
    },
  ),
)

== 直和分解の因子に名前をつける

#align(
  center,
  cetz.canvas(
    length: 9%,
    {
      import cetz.draw: *
      rect((0, 0), (1, 0), name: "W0")
      rect((2, 0), (3, 2), name: "W1")
      rect((5, 0), (6, 3.5), name: "Wk-2")
      rect((7, 0), (8, 4.5), name: "Wk-1")
      rect((9, 0), (10, 5), name: "Wk")
      content((0.5, 0), anchor: "north", padding: .1, $W_0$)
      content((1.5, 0), anchor: "north", padding: .1, $subset.neq$)
      content((2.5, 0), anchor: "north", padding: .1, $W_1$)
      content((3.25, 0), anchor: "north", padding: .1, $subset.eq$)
      content((4, 0), anchor: "north", padding: .1, $dots.c$)
      content((4, 1.5), anchor: "north", padding: .1, text(size: 40pt)[$dots.c$])
      content((4.75, 0), anchor: "north", padding: .1, $subset.eq$)
      content((5.5, 0), anchor: "north", padding: .1, $W_(k-2)$)
      content((6.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((7.5, 0), anchor: "north", padding: .1, $W_(k-1)$)
      content((8.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((9.5, 0), anchor: "north", padding: .1, $W_k$)
      line((5, 2.5), (6, 2.5), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((7, 2.5), (8, 2.5), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 2.5), (10, 2.5), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((5, 2), (6, 2), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((7, 2), (8, 2), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 2), (10, 2), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((7, 3.5), (8, 3.5), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 3.5), (10, 3.5), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      line((9, 4.5), (10, 4.5), name: "d")
      content("d", $plus.circle$, frame: "rect", stroke: none, fill: white)
      content((2.5, 1), $U_1$)
      content((5.5, 1), $U_1$)
      content((7.5, 1), $U_1$)
      content((9.5, 1), $U_1$)
      content((5.5, 3), $U_(k-2)$)
      content((7.5, 3), $U_(k-2)$)
      content((9.5, 3), $U_(k-2)$)
      content((7.5, 4), $U_(k-1)$)
      content((9.5, 4), $U_(k-1)$)
      content((9.5, 4.75), $U_k$)
      content(
        (4, 2.2),
        (11, 2.38),
        box(for _ in range(31) [$tilde.triple$], fill: white),
      )
    },
  ),
)

==

/ Check!: *$U_j$ は"$N^j times$ でやっと $bold(0)$ になる"ベクトル全体によって張られる部分空間。*

線型独立な $bold(x)_1, dots.c, bold(x)_d_k in U_k$ によって $W_(k-1)$ の基底を延長して $W_k$ の基底とする。

このとき、$bold(x)_1, dots.c, bold(x)_d_k$ は次の条件を満たしている：
+ $angle.l N bold(x)_1, dots.c, N bold(x)_d_k angle.r subset.eq U_(k-1).$
  - $bold(x)_j$ は "$N^k$ でやっと $bold(0)$ になる"から、$N bold(x)_j$ は "$N^(k-1)$ でやっと $bold(0)$" になる。
+ $N bold(x)_1, dots.c, N bold(x)_d_k$ は一次独立。
  - $sum_j c_j N bold(x)_j = bold(0) => N (sum_j c_j bold(x)_j) = bold(0) => sum_j c_j bold(x)_j in W_1 => sum_j c_j bold(x)_j in W_(k-1).$
  - もし $sum_j c_j bold(x)_j != bold(0)$ であれば $bold(x)_j in.not W_(k-1)$ に矛盾するので、$sum_j c_j bold(x)_j = bold(0).$
  - $bold(x)_1, dots.c, bold(x)_d_k$ は線型独立だったから $c_1 = dots.c = c_d_k = 0.$

== $W_(k-1), W_k$ の上段を抜粋。

#align(
  center,
  cetz.canvas(
    length: 7%,
    {
      import cetz.draw: *

      rect((0, 0), (rel: (4, 4)))
      rect((8, 0), (rel: (4, 4)))
      rect((8, 4), (rel: (4, 2.5)))
      // line((0, 1.5), (rel: (4, 0)), stroke: (dash: "dashed"))
      content((2, 2), $U_(k-1)$)
      content((10, 2), $U_(k-1)$)
      content((10, 5.25), $U_k = angle.l bold(x)_1, dots.c, bold(x)_d_k angle.r$)
    },
  ),
)

== $Im_N U_k subset.eq U_(k-1)$ の様子。

#align(
  center,
  cetz.canvas(
    length: 7%,
    {
      import cetz.draw: *

      rect((0, 0), (rel: (4, 4)))
      rect((8, 0), (rel: (4, 4)))
      rect((8, 4), (rel: (4, 2.5)), fill: color.red)
      rect((0, 1.5), (rel: (4, 2.5)), stroke: none, fill: color.red.lighten(30%))
      line((4, 4), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((4, 1.5), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((7.5, 5), (4.5, 3), stroke: 2pt, mark: (end: ">"), name: "arrow")
      content(("arrow.start", 50%, "arrow.end"), anchor: "south", angle: "arrow.start", padding: 10pt, $N times$)
      content((10, 2), $U_(k-1)$)
      content((10, 5.25), $U_k = angle.l bold(x)_1, dots.c, bold(x)_d_k angle.r$)
      content((2, 2.5), $Im = angle.l N bold(x)_1, dots.c, N bold(x)_d_k angle.r$)
      line((12.5, 4), (rel: (0, 2.5)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_k$)
      line((-0.5, 1.5), (rel: (0, 2.5)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_k$)
      line((-0.5, 0), (rel: (0, 1.5)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_(k-1) - d_k >= 0$)
    },
  ),
)

== 余った部分の基底をとる。

#align(
  center,
  cetz.canvas(
    length: 7%,
    {
      import cetz.draw: *

      rect((0, 0), (rel: (4, 4)))
      rect((8, 0), (rel: (4, 4)))
      rect((8, 4), (rel: (4, 2.5)), fill: color.red)
      rect((0, 0), (rel: (4, 4)), stroke: none, fill: color.red.lighten(30%))
      rect((8, 0), (rel: (4, 4)), stroke: none, fill: color.red.lighten(30%))
      line((4, 4), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((4, 1.5), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((7.5, 5), (4.5, 3), stroke: 2pt, mark: (end: ">"), name: "arrow")
      content(("arrow.start", 50%, "arrow.end"), anchor: "south", angle: "arrow.start", padding: 10pt, $N times$)
      content((10, 2), $U_(k-1)$)
      content((10, 5.25), $U_k = angle.l bold(x)_1, dots.c, bold(x)_d_k angle.r$)
      content((2, 2.5), $angle.l N bold(x)_1, dots.c, N bold(x)_d_k angle.r$)
      content((2, 0.75), $angle.l bold(x)_(d_k+1), dots.c, bold(x)_d_(k-1) angle.r$)
      content((2, 1.7), $plus.circle$)
    },
  ),
)

== $W_(k-2)$ の上段でも同様の現象が起こる。

$U_(k-1)$ の基底は $N bold(x)_1, dots.c, N bold(x)_d_k, bold(x)_(d_k+1), dots.c, bold(x)_d_(k-1)$ になっている。

$Im_N U_k subset.eq U_(k-1)$ と $N bold(x)_1, dots.c, N bold(x)_d_k$ の線型独立性を示したときとまったく同様にして次が成り立つ：

- $Im_N U_(k-1) = angle.l N^2 bold(x)_1, dots.c, N^2 bold(x)_d_k, N bold(x)_(d_k+1), dots.c, N bold(x)_d_(k-1) angle.r subset.eq U_(k-2).$
- $N^2 bold(x)_1, dots.c, N^2 bold(x)_d_k, N bold(x)_(d_k+1), dots.c, N bold(x)_d_(k-1)$ は一次独立。
  - 次のように換言してもよい：$N times$ によって $U_(k-1)$ は退化しない。つまり、$dim Im_N U_(k-1) = d_(k-1).$

== $Im U_(k-1) subset.eq U_(k-2)$ の様子。

#align(
  center,
  cetz.canvas(
    length: 4.5%,
    {
      import cetz.draw: *

      rect((0, 0), (rel: (4, 4)))
      rect((8, 0), (rel: (4, 4)))
      rect((16, 0), (rel: (4, 4)))
      rect((16, 4), (rel: (4, 2.5)))
      rect((16, 6.5), (rel: (4, 1)))
      rect((16, 4), (rel: (4, 2.5)), fill: color.red.lighten(30%))
      rect((16, 6.5), (rel: (4, 1)), fill: color.red)
      rect((8, 4), (rel: (4, 2.5)), fill: color.red.lighten(30%))
      rect((0, 1.5), (rel: (4, 2.5)), stroke: none, fill: color.red.lighten(60%))
      line((4, 4), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((4, 1.5), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((7.5, 5), (4.5, 3), stroke: 2pt, mark: (end: ">"), name: "arrow")
      content(("arrow.start", 50%, "arrow.end"), anchor: "south", angle: "arrow.start", padding: 10pt, $N times$)
      content((18, 2), $U_(k-2)$)
      content((18, 5.25), $U_(k-1)$)
      content((18, 7), $U_k$)
      content(
        (10, 5.25),
        text(
          size: 16pt,
        )[$angle.l N bold(x)_1, dots.c, N bold(x)_d_k,\ bold(x)_(d_k+1), dots.c, bold(x)_(d_(k-1)) angle.r$],
      )
      content((2, 2.5), $Im_N U_(k-1)$)
      line((15, 0), (rel: (0, 4)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_(k-2)$)
      line((15, 4), (rel: (0, 2.5)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_(k-1)$)
      line((15, 6.5), (rel: (0, 1)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, text(size: 17pt)[$d_k$])
      line((-1, 1.5), (rel: (0, 2.5)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content((name: "d", anchor: 50%), frame: "rect", padding: 0.1, stroke: none, fill: white, $d_(k-1)$)
      line((-1, 0), (rel: (0, 1.5)), mark: (symbol: "bar", width: 15pt), stroke: 1pt, name: "d")
      content(
        (name: "d", anchor: 50%),
        frame: "rect",
        padding: 0.1,
        stroke: none,
        fill: white,
        $d_(k-2) - d_(k-1) >= 0$,
      )
    },
  ),
)

== 例によって余った部分の基底をとる。

#align(
  center,
  cetz.canvas(
    length: 4.5%,
    {
      import cetz.draw: *

      rect((0, 0), (rel: (4, 4)))
      rect((8, 0), (rel: (4, 4)))
      rect((16, 0), (rel: (4, 4)))
      rect((16, 4), (rel: (4, 2.5)))
      rect((16, 6.5), (rel: (4, 1)))
      rect((16, 4), (rel: (4, 2.5)), fill: color.red.lighten(30%))
      rect((16, 6.5), (rel: (4, 1)), fill: color.red)
      rect((8, 4), (rel: (4, 2.5)), fill: color.red.lighten(30%))
      rect((0, 0), (rel: (4, 4)), stroke: none, fill: color.red.lighten(60%))
      rect((8, 0), (rel: (4, 4)), stroke: none, fill: color.red.lighten(60%))
      rect((16, 0), (rel: (4, 4)), stroke: none, fill: color.red.lighten(60%))
      line((4, 4), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((4, 1.5), (rel: (4, 2.5)), stroke: (dash: "dashed"))
      line((7.5, 5), (4.5, 3), stroke: 2pt, mark: (end: ">"), name: "arrow")
      content(("arrow.start", 50%, "arrow.end"), anchor: "south", angle: "arrow.start", padding: 10pt, $N times$)
      content((18, 2), $U_(k-2)$)
      content((18, 5.25), $U_(k-1)$)
      content((18, 7), $U_k$)
      content(
        (10, 5.25),
        text(
          size: 16pt,
        )[$angle.l N bold(x)_1, dots.c, N bold(x)_d_k,\ bold(x)_(d_k+1), dots.c, bold(x)_(d_(k-1)) angle.r$],
      )
      content(
        (2, 3),
        text(
          size: 16pt,
        )[$angle.l N^2 bold(x)_1, dots.c, N^2 bold(x)_d_k,\ N bold(x)_(d_k+1), dots.c, N bold(x)_(d_(k-1)) angle.r$],
      )
      content((2, 2), $plus.circle$)
      content(
        (2, 1),
        text(size: 16pt)[$angle.l bold(x)_(d_(k-1)+1) dots.c, bold(x)_(d_(k-2)) angle.r$],
      )
    },
  ),
)

== 増大列再訪

#align(
  center,
  cetz.canvas(
    length: 9%,
    {
      import cetz.draw: *
      rect((0, 0), (1, 0), name: "W0")
      rect((2, 0), (3, 2), name: "W1")
      rect((5, 0), (6, 3.5), name: "Wk-2")
      rect((7, 0), (8, 4.5), name: "Wk-1")
      rect((9, 0), (10, 5), name: "Wk")
      rect((9, 4.5), (rel: (1, 0.5)), fill: color.red)
      rect((9, 3.5), (rel: (1, 1)), fill: color.red.lighten(30%))
      rect((7, 3.5), (rel: (1, 1)), fill: color.red.lighten(30%))
      rect((9, 2.5), (rel: (1, 1)), fill: color.red.lighten(60%))
      rect((7, 2.5), (rel: (1, 1)), fill: color.red.lighten(60%))
      rect((5, 2.5), (rel: (1, 1)), fill: color.red.lighten(60%))
      rect((9, 0), (rel: (1, 2)), fill: color.red.lighten(90%))
      rect((7, 0), (rel: (1, 2)), fill: color.red.lighten(90%))
      rect((5, 0), (rel: (1, 2)), fill: color.red.lighten(90%))
      rect((2, 0), (rel: (1, 2)), fill: color.red.lighten(90%))
      content((0.5, 0), anchor: "north", padding: .1, $W_0$)
      content((1.5, 0), anchor: "north", padding: .1, $subset.neq$)
      content((2.5, 0), anchor: "north", padding: .1, $W_1$)
      content((3.25, 0), anchor: "north", padding: .1, $subset.eq$)
      content((4, 0), anchor: "north", padding: .1, $dots.c$)
      content((4, 1.5), anchor: "north", padding: .1, text(size: 40pt)[$dots.c$])
      content((4.75, 0), anchor: "north", padding: .1, $subset.eq$)
      content((5.5, 0), anchor: "north", padding: .1, $W_(k-2)$)
      content((6.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((7.5, 0), anchor: "north", padding: .1, $W_(k-1)$)
      content((8.5, 0), anchor: "north", padding: .1, $subset.eq$)
      content((9.5, 0), anchor: "north", padding: .1, $W_k$)
      line((5, 2.5), (6, 2.5), name: "d")
      line((7, 2.5), (8, 2.5), name: "d")
      line((9, 2.5), (10, 2.5), name: "d")
      line((5, 2), (6, 2), name: "d")
      line((7, 2), (8, 2), name: "d")
      line((9, 2), (10, 2), name: "d")
      line((7, 3.5), (8, 3.5), name: "d")
      line((9, 3.5), (10, 3.5), name: "d")
      line((9, 4.5), (10, 4.5), name: "d")
      content((2.5, 1), $U_1$)
      content((5.5, 1), $U_1$)
      content((7.5, 1), $U_1$)
      content((9.5, 1), $U_1$)
      content((5.5, 3), $U_(k-2)$)
      content((7.5, 3), $U_(k-2)$)
      content((9.5, 3), $U_(k-2)$)
      content((7.5, 4), $U_(k-1)$)
      content((9.5, 4), $U_(k-1)$)
      content((9.5, 4.75), $U_k$)
      content(
        (4, 2.2),
        (11, 2.38),
        box(for _ in range(31) [$tilde.triple$], fill: white),
      )
    },
  ),
)

== $CC^n$ の基底

以上のような操作を繰り返すことにより $CC^n = W_k$ の基底をとることができる。
その構成は次の基底を集めたものになっている：
- $U_k$ の基底：$bold(x)_1, dots.c, bold(x)_d_k.$
- $U_(k-1)$ の基底：$N bold(x)_1, dots.c, N bold(x)_d_k, bold(x)_(d_k+1), dots.c, bold(x)_d_(k-1).$
- $dots.v$
- $U_1$ の基底 $N^(k-1) bold(x)_1, dots.c, N^(k-1) bold(x)_d_k, N^(k-2) bold(x)_(d_k+1), dots.c, N^(k-2) bold(x)_d_(k-1), dots.c, bold(x)_(d_2+1), dots.c, bold(x)_d_1.$
