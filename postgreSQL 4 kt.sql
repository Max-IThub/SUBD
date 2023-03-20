CREATE TABLE Education (
  ID_Education SERIAL PRIMARY KEY,
  Name_Education VARCHAR(30) NOT NULL
);

CREATE TABLE Type_Of_Code (
  ID_Type_Of_Code SERIAL PRIMARY KEY,
  Name_Type_Of_Code TEXT NOT NULL
);

CREATE TABLE Post (
  ID_Post SERIAL PRIMARY KEY,
  Name_Post TEXT NOT NULL
);

CREATE TABLE Type_Of_Report_Card (
  ID_Type_Of_Report_Card SERIAL PRIMARY KEY,
  Name_Type_Of_Report_Card TEXT NOT NULL
);

CREATE TABLE Status (
  ID_Status SERIAL PRIMARY KEY,
  Name_Status TEXT NOT NULL
);

CREATE TABLE Work_Schedule (
  ID_Work_Schedule SERIAL PRIMARY KEY,
  Start_time_Work_Schedule TIME,
  End_time_Work_Schedule TIME
);

CREATE TABLE Citizen (
    ID_Citizen SERIAL PRIMARY KEY,
    Second_Name_Citiz VARCHAR(30) NOT NULL,
    First_Name_Citiz VARCHAR(30) NOT NULL,
    Middle_Name_Citiz VARCHAR(30) DEFAULT '-',
    Date_Bir_Citiz DATE,
    Pass_Series_Citiz VARCHAR(4) NOT NULL,
    Pass_Numb_Citiz VARCHAR(6) NOT NULL,
    Dep_code_Citiz VARCHAR(7) NOT NULL,
    Add_MFC_Citiz TEXT NOT NULL,
    Date_issue_Citiz DATE,
    Add_reg_Citiz TEXT NOT NULL,
    Phone_number_Citiz VARCHAR(17) NOT NULL,
    Add_actual_residence_Сitiz TEXT NOT NULL
);

CREATE TABLE Appeal (
    ID_Appeal SERIAL PRIMARY KEY,
    Number_Appeal TEXT NOT NULL,
    Date_formation_Appeal DATE,
    Formation_time_Appeal TIME,
    Status_name_Appeal VARCHAR(30) NOT NULL,
    Qualification_Appeal VARCHAR(30) NOT NULL,
    Start_time_Appeal TIME,
    End_time_Appeal TIME
);

CREATE TABLE Candidate (
    ID_Candidate SERIAL PRIMARY KEY,
    Education_ID INT NOT NULL,
    Second_Name_Can VARCHAR(30) NOT NULL,
    First_Name_Can VARCHAR(30) NOT NULL,
    Middle_Name_Can VARCHAR(30) DEFAULT '-',
    Date_Bir_Can DATE,
    Pass_Series_Can VARCHAR(4) NOT NULL,
    Pass_Numb_Can VARCHAR(6) NOT NULL,
    Dep_code_Can VARCHAR(7) NOT NULL,
    Add_MFC_Can TEXT NOT NULL,
    Date_issue_Can DATE,
    Add_reg_Can TEXT NOT NULL,
    Med_policy_Can VARCHAR(16) NOT NULL,
    Mil_ticket_Can VARCHAR(10) NOT NULL,
    Diploma_Can VARCHAR(14) NOT NULL,
    SNILS_Can VARCHAR(14) NOT NULL,
    INN_Can VARCHAR(10) NOT NULL,
    CONSTRAINT FK_Education_Candidate FOREIGN KEY (Education_ID) REFERENCES Education (ID_Education)
);

CREATE TABLE The_Code (
    ID_The_Code SERIAL PRIMARY KEY,
    Type_Of_Code_ID INT NOT NULL,
    Name_The_Code TEXT NOT NULL,
    CONSTRAINT FK_Type_Of_Code_The_Code FOREIGN KEY (Type_Of_Code_ID) REFERENCES Type_Of_Code(ID_Type_Of_Code)
);

CREATE TABLE Article (
    ID_Article SERIAL PRIMARY KEY,
    The_Code_ID INT NOT NULL,
    Act_number_Article VARCHAR(50) NOT NULL,
    CONSTRAINT FK_The_Code_Article FOREIGN KEY (The_Code_ID) REFERENCES The_Code(ID_The_Code)
);

CREATE TABLE Department (
    ID_Department SERIAL PRIMARY KEY,
    Work_Schedule_ID INT NOT NULL,
    Name_Department VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Work_Schedule_Department FOREIGN KEY (Work_Schedule_ID) REFERENCES Work_Schedule(ID_Work_Schedule)
);

CREATE TABLE Service_Weapon (
    ID_Service_Weapon SERIAL PRIMARY KEY,
    Type_Of_Report_Card_ID INT NOT NULL,
    Number_Service_Weapon VARCHAR(5) NOT NULL,
    CONSTRAINT FK_Type_Of_Report_Card_Service_Weapon FOREIGN KEY (Type_Of_Report_Card_ID) REFERENCES Type_Of_Report_Card(ID_Type_Of_Report_Card)
);

CREATE TABLE Employee (
    ID_Employee SERIAL PRIMARY KEY,
    Department_ID INT NOT NULL REFERENCES Department (ID_Department),
    Candidate_ID INT NOT NULL REFERENCES Candidate (ID_Candidate),
    Service_Weapon_ID INT NOT NULL REFERENCES Service_Weapon (ID_Service_Weapon),
    Service_number_Employee VARCHAR(7) NOT NULL,
    Date_of_admission_Employee DATE NULL,
    Service_card_number_Employee VARCHAR(5) NOT NULL,
    Personal_file_number_Employee VARCHAR(30) NOT NULL
);

CREATE TABLE Statement ( 
	ID_Statement SERIAL PRIMARY KEY,
	Citizen_ID INT NOT NULL,
	Appeal_ID INT NOT NULL,
	CONSTRAINT FK_Citizen_Statement FOREIGN KEY (Citizen_ID) REFERENCES Citizen (ID_Citizen), 
	CONSTRAINT FK_Appeal_Statement FOREIGN KEY (Appeal_ID) REFERENCES Appeal (ID_Appeal)
);

CREATE TABLE Consequence ( 
	ID_Consequence SERIAL PRIMARY KEY,
	Employee_ID int not null,
	Article_ID int not null,
	Status_ID int not null,
	Statement_ID int not null,
	The_revealed_facts_Consequence text not null,
	CONSTRAINT FK_Employee_Consequence FOREIGN KEY (Employee_ID) REFERENCES Employee (ID_Employee),
	CONSTRAINT FK_Article_Consequence FOREIGN KEY (Article_ID) REFERENCES Article (ID_Article),
	CONSTRAINT FK_Status_Consequence FOREIGN KEY (Status_ID) REFERENCES Status (ID_Status),
	CONSTRAINT FK_Statement_Consequence FOREIGN KEY (Statement_ID) REFERENCES Statement (ID_Statement)
);

SELECT count(*) FROM information_schema.tables 
where table_schema = 'public' and table_type = 'BASE TABLE';

SELECT table_name, count(column_Name) FROM information_schema.columns 
where table_schema = 'public' group by table_name;
