FROM python:3.8.10-slim
LABEL maintainer="khaivu.mta@gmail.com"
EXPOSE 80

WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y libsndfile1 libtinfo5 g++ ffmpeg \
&& pip install -f torch==1.8.1+cpu torchvision==0.9.1+cpu  torchaudio==0.8.1 --find-links=https://download.pytorch.org/whl/torch_stable.html \
&& pip install /app/dependencies/kenlm-master-04012023.zip \
&& pip install -r requirements.txt \
&& pip cache purge \
&& rm -rf /temp /tmp/* /var/lib/apt/lists/* /var/cache/apt/* ~/.cache/pip /app/dependencies \
&& apt-get remove -y g++ ffmpeg 

CMD ["python", "/app/app.py"]