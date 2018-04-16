# Read the Training set
df <- read.csv('data/train_ajEneEa.csv')

# Read the test set
test <- read.csv('data/test_v2akXPA.csv')

# get the variable kinds
str(df)

# Preview first 6 rows in trainset
head(df)

# Let us find the levels of gender
levels(df$gender)

# Tabulate the count of gender across levels
table(df$gender)

# Tabulate the proportion
prop.table(table(df$gender))

# Plot a histogram of age

hist(df$age)

# Get the range of age
range(df$age)

# Let us try to bin the age into range 0-5, 5-15, 15-25, 25-35, 35-45, 45-60, 60 and above

# df$age_range <- 0
# df[(df$age > 5 & df$age<=15), 'age_range'] <- 1
# df[(df$age > 15 & df$age<=25), 'age_range'] <- 2
# df[(df$age > 25 & df$age<=35), 'age_range'] <- 3
# df[(df$age > 35 & df$age<=45), 'age_range'] <- 4
# df[(df$age > 45 & df$age<=60), 'age_range'] <- 5
# df[(df$age > 60), 'age_range'] <- 6

# test$age_range <- 0
# test[(test$age > 5 & test$age<=15), 'age_range'] <- 1
# test[(test$age > 15 & test$age<=25), 'age_range'] <- 2
# test[(test$age > 25 & test$age<=35), 'age_range'] <- 3
# test[(test$age > 35 & test$age<=45), 'age_range'] <- 4
# test[(test$age > 45 & test$age<=60), 'age_range'] <- 5
# test[(test$age > 60), 'age_range'] <- 6

# table(df$age_range)

# plot(table(df$age_range))

#hypertension

table(df$hypertension)
prop.table(table(df$hypertension))

# heart Disease

table(df$heart_disease)
prop.table(table(df$heart_disease))

# Marital status

levels(df$ever_married)

table(df$ever_married)
prop.table(table(df$ever_married))

# Work type
levels(df$work_type)
table(df$work_type)
prop.table(table(df$work_type))

# Residence type
levels(df$Residence_type)

table(df$Residence_type)
prop.table(table(df$Residence_type))

# Average glucose levels

hist(df$avg_glucose_level)

range(df$avg_glucose_level)

# BMI
hist(df$bmi)
range(df$bmi)

# Smoking status
levels(df$smoking_status)

table(df$smoking_status)
prop.table(table(df$smoking_status))

levels(test$smoking_status)

#Stroke

table(df$stroke)
prop.table(table(df$stroke))

# df$hypertension <- as.factor(df$hypertension)

# df$heart_disease <- as.factor(df$heart_disease)
# df$stroke <- as.factor(df$stroke)
