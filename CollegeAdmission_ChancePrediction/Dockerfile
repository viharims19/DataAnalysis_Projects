FROM python:3.9-slim-buster


WORKDIR /app

RUN python -m pip install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

CMD streamlit run app.py