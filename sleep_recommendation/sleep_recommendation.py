from statistics import mean


def sleep_rec(age):
    if age in range(14, 18):
        return list(range(8, 11))
    elif age in range(18,26):
        return list(range(7, 10))
    elif age in range(26, 65):
        return list(range(7, 10))
    elif age >= 65:
        return list(range(7, 9))

def sleep_time(hours):
    start = [10,11]
    lower= hours[0]
    upper = hours[-1]

    print("Healthy Sleeping Hour Based on Age:")
    print(f"Based on Your Age Input, recommend to get a sleep hour between {lower}-{upper} hours per day")
    print(f'Recommend to sleep at {start[0]}PM and wake up between {(start[0]+lower)-12}AM - {(start[0]+upper)-12}AM')
    print(f'Recommend to sleep at {start[1]}PM and wake up between {(start[1]+lower)}AM - {(start[1]+upper)-12}AM')



def goodness_of_sleep(sleep_track, recommend_sleep):
    sleep_score = 0
    if sleep_track in recommend_sleep:
        sleep_score= 10
    elif sleep_track < recommend_sleep[0]:
        sleep_score = (sleep_track / mean(recommend_sleep)) *10
    elif sleep_track > recommend_sleep[-1]:
        difference = sleep_track - mean(recommend_sleep)
        sleep_score  = ((mean(recommend_sleep)-difference) / mean(recommend_sleep)) *10
    return sleep_score
