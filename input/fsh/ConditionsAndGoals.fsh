Instance: PatientBSJ1
InstanceOf: USCorePatientProfile
Title: "Betsy Smith-Johnson"
Description: "Betsy Smith-Johnson"
Usage: #example
* name.text = "Betsy Smith-Johnson"
* gender = #female
* identifier.value = "123"
* identifier.system = "http:/test.org"

Instance: PractitionerAnitaChu
InstanceOf: USCorePractitionerProfile
Title: "Anita Chu, MD"
Description: "Anita Chu, MD"
Usage: #example
* identifier.value = "ABC"
* identifier.system = "http:/test.org"
* name.family = "Chu"

Instance: BSJ-PACondition
InstanceOf: PAConditionLowPA
Title:       "Condition - BSJ Low Physical Activity"
Description:  "BSJ Low Physical Activity"
Usage: #example
* insert ConditionPA(PractitionerAnitaChu, [[Anita Chu MD]], 2010-10-25)
* evidence.detail = Reference(BSJ-PA-Support2)
* evidence.detail = Reference(BSJ-PA-Support4)

Instance: BSJ-FatigueCondition
InstanceOf: USCoreCondition
Title:       "Condition - BSJ Fatigue"
Description:  "BSJ Fatigue"
Usage: #example
* insert Condition(PractitionerAnitaChu, [[Anita Chu\, MD]], $ICD10#R53.0, [[Neoplastic (malignant) related fatigue]], 2022-09-18)
* evidence.detail = Reference(BSJ-PA-Support5)

Instance:       BSJ-PA-AerobicGoal1
InstanceOf:     PAGoal
Title:          "BSJ-PA-AerobicGoal1"
Description:    "BSJ-PA-AerobicGoal1"
* insert Goal(in-progress, [[Working with the Exercise Program, gradually increase your weekly exercise to at least 150 minutes/week of moderate to vigorous physical activity.]])
* insert GoalTargetMinWeek(2024-01-26, 150)
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])

Instance:       BSJ-PA-AerobicGoal2
InstanceOf:     PAGoal
Title:          "BSJ-PA-AerobicGoal2"
Description:    "BSJ-PA-AerobicGoal2"
* insert Goal(in-progress, [[Working with the Exercise Program, gradually increase your weekly exercise to at least 150 minutes/week of moderate to vigorous physical activity.]])
* insert GoalTargetMinWeek(2024-01-26, 150)
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])



Instance:       BSJ-PA-Support2
InstanceOf:     PAObservationEVSMinutesPerWeek
Title:          "BSJ-PA-Support2"
Description:    "BSJ-PA-Support2"
* insert MinPerWeek(2023-11-03, 0)

Instance:       BSJ-PA-Support4
InstanceOf:     PAObservationStrengthDaysPerWeek
Title:          "BSJ-PA-Support4"
Description:    "BSJ-PA-Support4"
* insert StrengthPerWeek(2023-11-03, 2)


Instance:       BSJ-PA-Support
InstanceOf:     PAObservationActivityGroup
Title:          "BSJ-PA-Support"
Description:    "BSJ-PA-Support"
* insert ActivityGroup(2023-11-03)
* insert HasMember(BSJ-PA-Support1)
* insert HasMember(BSJ-PA-Support3)
* insert HasMember(BSJ-PA-Support5)
* insert HasMember(BSJ-PA-Support6)
* insert HasMember(BSJ-PA-Support7)
* insert HasMember(BSJ-PA-Support8)

Instance:       BSJ-PA-Support1
InstanceOf:     PAObservationActivityMeasure
Title:          "BSJ-PA-Support1"
Description:    "BSJ-PA-Support1"
* insert ActivityTypeOther(2023-11-03, [[Elliptical]])

Instance:       BSJ-PA-Support3
InstanceOf:     PAObservationActivityMeasure
Title:          "BSJ-PA-Support3"
Description:    "BSJ-PA-Support3"
* insert ActivityDuration(2023-11-03, 20)

Instance:       BSJ-PA-Support5
InstanceOf:     PAObservationActivityMeasure
Title:          "BSJ-PA-Support5"
Description:    "BSJ-PA-Support5"
* insert ActivityCalories(2023-11-03, 250)

Instance:       BSJ-PA-Support6
InstanceOf:     PAObservationActivityMeasure
Title:          "BSJ-PA-Support6"
Description:    "BSJ-PA-Support6"
* insert MeanHeartRate(2023-11-03, 81)

Instance:       BSJ-PA-Support7
InstanceOf:     PAObservationActivityMeasure
Title:          "BSJ-PA-Support7"
Description:    "BSJ-PA-Support7"
* insert PeakHeartRate(2023-11-03, 115)

Instance:       BSJ-PA-Support8
InstanceOf:     PAObservationActivityMeasure
Title:          "BSJ-PA-Support8"
Description:    "BSJ-PA-Support8"
* insert ActivityExperience(2023-11-03, 3, "Good")

