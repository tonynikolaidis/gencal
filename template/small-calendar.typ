#let small-calendar(month, year, first-weekday, days-in-month, current) = {
  let calendar-width = 90pt
  let week-height = 10pt
  let week-count = calc.ceil((first-weekday + days-in-month) / 7)

  let small-font = 7pt
  let row-gap = 2pt
  let days-gap = 1pt
  let month-gap = 6pt
  let stroke-width = 0pt

  let w = "bold"

  let smallDayStyle(t) = {
    text(size: small-font, weight: w, str(t))
  }

  let smallDay(day) = {
    table.cell(inset: (bottom: days-gap), text(size: small-font, weight: w, day))
  }

  let smallDays = ([M], [T], [W], [T], [F], [S], [S])

  // Clip each week as a single pill so adjacent cells have no seams.
  let week-row(week) = table.cell(colspan: 7)[
    #block(
      width: 100%,
      height: week-height,
      radius: 2pt,
      clip: true,
      stroke: (stroke-width + black),
    )[
      #table(
        columns: (1fr,) * 7,
        rows: week-height,
        stroke: none,
        inset: 0pt,
        align: center + horizon,
        ..range(7).map(day => {
          let date = week * 7 + day - first-weekday + 1
          let in-month = date >= 1 and date <= days-in-month

          table.cell(
            fill: if in-month and current { black } else { rgb("#CBCBCB") },
          )[
            #if in-month {
              text(
                fill: if (current) { white } else { black },
                size: small-font,
                weight: w,
                smallDayStyle(date),
              )
            }
          ]
        }),
      )
    ]
  ]

  block(width: calendar-width)[
    #set par(leading: 0pt)
    #table(
      columns: (1fr,) * 7,
      stroke: none,
      inset: 0pt,
      align: center + horizon,
      row-gutter: row-gap,
      table.header(
        table.cell(colspan: 7, inset: (bottom: month-gap))[
          #text(size: (small-font + 0pt), weight: w, [#month #year])
        ],
        ..smallDays.map(day => smallDay(day)),
      ),
      ..range(week-count).map(week-row),
    )
  ]
}
