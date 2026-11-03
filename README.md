# erp_accounts_backend
# Machine Test Project – How to Run

## 1. Start MySQL
1. Open XAMPP.
2. Start **MySQL**.
3. Open phpMyAdmin: http://localhost/phpmyadmin
4. Create the database:
   `erp_accounts`
5. Import your SQL file or create the required tables.

## 2. Run Backend

Open VS Code terminal.

```bash
cd backend
npm install
```

Create `.env` in the backend folder:

```env
PORT=5000
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=erp_accounts
```

Run the backend:

```bash
node server.js
```

Keep this terminal running.

If your entry file is `app.js`, use `node app.js` instead.

## 3. Run Frontend

Open another terminal:

```bash
cd frontend
npm install
npm run dev
```

Open the local URL shown in the terminal, usually:

`http://localhost:5173`

## 4. Test the APIs

Use Postman or your browser.

Example:

`GET http://localhost:5000/api/products`

Test the other APIs for customers, invoices, invoice line items and payments according to your configured routes.

## 5. If Something Goes Wrong

- **MySQL connection refused:** Start MySQL in XAMPP.
- **Unknown database:** Create the database and verify `.env`.
- **Table doesn't exist:** Import/create the tables.
- **Port 5000 busy:** Change the port.
- **npm install error:** Check Node.js and npm installation.
- **API not working:** Check the backend terminal for errors.

## Quick Start – Every Time

1. Start XAMPP MySQL.
2. Open the project in VS Code.
3. Start backend: `npm start` or `node server.js`.
4. Start frontend: `npm run dev`.
5. Test the project in your browser.
