#import "small-calendar.typ": small-calendar
#import "big-calendar.typ": big-calendar

// Accept both plain strings ("October") and text content ([October]).
#let input-text(value) = {
  if type(value) == str {
    value.trim()
  } else {
    assert(
      type(value) == content and value.has("text"),
      message: "Use plain text such as [October], [2026], or quoted strings.",
    )
    value.text.trim()
  }
}

// Date arithmetic handles leap years and December/January automatically.
#let month-info(date) = {
  let first = datetime(year: date.year(), month: date.month(), day: 1)
  let following = first + duration(days: 32)
  let next-first = datetime(
    year: following.year(), month: following.month(), day: 1,
  )
  (
    month: first.display("[month repr:long]"),
    year: str(first.year()),
    first-weekday: first.weekday() - 1,
    days-in-month: (next-first - duration(days: 1)).day(),
  )
}

#let calendar-data(month, year) = {
  let month-names = (
    "january", "february", "march", "april", "may", "june",
    "july", "august", "september", "october", "november", "december",
  )
  let month-name = lower(input-text(month))
  let month-index = month-names.position(name => name == month-name)
  assert(month-index != none, message: "Provide a full English month name.")
  let first = datetime(
    year: int(input-text(year)), month: month-index + 1, day: 1,
  )
  (
    previous: month-info(first - duration(days: 1)),
    current: month-info(first),
    next: month-info(first + duration(days: 32)),
  )
}

#let calendar(month, year) = {
  let dates = calendar-data(month, year)
  let current = dates.current

  set page(
    paper: "a4",
    margin: 0.5in,
    flipped: true,
  )

  set text(
    font: "Helvetica Neue",
    // size: 12pt,
    // weight: "bold",
  )

  let extra-margin = 0.15in

  grid(
    columns: (auto, 1fr),
    rows: (extra-margin, auto, 0.2in, 1fr),
    align: (left, right),
    grid.cell(colspan: 2, []),
    text(
      size: 24pt,
      weight: "bold",
      [#current.month #current.year],
    ),
    grid(
      columns: 3,
      column-gutter: 12pt,
      ..(dates.previous, current, dates.next).enumerate().map(((index, date)) => {
        small-calendar(
          date.month,
          date.year,
          date.first-weekday,
          date.days-in-month,
          index == 1,
        )
      }),
    ),
    grid.cell(colspan: 2, []),
    grid.cell(
      colspan: 2,
      big-calendar(
        current.first-weekday,
        current.days-in-month,
        previous-month-days: dates.previous.days-in-month,
      ),
    ),
  )
}
