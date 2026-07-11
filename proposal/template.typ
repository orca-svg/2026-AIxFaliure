// 1페이지 제안서 레이아웃/스타일. 내용(proposal.typ)과 분리해 git diff를 깔끔하게 유지한다.

#let accent = rgb("#c81e2c") // 가이드북 포인트 컬러(빨강) 참고

#let conf(
  title: "",
  subtitle: "",
  team: "",
  body,
) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin: (x: 1.6cm, y: 1.5cm),
    footer: context [
      #set text(size: 8pt, fill: gray)
      #line(length: 100%, stroke: 0.5pt + gray)
      #v(0.15cm)
      #team #h(1fr) #counter(page).display()
    ],
  )
  // 한글 본문 폰트. 로컬에 NanumGothic(나눔고딕)이 설치돼 있어야 컴파일된다.
  set text(font: "NanumGothic", size: 9.5pt, lang: "ko")
  set par(justify: true, leading: 0.55em)
  set heading(numbering: none)

  show heading.where(level: 1): it => [
    #v(0.3cm)
    #block(
      fill: accent,
      inset: (x: 6pt, y: 4pt),
      radius: 2pt,
      text(fill: white, weight: "bold", size: 11pt)[#it.body],
    )
    #v(0.15cm)
  ]

  // 제목부
  align(center)[
    #text(size: 17pt, weight: "bold")[#title] \
    #if subtitle != "" [
      #text(size: 10pt, fill: gray)[#subtitle]
    ]
  ]
  v(0.4cm)

  body
}

// 세 요소(예견된 실패/원인 진단/대응 방안) 공통 섹션 헬퍼
#let section(label, question, content) = [
  = #label
  #text(style: "italic", size: 8.5pt, fill: gray)[#question]
  #v(0.1cm)
  #content
]

// 인과 역추적 체인을 화살표 다이어그램으로 표현하는 헬퍼
// nodes: ("2026년 신호", "놓친 선택", ..., "2036년 실패") 형태의 문자열 배열
#let causal_chain(nodes) = {
  set text(size: 8.5pt)
  let n = nodes.len()
  box(width: 100%, stroke: 0.5pt + gray, inset: 8pt, radius: 3pt)[
    #align(center)[
      #for (i, node) in nodes.enumerate() [
        #box(fill: rgb("#f2f2f2"), inset: (x: 6pt, y: 4pt), radius: 2pt)[#node]
        #if i < n - 1 [ #h(4pt) #sym.arrow.r #h(4pt) ]
      ]
    ]
  ]
}
