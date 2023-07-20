import numpy as np
import re


def scaling(dataframe):
    data = dataframe.iloc[:, 6:15].to_numpy()
    mean = np.mean(data, axis=0)
    std = np.std(data, axis=0)
    prep_data = (data - mean) / std
    return prep_data, mean, std


def cosine_similarity(a, b):
    dot_product = np.dot(a, b)
    norm_a = np.linalg.norm(a)
    norm_b = np.linalg.norm(b)
    similarity = dot_product / (norm_a * norm_b)
    if similarity > 0.952:
        print("Cosine Similarity : ", similarity)
    return similarity


def find_nearest_neighbors(prep_data, _input, n_neighbors):
    similarities = [cosine_similarity(x, _input) for x in prep_data]
    sorted_indices = np.argsort(similarities)[::-1]
    return sorted_indices[:n_neighbors]


def build_pipeline(prep_data, mean, std, params):
    def transformer(_input):
        _input = (_input - mean) / std
        indices = find_nearest_neighbors(prep_data, _input, params["n_neighbors"])
        return prep_data[indices], indices

    pipeline = {"mean": mean, "std": std, "NN": transformer}
    return pipeline


def extract_data(dataframe, ingredients):
    extracted_data = dataframe.copy()
    extracted_data = extract_ingredient_filtered_data(extracted_data, ingredients)
    return extracted_data


def extract_ingredient_filtered_data(dataframe, ingredients):
    extracted_data = dataframe.copy()
    regex_string = "".join(map(lambda x: f"(?=.*{x})", ingredients))
    extracted_data = extracted_data[
        extracted_data["RecipeIngredientParts"].str.contains(
            regex_string, regex=True, flags=re.IGNORECASE
        )
    ]
    return extracted_data


def apply_pipeline(pipeline, _input, extracted_data):
    prep_data, indices = pipeline["NN"](_input)
    return extracted_data.iloc[indices]


def recommend(dataframe, _input, ingredients=[], params={"n_neighbors": 5}):
    extracted_data = extract_data(dataframe, ingredients)
    if extracted_data.shape[0] >= params["n_neighbors"]:
        prep_data, mean, std = scaling(extracted_data)
        pipeline = build_pipeline(prep_data, mean, std, params)
        return apply_pipeline(pipeline, _input, extracted_data)
    else:
        return None


def extract_quoted_strings(s):
    strings = re.findall(r'"([^"]*)"', s)
    return strings


def output_recommended_recipes(dataframe):
    if dataframe is not None:
        output = dataframe.copy()
        output = output.to_dict("records")
        for recipe in output:
            recipe["RecipeIngredientParts"] = extract_quoted_strings(
                recipe["RecipeIngredientParts"]
            )
            recipe["RecipeInstructions"] = extract_quoted_strings(
                recipe["RecipeInstructions"]
            )
    else:
        output = None
    return output
