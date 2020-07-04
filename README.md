# Specification
## Non-functional requirements

Non-functional requirements
	• You should include appropriate documentation about your code.
	• Your code should follow best practices and a consistent coding style.
	• Your submission should include whatever test cases you consider appropri-ate.

## Functional requirements

1. Given a text file containing a list of unique, four-digit numerical asset IDs in a text file format, calculate a two-digit checksum for each ID and add it as a prefix to the ID to generate a six-digit code.

Each individual asset ID is represented as a 4-digit number between 0 and 9999. A simple checksum can be implemented by using modular arithmetic with a base of 97 to calculate two check digits. The checksum c of a number a with 4 digits can be calculated as:

```
c = (a1 + (10 * a2) + (100 * a3) + (1000 * a4)) mod 97
```

For example, the checksum for the asset ID 1337 can be calculated as follows:

```
(1 + (10 * 3) + (100 * 3) + (1000 * 7)) mod 97 = 7331 mod 97 = 56
```

This can be prefixed to the original asset ID to give the six-digit checksummed code 561337.
