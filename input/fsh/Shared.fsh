// External Code Systems
Alias: $ICD10 = http://hl7.org/fhir/sid/icd-10-cm
Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct

// FHIR Code Systems
Alias: $obsStatus       = http://hl7.org/fhir/observation-status
Alias: $reportStatus    = http://hl7.org/fhir/diagnostic-report-status
Alias: $requestIntent   = http://hl7.org/fhir/request-intent
Alias: $task-code       = http://hl7.org/fhir/CodeSystem/task-code

// THO Code Systems
Alias: $clinicalStatus    = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $goal-achievement  = http://terminology.hl7.org/CodeSystem/goal-achievement
Alias: $obsCategory       = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $practitioner-role = http://terminology.hl7.org/CodeSystem/practitioner-role
Alias: $relationships     = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $security          = http://terminology.hl7.org/CodeSystem/restful-security-service
Alias: $verifyStatus      = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $v2-0203           = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-RoleCode       = http://terminology.hl7.org/CodeSystem/v3-RoleCode

// IG Code Systems
Alias: $careplan-category  = http://hl7.org/fhir/us/core/CodeSystem/careplan-category
Alias: $condition-category = http://hl7.org/fhir/us/core/CodeSystem/condition-category
Alias: $SDOHCC-Temp        = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes
Alias: $SDC-Temp           = http://hl7.org/fhir/uv/sdc/CodeSystem/temp


// Extensions
Alias: $conf             = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $dar              = http://hl7.org/fhir/StructureDefinition/data-absent-reason
Alias: $minLength        = http://hl7.org/fhir/StructureDefinition/minLength
Alias: $pertainsToGoal   = http://hl7.org/fhir/StructureDefinition/resource-pertainsToGoal
Alias: $typeMS           = http://hl7.org/fhir/StructureDefinition/elementdefinition-type-must-support

// Inter-version extensions
Alias: $observationFocus = http://hl7.org/fhir/5.0/StructureDefinition/extension-Observation.focus
Alias: $instanceContent  = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.content
Alias: $verContent       = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.version.content
Alias: $verTitle         = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.version.title

RuleSet: SubjectPatient
* subject = Reference(PatientBSJ1) "Betsy Smith-Johnson"

RuleSet: PerformerPatient
* performer = Reference(PatientBSJ1) "Betsy Smith-Johnson"

RuleSet: ForPatient
* for = Reference(PatientBSJ1) "Betsy Smith-Johnson"

RuleSet: OwnerPatient
* owner = Reference(PatientBSJ1) "Betsy Smith-Johnson"

// PA RuleSets
RuleSet: Note(time, author, authorName, note)
* note[+]
  * authorReference = Reference({author}) {authorName}
  * time = {time}
  * text = "{note}"

RuleSet: NoteGP(time, note)
* insert Note({time}, PractitionerAnitaChu, "Anita Chu\, MD", {note})

RuleSet: ConditionPA(asserter, asserterName, onset)
* insert SubjectPatient
* clinicalStatus = $clinicalStatus#active
* verificationStatus = $verifyStatus#confirmed
* category[+] = $condition-category#health-concern
* onsetDateTime = "{onset}"
* asserter = Reference({asserter}) "{asserterName}"

RuleSet: Condition(asserter, asserterName, code, display, onset)
* insert ConditionPA({asserter}, {asserterName}, {onset})
* code = {code} "{display}"

RuleSet: CarePlan(start, end, author, authorName, detail)
* insert SubjectPatient
* text
  * status = #additional
  * div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">{detail}</div>"
* status = #active
* intent = #plan
* period
  * start = "{start}"
  * start = "{end}"
* author = Reference({author}) {authorName}

RuleSet: Goal(status, description)
* insert SubjectPatient
* lifecycleStatus = #active
* achievementStatus = $goal-achievement#{status}
* description.text = "{description}"

RuleSet: GoalTarget(due, loinc, display, quantity)
* target
  * measure = $loinc#{loinc} {display}
  * detailQuantity = {quantity}
  * dueDate = "{due}"

