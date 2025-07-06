#import "@preview/numbly:0.1.0": numbly
#import "@preview/unify:0.7.1": * // 单位
#import "@preview/pinit:0.2.2": * // 相对脚注
#import "@preview/cetz:0.4.0": * // 绘图
#import "@preview/fletcher:0.5.8": * // 优雅的箭头
#import "@preview/tablem:0.2.0": tablem, three-line-table // markdown-like tables
#import "@preview/cheq:0.2.2": * // markdown-like checklist
#import "@preview/zero:0.3.3": * // 科学数字表示法
#import "@preview/showybox:2.0.4": showybox
#import "@preview/ctheorems:1.1.3": *
#import "@preview/zebraw:0.5.5": * // 代码块
#import "@preview/physica:0.9.5": * // 物理专用数学公式
#import "@preview/mitex:0.2.5": * // 输出tex代码
#import "@preview/cmarker:0.1.5": render as cmarker-render
#import "@preview/theorion:0.3.3": *
// theorion公式相关设置
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *

#let md = cmarker-render.with(math: mitex)

#let default-font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif SC",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)



// 主题自适应的代码框
#let frame-dark = block.with(fill: rgb("#27292c"), inset: (x: 8pt, y: 4pt), radius: 4pt)
#let frame-light = block.with(fill: rgb("#f0f0f0"), inset: (x: 8pt, y: 4pt), outset: (y: 4pt), radius: 4pt)

// 脚注强调
#let crimson = rgb("#c00000")
#let redbold(body) = {
  set text(fill: crimson, weight: "bold")
  body
}


// Definitions for math
#let prox = math.op("prox")
#let proj = math.op("proj")
#let argmax = math.op("argmax", limits: true)
#let argmin = math.op("argmin", limits: true)


