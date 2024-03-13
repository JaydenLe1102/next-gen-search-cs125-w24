



def convertSecondsToFloatingHours(seconds): 
  return seconds / 3600

def getExerciseDuration(energy_level):
  if energy_level == "Beginner":
    return 30
  elif energy_level == "Intermediate":
    return 60
  elif energy_level == "Advanced":
    return 120
  
def getExerciseDurationNumber(energy_level):
  if energy_level == "Beginner":
    return 1
  elif energy_level == "Intermediate":
    return 2
  elif energy_level == "Advanced":
    return 3
  
def getGenderNumber(gender):
  if gender == "Male":
    return 0
  else:
    return 1
  
  
def convertLbsToKilogram(weightInLbs):
  return 0.453592 * weightInLbs

def getExerciseDateYesterday(createdDate, todayDate):
  days_difference = (todayDate - createdDate).days

  if days_difference <= 0:
    return 1 

  cycle_day = days_difference % 7
  
  if (cycle_day == 0):
    return 7

  return cycle_day - 1


def calculateExerciseScore(createdDate, todayDate, user_info):
  
  print("hello world")
  if (todayDate == createdDate):
      return 10

  exerciseDate = getExerciseDateYesterday(createdDate, todayDate)
  
  exerciseDateString = "day_" + str(exerciseDate)
  
  exercisePlan = user_info["exercisePlan"]

  totalCalories = 0
  for exercise in exercisePlan[exerciseDateString]:
      totalCalories += exercise["calories_burned"]
      
  calories_burned_yesterday = user_info["calories_burn_yesterday"]
  
  maxScore = 10
  
  if (totalCalories == 0) or (calories_burned_yesterday > totalCalories):
      return 10
  else:
      score = (calories_burned_yesterday / totalCalories) * maxScore
      return score