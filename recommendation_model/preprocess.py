import pandas as pd
import numpy as np

def calc_bmr(weight, height, age, gender):
    #calculate bmr will allow us to further know if the 
    if gender == 0: #if the user is male
        bmr = 10*weight + 6.25*height - 5*age + 5
    else:
        bmr = 10*weight + 6.25*height - 5*age - 161
    return bmr 

def cacl_calories(bmr, exercise_duration):
    #we gonna calculate the needed caloried to be observed per day when 
    #wanting the maintaining weight

    # little to no exercise 
    if exercise_duration == 0:
        calories_per_day  = bmr * 1.2
    # light exercise --> 1 to 3 times per week
    elif exercise_duration == 1:
        calories_per_day  = bmr * 1.35
    elif exercise_duration == 2: #Moderate exercise 
        calories_per_day = bmr * 1.5
    else: #active/intense exercise 
        calories_per_day = bmr * 1.5
    
    return calories_per_day


def bmi_cal(weight, height):
    bmi = weight/((height/100)**2) 
    if ( bmi < 18.5):
        # you are underweight
        return 2
    elif ( bmi >= 18.5 and bmi < 25):
        #healthy
        return 1
    elif ( bmi >=25):
        #obesity
        return 0 

def bmi_result(bmi):
    if ( bmi == 2):
        # severly underweight
        return "Based on the BMI calculation: You are underweight -- Recommend Increase Weight to Maintain the Healthy Condition"
    elif ( bmi == 1):
        #underweight
        return "Based on the BMI calculation: You are healthy -- -- Recommend Maintain Weight to Maintain the Healthy Condition"
    elif ( bmi == 0):
        #healthy
        return "Based on the BMI calculation: You are overweight -- Recommend Decrease Weight to Maintain the Healthy Condition"
    
def categorize_meal(time_list):
    # Check if the total time is less than 30 minutes
    label = []
    for time in time_list: 
        #if it at the hour range, then put it as dinner 
        if "H" in time and "M" in time: 
            #print(time, "dinner")
            label.append(2)
        elif time[-1] == "H":
            #print(time,"dinner")
            if int(time[0:len(time)-1]) < 8:
                label.append(2)
            else:
                label.append(3) #if greater than 8 hrs, then not consider that food 
        elif time[-1] == "M":
            curr_min = time[0:len(time)-1]
            if int(curr_min)  < 20:
                #print(curr_min,"breakfast")
                label.append(0) #breakfast
            elif int(curr_min) >= 20 and int(curr_min) < 40:
                #print(curr_min,"lunch")
                label.append(1)
            elif int(curr_min) >= 40:
                #print(curr_min,"Dinner")
                label.append(2)
    return label

def data_preprocess():
    data  = pd.read_csv('./dataset/recipes.csv')
    data = data.dropna(subset=['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images'])
    cook_time_list  = [i[2:] for i  in data["CookTime"]]
    meal_label = categorize_meal(cook_time_list)
    data['CookTime'] = cook_time_list
    data["Meal Label"] = meal_label
    breakfast_data = data[data["Meal Label"]==0]
    lunch_data = data[data["Meal Label"]==1]
    dinner_data = data[data["Meal Label"]==2]
    #specify the important feature only --> include recipe, nutritions, food name 
    important_keys = [0,1,4,16,17,18,19,20,21,22,23,24,27]
    breakfast_data = breakfast_data.iloc[:,important_keys]
    lunch_data = lunch_data.iloc[:, important_keys]
    dinner_data = dinner_data.iloc[:, important_keys]
    return breakfast_data, lunch_data, dinner_data



def increase_weight(current_calories, desire_weight_gain):
    
    calories_per_kilogram = 7700

    # Calculate weekly and daily surplus
    weekly_surplus_calories = desire_weight_gain * calories_per_kilogram
    daily_surplus_calories = weekly_surplus_calories / 7
    target_calorie = current_calories + daily_surplus_calories
    
    # diverse the the probability of calories consumption of 3 meals accordingly 
    breakfast_target_calorie  = target_calorie * 0.2
    lunch_tagret_calorie = target_calorie * 0.35
    dinner_target_calorie = target_calorie * 0.45

    return breakfast_target_calorie, lunch_tagret_calorie, dinner_target_calorie


def decrease_weight(current_calories, desire_weight_decrease):
    
    calories_per_kilogram = 7700

    # Calculate weekly and daily surplus
    weekly_surplus_calories = desire_weight_decrease * calories_per_kilogram
    daily_surplus_calories = weekly_surplus_calories / 7
    target_calorie = current_calories - daily_surplus_calories
    
    #distribute the distribution between breakfast, lunch and dinner (20 - 40 - 40)
    breakfast_target_calorie  = target_calorie * 0.2
    lunch_tagret_calorie = target_calorie * 0.35
    dinner_target_calorie = target_calorie * 0.45

    return breakfast_target_calorie, lunch_tagret_calorie, dinner_target_calorie


#if maintain weight just get the needed calories
def maintain_weight(current_calories):

    
    #distribute the distribution between breakfast, lunch and dinner (20 - 40 - 40)
    breakfast_target_calorie  = current_calories * 0.2
    lunch_tagret_calorie = current_calories * 0.35
    dinner_target_calorie = current_calories * 0.45

    return breakfast_target_calorie, lunch_tagret_calorie, dinner_target_calorie