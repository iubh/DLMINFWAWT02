# Database Setup for Web Architecture Course

Welcome to the database setup section of our Web Architecture course. In this part, we will set up a serverless PostgreSQL database using Vercel. This process will involve integrating our database with GitHub for seamless development and deployment.

## Step 1: Log in to GitHub

1. **Access GitHub**: Visit [GitHub](https://github.com/). If you do not yet have a GitHub user account, you must create one using the "Sign Up" button. If you already have a GitHub user account, you should log in using the button "Sign in".
2. **Create a new GitHub project**: Create a new private project "DLMINFWAWT02_Web_Architectures" within your personal GitHub user account.

## Step 2: Log in to Vercel

1. **Access Vercel**: Visit [Vercel](https://vercel.com/). If you do not yet have a Vercel user account, you must create one using the "Sign Up" button and link it to your own GitHub user account. If you already have a Vercel user account, you should log in using the linked GitHub user account via the button "Log In". 
2. **GitHub Integration**: Select the option to log in using GitHub. This will streamline our development process and simplify deployments.
3. **Authenticate**: You may be prompted to authorize Vercel to access your GitHub account. Please allow this authentication.
4. **Redirection**: After successful login and authentication, you will be redirected to the Vercel homepage.
5. **Create a new Vercel project**: Create a new Vercel project "dlminfwawt02_web_architectures" within your personal Vercel account and link it to the GitHub project "DLMINFWAWT02_Web_Architectures" that was created before.

## Step 3: Create a Serverless PostgreSQL Database

1. **Navigate to Storage**: On the Vercel homepage, locate and click on the 'Storage' option. This is where you can manage database configurations.
![Vercel Navigation to Storage](img/Vercel-Storage.png)
2. **Database Setup**: Here, you will set up a new serverless PostgreSQL database. Fill in the required information as prompted.
![Vercel Storage PostgreSQL](img/Vercel-Storage-Postgresql.png)
![Vercel create storage with PostgreSQL](img/Vercel-Create-Step-Storage-Postgresql.png)
3. **Completion**: Once you have entered all the necessary details and created the database, you should receive a confirmation with details of your newly created database.
![Vercel Dashboard after created storage with PostgreSQL](img/Vercel-Dashboard-After-Create-Step-Storage-Postgresql.png)

---

### Note:
- Ensure you keep a record of your database credentials and connection details securely, as you'll need them for connecting your application to the database.
- In general, not for this course, familiarize yourself with the Vercel and PostgreSQL documentation for advanced configuration and troubleshooting.

---

Proceed to [Step 2: BackendDevelopment - FastAPI](../Step2_BackendDevelopment/README.md) to continue with the course.
