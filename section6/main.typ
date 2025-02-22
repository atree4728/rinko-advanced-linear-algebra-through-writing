#import "@preview/touying:0.5.5": *
#import themes.university: *
#import "@preview/cetz:0.3.1"
#import "@preview/physica:0.9.4": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))

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
#let example = thmplain("example", "例").with(numbering: none)
#let proof = thmproof("proof", "Proof")

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

== べき零行列のべきの特徴付け

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

== べき零行列の Jordan 標準形

#theorem(number: "6.3")[
  $N in M_n (CC)$ がべき零行列ならば、ある正則な $P in M_n (CC)$ が存在し、
  $
    P^(-1) N P = dmat(J(0; m_1), J(0; m_2), dots.down, J(0; m_r)).
  $
]
