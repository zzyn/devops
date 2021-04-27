from kafka import KafkaProducer

BOOTSTRAP_SERVERS = ['localhost:9092']
TOPIC_NAME = 'uppercase_input'

MESSAGE = "hello"

def main():
  print('connecting to kafka brokers...')
  producer = KafkaProducer(
    bootstrap_servers=BOOTSTRAP_SERVERS
  )
  print('sending message')
  producer.send(TOPIC_NAME, MESSAGE.encode('utf-8'))
  print('closing connection')
  producer.close()

  print(f"message is put in topic {TOPIC_NAME}")

if __name__ == '__main__':
  main()
