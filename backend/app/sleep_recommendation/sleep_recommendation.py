from statistics import mean


def sleep_rec(age, sleepTimeYesterday):
    
    rec_range = []
    
    if age in range(0, 2):
        rec_range = list(range(14, 17))
    elif age in range(1, 3):
        rec_range = list(range(11, 14))
    elif age in range(3, 6):
        rec_range = list(range(10, 13))
    elif age in range(6, 14):
        rec_range = list(range(9, 11))  
    elif age in range(14, 18):
        rec_range = list(range(8, 11))
    elif age in range(18,26):
        rec_range = list(range(7, 10))
    elif age in range(26, 65):
        rec_range = list(range(7, 10))
    else:
        rec_range = list(range(7, 9))

        

    rec_hour = min(rec_range, key=lambda hour: abs(hour * 3600 - sleepTimeYesterday))
    
    
    return rec_range, rec_hour
     
        
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

    if sleep_track < recommend_sleep[0]:
        sleep_score = (sleep_track / mean(recommend_sleep)) *10
    elif sleep_track > recommend_sleep[-1]:
        difference = sleep_track - mean(recommend_sleep)
        sleep_score  = ((mean(recommend_sleep)-difference) / mean(recommend_sleep)) *10
    else:
        sleep_score= 10
        
    return sleep_score
