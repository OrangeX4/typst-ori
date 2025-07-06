#import "lib.typ": *

#set heading(numbering: numbly("{1:一}、", default: "1.1  "))

#show: ori.with(
  title: [Ori in Typst\ 文档标题],
  short-title: [Ori in Typst],
  // 笔记描述（选填）
  description: [
    文档描述示例\ 逸一时误一世，忆久忆久罢已龄
  ],
  // 笔记创建日期（选填）
  date: datetime(year: 2025, month: 6, day: 24),
  authors: (
    (
      name: "作者一",
      //github: "https://github.com/a-kkiri",
      //homepage: "https://github.com/a-kkiri",
      affiliations: "1,2",
    ),
    (
      name: "作者二",
      //github: "https://github.com/a-kkiri",
      //homepage: "https://github.com/a-kkiri",
      affiliations: "3,4",
    ),
  ),

  // 所属组织列表，每一项包括一个 id 和 name。这些将显示在作者下方。
  affiliations: (
    (id: "1", name: "114 University"),
    (id: "2", name: "514 Inc."),
    (id: "1", name: "1919 University"),
    (id: "2", name: "810 Inc."),
  ),
  // 学期
  semester: "2025 春",
  // 参考书目文件路径及引用样式
  bibliography-file: "refs.bib",
  bibstyle: "gb-7714-2015-numeric",
  // 是否生成标题和目录
  maketitle: true,
  makeoutline: true,
  // 主题色
  accent: blue,
  // 封面背景图片（选填图片路径或 none）
  // cover-image: "./figures/cover-image.png",
  // 正文背景颜色（选填 HEX 颜色或 none）
  background-color: "#FAF9DE",

  // theme: "dark", //此处有bug
  // media: "screen",
)

#include "content/charpter1.typ"
#include "content/charpter2.typ"