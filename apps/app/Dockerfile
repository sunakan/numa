FROM kennethreitz/httpbin:latest

EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "httpbin:app", "-k", "gevent"]
