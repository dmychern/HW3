import csv
import random
import os
import sys

NUM_ROWS = 150


COLUMNS = ["RECIPE_ID", "COOKING_TIME", "CALORIES", "CATEGORY"]

def generate_row():

    return {
        "RECIPE_ID": random.randint(0, 1000),
        "COOKING_TIME": random.randint(10, 180),
        "CALORIES": random.randint(150, 1200),
        "CATEGORY": random.choice(["Завтрак", "Суп", "Горячее", "Салат", "Десерт", "Выпечка"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)

