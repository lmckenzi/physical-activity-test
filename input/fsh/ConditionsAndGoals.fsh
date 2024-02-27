//NOTE - txn4 and txn5 will need to have goal ids updated to not end with "3" or "4"


// Background instances (presume these already exist with the specified ids)

// Transactions (what we will actually import with)

Instance: BSJ-txn1-setup
InstanceOf: Bundle
Title:       "Txn 1 - Initial Set-up Bundle"
Description:  "Pre-existing resources"
Usage: #example
* insert TxnBundle
* insert TxnEntry(Patient, PatientBSJ1)
* insert TxnEntry(Practitioner, Practitioner-AnitaChu)
* insert TxnEntry(Condition, OT-ProblemList-RightWeak)
* insert TxnEntry(Condition, BSJ-HemiparesisDiagnosis)

Instance: BSJ-txn2-Visit1
InstanceOf: Bundle
Title:       "Txn 2 - Initial Visit Bundle"
Description:  "BSJ resources created in first visit - 2023-10-25"
Usage: #example
* insert TxnBundle
* insert TxnEntryObs(BSJ-PA-EVSdays)
* insert TxnEntryObs(BSJ-PA-EVSmin)
* insert TxnEntryObs(BSJ-PA-EVS)
* insert TxnEntryObs(BSJ-PA-Strength)
* insert TxnEntryObs(BSJ-PA-Fatigue)
* insert TxnEntry(Condition, BSJ-PACondition)
* insert TxnEntry(Condition, BSJ-FatigueCondition)
* insert TxnEntry(Goal, BSJ-PA-AerobicGoal)
* insert TxnEntry(Goal, BSJ-PA-FatigueGoal)
* insert TxnEntry(Goal, BSJ-PA-StrengthGoal)

Instance: BSJ-txn3-Visit2
InstanceOf: Bundle
Title:       "Txn 3 - Follow-up visit"
Description:  "BSJ resources created in second visit - 2023-12-13"
Usage: #example
* insert TxnBundle
* insert TxnEntryObs(BSJ-PA-Fatigue1)

Instance: BSJ-txn4-Visit2
InstanceOf: Bundle
Title:       "Txn 4 - Second Visit Bundle"
Description:  "BSJ resources created in second visit (post stroke) - 2023-12-18.  Must be imported after Visit1 Bundle"
Usage: #example
* insert TxnBundle
* insert TxnEntryCond(Goal, BSJ-PA-AerobicGoal2, BSJ-PA-AerobicGoal2)
* insert TxnEntryCond(Goal, BSJ-PA-FatigueGoal2, BSJ-PA-FatigueGoal2)
* insert TxnEntryCond(Goal, BSJ-PA-StrengthGoal2, BSJ-PA-StrengthGoal)

Instance: BSJ-txn5-Visit3
InstanceOf: Bundle
Title:       "Txn 5 - Third Visit Bundle"
Description:  "BSJ resources created in second visit (post stroke) - 2024-01-24.  Must be imported after Visit2 Bundle"
Usage: #example
* insert TxnBundle
* insert TxnEntryObs(BSJ-PA-EVSdays2)
* insert TxnEntryObs(BSJ-PA-EVSmin2)
* insert TxnEntryObs(BSJ-PA-EVS2)
* insert TxnEntryObs(BSJ-PA-Strength2)
* insert TxnEntryObs(BSJ-PA-Fatigue2)
* insert TxnEntryCond(Goal, BSJ-PA-AerobicGoal3, BSJ-PA-AerobicGoal)
* insert TxnEntryCond(Goal, BSJ-PA-FatigueGoal3, BSJ-PA-FatigueGoal)
* insert TxnEntryCond(Goal, BSJ-PA-StrengthGoal3, BSJ-PA-StrengthGoal)
* insert TxnEntry(Goal, BSJ-PA-PowerGoal)

// Pre-existing / set-up resources

Instance: PatientBSJ1
InstanceOf: USCorePatientProfile
Title: "Betsy Smith-Johnson"
Description: "Betsy Smith-Johnson"
Usage: #example
* name.text = "Betsy Smith-Johnson"
* gender = #female
* insert Identifier(PatientBSJ1)

