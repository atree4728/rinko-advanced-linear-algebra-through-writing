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
    title: [§12. 行列の指数関数と微分方程式 ],
    subtitle: [輪講 \#6],
    date: datetime.today(),
  ),
)

#set text(font: "Noto Sans CJK JP", size: 20pt)

#show "、": "，"
#show "。": "．"

#set heading(numbering: none)

#title-slide()

== 行列の指数関数

#definition(number: none)[
  正方行列 $A in M_n (CC)$ に対し、$exp A$ を次で定義する。
  $
    exp A = sum_(k=0)^oo A^k / k! = I + A + A^2 / 2 + A^3 / 6 + dots.c
  $
]

/ Question: ちゃんと収束するの？

#theorem(number: [(Weierstrass's $M$-test)])[
  関数列 $(f_k (x))$ に対してある数列 $(M_k)$ が存在し、
  + $sum_(k=0)^oo M_k < oo.$
  + $sup_x abs(f_k (x)) <= M_k$ for $forall k.$
  の 2 条件が成立するとき、関数項級数 $sum_(k=0)^oo f_k (x)$ は*絶対かつ一様に収束する*。
]



==

#theorem(number: none)[
  $exp A$ の各成分は $A$ の成分に対して絶対広義一様収束する。
  #proof[
    $sup_(norm(A) < oo) abs(A^k/k!)_(i j) <= M_k$ なる実数列 $(M_k)_k$ がとれて、$sum_k M_k < oo$ となることを示せばよい（Weierstrass の $M$-test）。

    $norm(A) = sqrt(Tr(A^* A))$ は $norm(A^k) <= norm(A)^k$ を満たし（略）、次が成り立つ。
    $
      abs((A^k / k!)_(i j)) = (A^k)_(i j) / k! <= norm(A^k) / k! <= norm(A)^k / k!
    $
    任意の有界な $A$ に対して $norm(A) <= L$ なる十分大きな定数 $L$ がとれて、$M_k = L^k / k!$ とすれば $sum_k M_k = e^L < oo$ となるから、題意は示された。
  ]
]

==

#theorem(number: none)[
  + $A, B$ が可換なら $exp(A + B) = (exp A)(exp B).$
  + $exp A$ は正則であり、$(exp(A))^(-1) = exp(-A).$
  + $(exp A)^TT = exp(A^TT).$
  + $overline((exp A)) = exp(overline(A)).$
  + $P$ が正則なら $exp(P^(-1) A P) = P^(-1) (exp A) P.$
]

一様収束するので割とやりたい放題。

== 一階の連立定数係数同次線型微分方程式

時間 $t$ の関数 $z_1 (t), dots.c, z_n (t)$ の満たす微分方程式が
$
  A = mat(a_(1 1), dots.c, a_(1 n); dots.v, dots.down, dots.v; a_(n 1), dots.c, a_(n n)), bold(z)(t) = vec(z_1 (t), dots.v, z_n (t))
$
によって
$ bold(z)' = dv(bold(z), t)= A bold(z) $
で与えられるものとする。

==

#theorem(number: none)[
  微分方程式 $bold(z)' = A bold(z)$ の解は $bold(z)(t) = e^(t A) bold(z)(0)$ により一意的に与えられる。
  #proof[
    まず、$bold(z)(t) = e^(t A) bold(z)(0)$ は実際に微分方程式の解である。実際、$ (e^(t A) bold(z)(0))' = sum_k ((t A)^k/k!)' bold(z)(0) = sum_k (t^(k-1) A^k)/(k-1)! bold(z)(0) = A bold(z) $
    である（$because e^(t A)$ は一様収束するから項別微分可能）。

    また、$bold(z)(t)$ が $bold(z)' = A bold(z)$ をみたすとすれば $ (e^(-t A) bold(z))' = -A e^(-t A) bold(z) + e^(-t A) A bold(z) = bold(0) $
    だから $e^(-t A) bold(z)$ は $t$ に依らず一定。$t = 0$ において $e^(-t A) bold(z) = bold(z)(0)$ ゆえ $bold(z) = e^(t A) bold(z)(0)$ はただひとつの解にほかならない。
  ]
]

== $exp t A$ の計算（Jordan 標準形）

$exp (P^(-1) A P) = P^(-1) (exp A) P$ だったから、$A$ の Jordan 標準形 $J$ に対して $exp J$ を計算できればよい。

$
  exp t J = dmat(exp t J(lambda_1; m_1), dots.down, exp t J(lambda_r; m_r)).
$

例によって Jordan 細胞 $J(lambda; m)$ に対する $exp (J(lambda; m))$ の計算に帰着された。

