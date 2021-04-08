---
title: "Running"
date: 2021-04-08
categories: running
---

## Training

I have a Julia script to generate a (somewhat naïve) training program for (the rest of) the year.
It's a mess and the comments are probably inaccurate.
I'll clean it up eventually.

```julia
function makemiles()
    mon = [1 0 0 0 0 0 0]
    tue = [0 1 0 0 0 0 0]
    wed = [0 0 1 0 0 0 0]
    thu = [0 0 0 1 0 0 0]
    fri = [0 0 0 0 1 0 0]
    sat = [0 0 0 0 0 1 0]
    sun = [0 0 0 0 0 0 1]

    miles = zeros(52, 7)
    miles[15, :] = mon + wed + fri
    miles[16, :] = mon + wed + fri + sat
    miles[17, :] = mon + wed + fri + 2sat

    "Protocol: go up 2 more miles at 1/2 mile/week, then pull everything up by a half mile a week"
    "Recovery run is 1 mile less than normal runs"
    "Once everything is pulled up, hold for 2 more weeks, then pull back 2 miles on the long run"

    "Basically we want to get Saturday to 2sum(week[[1 3 5]] / 3)"
    hold = 0
    for k in 18:52
        miles[k, :] .= miles[k - 1, :]

        week = miles[k, :]
        if 0 < hold < 3
            hold += 1
            if hold == 3 hold = 0 end
            continue
        end

        if week[1] == week[3] == week[5] # all running the same on MWF
            if week[6] == 2week[1]  # Saturday is twice the MWF mileage
                if week[7] < week[1] - 1
                    week[7] += 0.5
                    if week[7] == week[1] - 1
                        hold = 1
                    end
                else
                    week[3] += 0.5
                end
            else
                week[6] += 0.5
            end
        elseif week[3] > week[1]
            week[1] = week[3]
        else # week[1] > week[5]
            week[5] = week[3]
        end

        miles[k, :] .= week
        k += 1
    end

    miles
end
```

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

[gc-profile]: https://connect.garmin.com/modern/profile/6c222f05-ac98-4ead-be9c-781ed50dce85