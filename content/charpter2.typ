#import "../lib.typ": *


= 使用

== 特殊参数

- `size`：字体大小，默认为 `11pt`；
- `screen-size`：屏幕字体大小，默认为 `11pt`；
- `maketitle`：是否生成标题页，默认为 `false`；
- `makeoutline`：是否生成目录，默认为 `false`；
- `outline-depth`：目录的深度，默认为 `2`；
- `first-line-indent`：首行缩进，如果设置为 `auto`，则会开启自动缩进，缩进量为 `2em`；
- `media`：媒体类型，可选值为 `"screen"` 和 `"print"`，前者边距较小，适合屏幕显示；后者边距较大，适合打印。默认值为 `"print"`；
- `lang`：语言，默认为 `"zh"`；
- `region`：地区，默认为 `"cn"`。

== 主题色示例
你可以配置 `accent` 为主题色，可选参数有 `orange` `blue` `olive` `red` `eastern` `yellow` `navy`
此颜色会改变
== 三线表

基于 #link("https://github.com/OrangeX4/typst-tablem")[*Tablem 包*]，提供了简单好用的三线表功能，如@three-line-table。



```typ
#figure(
  three-line-table[
    | Substance             | Subcritical °C | Supercritical °C |
    | --------------------- | -------------- | ---------------- |
    | Hydrochloric Acid     | 12.0           | 92.1             |
    | Sodium Myreth Sulfate | 16.6           | 104              |
    | Potassium Hydroxide   | 24.7           | <                |
  ],
  caption: "三线表示例"
) <three-line-table>
```

#figure(
  three-line-table[
    | Substance             | Subcritical °C | Supercritical °C |
    | --------------------- | -------------- | ---------------- |
    | Hydrochloric Acid     | 12.0           | 92.1             |
    | Sodium Myreth Sulfate | 16.6           | 104              |
    | Potassium Hydroxide   | 24.7           | <                |
  ],
  caption: "三线表示例",
) <three-line-table>

== Markdown 渲染



基于 #link("https://github.com/SabrinaJewson/cmarker.typ")[*Cmarker 包*] 和 #link("https://github.com/mitex-rs/mitex")[*MiTeX 包*]，支持 Markdown 渲染，包括数学公式，如：

`````typ
#md(````markdown
  支持 **加粗**、*斜体*、~~删除线~~、[链接](https://typst.com)、LaTeX 数学公式 $\max_{x \in X} f(x)$ 等 Markdown 语法。
````)
`````

#rect(
  width: 100%,
  md(
    ````markdown
      支持 **加粗**、*斜体*、~~删除线~~、[链接](https://typst.com)、LaTeX 数学公式 $\max_{x \in X} f(x)$ 等 Markdown 语法。
    ````,
  ),
)

== 定理环境

=== 定理目录

#outline(title: none, target: figure.where(kind: "theorem"))

== 基本定理环境

基于 #link("https://github.com/OrangeX4/typst-theorion")[*Theorion 包*]，我们可以创建@def:prime 、@thm:euclid 、@lemma  和@proposition  等定理环境。

#definition[
  A natural number is called a #highlight[_prime number_] if it is greater than 1
  and cannot be written as the product of two smaller natural numbers.
] <def:prime>

#definition[123]

#example[
  The numbers $2$, $3$, and $17$ are prime. As proven in @cor:infinite-prime,
  this list is far from complete! See @thm:euclid for the full proof.
] <example>

#proof[
  By contradiction: Suppose $p_1, p_2, dots, p_n$ is a finite enumeration of all primes.
  Let $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,
  it cannot be prime. Thus, some prime $p_j$ divides $P + 1$.
  Since $p_j$ also divides $P$, it must divide their difference $(P + 1) - P = 1$,
  a contradiction.
]

#corollary[
  There is no largest prime number.
] <cor:infinite-prime>

#theorem(title: "Euclid's Theorem")[
  There are infinitely many prime numbers.
] <thm:euclid>

#lemma[
  引理内容。
] <lemma>

#proposition[
  命题内容。
] <proposition>

#emph-box[
  强调内容。
]

#quote-box[
  引用内容。
]

#remark[
  注解内容。
]

#note-box[
  在快速浏览时也应该注意的重要信息。
]

#tip-box[
  帮助更好使用的可选建议信息。
]

