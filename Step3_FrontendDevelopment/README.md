# Step 3: Frontend Development

In this step, we will develop a hairdresser reservation site using React and Next.js. We will use Material-UI (MUI) for the UI components. The site will allow users to make reservations and manage their accounts.

## Prerequisites

- Completion of Step 0: Environment Setup
- Basic understanding of React and JavaScript
- Familiarity with RESTful API concepts

## Setting Up the Project

### 1. Create a Next.js App

We recommend starting a new Next.js app using `create-next-app`, which sets up everything automatically for you.

Open your terminal and run:

```sh
npx create-next-app@latest
```

You will see the following prompts. Answer them as follows:

```
What is your project named? my-app
Would you like to use TypeScript? Yes
Would you like to use ESLint? Yes
Would you like to use Tailwind CSS? No
Would you like to use `src/` directory? Yes
Would you like to use App Router? (recommended) Yes
Would you like to customize the default import alias (@/*)? Yes
What import alias would you like configured? @/*
```

After the prompts, `create-next-app` will create a folder with your project name and install the required dependencies.

### 2. Install Material-UI (MUI)

Navigate to your project directory and install MUI:

```sh
cd my-app
npm install @mui/material @emotion/react @emotion/styled
```

## Project Structure

Your project structure should look like this:

```
my-app/
│
├── app/
│   ├── layout.tsx
│   ├── page.tsx
│   └── reservation/
│       ├── page.tsx
│       └── create.tsx
├── public/
├── src/
│   ├── components/
│   │   ├── Navbar.tsx
│   │   └── ReservationForm.tsx
├── .eslintrc.json
├── next.config.js
└── package.json
```

## Creating the Frontend Pages and Components

### 1. Set Up the Root Layout

Create a root layout inside `app/layout.tsx` with the required `<html>` and `<body>` tags:

```typescript
// app/layout.tsx
import { ReactNode } from 'react';
import { CssBaseline, Container } from '@mui/material';

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>
        <CssBaseline />
        <Container>
          {children}
        </Container>
      </body>
    </html>
  );
}
```

### 2. Create the Home Page

Create a home page inside `app/page.tsx` with some initial content:

```typescript
// app/page.tsx
import { Typography } from '@mui/material';

export default function HomePage() {
  return <Typography variant="h1">Welcome to the Hairdresser Reservation System</Typography>;
}
```

### 3. Create the Reservation Page

Create a reservation page inside `app/reservation/page.tsx`:

```typescript
// app/reservation/page.tsx
import { Typography, Button } from '@mui/material';
import Link from 'next/link';

export default function ReservationPage() {
  return (
    <>
      <Typography variant="h2">Reservations</Typography>
      <Button variant="contained" component={Link} href="/reservation/create">
        Create a New Reservation
      </Button>
    </>
  );
}
```

### 4. Create the Reservation Form Page

Create a form for creating reservations inside `app/reservation/create.tsx`:

```typescript
// app/reservation/create.tsx
import { useState } from 'react';
import { TextField, Button, Box, Typography } from '@mui/material';

export default function CreateReservationPage() {
  const [name, setName] = useState('');
  const [dateTime, setDateTime] = useState('');
  const [service, setService] = useState('');

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    const response = await fetch('/api/reservations', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ name, dateTime, service }),
    });
    if (response.ok) {
      alert('Reservation created successfully');
    } else {
      alert('Failed to create reservation');
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit}>
      <Typography variant="h2">Create a New Reservation</Typography>
      <TextField
        label="Name"
        value={name}
        onChange={(e) => setName(e.target.value)}
        fullWidth
        margin="normal"
      />
      <TextField
        label="Date and Time"
        type="datetime-local"
        value={dateTime}
        onChange={(e) => setDateTime(e.target.value)}
        fullWidth
        margin="normal"
      />
      <TextField
        label="Service"
        value={service}
        onChange={(e) => setService(e.target.value)}
        fullWidth
        margin="normal"
      />
      <Button type="submit" variant="contained" color="primary">
        Submit
      </Button>
    </Box>
  );
}
```

### 5. Create Navbar Component

Create a Navbar component inside `src/components/Navbar.tsx`:

```typescript
// src/components/Navbar.tsx
import { AppBar, Toolbar, Typography, Button } from '@mui/material';
import Link from 'next/link';

export default function Navbar() {
  return (
    <AppBar position="static">
      <Toolbar>
        <Typography variant="h6" style={{ flexGrow: 1 }}>
          Hairdresser Reservation
        </Typography>
        <Button color="inherit" component={Link} href="/">
          Home
        </Button>
        <Button color="inherit" component={Link} href="/reservation">
          Reservations
        </Button>
      </Toolbar>
    </AppBar>
  );
}
```

Include the Navbar component in the `RootLayout`:

```typescript
// app/layout.tsx
import { ReactNode } from 'react';
import { CssBaseline, Container } from '@mui/material';
import Navbar from '@/components/Navbar';

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>
        <CssBaseline />
        <Navbar />
        <Container>
          {children}
        </Container>
      </body>
    </html>
  );
}
```

## Running the Development Server

Run the development server to view your application:

```sh
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) to view your application. You can now navigate through the home page and the reservation pages.

## Summary

You have now set up a basic frontend for the hairdresser reservation system using React and Next.js with MUI for the components. The frontend includes a home page, a reservations page, and a form for creating new reservations.

Proceed to [Step 4: Docker and Kubernetes](../Step4_Docker_Kubernetes/README.md) to continue with the course.
