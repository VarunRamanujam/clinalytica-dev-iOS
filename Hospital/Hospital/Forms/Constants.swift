//
//  Constants.swift
//  Hospital
//
//  Created by Shridhar on 2/2/17.
//
//

import Foundation

let Text_Length = 125
let Comment_Length = 50

let Form_Number_Length = 3
let Study_Length = 4
let Center_Length = 4
let Patient_Number_Length = 6
let Total_Income_Length = 6
let Study_Week_Number_Length = 6
let Medical_Event_Code_Length = 6
let Code_Drug_Length = 3
let Strength_Length = 4
let Doses_Per_Day_Length = 3
let Code_Indication_Length = 60
let Event_Code_Length = 4

let RaceOptions = ["White, not of Hispanic origin", "Black, not of Hispanic origin", "American Indian", "Alaskan Native", "Asian or Pacific Islander", "Hispanic"]

let EducationOptions = ["Completed graduate/professional training",
                        "Standard college/university graduate",
                        "Partial college training",
                        "High school graduate",
                        "Partial high school (10th - 11th grade)",
                        "Junior high school (7th - 9th grade)",
                        "Under 7 years schooling"]

let WorkDuringThePast3Years = ["Never gainfully employed",
                               "Unskilled employee",
                               "Machine operator, semi-skilled employee",
                               "Skilled manual employee",
                               "Clerical or sales worker, technician, owner of small business",
                               "Administrative personal, owner of small independent business, minor professional",
                               "Business manager of large concern, proprietor of medium-sized business, lesser professional",
                               "Higher executive, proprietor of large concern, major professional"]

let PastEmploymentOptions = ["Full-time (40 hours/week)",
                             "Part-time (regular hours)",
                             "Part-time (irregular workday)",
                             "Student",
                             "Military service",
                             "Retired/disability",
                             "Unemployed",
                             "In controlled environment"]

let MaritalOptions = ["Married",
                      "Remarried",
                      "Windowed",
                      "Separated",
                      "Divorced",
                      "Never Married"]
let UsualLivingArrangementsOptions = ["With sexual partner and children",
                                      "With sexual partner alone",
                                      "With parents",
                                      "With family",
                                      "With friends",
                                      "Alone",
                                      "Controlled environment",
                                      "No stable arrangements"]
let HouseHoldOptions = ["Yes",
                        "No",
                        "Don't know"]


let StudyAdmissionQuestions = ["DSM-III-R diagnosis of current opiate dependence",
                               "Expected to remain available to attend clinic for duration of study\n(e.g., those with critical charges)",
                               "Mentally competent to give informed consent",
                               "Permanent residence within commuting distance of clinic",
                               "Patient 18 years of age or older",
                               "Pregnant or nursing female",
                               "Female of childbearing potential who refuses birth control",
                               "Acute hepatitis or any other acute medical condition that would make participation in the study medically hazardous for the patient (e.g., active tuberculosis, unstable cardiovascular or liver disease, or unstable diabetes, or AIDS)",
                               "DSM-III-R diagnosis of current alcohol dependence or sedative-hypnotics dependence",
                               "Current daily use of anticonvulsants, Antabuse, or neuroleptics",
                               "Enrolled in a methadone maintenance program in past 30 days",
                               "Positive urine for methadone",
                               "Has been a subject in a prior buprenorphine trial for drug addiction",
                               "Currently participating in another research project",
                               "Refuses to participate in study",
                               "Other, specify",
                               "IS PATIENT ELIGIBLE TO PRTICIPATE IN THE STUDY"]

let MedicalHistoryOptions = ["Head, eyes, ears, nose, throat",
                             "Cardiovascular",
                             "Respiratory",
                             "Gastrointestinal",
                             "Genitourinary",
                             "Musculoskeletal",
                             "Neurological",
                             "Endocrinological",
                             "Dermatological",
                             "Hematopoietic",
                             "Allergies",
                             "Alcoholism or drug dependency other than opiate"]

let SeverityOptions = ["Mild", "Moderate", "Severe"]
let ActionTakenOptions = ["None",
                          "Prescription drug therapy required",
                          "Inpatient hospitalization required or prolonged",
                          "Prescription drug therapy and hospitalization required"]
let OutcomeOptions = ["Resolved; No sequelae",
                      "Not yet resolved",
                      "Resulted in chronic condition, severe and/or permanent disability",
                      "Unknown"]

let Albumin = ["Absent",
               "Trace",
               "Neutral"]

let Glucose = ["0",
               "1",
               "2", "3", "4",]
let Acetone = ["Absent",
               "Trace",
               "Neutral"]
let WBCS = ["None",
            "Few",
            "Moderate",
            "Heavy"]
let RBCS = ["None",
            "Few",
            "Moderate",
            "Heavy"]

let EpithelialCells = ["None",
                       "Few",
                       "Moderate",
                       "Heavy"]

let TypeOfReportptions = ["Anticipated adverse event",
                          "Unanticipated adverse event",
                          "Intercurrent illeness",
                          "Withdrawal symptom",
                          "Development of clinically significant abnormal lab value"]

let RelatednessOptions = ["Study drug related",
                          "Probably study drug related",
                          "Possibly study drug related",
                          "Unrelated to study drug"]

let ActionTakenForm16Options = ["None",
                                "Prescription drug therapy required",
                                "Inpatient hospitalization required or prolonged",
                                "Prescription drug therapy and hospitalization required",
                                "Dropped from study due to effect",
                                "Medical specially consultation"]

let OutcomeForm16Options = ["Resolved; No sequelae",
                            "Not yet resolved",
                            "Resulted in chronic condition, severe and/or permanent disability",
                            "Deceased",
                            "Unknown"]


//Alerts
let NoInternetAccess = "No network access."
let ServerError = "Server failed to process the request"


//ResponseMessages
let okStatus = "ok"
