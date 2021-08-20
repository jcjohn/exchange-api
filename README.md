# README

I have dockerized this project.

In order to get it up and running, one needs only to run `docker compose up -d`

Once completed, run ```shell
docker compose exec runner bundle install
docker compose exec runner bundle exec rails db:create db:migrate
docker compose up -d
```

The rails container is exposed on port 3001

## API documentation
The root will accept the following:
```yaml
'/':
  get:
    summary: returns the amount that will be exchanged for
    description: 'Accepts a base currency code, amount and currency code to exchange to and return the amount in the exchange code currency
    oprationId: exchangeCurrency
    parameters:
      - name: base_code
        in: query
        description: starting currency code
        required: true
        schema:
          type: string
      - name: exchange_code
        in: query
        description: the currency code to exchange into
        required: true
        schema:
          type: string
      - name: amount
        in: query
        description: the amount of starting currency to be exchanged
        required: true
        schema:
          type: number
    responses:
      '200':
        description: the value of the amount of currency exchanged
        content:
          'application/json':
            schema:
              type: object
              properties:
                exchange_amount:
                  type: number
```
