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
    title: [§11. 行列のべき乗と差分方程式 ],
    subtitle: [輪講 \#6],
    date: datetime.today(),
  ),
)

#set text(font: "Noto Sans CJK JP", size: 20pt)

#show "、": "，"
#show "。": "．"

#set heading(numbering: none)

#title-slide()

== 1 階の連立定数係数同次線型差分方程式

連立方程式がある。
$
  cases(
    x_(k+1)^((1)) = a_(1 1) x_k^((1)) + a_(1 2)&x_k^((2)) + dots.c + a_(1 n) x_(k)^((n)),
    x_(k+1)^((2)) = a_(2 1) x_k^((1)) + a_(2 2)&x_k^((2)) + dots.c + a_(2 n) x_(k)^((n)),
    &dots.v&,
    x_(k+1)^((n)) = a_(n 1) x_k^((1)) + a_(n 2)&x_k^((2)) + dots.c + a_(n n) x_(k)^((n)),
  )
$

これは行列と数ベクトルによって簡単に書き表すことができる。

$
  A = mat(
    a_(1 1), a_(1 2), dots.c, a_(1 n);
    a_(2 1), a_(2 2), dots.c, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), dots.c, a_(n n);
  ),
  bold(x)_k = vec(x_k^((1)), x_k^((2)), dots.v, x_k^((n))) in CC^n
$

とすると、 $bold(x)_(k+1) = A bold(x)_k.$

初期値を $bold(x)_0 in CC$ とすると、$ bold(x)_k = A^k bold(x)_0. $

/ Motivation: 一般の $A in M_n (CC)$ に対して $A^k$ を計算したい！

+ Jordan 標準形を利用する方法。\
  $A = P J P^(-1)$ とすれば $A^k = P J^k P^(-1)$ だから、Jordan 標準形のべき乗を計算。
+ 一般スペクトル分解を利用する方法。


== 行列のべき乗（Jordan 標準形の利用）

Jordan 標準形の存在定理より、任意の $A in M_n (CC)$ に対して正則行列 $P in M_n (CC)$ が存在して、
$
  P^(-1) A P = dmat(J(lambda_1; m_1), dots.down, J(lambda_r; m_r)) =: J.
$
ブロック対角行列の性質により、
$
  A^k
  &= P J^k P^(-1)\
  &= P dmat(J(lambda_1; m_1)^k, dots.down, J(lambda_r; m_r)^k) P^(-1).
$
したがって、Jordan 細胞のべき乗 $J(lambda; m)^k$ が計算できればよい。

==

