#let event-text(cont) = {
  text(
    size: 6pt,
    weight: "regular",
    align(left, par(
      leading: 2pt,
      cont,
    )),
  )
}

#let event(ti, de) = {
  if (ti == none) {
    block(
      width: 100%,
      radius: 2pt,
      clip: true,
      inset: 2pt,
      fill: rgb("#CBCBCB"),
      event-text([#de])
    )
  } else {
    block(
      width: 100%,
      radius: 2pt,
      clip: true,
      grid(
        align: horizon,
        columns: (2pt, 1fr),
        grid.cell(fill: black, []),
        block(
          width: 100%,
          inset: 2pt,
          event-text([*#ti*#h(3pt)#de])
        ),
      ),
    )
  }
}