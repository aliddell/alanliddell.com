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