/// 模板的核心类，规范了文档的格式。
/// - media (string): 媒体类型，可选值为 `"screen"` 和 `"print"`。默认为 `"print"`。
/// - theme (string): 主题，可选值为 `"light"` 和 `"dark"`。默认为 `"light"`。
/// - size (length): 字体大小。默认为 `11pt`。
/// - screen-size (length): 屏幕字体大小。默认为 `11pt`。
/// - title (string): 文档的标题。
/// - short-title (string) ：文档的短标题。
/// - authors (string): 作者，实际上是一个字典。
/// - subject (string): 课程名。（已删除）
/// - semester (string): 学期。
/// - date (datetime): 创建日期。
/// - bibliography-file (string): 参考书目文件路径及引用样式。
/// - accent : 主题色，将会设置一级标题，表格，`strong`的颜色
/// - font (object): 字体。默认为 `default-font`。如果你想使用不同的字体，可以传入一个字典，包含 `main`、`mono`、`cjk`、`math` 和 `math-cjk` 字段。
/// - lang (string): 语言。默认为 `zh`。
/// - region (string): 地区。默认为 `cn`。
/// - body (content): 文档的内容。
/// -> content
#let ori(
  media: "print",
  theme: "light", //fix the bug
  size: 11pt,
  screen-size: 11pt,
  title: none,
  short-title: none,
  description: none,
  authors: (),
  affiliations: (),
  //subject已删除
  semester: none,
  date: none,
  bibliography-file: none,
  bibstyle: "gb-7714-2015-numeric",
  paper-size: "a4",
  accent: "#000000",
  font: default-font,
  lang: "zh",
  region: "cn",
  first-line-indent: (amount: 0pt, all: false),
  maketitle: false,
  makeoutline: false,
  outline-depth: 2,
  cover-image: none,
  background-color: none,
  body,
) = {
  // theorion公式相关设置
  import cosmos.fancy: *
  // import cosmos.rainbow: *
  // import cosmos.clouds: *
  show: show-theorion

  show: thmrules
  // 使用 zebraw 调整代码块
  show: zebraw
  show: zebraw-init.with(
    background-color: if theme == "dark" {
      // 深色：四色斑马
      (rgb("#2b2d30"), rgb("#2f3134"), rgb("#2b2d30"), rgb("#333639"))
    } else {
      // 亮色：单一浅灰
      rgb("#f5f5f5")
    },
    lang-color: if theme == "dark" { rgb("#2b2d30") } else { teal },
    indentation: 2, // 每 2 个空格一根缩进线
    numbering: true, //是否有行号
    highlight-color: if theme == "dark" { rgb("#44475a") } else { rgb("#eaf2ff") }, // 高亮颜色
  )
  // show: zebraw.with(..zebraw-themes.zebra-reverse)
  // show: zebraw.with(..zebraw-themes.zebra)
  let accent-color = rgb(accent)

  assert(media == "screen" or media == "print", message: "media must be 'screen' or 'print'")
  assert(theme == "light" or theme == "dark", message: "theme must be 'light' or 'dark'")
  let page-margin = if media == "screen" { (x: 35pt, y: 35pt) } else { auto }
  let text-size = if media == "screen" { screen-size } else { size }
  let bg-color = if theme == "dark" { rgb("#1f1f1f") } else { rgb("#ffffff") }
  let text-color = if theme == "dark" { rgb("#ffffff") } else { rgb("#000000") }
  let raw-color = if theme == "dark" { rgb("#27292c") } else { rgb("#f0f0f0") }
  let font = default-font + font


  /// 设置字体。
  set text(
    font: ((name: font.main, covers: "latin-in-cjk"), font.cjk),
    size: text-size,
    fill: text-color,
    lang: lang,
    region: region,
  )
  // 设置中文粗体
  show strong: set text(fill: accent-color, font: ((name: font.main, covers: "latin-in-cjk"), font.cjk))

  show emph: text.with(font: ((name: font.main, covers: "latin-in-cjk"), font.emph-cjk))
  show raw: set text(font: ((name: font.mono, covers: "latin-in-cjk"), font.cjk))
  // 数学公式的字体
  show math.equation: it => {
    set text(font: font.math)
    it
  }
  show math.text: set text(
  // 数学公式中引入的中文字的字体
  font: ((name: font.main, covers: "latin-in-cjk"), font.cjk),
  // size: 1em,         
)
  // 文本高亮
  set highlight(fill: accent-color.lighten(50%))

  /// 设置段落样式。
  set par(justify: true, first-line-indent: if first-line-indent == auto {
    (amount: 2em, all: true)
  } else {
    first-line-indent
  })
  // 计数器
  let chaptercounter = counter("chapter")
  /// 设置标题样式。
  show heading: it => {
    show h.where(amount: 0.3em): none
    it
    if it.level == 1 and it.numbering != none {
      chaptercounter.step()
      counter(math.equation).update(0)
    }
  }
  show heading: set block(spacing: 1.2em)

  /// 设置代码块样式。
  show raw.where(block: false): body => box(
    fill: raw-color,
    inset: (x: 3pt, y: 0pt),
    outset: (x: 0pt, y: 3pt),
    radius: 2pt,
    {
      set par(justify: false)
      body
    },
  )
  // show raw.where(block: true): body => block(
  //   width: 100%,
  //   fill: raw-color,
  //   outset: (x: 0pt, y: 4pt),
  //   inset: (x: 8pt, y: 4pt),
  //   radius: 4pt,
  //   {
  //     set par(justify: false)
  //     body
  //   },
  // )

  // 配置行内代码块
  // show raw.where(
  //   block: false,
  // ): it => box(fill: luma(245), inset: (x: 2pt), outset: (y: 3pt), radius: 1pt)[#it]

  // show raw.where(block: true): it => sourcecode[#it]


  /// 将链接设置蓝色并加下划线，并且对于作者列表禁用此设置
  show link: it => {
    let author-names = ()
    for author in authors {
      author-names.push(author.name)
    }

    if it.body.has("text") and it.body.text in author-names {
      it
    } else {
      underline(stroke: (dash: "densely-dotted"), text(fill: blue, it))
    }
  }


  show image.where(format: auto): it => {
    if theme == "dark" {
      box(fill: rgb("#707580"), inset: 2pt, radius: 2pt)[#it]
    } else { it }
  }


  /// 设置 figure 样式。
  show figure.where(kind: table): set figure.caption(position: top)

  /// 设置列表样式。
  set list(indent: 6pt)
  set enum(indent: 6pt)
  set enum(numbering: numbly("{1:1}.", "{2:1})", "{3:a}."), full: true)

  /// 设置引用样式。
  set bibliography(style: "ieee")

  /// 设置文档元数据
  set document(title: title, author: authors.map(author => author.name), date: date)

  // 配置公式的编号和间距
  set math.equation(numbering: (..nums) => (
    context {
      numbering("(1.1)", chaptercounter.at(here()).first(), ..nums)
    }
  ))

  // 配置图像和图像编号
  set figure(numbering: (..nums) => context {
    numbering("1.1", chaptercounter.at(here()).first(), ..nums)
  })


  // 配置表格（不能用if{}，因使用if{}后作用域仅局限在块里，无法影响body）
  set table(
    fill: (_, row) => if row == 0 { accent-color.lighten(60%) } else { accent-color.lighten(80%) },
    stroke: 1pt + white,
  ) if theme == "light"

  set table.vline(stroke: 1pt + white) if theme == "dark"
  set table.hline(stroke: 1pt + white) if theme == "dark"


  /// 重置页面计数器。
  counter(page).update(1)
  /// 设置页面。
  set page(
    paper: paper-size,
    header: context {
      if here().page() == 1 {
        return
      }
      // 获取正确的章节标题
      let elems = query(heading.where(level: 1).after(here()))

      let chapter-title = ""

      if (elems == () or elems.first().location().page() != here().page()) {
        let elems = query(heading.where(level: 1).before(here()))
        if (elems != ()) { chapter-title = elems.last().body }
      } else {
        chapter-title = elems.first().body
      }
      // 修改页眉为 章节标题  short-title  semester
      // 其中章节标题和 semester奇偶轮换，若无短标题(short-title)，就使用标题(title)
      let head-title = text()[
        #if short-title != none {
          short-title
        } else {
          title
        }
      ]
      let (lefthead, midhead, righthead) = if calc.even(here().page()) == true {
        (chapter-title, head-title, semester)
      } else { (semester, head-title, chapter-title) }

      set text(0.9em)
      stack(
        spacing: 0.2em,
        grid(
          columns: (1fr, 1fr, 1fr),
          gutter: 0pt,
          align(left, lefthead), align(center, midhead), align(right, righthead),
        ),
        v(0.3em),
        line(length: 100%, stroke: 1pt + text-color),
        v(.15em),
        line(length: 100%, stroke: .5pt + text-color),
      )

      // reset footnote counter
      counter(footnote).update(0)
    },
    footer: context {
      if here().page() == 1 { return }
      [
        #if calc.even(here().page()) == true {
          align(left)[#counter(page).display("1 / 1", both: true)]
        } else {
          align(right)[#counter(page).display("1 / 1", both: true)]
        }
      ]
    },
    fill: bg-color,
    // 封面图片和背景图片
    background: context {
      if here().page() == 1 and cover-image != none {
        block(width: 100%, height: 100%)[#image(cover-image, width: 100%, height: 100%)]
      } else if background-color != none {
        block(width: 100%, height: 100%, fill: rgb(background-color))
      }
    },

    // numbering: "1 / 1",
    margin: page-margin,
  )

  /// 标题页。
  if maketitle {
    // Title page
    box(width: 100%, height: 40%)[
      #align(center + bottom)[
        // #v(20%)
        // #text(2em, weight: 500, subject)
        // #v(2em, weak: true)
        // #text(2em, weight: 500, title)
        // #v(2em, weak: true)

        #box(width: 100%, height: 40%)[
          // 显示论文的标题和描述。
          #align(center + bottom)[
            #text(36pt, weight: "bold")[#title]
            #parbreak()
            #if description != none {
              text(size: 16pt, style: "italic")[#description]
            }
          ]
        ]


        // #authors.name
      ]
    ]
    box(width: 100%, height: 40%)[
      #align(center + top)[
        #if authors.len() > 0 {
          box(inset: (y: 10pt), {
            authors
              .map(author => {
                text(16pt, weight: "semibold")[
                  #if "homepage" in author {
                    [#link(author.homepage)[#author.name]]
                  } else { author.name }]
                if "affiliations" in author {
                  super(author.affiliations)
                }
                if "github" in author {
                  link(author.github, box(height: 1.1em, baseline: 13.5%)[#image.decode(githubSvg)])
                }
              })
              .join(", ", last: {
                if authors.len() > 2 {
                  ", and"
                } else {
                  " and"
                }
              })
          })
        }
        #v(-2pt, weak: true)
        #if affiliations.len() > 0 {
          box(inset: (bottom: 10pt), {
            affiliations
              .map(affiliation => {
                text(12pt)[
                  #super(affiliation.id)#h(1pt)#affiliation.name
                ]
              })
              .join(", ")
          })
        }
      ]
    ]
    // v(9em)
    box(width: 100%)[
      #align(center + top)[
        #if date != none {
          text(size: 12pt, "最初写作于：")
          text(size: 12pt, fill: accent-color, weight: "semibold", date.display("[year]年[month]月[day]日"))
          parbreak()
          text(size: 12pt, "最后更新于：")
          text(size: 12pt, fill: accent-color, weight: "semibold", datetime.today().display("[year]年[month]月[day]日"))
        } else {
          (
            text(size: 11pt)[最后更新于：#h(5pt)]
              + text(size: 11pt, fill: accen-color, weight: "semibold", datetime
                .today()
                .display("[month repr:long] [day padding:zero], [year repr:full]"))
          )
        }
      ]

    ]
    pagebreak(weak: true)
  }

  /// 目录。
  if makeoutline {
    show heading: align.with(center)
    show outline.entry: set block(spacing: 1.2em)

    outline(depth: outline-depth, indent: 2em)
    pagebreak(weak: true)
  }


  // /// 行间代码块
  // show raw.where(block: true): code => sourcecode(
  //   frame: f => if theme == "dark" { frame-dark(f) } else { frame-lig1ht(f) },
  //   numbers-step: 1,
  //   numbers-side: left,
  //   gutter: 10pt,
  // )[#code]


  // 行内代码块

  // show raw.where(block: false): code => sourcecode(
  //   numbers-side: none, // 不要行号

  //   frame: f => box(
  //     fill: if theme == "dark" { rgb("#27292c") } else { rgb("#f0f0f0") },
  //     inset: (x: 2pt, y: 0pt),
  //     radius: 1pt,
  //     [#f], // ← 把变量 f 插入内容，用 # 前缀
  //   ),
  // )[#code]


  body
  // 显示参考文献
  if bibliography-file != none {
    pagebreak()
    show bibliography: set text(10.5pt)
    bibliography(bibliography-file, title: "参考文献", style: bibstyle) // apply bibstyle here.
  }
}


