---
title: "Running"
date: 2021-01-05
categories: running
---

## Training

I have a Julia script to generate a (somewhat naïve) training program for the year.
It's a mess and the comments are probably inaccurate.
I'll clean it up soon.
I'll probably also rewrite in Python because I can't quit Python.

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
    miles[1, :] = mon + wed + fri
    miles[2, :] = mon + wed + fri + sat
    miles[3, :] = mon + wed + fri + 2sat

    "Protocol: go up 2 more miles at 1/2 mile/week, then pull everything up by a half mile a week"
    "Recovery run is 1 mile less than normal runs"
    "Once everything is pulled up, hold for 2 more weeks, then pull back 2 miles on the long run"

    "Basically we want to get Saturday to 2sum(week[[1 3 5]] / 3)"
    hold = 0
    for k in 4:52
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
One of my [goals](/about/#my-goals) is to run 730 miles this year and I mean to log each and every one of them.

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
| 2021-01-01 14:40 | 1.00     | 10:07        | 0.099 | 1.00                | Chilly (32°), light precipitation | OK          |