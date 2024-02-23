// Background instances (presume these already exist with the specified ids)

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

Instance: OT-ProblemList-RightWeak
InstanceOf: USCoreCondition
Title:       "Condition - Right-side weakness"
Description:  "BSJ RightWeak"
Usage: #example
* insert Condition(PractitionerAnitaChu, [[Anita Chu\, MD]], $sct#570961000124101, [[Weakness of right upper limb (finding)]], 2024-01-01)

// Transactions (what we will actually import with)

Instance: BSJ-Visit1
InstanceOf: Bundle
Title:       "Initial Visit Bundle"
Description:  "BSJ resources created in first visit - 2023-10-25"
Usage: #example
* insert TxnBundle
* insert TxnEntry(Condition, BSJ-PACondition)
* insert TxnEntry(Condition, BSJ-FatigueCondition)
* insert TxnEntry(Goal, BSJ-PA-AerobicGoal1)
* insert TxnEntry(Goal, BSJ-PA-FatigueGoal1)
* insert TxnEntry(Goal, BSJ-PA-StrengthGoal1)

Instance: BSJ-Home
InstanceOf: Bundle
Title:       "Home data capture Bundle"
Description:  "BSJ resources created by patient at home (pre-stroke) - 2023-11-03"
Usage: #example
* insert TxnBundle
* insert TxnEntryObs(BSJ-PA-Support)
* insert TxnEntryObs(BSJ-PA-Support1)
* insert TxnEntryObs(BSJ-PA-Support2)
* insert TxnEntryObs(BSJ-PA-Support3)
* insert TxnEntryObs(BSJ-PA-Support4)
* insert TxnEntryObs(BSJ-PA-Support5)
* insert TxnEntryObs(BSJ-PA-Support6)

Instance: BSJ-Visit2
InstanceOf: Bundle
Title:       "Second Visit Bundle"
Description:  "BSJ resources created in second visit (post stroke) - 2023-12-18.  Must be imported after Visit1 Bundle"
Usage: #example
* insert TxnBundle
* insert TxnEntryCond(Goal, BSJ-PA-AerobicGoal2, BSJ-PA-AerobicGoal2)
* insert TxnEntryCond(Goal, BSJ-PA-FatigueGoal2, BSJ-PA-FatigueGoal2)
* insert TxnEntryCond(Goal, BSJ-PA-StrengthGoal2, BSJ-PA-StrengthGoal)

Instance: BSJ-Visit3
InstanceOf: Bundle
Title:       "Third Visit Bundle"
Description:  "BSJ resources created in second visit (post stroke) - 2023-12-18.  Must be imported after Visit2 Bundle"
Usage: #example
* insert TxnBundle
* insert TxnEntryCond(Goal, BSJ-PA-AerobicGoal3, BSJ-PA-AerobicGoal)
* insert TxnEntryCond(Goal, BSJ-PA-FatigueGoal3, BSJ-PA-FatigueGoal)
* insert TxnEntryCond(Goal, BSJ-PA-StrengthGoal3, BSJ-PA-StrengthGoal)
* insert TxnEntry(Goal, BSJ-PA-PowerGoal)


// Data to load

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

Instance:       BSJ-PA-FatigueGoal1
InstanceOf:     PAGoal
Title:          "BSJ-PA-FatigueGoal1"
Description:    "BSJ-PA-FatigueGoal1"
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

Instance:       BSJ-PA-StrengthGoal1
InstanceOf:     PAGoal
Title:          "BSJ-PA-StrengthGoal1"
Description:    "BSJ-PA-StrengthGoal1"
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