Instance: Practitioner-AnitaChu
InstanceOf: USCorePractitionerProfile
Title: "Anita Chu, MD"
Description: "Anita Chu, MD"
Usage: #example
* insert Identifier(Practitioner-AnitaChu)
* name.family = "Chu"

Instance: OT-ProblemList-RightWeak
InstanceOf: USCoreCondition
Title:       "Condition - Right-side weakness"
Description:  "BSJ RightWeak"
Usage: #example
* insert Condition(Practitioner-AnitaChu, [[Anita Chu\, MD]], $sct#570961000124101, [[Weakness of right upper limb (finding)]], 2023-12-16T13:30:00-05:00)
* insert Identifier(OT-ProblemList-RightWeak)

Instance: BSJ-HemiparesisDiagnosis
InstanceOf: USCoreCondition
Title:       "Condition - Hemiparesis"
Description:  "BSJ Hemiparesis"
Usage: #example
* insert Condition(Practitioner-AnitaChu, [[Anita Chu\, MD]], $sct#278286009, [[Right hemiparesis (disorder)]], 2023-12-16T13:30:00-05:00)
* insert Identifier(BSJ-HemiparesisDiagnosis)



// Data to load

Instance: BSJ-PA-EVSdays
InstanceOf: PAObservationEVSDaysPerWeek
Title:       "Initial EVS Days"
Description:  "BSJ Days/week initial assessment"
Usage: #example
* insert DaysPerWeek(2023-10-25, 0)

Instance: BSJ-PA-EVSmin
InstanceOf: PAObservationEVSMinutesPerDay
Title:       "Initial EVS Days"
Description:  "BSJ Min/Day initial assessment"
Usage: #example
* insert MinPerDay(2023-10-25, 0)

Instance: BSJ-PA-EVS
InstanceOf: PAObservationEVSMinutesPerWeek
Title:       "Initial EVS Minutes"
Description:  "BSJ Minutes/week initial assessment"
Usage: #example
* insert MinPerWeek(2023-10-25, 0)
* derivedFrom = Reference(BSJ-PA-EVSdays)
* derivedFrom = Reference(BSJ-PA-EVSmin)

Instance: BSJ-PA-Strength
InstanceOf: PAObservationStrengthDaysPerWeek
Title:       "Initial EVS Strength"
Description:  "BSJ Strength/week initial assessment"
Usage: #example
* insert StrengthPerWeek(2023-10-25, 0)

Instance: BSJ-PA-Fatigue
InstanceOf: Observation
Title:       "Initial Fatigue"
Description:  "BSJ Fatigue Score initial assessment"
Usage: #example
* insert FatigueObs(2023-10-25, 35, "Extreme Fatigue")

Instance: BSJ-PACondition
InstanceOf: PAConditionLowPA
Title:       "Condition - BSJ Low Physical Activity"
Description:  "BSJ Low Physical Activity"
Usage: #example
* insert ConditionPA(Practitioner-AnitaChu, [[Anita Chu MD]], 2010-10-25)
* evidence.detail = Reference(BSJ-PA-EVS)
* evidence.detail = Reference(BSJ-PA-Strength)

Instance: BSJ-FatigueCondition
InstanceOf: USCoreCondition
Title:       "Condition - BSJ Fatigue"
Description:  "BSJ Fatigue"
Usage: #example
* insert Condition(Practitioner-AnitaChu, [[Anita Chu\, MD]], $ICD10#R53.0, [[Neoplastic (malignant) related fatigue]], 2022-09-18)
* evidence.detail = Reference(BSJ-PA-Fatigue)

Instance:       BSJ-PA-AerobicGoal
InstanceOf:     PAGoal
Title:          "BSJ-PA-AerobicGoal"
Description:    "BSJ-PA-AerobicGoal"
* insert Goal(active, [[Working with the Exercise Program, gradually increase your weekly exercise to at least 150 minutes/week of moderate to vigorous physical activity.]])
* insert Identifier(BSJ-PA-AerobicGoal)
* insert GoalTargetMinWeek(2024-01-26, 150)
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])

Instance:       BSJ-PA-AerobicGoal2
InstanceOf:     PAGoal
Title:          "BSJ-PA-AerobicGoal2"
Description:    "BSJ-PA-AerobicGoal2"
* insert Goal(on-hold, [[Working with the Exercise Program, gradually increase your weekly exercise to at least 150 minutes/week of moderate to vigorous physical activity.]])
* insert Identifier(BSJ-PA-AerobicGoal)
* insert GoalTargetMinWeek(2024-01-26, 150)
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])

