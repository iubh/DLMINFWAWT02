# Step 2: Backend Development

In this step, we will develop two microservices for our reservation system: one for handling reservations and another for user registration and login. We will use FastAPI for the reservations microservice and Node.js for the authentication microservice. Both microservices will use a PostgreSQL database hosted on Vercel.

## Overview

You will learn how to:
1. Set up and configure a FastAPI application for handling reservations.
2. Set up and configure a Node.js application for user registration and login.
3. Connect both microservices to a PostgreSQL database on Vercel.

## Prerequisites

- Completion of Step 0: Environment Setup
- Basic understanding of Python and JavaScript
- Familiarity with RESTful API concepts
- Vercel account with a PostgreSQL database set up (Step 1)

## Setting Up Vercel PostgreSQL

Before you begin, ensure you have set up your PostgreSQL database on Vercel and have the necessary environment variables.

1. In your Vercel dashboard, create or select the project you want to work with.
2. Select the Storage tab, then select the Connect Store button.
3. Select PostgreSQL, enter a database name, and choose a region.
4. Review the credentials generated for your database: `POSTGRES_URL`, `POSTGRES_USER`, `POSTGRES_HOST`, `POSTGRES_PASSWORD`, `POSTGRES_DATABASE`.
5. Install the Vercel CLI (command line interface):
   ```sh
   npm i -g vercel
   ```
   Remark: You might need to use `sudo` together with the command mentioned above in order to be able to execute it.
6. To link your project to Vercel execute the following command while inside your local project directory:
   ```sh
   vercel link
   ```
