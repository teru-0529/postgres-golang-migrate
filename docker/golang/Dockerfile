FROM golang:1.21

WORKDIR /app

RUN go install github.com/volatiletech/sqlboiler@latest
RUN go install github.com/volatiletech/sqlboiler/drivers/sqlboiler-psql@latest
# RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.16.2
RUN go install -tags 'postgres,github' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
COPY ./src .
