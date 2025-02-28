#import "@preview/touying:0.5.5": *
#import themes.university: *
#import "@preview/cetz:0.3.1"
#import "@preview/fletcher:0.5.3" as fletcher: node, edge
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/physica:0.9.4": *

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

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
#let example = thmplain("example", "Example", titlefmt: strong).with(numbering: none)
#let proof = thmproof("proof", "Proof", titlefmt: strong)

#let red(expr) = text(fill: color.red)[$#expr$]
#let blu(expr) = text(fill: blue)[$#expr$]
#let gre(expr) = text(fill: green)[$#expr$]

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(
    title: [§5. 和空間と直和 ],
    subtitle: [輪講 \#3],
    date: datetime.today(),
  ),
)

#set text(font: "Noto Sans CJK JP", size: 20pt)

#show "、": "，"
#show "。": "．"

#let Ker = $op("Ker")$

#set heading(numbering: none)

#title-slide()

= 可換な行列による部分空間

==

#theorem(number: none)[
  $A in M_n$ について、$C(A) = {X in M_n | X A = A X}$ はベクトル空間 $M_n$ の部分空間をなす。ただし、和とスカラー倍は自然に定まるものとする。
  #proof[
    $O$ を含むことと、和とスカラー倍で閉じていることを示す。
    - $O A = A O = O$ より $O in C(A).$
    - $X, Y in C(A)$ ならば、 $(X+Y)A = X A + Y A = A X + A Y = A (X+Y)$ より $X+Y in C(A).$
    - $X in C(A)$ ならば、 $(c X)A = A (c X)$ より $c X in C(A).$
  ]
]

/ Remark: $C(A)$ は（群としての）$M_n$ の部分群となり、*中心化群*と呼ばれる。

/ Question: $C(A)$ の次元はいくつになるだろうか？


==

/ Motivation: $A$ を簡単な標準形にしたい。
  - $A$ の相似変換に対して $C(A)$ が不変、つまり $C(A) = C(P^(-1)A P)$ ならよいが、そうではない……
  - 実際、$X A = A X <=> red(P X P^(-1)) blu(P A P^(-1)) = blu(P A P^(-1)) red(P X P^(-1)). $
  - 不変ではないけれど、線形同型写像 $F: X |-> P X P^(-1)$ を考えられる！

#theorem(number: none)[
  正方行列 $A, B$ が相似なら、$C(A) tilde.eq C(B).$ 特に $dim C(A) = dim C(B).$
  #proof[
    $B = P^(-1) A P$ となるような正則行列 $P$ をとれる。\
    線形同型写像 $F: C(A) in.rev X |-> P X P^(-1) in C(B)$ が存在する。
    // F の逆写像が簡単にとれるので F は線形同型写像。
  ]
]

/ Remark: 有限次元なら、$V tilde.eq W <=> dim V = dim W.$
- したがって、$A$ を初めから Jordan 標準形として考えてよい。
- $A$ が対角化可能という条件付きでさらに考察してみよう。

==

- 始めから $A = diag(lambda_1, dots.c, lambda_n)$ としてよい。
- $f(X) = X A - A X$ として、$C(A) = Ker f.$
  - 特に $C(A)$ が部分空間であることがただちにわかる。
- $f(E_(i j)) = (lambda_j - lambda_i) E_(i j).$ つまり、$E_(i j)$ は固有値 $lambda_j - lambda_i$ の固有ベクトル。
- $C(A) = Ker f$ は $f$ の固有値 $0$ の固有空間に等しい。
  - $dim C(A) = hash{(i, j) | lambda_i = lambda_j}.$

#theorem(number: none)[
  対角化可能な正方行列 $A$ の*相異なる*固有値を $mu_1, dots.c, mu_s$ とし、それぞれの重複度を $m_1, dots.c, m_s$ とする。このとき、$dim C(A) = sum_(i = 1)^s (m_i)^2.$
]

==

#example[
  $
    A = mat(8, -9, -2; 6, -7, -2; -6, 9, 4) stretch(~>)^"diagonize" D = mat(1,,;,2,;,,2; augment: #(hline: 1, vline: 1)).
  $
  したがって、$dim C(A) = dim C(D) = 1^2 + 2^2 = 5.$

  実際、$D$ と可換な行列 $X$ は次のような形をしているハズである：$ X = mat(*,,;,*,*;,*,*; augment: #(hline: 1, vline: 1)). $
]

= 本編

==

- $V$：$CC$ 上のベクトル空間。
- $W_1, dots.c, W_m$：$V$ の部分空間。

#theorem(number: "5.1")[
  和空間 $W_1 + dots.c + W_m := {bold(x)_1 + dots.c + bold(x)_m | bold(x)_j in W_j}$ は $V$ の部分空間。
]