$N = J(lambda; m) - lambda I_m = J(0; m)$ とおくと、

$
  exp (t J(lambda; m))
  &= exp (lambda t I + t N)\
  &= exp (lambda t I) exp (t N)\
  &= e^(lambda t) exp (t N).
$

==

$
  &exp(J(lambda; m))\
  &= e^(lambda t)exp (t N)\
  &= e^(lambda t)(I + N + N^2 / 2! + dots.c + N^(m-1) / (m-1)!)\
  &= e^(lambda t) mat(
    1, t/1!, dots.c, t^(n-2)/(n-2)!, t^(n-1)/(n-1)!;
    0, 1, t/1!, dots.c, t^(n-2)/(n-2)!;
    dots.v, dots.v, 1, dots.down, dots.v;
    0, 0, dots.v, dots.down, t/1!;
    0, 0, 0, dots.c, 1;
  ).
$

第一行を左から眺めていくと、$e^t$ の Taylor 展開の各項が並んでいる。

== $exp t A$ の計算（一般スペクトル分解）

$A$ の一般スペクトル分解が $A = lambda_1 P_1 + dots.c + lambda_r P_r + N$ で与えられるとする。

$
  exp(t A)
  &= exp(t lambda_1 P_1 + dots.c + t lambda_r P_r + t N)\
  &= exp(t lambda_1 P_1 + dots.c + t lambda_r P_r) exp(t N)\
  &= (e^(t lambda_1) P_1 + dots.c + e^(t lambda_r) P_r) exp(t N).
$

また、
$
  exp(t N)
  = exp(sum_j t(A - lambda_j I) P_j)
  = sum_j exp(t (A - lambda_j I)) P_j
$
であることから、$k_j$ を $lambda_j$ に対応する標数として、
$
  exp(t A) = sum_j e^(t lambda_j) (sum_(0 <= k <= k_j) t^k / k! (A - lambda_j I)^k) P_j.
$

== 計算例

/ Example:
$ A = mat(8, 9; -4, -4) $ に対して $exp(t A)$ を計算してみよう。

=== Jordan 標準形による方法

#text(size: 12pt)[
  $phi.alt_A (x) = (x-2)^2$ であり、$A - 2I != O$ より $psi_A (x) = (x-2)^2$ となる。
  $Ker (A - 2I) = Ker mat(6, 9; -4, -6) = CC vec(3, -2), Ker (A - 2I)^2 = CC^2$
  だから、\ $vec(3, -2)$ と線型独立な $vec(1, 0)$ を $bold(x)$ としてとると、$(A - 2I) bold(x) = vec(6, -4)$ で、$P = mat(6, 1; -4, 0)$ とすると $A = P mat(2, 1; 0, 2) P^(-1).$
]

Jordan 細胞の指数関数を計算する。
$
  exp t mat(2, 1; 0, 2) = exp (t dmat(2, 2) + t mat(0, 1; 0, 0)) = e^(2 t) mat(1, t; 0, 1).
$


したがって、
$
  exp(t A) = mat(6, 1; -4, 0) e^(2 t) mat(1, t; 0, 1) mat(0,-1/4;1,3/2) = e^(2 t) mat(6t+1, 9t; -4t, -6t+1).
$

#emoji.thumb わかりやすい。\
#emoji.thumb.down Jordan 標準形を与える基底の計算、逆行列計算、最後の行列積の計算。

=== 一般スペクトル分解による方法

一般スペクトル分解は $A = 2I + (A - 2I)$ で与えられる。
$
  exp(t A) = exp(2t I + t(A - 2I)) = e^(2 t) (I + t(A - 2I)) = e^(2 t) mat(6t+1, 9t; -4 t, -6t+1).
$

#emoji.thumb ラク。賢い。かっこいい。\
#emoji.thumb.down 射影の計算が面倒になるときがある（部分分数分解）。


== $n$ 階の定数係数同次線型微分方程式

$z(t)$ の $k$ 階微分を $z^((k))$ と書く。定数 $a_1, dots.c, a_n in CC$ によって与えられる微分方程式
$
  z^((n)) + a_1 z^((n-1)) + dots.c + a_n z = 0
