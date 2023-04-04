import sentry_sdk
sentry_sdk.init(
    dsn="https://6302b1fb9bde45d6a3657c6a8f1bcb8f@o4504957037903872.ingest.sentry.io/4504957085810688",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0
)

cubes = []
for number in range(1, 1001, 2):
    cubes.append(number ** 3)

result = 0
for cube in cubes:
    digits_sum = 0
    for digit in str(cube):
        digits_sum += int(digit)
    if digits_sum % 7 == 0:
        result += cube

cubes_with_17 = []
for cube in cubes:
    cubes_with_17.append(cube + 17)

result = 0
for cube in cubes_with_17:
    digits_sum = 0
    for digit in str(cube):
        digits_sum += int(digit)
    if digits_sum % 7 == 0:
        result += cube
print(result)