7. Pull the environment variables into your local environment using the Vercel CLI:
   ```sh
   vercel env pull .env.development.local
   ```
   **ATTENTION**: The `POSTGRES_URL` exported might start with `postgres://` instead of `postgresql://`. If you, please make sure to **only** use `postgresql://`. See [StackOverflow](https://stackoverflow.com/questions/62688256/sqlalchemy-exc-nosuchmoduleerror-cant-load-plugin-sqlalchemy-dialectspostgre) for more details.
8. Make sure that the environment variables `POSTGRES_URL`, `POSTGRES_USER`, `POSTGRES_HOST`, `POSTGRES_PASSWORD`, and `POSTGRES_DATABASE` as defined in the file `.env.development.local` that was created in the previous step are set whenever executing one of the below mentioned apps:
   * [How to Set Environment Variables in MacOS](https://phoenixnap.com/kb/set-environment-variable-mac)
   * [How to Set Environment Variable in Windows](https://phoenixnap.com/kb/windows-set-environment-variable)

## Microservice 1: Reservations (FastAPI)

### 1. Set Up FastAPI

#### Installation

First, ensure your virtual environment is activated, then install [FastAPI](https://fastapi.tiangolo.com/) (web framework for building APIs with Python), [Uvicorn](https://www.uvicorn.org/) (ASGI web server implementation for Python), and [asyncpg](https://pypi.org/project/asyncpg/) (database interface library designed specifically for PostgreSQL):

```sh
pip install fastapi uvicorn asyncpg
```

Install [SQLAlchemy](https://www.sqlalchemy.org/) (Python SQL Toolkit and Object Relational Mapper):

```sh
pip install sqlalchemy
```

Install [Psycopg](https://www.psycopg.org/) (PostgreSQL adapter for the Python programming language):

```sh
pip install psycopg2-binary
```

#### Project Structure

Create the following directory structure for the reservations microservice:

```
reservations/
│
├── main.py
├── models.py
├── schemas.py
├── database.py
└── routers/
    └── reservation.py
```

#### main.py

Create the main entry point for the FastAPI application:

```python
from fastapi import FastAPI
from .database import engine, Base
from .routers import reservation

app = FastAPI()

Base.metadata.create_all(bind=engine)

app.include_router(reservation.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to the Reservations Microservice"}
```

#### models.py

Define the database models:

```python
from sqlalchemy import Column, Integer, String, DateTime
from .database import Base

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    datetime = Column(DateTime)
    service = Column(String)
```

#### schemas.py

Define the Pydantic schemas:

```python
from pydantic import BaseModel
from datetime import datetime

class ReservationCreate(BaseModel):
    name: str
    datetime: datetime
    service: str

class Reservation(BaseModel):
    id: int
    name: str
    datetime: datetime
    service: str

    class Config:
        orm_mode = True
```

#### database.py

Configure the database connection:

```python
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

DATABASE_URL = os.getenv("POSTGRES_URL")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
```

#### routers/reservation.py

Create the reservation router:

```python
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, models
from ..database import SessionLocal

router = APIRouter(
    prefix="/reservations",
    tags=["reservations"],
    responses={404: {"description": "Not found"}},
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=schemas.Reservation)
def create_reservation(reservation: schemas.ReservationCreate, db: Session = Depends(get_db)):
    db_reservation = models.Reservation(**reservation.dict())
    db.add(db_reservation)
    db.commit()
    db.refresh(db_reservation)
    return db_reservation
```

#### Run the FastAPI Application

Start the FastAPI server:

```sh
uvicorn reservations.main:app --reload
```

## Microservice 2: Authentication (Node.js)

### 1. Set Up Node.js

#### Installation

Ensure Node.js is installed, then create a new Node.js project:

```sh
mkdir auth
cd auth
npm init -y
npm install express mongoose bcryptjs jsonwebtoken pg
```
Remark: You might need to use `sudo` together with the last two commands mentioned above in order to be able to execute them.

#### Project Structure

Create the following directory structure for the authentication microservice:

```
auth/
│
├── server.js
├── models/
│   └── User.js
├── routes/
│   └── auth.js
└── middleware/
    └── authMiddleware.js
```

#### server.js

Set up the main entry point for the Node.js application:

```javascript
const express = require('express');
const { Client } = require('pg');
const authRoutes = require('./routes/auth');

const app = express();

app.use(express.json());

const client = new Client({
  connectionString: process.env.POSTGRES_URL,
});
client.connect();

app.use('/api/auth', authRoutes(client));

app.get('/', (req, res) => {
  res.send('Welcome to the Authentication Microservice');
});

const PORT = process.env.PORT || 5001;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
```

#### models/User.js

Define the User model:

```javascript
const { Client } = require('pg');
const bcrypt = require('bcryptjs');

class User {
  constructor(client) {
    this.client = client;
  }

  async createUser(username, password) {
    const hashedPassword = await bcrypt.hash(password, 10);
    const result = await this.client.query(
      'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *',
      [username, hashedPassword]
    );
    return result.rows[0];
  }

  async findUserByUsername(username) {
    const result = await this.client.query('SELECT * FROM users WHERE username = $1', [username]);
    return result.rows[0];
  }
}

module.exports = User;
```

#### routes/auth.js

Create the authentication routes:

```javascript
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const router = express.Router();

module.exports = (client) => {
  const user = new User(client);

  router.post('/register', async (req, res) => {
    const { username, password } = req.body;
    try {
      const newUser = await user.createUser(username, password);
      res.status(201).send('User registered');
    } catch (error) {
      res.status(500).send('Server error');
    }
  });

  router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
      const existingUser = await user.findUserByUsername(username);
      if (!existingUser) {
        return res.status(400).send('Invalid credentials');
      }
      const isMatch = await bcrypt.compare(password, existingUser.password);
      if (!isMatch) {
        return res.status(400).send('Invalid credentials');
      }
      const token = jwt.sign({ userId: existingUser.id }, 'your_jwt_secret', {
        expiresIn: '1h',
      });
      res.json({ token });
    } catch (error) {
      res.status(500).send('Server error');
    }
  });

  return router;
};
```

#### middleware/authMiddleware.js

Create middleware to protect routes:

```javascript
const jwt = require('jsonwebtoken');

module.exports = function (req, res, next) {
  const token = req.header('x-auth-token');
  if (!token) {
    return res.status(401).send('No token, authorization denied');
  }
  try {
    const decoded = jwt.verify(token, 'your_jwt_secret');
    req.user = decoded.user;
    next();
  } catch (err) {
    res.status(401).send('Token is not valid');
  }
};
```

#### Run the Node.js Application

Start the Node.js server:

```sh
node server.js
```

## Summary

You have now set up and configured two microservices: one for handling reservations using FastAPI and another for user authentication using Node.js. Both services are connected to a PostgreSQL database hosted on Vercel.

Proceed to [Step 3: Frontend Development](../Step3_FrontendDevelopment/README.md) to continue with the course.
