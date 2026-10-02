#import "template/calendar-template.typ": calendar

#let events-path = sys.inputs.at("events", default: "events.json")

#show: _ => calendar(
  sys.inputs.at("month", default: "October"),
  sys.inputs.at("year", default: "2026"),
  events: if events-path == none { () } else { json(events-path) },
)
