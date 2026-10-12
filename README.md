# Fashion business database

A MySQL schema and sample-data exercise for a fashion business. It models designers, customers, phone numbers, tailoring technicians, outfits, fashion shows, and the relationships between them.

## Run the example

Use a disposable local MySQL database and run:

```bash
git clone https://github.com/derrickbaruga7/SQL-Database-Management.git
cd SQL-Database-Management
mysql -u YOUR_MYSQL_USER -p < final.sql
```

`final.sql` creates a database named `cit01`, loads sample records, and runs three queries. The account needs permission to create databases and tables. Use the client in batch mode as shown and **do not pass `--force`**: if `cit01` already exists, the initial `CREATE DATABASE` must stop the script before its table-reset statements run. To repeat the exercise, choose a fresh disposable database or explicitly remove only your previous demo database after checking its contents.

## Schema and queries

- Sample people use explicit demo names, staff codes (`DesignerCode` and `TechnicianID`), and non-dialable phone labels rather than SSN-like values.
- Designers have a composite primary key plus a unique `DesID`, so references to the ID alone target a unique key.
- Outfit prices use `DECIMAL(10, 2)` for numeric values with cents.
- `soldto` is populated from the sample outfit/customer assignments, giving the first join actual rows to display.
- The final queries show customer purchases, tailoring assignments and dates, and designer participation in fashion shows.

The expected result counts are 6 customer purchases, 9 tailoring assignments, and 8 show participations. This is a teaching dataset and schema exercise, not a production migration. The `designs` relation is defined but has no sample rows; outfit records also carry designer and customer references.
