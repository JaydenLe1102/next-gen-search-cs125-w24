



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