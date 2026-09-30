// Monday is 0 and Sunday is 6, as in small-calendar.
// Supply the previous month's length to show its trailing dates correctly.
#let big-calendar(
  first-weekday,
  days-in-month,
  previous-month-days: 31,
  width: 100%,
  height: 100%,
) = {
  let week-count = calc.ceil((first-weekday + days-in-month) / 7)
  let header-height = 16pt
  let week-height = (height - header-height) / week-count
  let weekdays = (
    [Monday], [Tuesday], [Wednesday], [Thursday],
    [Friday], [Saturday], [Sunday],
  )

  block(width: width, breakable: false)[
    #set par(leading: 0pt)
    #table(
      columns: (1fr,) * 7,
      rows: (header-height,) + (week-height,) * week-count,
      stroke: 0.5pt + black,
      inset: 1.5pt,
      align: right + top,
      table.header(
        ..weekdays.map(day => table.cell(
          stroke: none,
          align: center + horizon,
          text(size: 9pt, weight: "bold", day),
        )),
      ),
      ..range(week-count * 7).map(index => {
        let date = index - first-weekday + 1
        let in-month = date >= 1 and date <= days-in-month
        let label = if date < 1 {
          previous-month-days + date
        } else if date > days-in-month {
          date - days-in-month
        } else {
          date
        }

        table.cell(
          inset: (4pt),
          text(
            size: 9pt,
            weight: "bold",
            fill: if in-month { black } else { rgb("#B5B5B5") },
            str(label),
          ),
        )
      }),
    )
  ]
}
