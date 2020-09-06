# Work with dates, times, timedeltas and timezones

The main module to works with dates and times in python is **datetime** module. To use it

```python
import datetime
```

## Basic usage

### Dates

- Create a new date

```python
date = datetime.date(2020, 1, 15) # 2020-01-15
```

- Get current date

```python
today_date = datetime.date.today() # 2020-05-09
today.year   # 2020
today.month  # 5
today.day    # 9
today.isoweekday() # 6 (Range 1(Monday)-7(Sunday))
```

### Times

- Create time

```python
time = datetime.time(9, 30, 34) # 09:30:34
time.hour   # 9
time.minute # 30
time.second # 34
```

- Get current time

```python
current_time = datetime.datetime.now().time() # 14:35:53.803003
```

### Datetimes

- Create a new datetime

```python
full_date_time = datetime.datetime(2020, 7, 26, 12, 30, 45) # 2020-07-26 12:30:45
full_date_time.date()  # 2020-07-26
full_date_time.time()  # 12:30:45
full_date_time.year    # 2020
full_date_time.month   # 7
full_date_time.day     # 26
full_date_time.hour    # 12
full_date_time.minute  # 30
full_date_time.second  # 45
```

- Get current datetime

```python
local_datetime = datetime.datetime.now() # 2020-05-09 14:33:05.430401
```


## Timedelta

`Timedeltas` are simply the **difference between two dates or times**, extremely useful when we want to do
operations on our dates.

When we work with dates and timedeltas, we have to take into account:

> `date + timedelta returns a **date**`

```python
timedelta = datetime.timedelta(days=3) # 3 days, 0:00:00
date_1 = datetime.date(2020, 1, 1) # 2020-01-01
date_2 = datetime.date(2020, 2, 1) # 2020-02-01
result = date_1 + timedelta # 2020-01-04
```

> `date + date returns a **timedelta**`

```python
date_1 = datetime.date(2020, 1, 1) # 2020-01-01
date_2 = datetime.date(2020, 2, 1) # 2020-02-01
result = date_2 - date_1 # 31 days, 0:00:00
```


- Create a time delta

```python
time_delta = datetime.timedelta(days=7) # 7 days, 0:00:00

# One week away
next_week = today + time_delta # 2020-05-16

# One week ago
week_ago = today - time_delta # 2020-05-02
```

- Calculate

```python
birthday = datetime.date(2020,11,7) # 2020-11-07
time_until_birtday = birthday - today # 182 days, 0:00:00

# Days
time_until_birtday.days # 182

# Calculate number of seconds
time_until_birtday.total_seconds() # 15724800.0

# Add 12 hours with datetime
date_time = datetime.datetime(2020, 7, 26, 12, 30, 45) # 2020-07-26 12:30:45
time_delta = datetime.timedelta(hours=12)
result = date_time + time_delta # 2020-07-27 00:30:45
```

## Timezones

- Work with timezones `pip install pytz`

```python
import pytz
```

- Print all timezones

```python
for tz in pytz.all_timezones:
  print(tz)
```

- Print UTC datetime and convert it to another zones

```python
# UTC
date_utc_now = datetime.datetime.now(tz=pytz.UTC) # 2020-05-09 12:45:39.616685+00:00

spain_datetime = date_utc_now.astimezone(pytz.timezone('Europe/Madrid')) # 2020-05-09 14:45:39.616685+02:00

east_datetime = spain_datetime.astimezone(pytz.timezone('US/Eastern')) # 2020-05-09 08:48:14.058023-04:00
```
## Date and times formats

- Get `ISO` format

```python
current_datetime = datetime.datetime.now().isoformat() # 2020-05-09T14:51:03.988798
```

- Datetime to string using `strftime`

```python
current_datetime = datetime.datetime.now().strftime('%B %d, %Y') # May 09, 2020
```

- String to datetime using `strptime`

```python
date_string = 'May 09, 2020'
datetime.datetime.strptime(date_string, '%B %d, %Y') # 2020-05-09 00:00:00
```

For more format information, see
[this section](https://docs.python.org/3.7/library/datetime.html#strftime-and-strptime-behavior) of python documentation

# References

- Python documentation, datetime — Basic date and time types, available in
  https://docs.python.org/3.7/library/datetime.html#module-datetime

- Corey Schafer, Python Tutorial: Datetime Module, available in https://www.youtube.com/watch?v=eirjjyP2qcQ