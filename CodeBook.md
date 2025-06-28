# CodeBook

## Description

This code book describes the variables and transformations for the tidy dataset.

## Variables

- `subject`: Identifier of the volunteer.
- `activity`: Activity name (e.g., WALKING, STANDING).
- Measurement variables like:
  - `TimeBodyAccelerometerMeanX`
  - `TimeBodyAccelerometerSTDY`
  - (etc...)

## Transformations

- Combined train/test data sets.
- Extracted only mean and standard deviation measurements.
- Applied descriptive activity names.
- Labeled variables with descriptive names.
- Created a second tidy data set with the average of each variable per subject and activity.
- 
