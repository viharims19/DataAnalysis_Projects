import numpy as np
import pandas as pd
import streamlit as st
import datetime
import pickle


col1, col2, col3 = st.columns([1, 2, 1])  # Adjust the column ratios as needed
with col2:
    st.image("images/FCAP.png", use_column_width=True)




features = ['GRE Score', 'TOEFL Score', 'University Rating', 'SOP', 'LOR', 'CGPA', 'Research']

with open("artifacts/scaler.pkl", 'rb') as scaler_pickle:
     standardize_input = pickle.load(scaler_pickle)

with open("artifacts/Regressor.pkl", 'rb') as model_pickle:
     reg_model = pickle.load(model_pickle)

# Define a function to preprocess input variables and make predictions
def predict(features):
    input_ = np.array([features])
    input_scaled = standardize_input.transform(input_)  # Apply scaling
    pred = reg_model.predict(input_scaled)[0]
    return pred

def main():
    col1,col2 = st.columns(2)

    with col1:
        gre = st.number_input('GRE Score*', min_value=0, max_value=340, step=1)
    with col2:
        toefl = st.number_input('TOEFL Score*', min_value=0, max_value=120, step=1)
    cgpa = st.number_input('CGPA*', min_value=0.0, max_value=10.0, step=0.001)

    university_rating = st.selectbox('University Rating', [1,2,3,4,5])

    col1,col2 = st.columns(2)

    with col1:
        sop = st.number_input('Statement of Purpose(SOP) Strength', min_value=1.0, max_value=5.0, step=0.5)
    with col2:
        lor = st.number_input('Letter of Recommendation(LOR) Strength', min_value=1.0, max_value=5.0, step=0.5)
    
    research = st.selectbox("Have Research Experience?", ['No','Yes'])
    

    # Convert research to numerical type
    research = 1 if research == 'Yes' else 0
  

    # Make prediction when the button is clicked
    if st.button('Predict'):
        result = predict([gre, toefl, university_rating, sop, lor, cgpa, research])
        result = round(100*result,2)
        # Check if all mandatory fields are filled
        if not gre or not toefl or not cgpa:
            st.error("Please fill in all mandatory fields marked with *")
        else:
            st.success(f'You have {result}% chance of admission.')

if __name__ == '__main__':
    main()