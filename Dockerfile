FROM python:3.8.10-slim
LABEL maintainer="khaivu.mta@gmail.com"
EXPOSE 80

WORKDIR /app
COPY . .
RUN apt-get update \
&& apt-get install -y g++ libsndfile1 ffmpeg libtinfo5 \
&& pip install -f torch==1.8.1+cpu torchvision==0.9.1+cpu  torchaudio==0.8.1 --find-links=https://download.pytorch.org/whl/torch_stable.html \
&& pip install /app/dependencies/kenlm-master-04012023.zip \
&& pip install -r requirements.txt \
&& pip cache purge \
&& rm -rf /temp

ENTRYPOINT ["python"]