RuleSet: GoalTargetMinWeek(due, quantityNum)
* insert GoalTarget({due}, 82290-8, "Frequency of moderate to vigorous aerobic physical activity", {quantityNum} 'min/wk')

RuleSet: ExerciseReferral(start, end, author, authorName, code, display)
* insert SubjectPatient
* status = #active
* intent = #order
* priority = #routine
* code = {code} "{display}"
* requester = Reference({author}) {authorName}
* authoredOn = "{start}"
* occurrencePeriod
  * start = "{start}"
  * end = "{end}"

RuleSet: ExerciseRx(start, end, author, authorName)
* insert PerformerPatient
* insert ExerciseReferral({start}, {end}, {author}, {authorName}, $sct#229065009, [[Exercise therapy (regime/therapy)]])

RuleSet: FulfillTask(requester, requesterName, owner, ownerName, order, status, date)
* insert ForPatient
* status = #{status}
* intent = #order
* code = $task-code#fulfill
* focus = Reference({order})
* requester = Reference({requester}) {requesterName}
* authoredOn = "{date}"
* owner = Reference({owner}) {ownerName}

RuleSet: QuestionnaireTask(requester, requesterName, priority, date, status, canonical, description)
* insert ForPatient
* insert OwnerPatient
* status = #{status}
* intent = #order
* priority = #{priority}
* code = $SDC-Temp#complete-questionnaire
* description = "{description}"
* authoredOn = {date}
* requester = Reference({requester}) {requesterName}
* input[Questionnaire].valueCanonical = "{canonical}"

RuleSet: ReviewTask(requester, requesterName, priority, date, status, content, description)
* insert ForPatient
* insert OwnerPatient
* status = #{status}
* intent = #order
* priority = #{priority}
* code = $SDOHCC-Temp#review-material
* focus = Reference({content})
* description = "{description}"
* authoredOn = {date}
* requester = Reference({requester}) {requesterName}

RuleSet: DocRefVideo(url)
* status = #current
* content[+]
  * attachment
    * contentType = #video/mp4
    * url = "{url}"

RuleSet: Questionnaire(url, version)
* url = "{url}"
* version = "{version}"
* status = #active
* subjectType = #Patient

RuleSet: Question(linkId, type, text)
* item[+]
  * linkId = "{linkId}"
  * text = "{text}"
  * type = #{type}

RuleSet: QuestionnaireResponse(date, questionnaire)
* insert SubjectPatient
* status = #completed
* questionnaire = "{questionnaire}"
* authored = {date}

RuleSet: BooleanAnswer(linkId, answer, text)
* item[+]
  * linkId = "{linkId}"
  * text = "{text}"
  * answer.valueBoolean = {answer}

RuleSet: StringAnswer(linkId, answer, text)
* item[+]
  * linkId = "{linkId}"
  * text = "{text}"
  * answer.valueString = {answer}

RuleSet: DiagnosticReport(performer, performerName, code, display, order, start, end, base64)
* insert SubjectPatient
* basedOn = Reference({order})
* status = #final
* code = {code} {display}
* effectivePeriod
  * start = "{start}"
  * end   = "{end}"
* performer = Reference({performer}) {performerName}
* presentedForm
  * contentType = #application/pdf
  * data = {base64}


// Bundle RuleSets
RuleSet: SearchBundle
* type = #transaction

RuleSet: TxnEntry(type, resourceId)
* entry[+]
  * fullUrl = "http://example.org/fhir/{type}/{resourceId}"
  * resource = {resourceId}
  * request.method = #POST
  * request.url = "http://example.org/fhir/{type}/{resourceId}"

RuleSet: TxnEntryObs(resourceId)
* insert TxnEntry(Observation, {resourceId})

// Observation RuleSets
RuleSet: Observation(effective)
* insert SubjectPatient
* insert PerformerPatient
* status = #final
* effectiveDateTime = "{effective}"

RuleSet: ObservationPeriod(performer, performerName, start, end)
* insert SubjectPatient
* status = #final
* effectivePeriod
  * start = "{start}"
  * end = "{end}"
* performer = Reference({performer}) {performerName}

// Exercise Vital Sign
RuleSet: DaysPerWeek(effective, value)
* insert Observation({effective})
* code = $loinc#89555-7 "How many days per week did you engage in moderate to strenuous physical activity in the last 30 days"
* valueQuantity = {value} 'd/wk' "days per week"

RuleSet: MinPerDay(effective, value)
* insert Observation({effective})
* code = $loinc#68516-4 "On those days that you engage in moderate to strenuous exercise, how many minutes, on average, do you exercise"
* valueQuantity = {value} 'min/d' "minutes per day"

RuleSet: MinPerWeek(effective, value)
* insert Observation({effective})
* code = $loinc#82290-8 "Frequency of moderate to vigorous aerobic physical activity"
* valueQuantity = {value} 'min/wk' "minutes per week"

RuleSet: StrengthPerWeek(effective, value)
* insert Observation({effective})
* code = $loinc#82291-6 "Frequency of muscle-strengthening physical activity"
* valueQuantity = {value} 'd/wk' "days per week"

// Activity Measures
RuleSet: ActivityGroup(effective)
* insert Observation({effective})
* code = PATemporaryCodes#PAPanel "Physical Activity Panel"

RuleSet: HasMember(target)
* hasMember = Reference({target})

RuleSet: ActivityType(effective, code, display)
* insert Observation({effective})
* code = $loinc#73985-4 "Exercise activity"
* valueCodeableConcept = $loinc#{code} {display}

RuleSet: ActivityTypeText(effective, code, display, text)
* insert ActivityType({effective}, {code}, {display})
* valueCodeableConcept.text = "{text}"

RuleSet: ActivityTypeOther(effective, text)
* insert ActivityTypeText({effective}, LL734-5, "Exercise", [[Exercise - {text}]])

RuleSet: ActivityDuration(effective, value)
* insert Observation({effective})
* code = $loinc#55411-3 "Exercise duration"
* valueQuantity = {value} 'min' "minutes"

RuleSet: ActivityModerate(effective, value)
* insert Observation({effective})
* code = $loinc#77592-4 "Moderate physical activity [IPAQ]"
* valueQuantity = {value} 'min' "minutes"

RuleSet: ActivityVigorous(effective, value)
* insert Observation({effective})
* code = $loinc#77593-2 "Vigorous physical activity [IPAQ]"
* valueQuantity = {value} 'min' "minutes"

RuleSet: PeakHeartRate(effective, value)
* insert Observation({effective})
* code = $loinc#55426-1 "Heart rate unspecified time maximum by Pedometer"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: MeanHeartRate(effective, value)
* insert Observation({effective})
* code = $loinc#55425-3 "Heart rate unspecified time mean by Pedometer"
* code.coding[+] = $loinc#8867-4 "Heart rate"
* category[+] = $obsCategory#vital-signs
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: ActivityCalories(effective, value)
* insert Observation({effective})
* code = $loinc#55424-6 "Calories burned in unspecified time Pedometer"
* valueQuantity = {value} 'kcal' "kilocalories"

RuleSet: ActivityExperience(effective, code, display)
* insert Observation({effective})
* code = PATemporaryCodes#Experience "Experience of Activity"
* valueCodeableConcept = PATemporaryCodes#{code} {display}


// Time-based Measures
RuleSet: DailySteps(effective, value)
* insert Observation({effective})
* code = $loinc#41950-7 "Number of steps in 24 hour Measured"
* valueQuantity = {value} '/d' "steps per day"

RuleSet: DailyPeakHR(effective, value)
* insert Observation({effective})
* code = $loinc#8873-2  "Heart rate 24 hour maximum"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: RestingHR(performer, performerName, start, end, value)
* insert ObservationPeriod({performer}, {performerName}, {start}, {end})
* code = $loinc#40443-4 "Heart rate --resting"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: DailyCalories(effective, value)
* insert Observation({effective})
* code = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* valueQuantity = {value} 'kcal/d' "kilokalories per day"