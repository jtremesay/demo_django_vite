# Django + vite

## Bootstrap

```shell
git clone TODO
cd demo_django_vite
direnv allow
pip install -U pip setuptools wheel && pip install -Ur requirements.txt
npm install
./manage.py migrate
```


## Dev

Terminal 1:

```shell
DJANGO_DEBUG=true npm run dev
```

Terminal 2:

```shell
DJANGO_DEBUG=true ./manage runserver
```

## Prod

```shell
mkdir static && echo "{}" > static/manifest.json
npm run build
./manage.py collectstatic --no-input
daphne proj.asgi:application -b 0.0.0.0
```