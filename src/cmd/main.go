package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	// DB接続
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable TimeZone=%s",
		os.Getenv("DB_HOST"),
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_NAME"),
		os.Getenv("DB_PORT"),
		os.Getenv("TZ"),
	)
	db, err := sql.Open("postgres", dsn)
	if err != nil {
		log.Fatal("failed to init database: ", err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatal("failed to connect database: ", err)
	}

	log.Default().Fatalln("success to connect db!!")
}
