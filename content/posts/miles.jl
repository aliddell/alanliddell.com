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

"""Cycle:

Week 1: add a half mile to Wednesday
Week 2: add a half mile to Monday
Week 3: add a half mile to Saturday
Week 4: add a half mile to Friday
Week 5: add a half mile to Sunday
Week 6: add a half mile to Saturday
Weeks 7-9: hold
"""