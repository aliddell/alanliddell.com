---
title: "Running"
date: 2021-05-11
categories: running
---

## Training

I have a Julia script to generate a (somewhat naïve) training program for a year.

```julia
"""
The training protocol is based around the (long) Saturday run.
The cycle begins by increasing the Saturday run by 2 miles from the previous equilibrium at a
rate of 0.5 miles/week, for a total of 4 weeks.
Then Monday is brought up a mile the next week, then Friday the following week,
then Sunday comes up a half mile, then Wednesday comes up a mile.
At this point, eight weeks have passed, and the MWF runs are each half the
distance of the Saturday run, while the Sunday run is half the distance of the MWF runs.

For example, if starting at a schedule of

Sun: 0.5, Mon: 1, Wed: 1, Fri: 1, Sat: 2

the next 8 weeks look like:

Sun: 0.5, Mon: 1, Wed: 1, Fri: 1, Sat: 2.5
Sun: 0.5, Mon: 1, Wed: 1, Fri: 1, Sat: 3
Sun: 0.5, Mon: 1, Wed: 1, Fri: 1, Sat: 3.5
Sun: 0.5, Mon: 1, Wed: 1, Fri: 1, Sat: 4
Sun: 0.5, Mon: 2, Wed: 1, Fri: 1, Sat: 4
Sun: 0.5, Mon: 2, Wed: 1, Fri: 2, Sat: 4
Sun: 1, Mon: 2, Wed: 1, Fri: 2, Sat: 4
Sun: 1, Mon: 2, Wed: 2, Fri: 2, Sat: 4

You hold at this point for two weeks.

Every 13 weeks, you take 80% of what you did the previous week,
then round to the nearest half mile.
This is to allow for a quarterly recovery.
"""
function makemiles()
    mon = [1 0 0 0 0 0 0]
    wed = [0 0 1 0 0 0 0]
    fri = [0 0 0 0 1 0 0]
    sat = [0 0 0 0 0 1 0]
    sun = [0 0 0 0 0 0 1]

    miles = zeros(52, 7)
    miles[1, :] = 0.5sun + mon + wed + fri + 2sat

    for week = 2:52

        cycle = (week - 1) % 10

        basevalue = miles[week - 1, :]

        if week % 13 ≠ 0 # a normal week
            if cycle ∈ (1, 2, 3, 4)
                miles[week, :] = basevalue + 0.5sat'
            elseif cycle == 5
                miles[week, :] = basevalue + mon'
            elseif cycle == 6
                miles[week, :] = basevalue + fri'
            elseif cycle == 7
                miles[week, :] = basevalue + 0.5sun'
            elseif cycle == 8
                miles[week, :] = basevalue + wed'
            else cycle == 9 # cycle ∈ (9, 10) are holds
                miles[week, :] = basevalue
            end
        else # quarterly recovery
            recovery = 
            # round to the nearest half mile
            recovery = map(x -> begin
                if abs(x - floor(x)) < abs(x - (floor(x) + 0.5)) # x is closer to floor(x)
                    floor(x)
                else
                    floor(x) + 0.5
                end
            end, 0.8basevalue)

            miles[week, :] = recovery
        end
    end

    miles
end

```

As you can see, as of May 11, I haven't followed this program at all.
But now that the script is cleaned up and the protocol is improved, I will!
I'll let you know how it goes.

## Log

This is a log of all the running I've done this year.
One of my [goals](/about/#my-goals) is to run ~~730~~ 435 miles this year and I mean to log each and every one of them.
I gather all my data using my Garmin Forerunner 35.
My Garmin Connect profile is [here][gc-profile].
Add me if you want to keep up!

### Description

- **Date/Time**: Date and time the run started, local time.
- **Distance**: The distance run (in miles), truncated at the hundredths place.
- **Running Time**: The length of time spent running, formatted mm:ss.
- **Pace**: Average pace (minutes/mile) over the whole run, rounded to the thousandths place.
- **Cumulative Distance**: The distance run (in miles) over the entire year, computed by simply summing the **Distance** column.
  (This might incur some small error as time goes by, but since each distance observation is always rounded down, the cumulative distance is a pessimistic estimate.)
- **Weather**: Qualitative description of the weather with temperature in °F.
- **Disposition**: How I feel before, during, and/or after the run.
  If there's pain or injury, I note it here.

### Data


|    Date/Time     | Distance | Running Time | Pace  | Cumulative Distance | Weather                           | Disposition |
|:----------------:|:--------:|:------------:|-------|---------------------|-----------------------------------|-------------|
| 2021-01-01 14:40 | 1.00     | 10:07        | 10:07 | 1.00                | Chilly (32°), light precipitation | OK          |
| 02021-04-05 19:44| 2.02     | 35:38        | 17:37 | 3.02                | Warm (72°)                        | Relaxed     |
| 02021-04-06 19:44| 2.09     | 35:52        | 17:10 | 5.11                | Warm (70°)                        | Relaxed     |
| 02021-04-07 19:44| 2.01     | 35:08        | 17:31 | 7.12                | Warm (77°)                        | Relaxed     |
| 02021-04-19 19:44| 1.68     | 24:27        | 20:15 | 8.8                 | Cool (55°)                        | Motivated   |
| 02021-04-23 16:47| 1.01     | 9:53         | 9:48  | 9.81                | Cool (57°)                        | Energized   |
| 02021-04-26 07:37| 1.57     | 24:27        | 12:45 | 11.38               | Pleasant (66°), clear             | Motivated   |
| 02021-04-28 07:05| 1.68     | 20:04        | 11:57 | 13.06               | Pleasant (70°), cloudy            | Motivated   |
| 02021-05-13 06:06| 1.01     | 10:41        | 10:35 | 14.07               | Chilly (34°), clear               | Reluctant, some pain   |

[gc-profile]: https://connect.garmin.com/modern/profile/6c222f05-ac98-4ead-be9c-781ed50dce85
