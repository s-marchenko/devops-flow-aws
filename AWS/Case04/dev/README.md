We use a migrate tool to automate configuring the database. Usual usage will look like:

`migrate -source file:/home/ubuntu/migrations -database postgres://devops:foobarbaz@dev-flow-db.chgkgyw4l4py.eu-west-1.rds.amazonaws.com:5432/peopleDatabase?sslmode=disable up 1`

After updating the database, the People Application will be able to write and read data from the DB.