$
は、
$
  A = mat(
    0, 1, 0, dots.c, 0, 0;
    0, 0, 1, dots.c, 0, 0;
    dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
    0, 0, 0, dots.c, 1, 0;
    0, 0, 0, dots.c, 0, 1;
    -a_n, -a_(n-1), -a_(n-2), dots.c, -a_2, -a_1
    ),
  bold(z) = vec(z(t), z'(t), dots.c, z^((n-1))(t))
$
によって $bold(z)' = A bold(z)$ と書ける。

/ Remark: $A$ は同伴行列だから Jordan 標準形がすぐにわかる。

==

/ Example: $z''' - 5 z'' + 8 z' - 4 z = 0.$

- $A = mat(0, 1, 0; 0, 0, 1; 4, -8, 5), bold(z) = vec(z, z', z'')$ とすると $bold(z)' = A z.$
- $phi.alt_A (x) = x^3 - 5 x^2 + 8 x - 4 = (x-1)(x-2)^2 = psi_A (x).$
- Jordan 標準形は $mat(1,,;,2,1;,,2,; augment: #{(hline: 1, vline: 1)}) =: J$ で、$exp(t J) = mat(e^t,,;,e^(2 t), t e^(2 t);,,e^(2 t),; augment: #{(hline: 1, vline: 1)}).$
- $bold(z) = exp(t A) bold(z)(0)$ だから、$z(t)$ は $e^t, e^(2t), t e^(2t)$ の線型結合で書ける。

== Quiz

+ $A in M_n (CC)$ に対し、$det exp A = exp Tr A$ か？
+ $[A, B] = O => exp(A+B) = (exp A)(exp B)$ か？
+ $exp(A+B) = (exp A)(exp B) => [A, B] = O$ か？
+ $exp: M_n (RR) -> M_n (RR)$ は全射か？また、単射か？
+ $exp: M_n (CC) -> M_n (CC)$ は全射か？また、単射か？
+ Jordan 標準形の存在定理は $M_n (RR)$ でも成立する。

#pause
=== 解答

+ Yes.
+ Yes.
+ No.
+ 全射でないし、単射でもない。
+ 全射でないし、単射でもない。
+ No.

== $det exp A = exp Tr A$

$A$ ははじめから上三角と仮定してよい。実際、
- $det exp (P^(-1) A P) = det (P^(-1) (exp A) P) = det exp A$
- $exp Tr (P^(-1) A P) = exp Tr (A P P^(-1)) = exp Tr A$
より $A$ の相似変換によって両辺は不変。

$A$ の対角成分を $lambda_1, dots.c, lambda_r$ とすると、
$
  "(LHS)" &= det exp mat(lambda_1, ,#text(size: 50pt, $*$);; ,dots.down;,,lambda_r) = mat(e^(lambda_1), , #text(size: 50pt,$*$);;,dots.down;,,e^(lambda_r)) = product_j e^(lambda_j).\
  "(RHS)" &= exp Tr mat(lambda_1,, #text(size: 50pt, $*$);;,dots.down;,,lambda_r) = e^(lambda_1 + dots + lambda_r).
$

== $exp(A + B) = (exp A)(exp B) <=>^? [A, B] = O$

/ $(arrow.double.l)$: 成り立つ。

$
  exp(A+B) = sum_(k=0)^oo (A+B)^k / k! = exp(A+B) = sum_(0<=j<=k) A^j / j! B^(k-j) / (k-j)! = (exp A)(exp B).
$

/ $(=>)$: 成り立たない。

反例として $A = mat(i pi, 0; 0, i pi), B = mat(i pi, 1; 0, i pi)$ がある。

- $exp mat(i pi, 0; 0, i pi) = e^(i pi) exp I = -e I.$
- $exp mat(i pi, 1; 0, i pi) = exp(i pi I + mat(0,1;0,0)) = e^(i pi) (I + mat(0,1;0,0)) = -mat(1,1;0,1).$


== $exp: M_n (K) -> M_n (K)$

/ $exp: M_n (RR) -> M_n (RR)$ は全射ではない: \
  $det exp A = exp Tr A > 0$ だから、$det B <= 0$ となるような $B in M_n (RR)$ に対しては $B = exp A$ となるような $A$ が存在しない。
/ $exp: M_n (CC) -> M_n (CC)$ は全射ではない: \
  $Tr A in CC$ の場合でも $exp Tr A != 0$ だから正則でない行列 $B$ に対して $B = exp A$ となる $A in M_n (CC)$ は存在しない。
/ $exp: M_n (RR) -> M_n (RR)$ も $exp: M_n (CC) -> M_n (CC)$ も単射ではない:
  $
    exp mat(0, 2 pi; -2 pi, 0) = I = exp O.
  $

/ Remark: 逆に、正則な行列に対しては必ず"対数"が存在する。

== 行列の対数

#definition(number: none)[
  正方行列 $A$ に対し、$A = exp X$ となるような $X$ が存在するとき、 この $X$ を行列 $A$ の対数といい、$log A$ と書く。これはしばしば多価関数になる。
]

#theorem(number: none)[
  $A in M_n (CC)$ の対数が存在することは $A$ が正則であることと必要十分。
  #proof[
    / $(=>)$: $det A = exp Tr log A != 0.$
    / $(arrow.double.l)$: $A$ を Jordan 標準形としてよい。
    各 Jordan 細胞 $J(lambda, m) = lambda I + N in M_m (CC) $ について、$
                                      K = (log lambda) I + sum_(1 <= k < m) (-1)^(k-1)/k (N/lambda)^k
                                    $
    を対応させたブロック対角行列が $log A$ を与える。
  ]
]

== Jordan 標準形 on $M_n (RR)$

#{
  align(center + horizon, text(size: 2em, [*実行列の固有値は実とは限らない！*]))
}

例えば $mat(0, -1; 1, 0)$ の固有値は $plus.minus i$ だから当然 Jordan 標準形は実の範囲で書けない。

$CC$ がエライのは*代数的に閉じている*、つまり代数学の基本定理が成り立つというところ。このような体は一般に代数閉体と呼ばれている。

= $K[A]$ と $C(A)$

== まずは $C(A)$ から

=== 復習

- $C(A) = {X | X A = A X }$ は $M_n (K)$ の部分空間。
- $C(P^(-1) A P) = {P^(-1) X P | X in C(A)} tilde.eq C(A)$
- $A$ が対角化可能なら $E_(i j)$ が固有値 $lambda_j - lambda_i$ の固有ベクトルで、$dim C(A) = sum m_j^2.$

=== 対角化可能性を仮定しなかったら $dim C(A)$ はどうなる？

$A$ を Jordan 標準形だとしてよい。
$A$ の相異なる固有値を $lambda_1, dots.c, lambda_r$ とする。
$i$ 番目の Jordan 細胞を $J(lambda_k, m_i)$ とし、このような添字 $i$ を集めて集合 $I_k$ とする。

#theorem(number: none)[
  $C(A) = sum_k sum_(i, j in I_k, i<=j) min(m_i, m_j)$.
]


$X$ を $A$ と同様に区分けし、$X$


==

#definition(number: none)[
  $K$ を体とする。$K[X] = {sum_(k<oo) a_k X^k | a_k in K}$ は多項式環と呼ばれる。
]

記号を濫用して、$K[A] = {f(A) | f(X) in K[X] }$ とする。

#theorem(number: none)[
  $K[A]$ は $M_n (K)$ の部分空間であり、$dim K[A] = deg psi_A <= deg phi.alt_A = n.$
]

/ Remark: 明らかに $K[A] subset.eq C(A).$

/ Question: $K[A] = C(A)$ となるのはどんなときだろうか？

== *$K[A]$ と $C(A)$*：対角化可能な場合

#align(
  center,
  diagram(
    spacing: 1em,
    node((1, 0), $K[A]$),
    node((2, 0), $subset.eq$),
    node((3, 0), $C(A)$),
    node((4, 0), $subset.eq$),
    node((5, 0), $M_n (K)$),
    node((0, 1), $dim:$),
    node((1, 1), $deg psi$),
    node((2, 1), $<= n = sum_j m_j <=$),
    node((3, 1), $sum_j m_j^2$),
    node((4, 1), $<=$),
    node((5, 1), $(sum_j m_j)^2 = n^2$),
  ),
)

対角化可能な場合、$dim K[A] <= n <= dim C(A)$ がいえるから、
$
  &K[A] = C(A)\
  &<=> n = dim K[A] = dim C(A)\
  &<=> n = deg psi = sum_j m_j^2\
  &<=> phi.alt = psi.
$

#theorem(number: none)[
  $A$ が対角化可能なとき、$K[A] = C(A) <=> phi.alt_A = psi_A.$
]


== *$K[A]$ と $C(A)$*：一般の場合

#theorem(number: none)[
  一般の $A in M_n (K)$ に対して、 $K[A] = C(A) <=> phi.alt_A = psi_A.$
]

/ Remark: 同伴行列のように、各 Jordan 細胞の固有値が相異なっているような状況。

/ $(arrow.double.l)$:
  $I, A, dots.c, A^(n-1)$ が $M_n (K)$ 上線型独立だから、ある $bold(x) in K^n$ がとれて $bold(x), A bold(x), dots.c, A^(n-1) bold(x)$ が $K^n$ の基底をなす。

https://www.chart.co.jp/subject/sugaku/suken_tsushin/05/5-3.pdf
http://www17.plala.or.jp/mi_kana/story/commutativityofmatrix.pdf
