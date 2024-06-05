FROM python:3.12-alpine

LABEL org.opencontainers.image.source=https://github.com/sehnryr/tempconverter

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

# Expose Flask port
EXPOSE 5000

ENV FLASK_APP=app.py

CMD ["flask", "run", "--host=0.0.0.0"]
