FROM ubuntu:22.04

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install python3-pip sqlite3 -y
COPY requirements.txt . 
COPY gunicorn_config.py . 
COPY init_db.py . 
COPY schema.sql . 
RUN pip install --no-cache-dir -r requirements.txt
RUN python3 ./init_db.py 

#Uncomment the following when deploying
COPY . /usr/src/app

CMD [ "python3","init_db.py"]
CMD [ "gunicorn","-c", "gunicorn_config.py","app:app"]
