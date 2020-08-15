This folder includes python3 scripts for producing and consuming Kafka messages.

## Install

1. Create a venv for test purpose.

```bash
$src/test/python > python3 -m venv ./venv
```

2. Swtich venv

```bash
$src/test/python > source venv/bin/activate
```

3. Install dependencies

```bash
pip3 install -r requirements.txt
```

## Test

Send a message.

```bash
python3 produce-{some-topic}.py
```

Consume a topic.

```bash
python3 consume-{some-topic}.py
```