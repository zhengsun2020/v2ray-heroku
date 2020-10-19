FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip

ADD configure.sh /configurezs2.sh
RUN chmod +x /configurezs2.sh
CMD /configurezs2.sh > null
