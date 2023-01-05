
FROM python:3.8.10-slim as build
WORKDIR /app
COPY . .
RUN apt-get update
RUN apt-get install -y g++ libsndfile1 ffmpeg libtinfo5
RUN pip install -f torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 --find-links=https://download.pytorch.org/whl/torch_stable.html
RUN pip install /app/dependencies/kenlm-master-04012023.zip
RUN pip install pyinstaller
RUN pip install -r requirements.txt
RUN /usr/local/bin/pyinstaller /app/infer.py
RUN ls -lR

FROM python:3.8.10-slim as publish
WORKDIR /publish
LABEL maintainer="khaivu.mta@gmail.com"
EXPOSE 80
COPY --from=build /app/dist .
RUN chmod +x /publish/infer
ENTRYPOINT ["/publish/infer"]