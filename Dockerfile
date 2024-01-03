FROM python:3.12

# Update packages and install needed stuff
RUN apt-get update && apt-get dist-upgrade -y
# I hate modern way of doing things
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
    apt-get install -y nodejs
RUN pip install -U pip setuptools wheel

# Install python & node deps
WORKDIR /code
COPY requirements.txt ./
RUN pip install -Ur requirements.txt
COPY package.json package-lock.json ./
RUN npm install

# Copy source dir
COPY manage.py tsconfig.json vite.config.ts ./
COPY proj/ proj/
COPY front/ front/
COPY demo/ demo/

# Build front
RUN npm run build

# Make django happy (we don't use the db so its ok to generate it at build time)
RUN python manage.py migrate

# Clean up the image
RUN rm -rf node_modules front demo/static

# Run the server
EXPOSE 8000
CMD [ "daphne", "proj.asgi:application", "-b", "0.0.0.0"]