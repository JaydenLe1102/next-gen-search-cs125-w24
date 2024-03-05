from flask import Flask, request, jsonify, render_template, session
import pickle 
from preprocess import calc_bmr, cacl_calories, bmi_cal, bmi_result, increase_weight, decrease_weight, data_preprocess, maintain_weight
from diet_rec import predict
#from diet_recommendation import data_preprocess, increase_weight, maintain_weight, decrease_weight

#create a flask app
app = Flask(__name__)
app.secret_key = '8888'
# load and read from pickle file 
model_breakfast = pickle.load(open("model_breakfast.pkl", "rb"))
model_lunch = pickle.load(open("model_lunch.pkl", "rb"))
model_dinner = pickle.load(open("model_dinner.pkl", "rb"))


@app.route("/")
def Home():
    return render_template("index.html")

@app.route("/information", methods = ["POST"])
def information():
    user_weight = float(request.form["weight"])
    user_height = float(request.form["height"])
    user_age = int(request.form["age"])
    user_gender = int(request.form["gender"])
    user_exercise_duration = int(request.form["exercise_duration"])

    bmi = bmi_cal(user_weight, user_height) #showing bmi as an additional information for user health
    bmr = calc_bmr(user_weight,user_height,user_age,user_gender) #bmr will allow to calculate the calories intake
    calories = cacl_calories(bmr, user_exercise_duration)

    bmi_show = bmi_result(bmi)

    session['calories'] = calories

    return render_template("user.html", bmi_show=bmi_show)

@app.route("/user_choice", methods=["POST"])
def user_choice():
    user_choice = int(request.form["user_choice"])

    #get the calories from the above through creating a session 
    calories = session.get('calories', 0)

    #if the user want to increase their weight then you gonna create another template for 
    #inputting the desire weight gain 
    if user_choice == 0:
        return render_template("increase_weight.html", calories=calories)
    elif user_choice == 1:
        return render_template("decrease_weight.html", calories=calories)
    elif user_choice == 2: #if want to maintain weight 
        breakfast, lunch, dinner = data_preprocess()
    
        breakfast_target_cal, lunch_target_cal, dinner_target_cal = maintain_weight(calories)
        rand_breakfast = predict(model_breakfast, breakfast_target_cal)
        rand_lunch = predict(model_breakfast, lunch_target_cal)
        rand_dinner = predict(model_breakfast, dinner_target_cal)
        
        nearest_neighbors_breakfast = breakfast.iloc[rand_breakfast[:5]]
        nearest_neighbors_lunch = lunch.iloc[rand_lunch[:5]]
        nearest_neighbors_dinner = dinner.iloc[rand_dinner[:5]]
    
        #turn to DataFrame
        top_breakfast = nearest_neighbors_breakfast[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
        top_lunch = nearest_neighbors_lunch[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
        top_dinner = nearest_neighbors_dinner[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
        return render_template("result.html", breakfast_choices=top_breakfast.to_dict(orient='records'),
                                    lunch_choices=top_lunch.to_dict(orient='records'),
                                    dinner_choices=top_dinner.to_dict(orient='records'))


@app.route("/increase_weight", methods=["POST"])
def increase_weight_form():
    # Retrieve desired weight gain from the form
    desired_weight_gain = float(request.form["desired_weight_gain"])
    # Retrieve calories from session
    calories = session.get('calories', 0)
    breakfast, lunch, dinner = data_preprocess()
    
    breakfast_target_cal, lunch_target_cal, dinner_target_cal = increase_weight(calories, desired_weight_gain)
    rand_breakfast = predict(model_breakfast, breakfast_target_cal)
    rand_lunch = predict(model_breakfast, lunch_target_cal)
    rand_dinner = predict(model_breakfast, dinner_target_cal)
    
    nearest_neighbors_breakfast = breakfast.iloc[rand_breakfast[:5]]
    nearest_neighbors_lunch = lunch.iloc[rand_lunch[:5]]
    nearest_neighbors_dinner = dinner.iloc[rand_dinner[:5]]
   
    #turn to DataFrame
    top_breakfast = nearest_neighbors_breakfast[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
    top_lunch = nearest_neighbors_lunch[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
    top_dinner = nearest_neighbors_dinner[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]

    return render_template("result.html", breakfast_choices=top_breakfast.to_dict(orient='records'),
                                   lunch_choices=top_lunch.to_dict(orient='records'),
                                   dinner_choices=top_dinner.to_dict(orient='records'))


@app.route("/decrease_weight", methods=["POST"])
def decrease_weight_form():
    # Retrieve desired weight loss from the form
    desired_weight_loss = float(request.form["desired_weight_loss"])
    # Retrieve calories from session
    calories = session.get('calories', 0)
    breakfast, lunch, dinner = data_preprocess()
    
    breakfast_target_cal, lunch_target_cal, dinner_target_cal = decrease_weight(calories, desired_weight_loss)
    rand_breakfast = predict(model_breakfast, breakfast_target_cal)
    rand_lunch = predict(model_breakfast, lunch_target_cal)
    rand_dinner = predict(model_breakfast, dinner_target_cal)
    
    nearest_neighbors_breakfast = breakfast.iloc[rand_breakfast[:5]]
    nearest_neighbors_lunch = lunch.iloc[rand_lunch[:5]]
    nearest_neighbors_dinner = dinner.iloc[rand_dinner[:5]]
   
    #turn to DataFrame
    top_breakfast = nearest_neighbors_breakfast[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
    top_lunch = nearest_neighbors_lunch[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]
    top_dinner = nearest_neighbors_dinner[['Name', 'CookTime', 'Calories', 'RecipeInstructions']]

    return render_template("result.html", breakfast_choices=top_breakfast.to_dict(orient='records'),
                                   lunch_choices=top_lunch.to_dict(orient='records'),
                                   dinner_choices=top_dinner.to_dict(orient='records'))



if __name__ == "__main__":
    app.run(debug=True)
