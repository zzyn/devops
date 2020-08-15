from kafka import KafkaProducer

BOOTSTRAP_SERVERS = ['localhost:9092']
TOPIC_NAME = 'student_reader_unlock'

MESSAGE = """
{
  "schema": {
    "type": "struct",
    "fields": [
      {
        "type": "int64",
        "optional": false,
        "field": "id"
      },
      {
        "type": "string",
        "optional": false,
        "field": "course_content_id"
      },
      {
        "type": "string",
        "optional": false,
        "field": "book_content_id"
      },
      {
        "type": "string",
        "optional": false,
        "field": "unit_content_id"
      },
      {
        "type": "string",
        "optional": false,
        "field": "lesson_content_id"
      },
      {
        "type": "int64",
        "optional": false,
        "field": "student_key"
      },
      {
        "type": "string",
        "optional": false,
        "field": "content_path"
      },
      {
        "type": "string",
        "optional": true,
        "field": "unlock_date_time_utc"
      },
      {
        "type": "string",
        "optional": true,
        "field": "created_date_time_utc"
      },
      {
        "type": "string",
        "optional": true,
        "field": "updated_date_time_utc"
      },
      {
        "type": "int64",
        "optional": false,
        "name": "org.apache.kafka.connect.data.Timestamp",
        "version": 1,
        "field": "last_updated_at"
      }
    ],
    "optional": false,
    "name": "student_reader_unlock"
  },
  "payload": {
    "id": 1002,
    "course_content_id": "00000000-0000-0000-0000-000000000001",
    "book_content_id": "00000000-0000-0000-0000-000000000011",
    "unit_content_id": "00000000-0000-0000-0000-000000000111",
    "lesson_content_id": "00000000-0000-0000-0000-000000001111",
    "student_key": 9002,
    "content_path": "highflyers/cn-3/book-1/unit-1/assignment-1",
    "unlock_date_time_utc": "2020-07-26 04:56:54.499280",
    "created_date_time_utc": "2020-07-26 04:57:03.288573",
    "updated_date_time_utc": "2020-07-26 04:57:03.288573",
    "last_updated_at": 1595739423288
  }
}
"""

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
