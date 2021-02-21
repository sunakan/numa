FROM nginx:stable

COPY ./templates/ /etc/nginx/templates/
EXPOSE 80
RUN apt update && apt install -y curl vim
