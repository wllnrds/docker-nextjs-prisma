# First Setup

## App
Your nextjs application must be on /app folder.

### Setup database

1. Start-up just database container to migrate you database

```sh
docker compose  -f "compose.dev.yaml" up -d --build database
```

By default both environments (dev&prod) shares a database volume to keep data sync. If you want to separate, just change prop name on db-data volume. Remember that's not the best way to keep you prod data safe.

2. Now you need to setup the DATABASE_URL on env to Prisma. By default, database on dev environment exposes 54032 port to access database from local machine, use it now.

```
DATABASE_URL=postgresql://[user]:[password]@localhost:54032/[database_name]?schema=public
```

3. Run migrations on prisma
```sh
npx prisma migrate dev // To run development migrations

// OR

npx prisma migrate deploy // To run deploy migrations
```

4. You don't need to keep de env file with database, unless that you can use it to keep using `npm run dev` in local machine mode.

## Update database

To keep you database updated, just repeat 1, 2 and 3 steps.

## Startup application

### Develop

To build up development environment mode run the following command. Application will be exposed on [http://localhost:81](http://localhost:81).

```sh
docker compose  -f "compose.dev.yaml" up -d
```

To build up production environment mode run the following command. Application will be exposed on [http://localhost:80](http://localhost:80).

```sh
docker compose  -f "compose.prod.yaml" up -d
```

## Extras
 - Prisma generate comand will run on docker build
 - On development environment docker will bind app folder to keep hotreload
 - On production environment docker will create a deploy version from code
 - Production mode is not using standalone mode yet, when used it miss tailwind style
 - Containers was setup to co exist, dev uses port 81 and production uses 80
 - You can change database password changing file on db/password.txt
 - You can change database name on composer file, by default both envs uses de same name. (Change POSTGRES_DB environment service value to change it - Remember to run migrations!)