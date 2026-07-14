FROM ubuntu:latest
WORKDIR /app
COPY . .
RUN sed -i 's/\r$//' script.sh
CMD ["bash", "script.sh"]