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
    title: [§22. 商空間],
    subtitle: [輪講 \#10],
    date: datetime.today(),
  ),
)


#set text(font: "Noto Sans CJK JP", size: 20pt)

#show "、": "，"
#show "。": "．"

#set heading(numbering: none)

#title-slide()

== 同値関係

/ Motivation: まず、一般の集合に対して商集合を定義する。

#definition[
  集合 $X$ 上の*二項関係*とは、$X^2$ の部分集合 $R$ のことである。

  $(x, y) in R$ のことを $x ~ y$ などと略記することもある。
]

#definition[
  集合 $X$ 上の二項関係 $~$ が*同値関係*であるとは、次が満たされるとき：
  / 反射律: $forall a in X, a ~ a.$
  / 対称律: $forall a, b in X, a ~ b => b ~ a.$
  / 推移律: $forall a, b, c in X, a ~ b and b ~ c => a ~ c.$
]

\

$X$ を空でない集合とする。
/ 例：自明な同値関係: 空でない集合 $X$ 上の二項関係 $R = X^2$ は同値関係。\ $~~>$ すべての $a, b in X$ について $a ~ b.$
/ 例：相当関係: 空でない集合 $X$ 上の二項関係 $R = {(x, x) | x in X}$ は同値関係。\ $~~> a ~ b <=> a = b.$
/ 例：有理数: $ZZ times (ZZ \\ {0})$ 上の二項関係 $R = {((m, n), (m', n')) | m n' = m' n}$ は同値関係。$~~> m/n = m'/n'$
  - （反射律）$(m, n)$ に対して $m n = m n$ だから $(m, n) ~ (m, n).$
  - （対称律）$m n' = m' n => m' n = m n'$ だから\ $(m,n) ~ (m', n') => (m', n') ~ (m, n).$
  - （推移律）$(m, n) tilde (m', n'), (m', n') tilde (m'', n'') => m n' = m' n, m' n'' = m'' n'$ であり、$m n'' = (n/n' m') (m''/m' n') = n m''.$

/ 例: $RR$ 上の二項関係 $<=$ は同値関係でない。$~~>$ 対称律に反する。

== 同値類

#definition[
  空でない集合 $X$ 上の二項関係 $~$ がある。$a in X$ に対して、$X$ の部分集合 $ C(a) = [a] = {x in X | a ~ x} $ を $a$ の*同値類* といい、各 $x in C(a)$ を $C(a)$ の*代表元*という。
]

#theorem[
  任意の $a in X$ に対して、$a in C(a).$ 特に $C(a)$ は空でない。
]

\

#theorem[
  次は互いに同値。
  #enum(numbering: "(a)")[ $a ~ b$][$C(a) = C(b)$][$C(a) inter C(b) != diameter$]
  #proof[
    / (a) $=>$ (b): $x in C(a)$ とすると $x ~ a.$ 推移律より $x ~ b.$ 逆も同様。
    / (b) $=>$ (c): 同値類は空でないことによる。
    / (c) $=>$ (a): $x in C(a) inter C(b)$ がとれて、$x ~ a, x ~ b$ が成立する。対称律と推移律より $a ~ b.$
  ]
]

/ Remark: $~$ による同値類全体は $X$ を互いに素な部分集合の和に分解する。

== 商集合

#definition[
  集合 $X$ 上の二項関係 $~$ に対して、$~$ による同値類全体は $X$ の分割になる。
  これを $~$ による $X$ の*商集合* といい、$X slash ~$ と書く。

  $x in X$ を $C(x) in X slash ~$ に対応させる全射 $pi: X -> X slash ~$ を*自然な射影*という。
]

== 部分集合による商空間

#theorem[
  線型空間 $V$ の部分空間 $W$ に対して、$x ~ y := (x - y in W)$ は\ $V$ 上の同値関係である。
  #proof[
    / 反射律: $x - x = 0 in W$ より $[x] = [x].$
    / 対称律: $x - y in W => y - x in W$ より $[x] = [y] => [y] = [x].$
    / 推移律: $x - y in W and y - z in W => x - z in W$ より $[x] = [y] and [y] = [z] => [x] = [z]$
  ]
]

/ Remark: $V slash ~$ を $V slash W$ と書く。

\

#theorem[
  線型写像 $+: V slash W times V slash W -> V slash W, dot: K times V slash W -> V slash W$ で、次の図式を可換にするものがただ一つ存在する。
  これにより $V slash W$ は線型空間をなし、これを*商空間*という。
  #align(
    center,
    grid(
      columns: 2,
      column-gutter: 4em,
      diagram($
        V times V edge("d", ->, pi times pi) edge(->, +) & V edge("d", ->, pi)\
        V slash W times V slash W edge(->, +) &V slash W
      $),
      diagram($
        K times V edge("d", ->, id_K times pi) edge(->, dot) & V edge("d", ->, pi)\
        V slash W times V slash W edge(->, dot) &V slash W
      $),
    ),
  )
  #proof[
    $x, y in V$ に対して $[x] + [y] = [x + y]$ と定義すると、$[x] = [x'], [y] = [y]$ なら $[x+y] = [x'+y']$ であることから、定理中の $+$ が well-defined であることが言える。
    $dot$ も同様。
  ]
]

== 商空間の次元

#theorem[
  $dim (V slash W) = dim V - dim W.$
  #proof[
    / $dim W = 0$ のとき: $V slash W = V$ だから成立。
    / $dim W = dim V$ のとき: $V = W$ だから成立。
    / $0 < dim W < dim V$ のとき: $W$ の基底 $x_1, dots.c, x_m$ を $x_(m+1), dots.c, x_n$ により延長して $V$ の基底とする。このとき、$[x_(m+1)], dots.c, [x_n]$ は一次独立である。実際、$sum_(m<i) c_i [x_i] = [0] => [sum_(m<i) c_i x_i] = [0] => sum_(m<i) c_i x_i in W$ だから $sum_(i<=m) c_i x_i = sum_(m<i) c_i x_i$ なる $(c_i)_(i <= m)$ が存在し、これは $V$ 上の一次関係式だから $c_i = 0 ("for" forall i)$ となる。また、$[x_(m+1)], dots.c, [x_n]$ は $V slash W$ を生成する。実際、$[x] in V slash W$ に対し $x in V$ より $x = sum_i c_i x_i$ なる $c_i in K$ がとれて、$x - sum_(m < i) c_i x_i = sum_(i<=m) c_i x_i in W$ より $[x] = [sum_(m < i) c_i x_i] = sum_(m<i) c_i [x_i]$ と書ける。$therefore (V slash W) = dim V - dim W.$
  ]
]

== 準同型定理

#theorem[
  線型写像 $f: V -> W$ について、$V slash Ker f tilde.eq Im f.$
  #proof[
    $[x] in V slash Ker f$ に対して $f(x) in Im f$ を対応させる線型写像 $[f]$ が well-defined であることと、同型であることを示す。

    まず、$[x] = [x']$ つまり $x - x' in Ker f$ なら $f(x) - f(x') = f(x - x') = 0$ となるから、$[f]$ は well-defined。

    また、次元定理より $dim V slash Ker f = dim V - dim Ker f = dim Im f$ だから $V slash Ker f tilde.eq Im f.$
  ]
]

/ Remark: 準同型定理はさらに一般化され、代数学のいたるところに登場する。
