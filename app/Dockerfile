# Python 이미지를 기반으로 설정
FROM python:3.9-slim

# 작업 디렉토리 생성
WORKDIR /app

# 종속성 설치
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# 애플리케이션 코드 복사
COPY . .

# 컨테이너 시작 명령
CMD ["python", "app.py"]