$N = J(0; m)$ はべき零行列であり、$J(lambda; m) = lambda I + N$ と書ける。
$
  J(lambda; m)^k &= (lambda I + N)^k\
  &= sum_(j=0)^k binom(k, j) lambda^(k-j) N^j\
  &= sum_(j=0)^k mat(
    0, dots.c, 0, binom(k, j) lambda^(k-j);
     ,       ,  ,                         , dots.down;
     ,       ,  ,                         ,          , binom(k, j) lambda^(k-j);
     ,       ,  ,                         ,          , 0;
     ,       ,  ,                         ,          , dots.v;
     ,       ,  ,                         ,          , 0;
    augment: #{ (hline: 3, vline: 3) })
    #stack(dir: ttb, v(5em), $ lr(}, size: #350%) j$)
  = mat(
    lambda^k, binom(k, 1) lambda^(k-1), dots.c, binom(k, n-1) lambda^(k-n+1);
    0, lambda^k, dots.c, binom(k, 1) lambda^(k-1);
    dots.v, dots.v, dots.down, dots.v;
    0, 0, dots.c, lambda^k
  ).
$

== 行列のべき乗（一般スペクトル分解）

Jordan 分解 $A = S + N$ の半単純部分をスペクトル分解する：$S = sum_(l=0)^r lambda_l P_l.$
$
  A^k = (S + N)^k = sum_(j=0)^k binom(k, j) S^(k-j) N^j
$
半単純部分 $S$ のべき乗は簡単に計算できる。
$
  S^(k - j) = sum_(l=0)^r lambda_l^(k-j) P_l.
$
べき零部分 $N$ はどうだろう？
$
  N& = A - sum_l lambda_l P_l = sum_l (A - lambda_l I) P_l\
  &~~> N^j = sum_l underbrace((A - lambda_l I)^j, "if" j >= k_l "then" O) P_l.
$

まとめると、

$
  A^k = sum_(j=0)^k sum_(l=0)^r binom(k, j) lambda_l^(k-j) (A - lambda_l I)^j P_l
$

== 行列のべき乗の計算例
$ A = mat(8, 9; -4, -4) $ に対して $A^k$ を求めてみよう。

=== Jordan 標準形による計算

- $phi.alt_A (x) = (x-2)^2$ であり、$A - 2I != O$ より $psi_A (x) = (x-2)^2$ となる。
- Jordan 標準形は $mat(2, 1; 0, 2)$ だとわかったので、基底を計算する。
- $Ker (A - 2I) = Ker mat(6, 9; -4, -6) = CC vec(3, -2), Ker (A - 2I)^2 = CC^2.$
- したがって $vec(3, -2)$ と線型独立な $vec(1, 0)$ を $bold(x)$ としてとると、$(A - 2I) bold(x) = vec(6, -4)$ で、 $ (A - 2I) mat((A-2I) bold(x), bold(x)) = mat((A-2I) bold(x), bold(x)) mat(0, 1; 0, 0). $
- 以上より、$P = mat(6, 1; -4, 0)$ とすると $A = P mat(2, 1; 0, 2) P^(-1).$
- $A^k = mat(6, 1; -4, 0) mat(2^k, k 2^(k-1); 0, 2^k) mat(0,-1/4;1,3/2) = 2^k mat(3k+1, 9/2 k; -2k, -3k+1).$

=== 一般スペクトル分解による計算

- $phi.alt_A (x) = (x-2)^2$ であり、$A - 2I != O$ より $psi_A (x) = (x-2)^2$ となる。
- 射影の和は $I$ なので、一般スペクトル分解は $A = 2I + (A - 2I)$ で与えられる。
- $
    A^k &= (2I)^k + (2I)^(k-1) (A - 2I)\
    &= mat(2^k, 0; 0, 2^k) + k mat(2^(k-1), 0; 0, 2^(k-1)) mat(6, 9; -4, -6)\
    &= 2^k mat(3k+1, 9/2 k; -2k, -3k+1).
  $

この場合はスペクトル分解が自明なので後者の方がラク。

== 同伴行列

#definition(number: none)[
  $n$ 次正方行列
  $
    A = mat(0, 1, 0, dots.c, 0, 0; 0, 0, 1, dots.c, 0, 0; dots.v, dots.v, dots.v, dots.down, dots.v, dots.v; 0, 0, 0, dots.c, 1, 0; 0, 0, 0, dots.c, 0, 1; -a_n, -a_(n-1), -a_(n-2), dots.c, -a_2, -a_1)
  $
  を多項式 $F(x) = x^n + a_1 x^(n-1) + dots.c + a_n in CC[x]$ の*同伴行列*という。
]

/ Remark:
  $A^TT$ が同伴行列として定義されることもある。

==

/ Remark:
  - $phi.alt_A (x) = F(x).$
    - 帰納法による。
  - 各固有空間の次元は $1.$
    - $A bold(x) = lambda bold(x)$ とすると、$x_2 = lambda x_1, dots.c, x_n = lambda x_(n-1), -a_n x_1 - dots.c - a_1 x_n = lambda x_n.$
    - したがって$bold(x)$ の自由度は $1$ しかない。
    - 特に、$A$ が対角化可能 $<=> phi.alt_A$ が相異なる一次式の積に分解される。
  - $bold(e)_1^TT$ に*右から* $A$ を適用していくと、次のようになる。

