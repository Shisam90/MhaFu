from random import uniform
from model import recommend, output_recommended_recipes
import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import Literal
from functools import cache

app = FastAPI()

activity_plan = {
    "activities": [
        "Little/no exercise",
        "Light exercise",
        "Moderate exercise (3-5 days/wk)",
        "Very active (6-7 days/wk)",
        "Extra active (very active & physical job)",
    ],
    "weights": [1.2, 1.375, 1.55, 1.725, 1.9],
}

weight_loss_plan = {
    "plans": [
        "Maintain weight",
        "Mild weight loss",
        "Weight loss",
        "Extreme weight loss",
    ],
    "weights": [1, 0.9, 0.8, 0.6],
    "losses": ["-0 kg/week", "-0.25 kg/week", "-0.5 kg/week", "-1 kg/week"],
}


class UserData(BaseModel):
    gender: Literal["Male", "Female"]
    age: int = Field(None, ge=2, le=120)
    height: int = Field(None, ge=50, le=300)
    weight: int = Field(None, ge=10, le=300)
    activity: Literal[
        "Little/no exercise",
        "Light exercise",
        "Moderate exercise (3-5 days/wk)",
        "Very active (6-7 days/wk)",
        "Extra active (very active & physical job)",
    ]
    mealsPerDay: Literal[3]
    weightLossPlan: Literal[
        "Maintain weight",
        "Mild weight loss",
        "Weight loss",
        "Extreme weight loss",
    ]


@cache
def get_dataset():
    return pd.read_csv("dataset.csv", compression="gzip")


dataset = get_dataset()


def calculate_bmr(gender, weight, height, age):
    if gender == "Male":
        bmr = 10 * weight + 6.25 * height - 5 * age + 5
    else:
        bmr = 10 * weight + 6.25 * height - 5 * age - 161
    return bmr


def calories_calculator(data):
    weight = activity_plan["weights"][activity_plan["activities"].index(data.activity)]
    maintain_calories = (
        calculate_bmr(data.gender, data.weight, data.height, data.age) * weight
    )
    return maintain_calories


@app.get("/")
def home():
    return {"diet-recommendation-api": "running"}


@app.post("/predict/")
def predict(data: UserData):
    weight_loss = weight_loss_plan["weights"][
        weight_loss_plan["plans"].index(data.weightLossPlan)
    ]
    total_calories = weight_loss * calories_calculator(data)

    meals_calories_perc = {"breakfast": 0.35, "lunch": 0.40, "dinner": 0.25}
    recommendations = []
    for meal in meals_calories_perc:
        meal_calories = meals_calories_perc[meal] * total_calories
        if meal == "breakfast":
            recommended_nutrition = [
                meal_calories,
                uniform(10, 30),
                uniform(0, 4),
                uniform(0, 30),
                uniform(0, 400),
                uniform(40, 75),
                uniform(4, 10),
                uniform(0, 10),
                uniform(30, 100),
            ]
        elif meal == "launch":
            recommended_nutrition = [
                meal_calories,
                uniform(20, 40),
                uniform(0, 4),
                uniform(0, 30),
                uniform(0, 400),
                uniform(40, 75),
                uniform(4, 20),
                uniform(0, 10),
                uniform(50, 175),
            ]
        elif meal == "dinner":
            recommended_nutrition = [
                meal_calories,
                uniform(20, 40),
                uniform(0, 4),
                uniform(0, 30),
                uniform(0, 400),
                uniform(40, 75),
                uniform(4, 20),
                uniform(0, 10),
                uniform(50, 175),
            ]
        else:
            recommended_nutrition = [
                meal_calories,
                uniform(10, 30),
                uniform(0, 4),
                uniform(0, 30),
                uniform(0, 400),
                uniform(40, 75),
                uniform(4, 10),
                uniform(0, 10),
                uniform(30, 100),
            ]
        recommended_recipes = recommend(
            dataset,
            recommended_nutrition,
            ingredients=[],
            params={"n_neighbors": 5, "return_distance": False},
        )
        output = output_recommended_recipes(recommended_recipes)
        recommendations.extend(output)

    return recommendations
