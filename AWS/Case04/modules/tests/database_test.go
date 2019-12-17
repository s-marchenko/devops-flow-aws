package test

import (
	"database/sql"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	_ "github.com/lib/pq"
	"log"
	"testing"
)

func TestDatabaseExample(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// You should update this relative path to point at your mysql
		// example directory!
		TerraformDir: "../test_db",
		Vars: map[string]interface{}{
			"db_config": map[string]interface{}{
				"name":    "peopleDatabase",
				"db_size": "db.t2.micro",
				"env_tag": "dev",
			},
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Test connection to Database

	// Get output data as db user, IP
	connectionString := terraform.OutputRequired(t, terraformOptions, "db_endpoint")
	//splittedConnectionString := strings.Split(connectionString,":")

	fmt.Println("Logging into the database")
	connStr := "postgres://devops:foobarbaz" + "@" + connectionString + "/peopleDatabase?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	defer db.Close()

	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Trying to ping the database")

	err = db.Ping()

	if err != nil {
		log.Fatal(err)
	}
}
