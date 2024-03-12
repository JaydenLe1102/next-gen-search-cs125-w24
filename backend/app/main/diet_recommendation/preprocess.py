import pandas as pd
import numpy as np
import os

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
        # underweight
        print("Based on the BMI calculation: You are underweight -- Recommend Increase Weight to Maintain the Healthy Condition")
        return "underweight"
    elif ( bmi == 1):
        #healthy
        print
        return "Based on the BMI calculation: You are healthy -- -- Recommend Maintain Weight to Maintain the Healthy Condition"
    elif ( bmi == 0):
        #healthy
        return "Based on the BMI calculation: You are overweight -- Recommend Decrease Weight to Maintain the Healthy Condition"

def data_preprocess():
    basePath = os.path.dirname(__file__) 
    print(basePath)
    csvPath = os.path.join(basePath, 'dataset/recipes.csv')
    data  = pd.read_csv(csvPath)
    data = data.dropna(subset=['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images'])
    cook_time_list  = [i[2:] for i  in data["CookTime"]]
    #meal_label = categorize_meal(cook_time_list)
    data['CookTime'] = cook_time_list
    data = data[data['Calories'] != 0]
    #specify the important feature only --> include recipe, nutritions, food name 
    
    data['RecipeInstructions'] = data['RecipeInstructions'].apply(clean_instructions)
    data['Images'] = data['Images'].apply(get_images)
    
    return data

def clean_instructions(instructions):
    string = instructions.replace('\",', '')
    string = string.replace('\"', '')
    string = string.replace('c(', '')
    string = string.replace(')', '')
    return string

def get_images(text):
    text = text.replace('\"', '')
    text = text.replace('c(', '')
    text = text.replace(')', '')
    
    listText = text.split(', ')
    
    if len(listText) == 1 and listText[0] == "character(0":
        return "null"
    
    return listText[0]


def increase_weight(current_calories, desire_weight_gain):
    
    calories_per_kilogram = 7700

    # Calculate weekly and daily surplus
    weekly_surplus_calories = desire_weight_gain * calories_per_kilogram
    daily_surplus_calories = weekly_surplus_calories / 7
    target_calorie = current_calories + daily_surplus_calories
    # diverse the the probability of calories consumption of 3 meals accordingly 
    low_calorie  = target_calorie * 0.2
    mid_calorie = target_calorie * 0.35
    high_calorie = target_calorie * 0.45

    return low_calorie, mid_calorie, high_calorie


def decrease_weight(current_calories, desire_weight_decrease):
    
    calories_per_kilogram = 7700

    # Calculate weekly and daily surplus
    weekly_surplus_calories = desire_weight_decrease * calories_per_kilogram
    daily_surplus_calories = weekly_surplus_calories / 7
    target_calorie = current_calories - daily_surplus_calories
    #distribute the distribution between breakfast, lunch and dinner (20 - 40 - 40)
    low_calorie  = target_calorie * 0.2
    mid_calorie = target_calorie * 0.35
    high_calorie = target_calorie * 0.45

    return low_calorie, mid_calorie, high_calorie

#if maintain weight just get the needed calories
def maintain_weight(current_calories):
   
    #distribute the distribution between breakfast, lunch and dinner (20 - 40 - 40)
    low_calorie  = current_calories * 0.2
    mid_calorie = current_calories * 0.35
    high_calorie = current_calories * 0.45
    return low_calorie, mid_calorie, high_calorie


def diet_score(intake_calories, standard_calorie):
    print("intake cal", intake_calories)
    print("standard cal", standard_calorie)
    lower = standard_calorie * 0.8
    upper = standard_calorie * 1.2
    total_score = 10
    if intake_calories < lower or intake_calories > upper:
        total_score -= (abs(intake_calories - standard_calorie) / max(standard_calorie, intake_calories)) * 10
    return total_score
