FROM centos:7
RUN yum install -y python3 python3-pip
RUN pip3 install -r requirements.txt
RUN mkdir -p /python-api
COPY python-api.py /python-api/python-api.py
EXPOSE 5290
CMD ["python3", "/python-api/python-api.py"]