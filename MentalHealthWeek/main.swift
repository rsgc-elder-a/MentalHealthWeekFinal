//
//  main.swift
//  MentalHealthWeek
//
//  Created by Russell Gordon on 1/12/17.
//  Copyright © 2017 Russell Gordon. All rights reserved.
//

import Foundation
var emptyArray : [[String]] = [[],[],[],[],[]] // Empty array to be used to initialize array of activities

//
// Define Globals.
//
let gradeChoiceNum = [27, 28, 28, 29] // Number of survey questions per grade
let activityChoiceOffset = 12 // Number of survey questions before the activity choices
var columnDescriptors : [String] = [] // An array for the column information
var titles : [String] = [] // An array to hold the titles
var students : [Student] = [] // An array of all the students
var activities : [Activity] = [ // An array of all the activities
    Activity(weekdays: emptyArray, shortName: "MathExam", name: "Math Exam", personCap: 500, supervisorName: "Mr. Fitz"),
    Activity(weekdays: emptyArray, shortName: "Sleep", name: "Sleep In", personCap: 500, supervisorName: "Mr. Fitz"),
    Activity(weekdays: emptyArray, shortName: "Breakfast", name: "Casual Breakfast", personCap: 160, supervisorName: "Ms. Totten"),
    Activity(weekdays: emptyArray, shortName: "Gym", name: "Physical Activity", personCap: 50, supervisorName: "Mr. T/ Mr. S"),
    Activity(weekdays: emptyArray, shortName: "Relaxation", name: "Relaxation", personCap: 160, supervisorName: "Fr. Donkin"),
    Activity(weekdays: emptyArray, shortName: "Academics", name: "Academic Management", personCap: 30, supervisorName: "Fr. D and NVH(Monday) KU (Wed-Fri) TH"),
    Activity(weekdays: emptyArray, shortName: "Yoga", name: "Yoga", personCap: 20, supervisorName: "Ms. McPhedran"),
    Activity(weekdays: emptyArray, shortName: "Animals", name: "Animal Therapy", personCap: 16, supervisorName: "Ms. Kaye/Fitz"),
    Activity(weekdays: emptyArray, shortName: "Massage", name: "Massage", personCap: 12, supervisorName: "Ms."),
]
var input = Input() // Initialize input class

// Open the input file
guard let reader = LineReader(path: "/Users/student/Desktop/MentalHealthWeekFinal/survey_response_all_data_new_headers.csv") else {
    exit(0); // cannot open file
}

for (number, line) in reader.enumerated() // Go through the data and process each student
{
    if number == 0 // If we are processing the titles
    {
        columnDescriptors = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: ",")
        
        for (column, descriptor) in columnDescriptors.enumerated()
        {
            titles.append(descriptor) // Build descriptor lookup table
        }
    } else { // If we are processing a student
        columnDescriptors = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: ",") //
        
        let student = input.getAndAssignStudent(data: columnDescriptors, titles: titles) // Get the student and assign them to the activity
        students.append(student) // Append the student to a list of students
    }
}


guard let writer = LineWriter(path: "/Users/student/Desktop/MentalHealthWeekFinal/survey_output.txt", appending: false) else {
    print("Cannot open output file") //lets us print to text document
    exit(0); // cannot open output file
}

//print(activities)
var output = Printer(stu: students, act: activities) //just intalitzingt the printer object

output.superVisorList2() // prints out the list for super visors
output.indivdualTime() //prints out lists for advisors / students

// Close the output file
writer.close() // MAKE NOTE OF THIS