#important-box[
  为了成功使用必须了解的关键信息。
]

#warning-box[
  可能存在风险，需要立即注意的关键信息。
]

#caution-box[
  可能带来负面后果的提醒信息。
]
== `unify` 单位包使用方法简介


== `pinit` 脚注包使用方法
=== 强调
在此放置脚注` #pin("h1")` #pin("h1")，可以强调此内容。#pin("h2") ` #pin("h2")`在此放置第二个脚注，然后在之后写`#pinit-highlight("h1","h2")` 即可
#pinit-highlight("h1","h2")




=== 画线
在此放置脚注` #pin("l1")` #pin("l1") ，可以画线。 \ #pin("l2") ` #pin("l1")`在此放置第二个脚注
然后在之后写\
`#pinit-line(stroke: 2pt + red, start-dy: -0.25em, end-dy: -0.25em, "l1", "l2")` 即可
#pinit-line(stroke: 2pt + red, start-dy: -0.25em, end-dy: -0.25em, "l1", "l2")

=== 脚注
这是一个问题？#pin("que")这是答案#pin("ans")，使用`#pinit-point-to()[]`和`#pinit-point-from()[]`即可
#pinit-point-to("que", fill: red, redbold[问题])

#pinit-point-from("ans", body-dx: +10pt)[
    答案
]
#linebreak()
=== 框
在此放置脚注` #pin("r1")` #pin("r1") 可以画框。  #pin("r2") ` #pin("r1")`在此放置第二个脚注\ 然后在之后写`#pinit-rect("r1","r2")` 即可
#pinit-rect("r1","r2")


= 自定义

== 标题编号

可以使用 `numbly` 包设置标题编号样式：

```typ
#set heading(numbering: numbly("{1:一}、", default: "1.1  "))
```

参数中，`{*:1}` 的 `*` 代表标题的级别，`1` 代表标题的格式。`{1:一}、` 代表一级标题的格式为 `一、`，并且设置了默认格式 `1.1  `。

*注意*，本模板默认去除了标题 numbering 后的空格，所以在设置标题编号时请注意空格的使用。如 `"1.1  "` 的末尾有两个空格，这样在标题编号后会有两个空格。

== 字体

先在终端 / 命令行输入 ```bash typst fonts``` 查看当前可用的字体，以在文档开头加入 `font` 参数修改字体设置以及使用的字体：

```typ
#let font = (
  main: "IBM Plex Sans",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif SC",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)

#show: ori.with(
  // ... 保持原有的参数
  font: font,
)
```
== 数学公式编号

为每个行间公式设置了公式编号，样式为 (a.b) ，其中a为章节号，b为该章公式序号
#theorem(title: "傅立叶级数的复数形式")[
  $f(x)$ 周期为 $2l$ ，且在每个周期内分段单调且有界（或者分段可导），则有
  $ f(x) tilde.eq sum_(n=-oo)^(+oo) F_n e^(i (n pi)/l x) $
  $ F_n= 1/(2l) integral_(-l)^l f(x) e^(-i (n pi)/l x) #text[数学公式中文字插入示例] $
  第一个式子不是等号，因为在间断点处级数收敛到间断点两断的平均值
]
数学公式中文字插入示例$ #text[情况a，b,c] cases(#text[方式一：测试文字],#text[方式二：测试文字?测试、顿号，逗号：冒号]) $
== 图像编号
惠更斯原理的表述：设 $S$ 为波源，在 $t$ 时刻由振源发处的波振动传播到了面 $Sigma$ 上，#highlight()[我们认为 S 上的每一面元都可以看作次波的波源]，由各个面元发出的次波将在 $t^prime$ 时刻形成一个新的次波面，这些次波面的包络面 $Sigma^prime$ 就是 $t^prime$ 时刻的波面。@zhaooptics2021
#grid(
  columns: (50%, 1fr),
  // 第一列50%宽度，第二列自动填充剩余空间
  gutter: 1em,
  // 列间距
  [
    #figure(image("../figures/prob1.svg", width: 80%, format:auto), caption: "惠更斯原理的示意图         " )
  ],
  [
    #figure(
      image("../figures/prob1-2.svg", width: 100%, format:auto),
      caption: "惠更斯原理的示意图",
    )
  ],
)
#important-box[你需要在`image` 中传入`format:auto`才能使得`dark`模式下自动添加底色]




