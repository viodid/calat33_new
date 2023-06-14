FROM python:3.10-slim

WORKDIR /calat33

COPY requirements.txt .

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt
    
# docker build --build-arg="GO_VERSION=1.19" .
ARG config_file

RUN echo $config_file \
    && cat $config_file

COPY $config_file /etc/calat33/

COPY . .

EXPOSE 8888/tcp

CMD ["gunicorn", "--bind", "0.0.0.0:8888", "run:app"]
