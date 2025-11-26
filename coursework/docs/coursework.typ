#import "template.typ": *

= Extracting Data From `Q1_Data.xlsx`

// Define student ID to look for
#let student_id = 32750552

// Use spreet to extract the data out of the excel spreadsheet
#let excel_data_from_bytes = spreet.decode(read("../Q1_Data.xlsx", encoding: none)).at("Data")

// Define the identifiers for the table
#let identifiers = (
  "Student No.",
  $T_R$,
  $C_R$,
  $T_L$,
  $C_L$,
  ..range(1, 121).map(n => $t_(#n)$),
)

// Initialize extract data which will be populated through the for loop
#let extracted_data = ()

// For loop to sift through excel data, find student id and save data in extracted data
#for (count, row) in excel_data_from_bytes.enumerate() {
  let row_data = excel_data_from_bytes.at(count)
  let student_id_in_column_0 = row_data.at(0)
  if student_id_in_column_0 == student_id {
    extracted_data = (
      extracted_data
        + row_data
          .enumerate()
          .map(
            ((sub_count, piece)) => (identifiers.at(sub_count), piece),
          )
    )
  }
}

#figure(
  table(
    columns: 3,
    inset: 5pt,
    fill: (col, row) => if row == 0 { gray } else { white },
    align: center + horizon,
    table.header[*Quantity Name*][*Symbol*][*Value*],

    [Right Censored Time], extracted_data.at(1).at(0), [#extracted_data.at(1).at(1)],
    [Amount of Right Censored Time], extracted_data.at(2).at(0), [#extracted_data.at(2).at(1)],
    [Left Censored Time], extracted_data.at(3).at(0), [#extracted_data.at(3).at(1)],
    [Amount of Left Censored Time], extracted_data.at(4).at(0), [#extracted_data.at(4).at(1)],
    [Left Censored Frequency], extracted_data.at(5).at(0), [#extracted_data.at(5).at(1)],
  ),
  caption: [Censoring applied to data in excel based on the student id (#student_id)],
) <how-data-is-censored>


#figure(
  table(
    columns: 12,
    inset: 8pt,
    align: left,
    ..extracted_data
      .slice(5)
      .map(pair => {
        let v = pair.at(1)
        [#calc.round(v, digits: 2)]
      })
  ),
  caption: [Failure times for all 120 components.],
) <all-failure-times>
= Question 1
==
