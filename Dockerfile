FROM golang as BUILD

WORKDIR /go/src

COPY . ./

RUN go get -v -d .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/pdns_exporter .

FROM alpine

COPY --from=BUILD /go/bin/pdns_exporter /

ENTRYPOINT [ "/pdns_exporter" ]
