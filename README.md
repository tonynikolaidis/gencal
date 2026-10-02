# Gencal – Generate Monthly Calendars

A printable monthly calendar built with Typst, with a large writing grid and small calendars for the previous, current, and next months. Weekdays, month lengths, leap years, and row counts are calculated automatically.

![Example monthly calendar](example.png)

## Compile a calendar

Typst and Python 3 are required. Run this command from the project folder,
replacing the month, year, and output filename. The helper automatically includes
`events.json` when it exists and compiles an empty calendar when it is absent:

```bash
python3 compile.py --input month=MONTH --input year=YEAR OUTPUT.pdf
```

For example, to generate October 2026:

```bash
python3 compile.py --input month=October --input year=2026 october-2026.pdf
```

Use a full English month name. The resulting PDF is saved to the specified output path.

Direct `typst compile calendar.typ OUTPUT.pdf` also works without any events file.
To include events with the direct command, add `--input events=events.json`.
Typst cannot check whether an optional file exists, so automatic detection is
handled by `compile.py`.

## Events

When supplied, `calendar.typ` reads the events file and displays only events in the selected month,
ordered by start time, with all-day events first. Each entry has a `date`
(`YYYY-MM-DD`) and `title`. Add `time` (`HH:MM`) for a timed event, or omit it
for an all-day event. Times are local calendar times.

```json
[
  { "date": "2026-10-05", "title": "Study day" },
  { "date": "2026-10-05", "time": "09:00", "title": "Maths for Finance" }
]
```

The October 2026 entries were transcribed from the supplied Outlook screenshot.
Course names use the supplied full names. The October 1 event at 13:30 has an
incomplete title because the screenshot truncates it. End times and recurrence
rules were not visible; these entries are individual dated events.