#definition(number: "5.1")[
  任意の $bold(x) in W_1 + dots.c + W_m$ が
  #align(center)[$bold(x) = bold(x)_1 + dots.c + bold(x)_m #v(0pt) (bold(x)_j in W_j)$]
  と*一意的に*表されるとき、
  #align(center)[$W_1 + dots.c + W_m = W_1 plus.circle dots.c plus.circle W_m$]
  と表し、$W_1 + dots.c + W_m$ は $W_1, dots.c, W_m$ の*直和*であるという。
]

== 直和の特徴付け

#theorem(number: "5.2")[
  次の 1 〜 4 は互いに同値。
  + $W_1 + dots.c + W_m$ は $W_1, dots.c, W_m$ の直和。
  + $bold(x)_1 in W_1, dots.c, bold(x)_m in W_m$ に対して $bold(x)_1 + dots.c + bold(x)_m = bold(0)$ ならば、$bold(x)_1 = dots.c = bold(x)_m = bold(0).$
  + $bold(x)_1 in W_1 backslash {bold(0)}, dots.c, bold(x)_m in W_m backslash {bold(0)}$ とすると、$bold(x)_1, dots.c, bold(x)_m$ は一次独立。
  + 各 $j = 2, dots.c, m$ に対して、$(W_1 + dots.c + W_(j-1)) inter W_j = {bold(0)}.$
  #proof[
    *1 $=>$ 2*, *2 $=>$ 3* は明らか。*3 $=>$ 4* は対偶が簡単に従う。*4 $=>$ 1* を示す。
    $bold(w) in W_1 + dots.c + W_m$ に対して、$bold(w) = sum_j bold(x)_j = sum_j bold(y)_j (bold(x)_j, bold(y)_j in W_j)$ とすると、$bold(z)_j = bold(x)_j - bold(y)_j in W_j$ として $sum_(j < m) bold(z)_j = -bold(z)_m$ だが、4 の主張よりその両辺は $bold(0)$ に等しい。これを繰り返すことで $forall j, bold(z)_j = bold(0)$ となり、$bold(w)$ の分解の一意性が従う。
  ]
]

== 部分空間に対する次元定理


#theorem(number: "5.3")[
  $dim (W_1 + W_2) = dim W_1 + dim W_2 - dim (W_1 inter W_2).$
  #proof[
    $n_0 = dim (W_1 inter W_2)$ とし、$W_1 inter W_2$ の基底 $bold(z)_1, dots.c, bold(z)_n_0$ をとる。
    これを延長することで、次のように基底をとることができる：
    - $W_1$ の基底 $bold(z)_1, dots.c, bold(z)_n_0, bold(x)_(n_0+1), dots.c, bold(x)_n_1.$ ただし、$n_1 = dim W_1.$
    - $W_2$ の基底 $bold(z)_1, dots.c, bold(z)_n_0, bold(y)_(n_0+1), dots.c, bold(y)_n_2.$ ただし、$n_2 = dim W_2.$
    / Claim: $bold(z)_1, dots.c, bold(z)_n_0, bold(x)_(n_0+1), dots.c, bold(x)_n_1, bold(y)_(n_0+1), dots.c, bold(y)_n_2$ は $W_1 + W_2$ の基底をなす。
    #proof[
      $bold(w)_1 + bold(w)_2 in W_1 + W_2$ に対して、
      - $bold(w)_1 = c_1 bold(z)_1 + dots.c + c_n_0 bold(z)_n_0 + c_(n_0+1) bold(x)_(n_0+1) + dots.c + c_(n_1) bold(x)_(n_1)$
      - $bold(w)_2 = d_1 bold(z)_1 + dots.c + d_n_0 bold(z)_n_0 + d_(n_0+1) bold(y)_(n_0+1) + dots.c + d_(n_1) bold(y)_(n_1)$
      なる $(c_i)_i, (d_i)_i$ が一意に存在するから、次の分解も一意的：
      $
        bold(w)_1 + bold(w)_2 = sum_(i<=n_0) (c_i + d_i) bold(z)_i + sum_(n_0 < i <= n_1) c_i bold(x)_i + sum_(n_0 < i <= n_2) d_i bold(y)_i.
      $
    ]
  ]
]


== 部分空間に対する次元定理（より一般の場合）

#text(size: 19pt)[
  #theorem(number: "5.4")[
    $dim (W_1 + dots.c + W_m) = sum_(j=1)^m dim W_j - sum_(j=2)^m dim ((W_1 + dots.c + W_(j-1)) inter W_j).$
    #example[
      $ dim (W_1 + W_2 + W_3) =& dim W_1 + dim W_2 + dim W_3\ -& dim(W_1 inter W_2) - dim((W_1 + W_2) inter W_3). $
    ]
    #proof[
      $m$ に関する帰納法。簡単なので略。
    ]
  ]
]
