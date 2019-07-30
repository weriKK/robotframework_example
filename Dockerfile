FROM python:3

RUN python3 -m pip install robotframework
RUN python3 -m pip install --upgrade RESTinstance

CMD ["robot", "-d", "/mnt/results", "/mnt/tests"]