from kafka import KafkaConsumer

BOOTSTRAP_SERVERS = ['localhost:9092']
TOPIC_NAME = 'uppercase_output'

def main():
  print(f"connecting {BOOTSTRAP_SERVERS}")

  consumer = KafkaConsumer(
    TOPIC_NAME,
    bootstrap_servers=BOOTSTRAP_SERVERS,
    auto_offset_reset='earliest',
    enable_auto_commit=False,
    auto_commit_interval_ms=10000)

  print(f"listening {TOPIC_NAME}")

  for message in consumer:
    print("================================")
    print(f"topic='{message.topic}', partition={message.partition}', offset={message.offset}, key={message.key}")
    print("--------------------------------")
    print(message.value.decode('utf-8'))

if __name__ == '__main__':
  main()
