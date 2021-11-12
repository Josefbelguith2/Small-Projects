// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.0 <0.9.0;

contract StudentDatabase{
    
    uint public studentCount;
    address public classTeacher;
    
    constructor() {
    classTeacher = msg.sender;
    }
    
    modifier OnlyClassTeacher(address _classTeacher) {
        require(classTeacher == _classTeacher, "Only the teacher has access to this function");
        _;
    }
    
    struct StudentDetails {
        string studentFirstName;
        string studentLastName;
        uint256 id;
    }
    
    struct Score {
        uint256 studentId;
        uint256 englishMarks;
        uint256 mathsMarks;
        uint256 scienceMarks;
    }
    
    mapping (uint => StudentDetails) students;
    
    mapping (uint => Score) scores;
    
    event StudentAdded(string _studentFirstName, string _studentLastName, uint256 _studentId);
    
    event StudentScoresRecorded(uint256 _studentId, uint256 _englishMarks, uint256 _mathMarks, uint256 _scienceMarks);
    
    function addStudentDetails(string memory _studentFirstName, 
                               string memory _studentLastName) public OnlyClassTeacher(msg.sender){
                                   
        StudentDetails storage studentObj = students[studentCount];
        studentObj.studentFirstName = _studentFirstName;
        studentObj.studentLastName = _studentLastName;
        studentObj.id = studentCount;
        emit StudentAdded(_studentFirstName, _studentLastName, studentCount);
        studentCount++;
    }
    
    function addScores(uint256 _studentId, 
                       uint256 _englishMarks, 
                       uint256 _mathMarks, 
                       uint256 _scienceMarks) public OnlyClassTeacher(msg.sender){
                           
        Score storage studentScores = scores[_studentId];
        studentScores.studentId = _studentId;
        studentScores.englishMarks = _englishMarks;
        studentScores.mathsMarks = _mathMarks;
        studentScores.scienceMarks = _scienceMarks;
        emit StudentScoresRecorded(_studentId, _englishMarks, _mathMarks, _scienceMarks);
    }
}