

Find the documentation [here](https://fusioninventory.org/documentation/)  

## Run mkdocs in dev mode

Install virtualenv:
```console
apt install virtualenv
```

Clone the repository:
```console
git clone https://github.com/fusioninventory/documentation.git
cd documentation
```

Create a virtual environment:
```console
virtualenv venv
```

Activate your virtual environment:
```console
source venv/bin/activate
```

Install requirement for mkdocs
```console
pip install -r requirements.txt
```

Run development instance:
```console
mkdocs serve
```
