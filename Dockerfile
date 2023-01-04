
FROM python:3.8.10-slim
LABEL maintainer="khaivu.mta@gmail.com"

WORKDIR /app
COPY . .
RUN apt-get install -y libsndfile1 ffmpeg \
	& pip install -r requirements.txt \
	& pip install -f \
	torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 \
	https://download.pytorch.org/whl/torch_stable.html \
	& pip install dependencies/kenlm-master-04012023.zip

EXPOSE 80
ENTRYPOINT ["python"]
CMD ["python", "app.py"]