Instance:       BSJ-PA-AerobicGoal3
InstanceOf:     PAGoal
Title:          "BSJ-PA-AerobicGoal3"
Description:    "BSJ-PA-AerobicGoal3"
* insert Goal(active, [[Working with the Exercise Program, gradually increase your weekly exercise to at least 150 minutes/week of moderate to vigorous physical activity.]])
* insert Identifier(BSJ-PA-AerobicGoal)
* insert GoalTargetMinWeek(2024-03-24, 150)
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])
* insert NoteGP(2024-01-24, [[Goal due date re-established for end of new 12-week exercise program]])

Instance:       BSJ-PA-FatigueGoal
InstanceOf:     PAGoal
Title:          "BSJ-PA-FatigueGoal"
Description:    "BSJ-PA-FatigueGoal"
* insert Goal(active, [[Working with the Exercise Program to increase overall physical activity,\\ improve Fatigue Assessment Scale score by at least 4 points.]])
* insert Identifier(BSJ-PA-FatigueGoal)
* insert GoalTargetSnomed(2024-01-26, 445784002, "Assessment using fatigue impact scale", 16)
* insert GoalAddresses(BSJ-FatigueCondition, [[Neoplastic (malignant) related fatigue]])
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])

Instance:       BSJ-PA-FatigueGoal2
InstanceOf:     PAGoal
Title:          "BSJ-PA-FatigueGoal2"
Description:    "BSJ-PA-FatigueGoal2"
* insert Goal(on-hold, [[Working with the Exercise Program to increase overall physical activity,\\ improve Fatigue Assessment Scale score by at least 4 points.]])
* insert Identifier(BSJ-PA-FatigueGoal)
* insert GoalTargetSnomed(2024-01-26, 445784002, "Assessment using fatigue impact scale", 16)
* insert GoalAddresses(BSJ-FatigueCondition, [[Neoplastic (malignant) related fatigue]])
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])

Instance:       BSJ-PA-FatigueGoal3
InstanceOf:     PAGoal
Title:          "BSJ-PA-FatigueGoal3"
Description:    "BSJ-PA-FatigueGoal3"
* insert Goal(active, [[Working with the Exercise Program to increase overall physical activity,\\ improve Fatigue Assessment Scale score by at least 4 points.]])
* insert Identifier(BSJ-PA-FatigueGoal)
* insert GoalTargetSnomed(2024-03-24, 445784002, "Assessment using fatigue impact scale", 16)
* insert GoalAddresses(BSJ-FatigueCondition, [[Neoplastic (malignant) related fatigue]])
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])
* insert NoteGP(2024-01-24, [[Goal due date re-established for end of new 12-week exercise program]])

Instance:       BSJ-PA-PowerGoal
InstanceOf:     PAGoal
Title:          "BSJ-PA-PowerGoal"
Description:    "BSJ-PA-PowerGoal"
* insert Goal(active, [[Working with the Exercise Program, improve sit-to-stand frequency in 30 seconds by two (2) sit-to-stand cycles.]])
* insert Identifier(BSJ-PA-PowerGoal)
* insert GoalTarget(2024-03-24, 66247-8, "Sit to stand frequency in 30 seconds", 16 '/30.s')
* insert GoalAddresses(BSJ-HemiparesisDiagnosis, [[Hemi-paresis]])
* insert GoalAddresses(OT-ProblemList-RightWeak, [[Right sided weakness]])
* insert GoalAddresses(OT-ProblemList-RightWeak, [[Physical deconditioning]])
* insert NoteGP(2024-01-24, [[Goal due date is based on 12-week exercise oncology program]])

