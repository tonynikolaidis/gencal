#import "template/calendar-template.typ": calendar

#show: _ => calendar(
  sys.inputs.at("month", default: "October"),
  sys.inputs.at("year", default: "2026"),
)