#align(
  center,
  diagram(
    spacing: 3em,
    (
      node((0, 0), $bold(e)_1^TT$),
      node((1, 0), $bold(e)_2^TT$),
      node((2, 0), $dots.c$),
      node((3, 0), $bold(e)_n^TT$),
      node((4, 0), $(-a_n, dots.c, -a_1)$),
    )
      .intersperse(edge("|->", text(size: 16pt)[$times A$], label-sep: 0em))
      .join(),
  ),
)

$0 <= j < n$ に対して、$bold(e)_1^TT A^j = bold(e)_(j+1)^TT$ となっている。

==

#theorem(number: none)[
  多項式 $F(x) = x^n + a_1 x^(n-1) + dots.c + a_n$ の同伴行列 $A$ の最小多項式は $F(x).$
  つまり、固有多項式と最小多項式が一致するということ。
  #proof[
    Cayley-Hamilton の定理より、$F(A) = phi.alt_A (A) = O.$\
    $n$ 次未満の多項式 $G(x) = b_1 x^(n-1) + b_2 x^(n-2) + dots.c + b_n$ に対して $G(A) = O$ だったとすると、
    $
      & b_1 A^(n-1) + b_2 A^(n-2) + dots.c + b_n = O\
      => & b_1 bold(e)_1^TT A^(n-1) + b_2 bold(e)_1^TT A^(n-2) + dots.c + b_n bold(e)_1^TT = bold(0)\
      => & b_1 bold(e)_n^TT + b_2 bold(e)_(n-1)^TT + dots.c + b_n bold(e)_1^TT = bold(0)\
      => & b_1 = b_2 = dots.c = b_n = 0.
    $
    したがって $G(x) = 0$ となってしまうので、最小多項式は $F(x) = phi.alt_A (x).$
  ]
]

== $n$ 階の定数係数同次線型差分方程式

定数 $a_1, dots.c, a_n in CC$ によって次の漸化式：
$ x_(k+n) + a_1 x_(k+n-1) + dots.c + a_n x_k = 0 $
が与えられる数列 $(x_k)_k$ に対して、
$
  A = mat(0, 1, 0, dots.c, 0, 0; 0, 0, 1, dots.c, 0, 0; dots.v, dots.v, dots.v, dots.down, dots.v, dots.v; 0, 0, 0, dots.c, 1, 0; 0, 0, 0, dots.c, 0, 1; -a_n, -a_(n-1), -a_(n-2), dots.c, -a_2, -a_1), bold(x)_k = vec(x_k, dots.v, x_(k+n-1))
$
を用いることで次の表式を得る：
$ bold(x)_(k+1) = A bold(x)_k. $

==

同伴行列のべき乗を求めよう。
$phi.alt_A (x) = product_j (x - lambda_j)^(m_j)$ が最小多項式に一致することから、$lambda_j$ の標数は $m_j$ であり、$A$ の Jordan 標準形は次のような形になっている。 $ dmat(J(lambda_1; m_1), dots.down, J(lambda_r; m_r)) $
したがって、$x_k$ は $binom(k, j) lambda_l^(k-j) "for" j, k$ の線型結合で書ける。

/ Example: $x_1 = 1, x_2 = 2, x_(k+2) - 6 x_(k+1) + 9 x_k = 0$。
  - $bold(x)_k = vec(x_k, x_(k+1)), A = mat(0, 1; 6, -9)$ として $bold(x)_k = A^(k-1) vec(1, 2).$
  - $phi.alt_A (x) = psi_A (x) = (x-3)^2$ より Jordan 標準形は $mat(3, 1; 0, 3).$
  - $mat(3, 1; 0, 3)^(k-1) = mat(3^(k-1), k 3^(k-2); 0, 3^(k-1))$ より $x_k = 3^(k-2) (3 alpha + beta k)$ と書ける。
  - $x_1 = alpha/3 + beta/3 = 1, x_2 = 3 alpha + 2 beta = 2$ より $alpha = -4, beta = 7.$
  - $x_k = 3^(k-2) (7 k - 12).$