Instance:       BSJ-PA-StrengthGoal
InstanceOf:     PAGoal
Title:          "BSJ-PA-StrengthGoal"
Description:    "BSJ-PA-StrengthGoal"
* insert Goal(active, [[Working with the Exercise Program,\\ increase your weekly exercise muscle strengthening exercises to at least two (2) days/week.]])
* insert Identifier(BSJ-PA-StrengthGoal)
* insert GoalTarget(2024-01-26, 82291-6, "Frequency of muscle-strengthening physical activity", 2 'd/wk')
* insert GoalAddresses(BSJ-PACondition, [[Lack of Physical Exercise]])
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])

Instance:       BSJ-PA-StrengthGoal2
InstanceOf:     PAGoal
Title:          "BSJ-PA-StrengthGoal2"
Description:    "BSJ-PA-StrengthGoal2"
* insert Goal(on-hold, [[Working with the Exercise Program,\\ increase your weekly exercise muscle strengthening exercises to at least two (2) days/week.]])
* insert Identifier(BSJ-PA-StrengthGoal)
* insert GoalTarget(2024-01-26, 82291-6, "Frequency of muscle-strengthening physical activity", 2 'd/wk')
* insert GoalAddresses(BSJ-PACondition, [[Lack of Physical Exercise]])
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])

Instance:       BSJ-PA-StrengthGoal3
InstanceOf:     PAGoal
Title:          "BSJ-PA-StrengthGoal3"
Description:    "BSJ-PA-StrengthGoal3"
* insert Goal(active, [[Working with the Exercise Program,\\ increase your weekly exercise muscle strengthening exercises to at least two (2) days/week.]])
* insert Identifier(BSJ-PA-StrengthGoal)
* insert GoalTarget(2024-03-24, 82291-6, "Frequency of muscle-strengthening physical activity", 2 'd/wk')
* insert GoalAddresses(BSJ-PACondition, [[Lack of Physical Exercise]])
* insert NoteGP(2023-10-25, [[Goal due date is based on 12-week exercise oncology program]])
* insert NoteGP(2023-12-18, [[Goal on hold due to stroke hospitalization]])
* insert NoteGP(2024-01-24, [[Goal due date re-established for end of new 12-week exercise program]])

Instance: BSJ-PA-Fatigue1
InstanceOf: Observation
Title:       "Second Fatigue"
Description:  "BSJ Fatigue Score second assessment"
Usage: #example
* insert FatigueObs(2023-12-18, 20, "Fatigue")

Instance: BSJ-PA-EVSdays2
InstanceOf: PAObservationEVSDaysPerWeek
Title:       "Final EVS Days"
Description:  "BSJ Days/week final assessment"
Usage: #example
* insert DaysPerWeek(2024-01-24, 2)

Instance: BSJ-PA-EVSmin2
InstanceOf: PAObservationEVSMinutesPerDay
Title:       "Final EVS Days"
Description:  "BSJ Min/Day final assessment"
Usage: #example
* insert MinPerDay(2024-01-24, 30)

Instance: BSJ-PA-EVS2
InstanceOf: PAObservationEVSMinutesPerWeek
Title:       "Initial EVS Minutes"
Description:  "BSJ Minutes/week initial assessment"
Usage: #example
* insert MinPerWeek(2024-01-24, 60)
* derivedFrom = Reference(BSJ-PA-EVSdays2)
* derivedFrom = Reference(BSJ-PA-EVSmin2)

Instance: BSJ-PA-Strength2
InstanceOf: PAObservationStrengthDaysPerWeek
Title:       "Final EVS Strength"
Description:  "BSJ Strength/week final assessment"
Usage: #example
* insert StrengthPerWeek(2024-01-24, 2)

Instance: BSJ-PA-Fatigue2
InstanceOf: Observation
Title:       "Final Fatigue"
Description:  "BSJ Fatigue Score final assessment"
Usage: #example
* insert FatigueObs(2024-01-24, 28, "Fatigue")


// High level observations
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

