USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'StudentsGraph')
BEGIN
    ALTER DATABASE StudentsGraph SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE StudentsGraph;
END
GO

CREATE DATABASE StudentsGraph;
GO

USE StudentsGraph;
GO


-- �������� ������ �����
-- �������� ������� ��������
CREATE TABLE Student (
    StudentID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
) AS NODE;

-- �������� ������� ������������
CREATE TABLE University (
    UniversityID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Country NVARCHAR(50),
) AS NODE;

-- �������� ������� ������
CREATE TABLE City (
    CityID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
) AS NODE;


-- �������� ������ �����
-- �������� ������� ������ �
CREATE TABLE FriendsWith AS EDGE;

-- �������� ������� ��������� �
CREATE TABLE ResidesIn AS EDGE;

-- �������� ������� ������ �
CREATE TABLE StudiesAt AS EDGE;
ALTER TABLE StudiesAt
ADD Rating INT NOT NULL;


-- ������� � ������� �����
-- ������� ������ � ������� Student
INSERT INTO Student (Name) VALUES
(N'����'), (N'�����'), (N'����'), (N'�����'), (N'�������'),
(N'�����'), (N'������'), (N'����'), (N'�������'), (N'���������'),
(N'�������'), (N'�������');

-- ������� ������ � ������� University
INSERT INTO University (Name, Country) VALUES
(N'���', N'������'), (N'�����', N'������'), (N'���', N'������'),
(N'����', N'������'), (N'���', N'������'), (N'��������', N'��������������'),
(N'��������', N'�������'), (N'MIT', N'���'), (N'��������� �����������', N'������'),
(N'������ �����������', N'�����');

-- ������� ������ � ������� City
INSERT INTO City (Name) VALUES
(N'�����'), (N'������'), (N'������'), (N'�������'),
(N'������'), (N'�����'), (N'����������'), (N'��������'),
(N'�����'), (N'����');

-- ������� ������ � ������� FriendsWith
INSERT INTO FriendsWith ($from_id, $to_id) VALUES
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'����')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM Student WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'����')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'������'), (SELECT $node_id FROM Student WHERE Name = N'���������')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM Student WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'���������'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM Student WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM Student WHERE Name = N'����')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'������'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM Student WHERE Name = N'���������')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM Student WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'���������'), (SELECT $node_id FROM Student WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM Student WHERE Name = N'�������'));


-- ������� ������ � ������� ResidesIn
INSERT INTO ResidesIn ($from_id, $to_id) VALUES
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM City WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM City WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM City WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM City WHERE Name = N'�������')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM City WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM City WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'������'), (SELECT $node_id FROM City WHERE Name = N'����������')),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM City WHERE Name = N'��������')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM City WHERE Name = N'�����')),
((SELECT $node_id FROM Student WHERE Name = N'���������'), (SELECT $node_id FROM City WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM City WHERE Name = N'������')),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM City WHERE Name = N'�������'));

-- ������� ������ � ������� StudiesAt
INSERT INTO StudiesAt ($from_id, $to_id, Rating) VALUES
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM University WHERE Name = N'���'), 7),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM University WHERE Name = N'�����'), 6),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM University WHERE Name = N'��������'), 8),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM University WHERE Name = N'��������'), 10),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM University WHERE Name = N'MIT'), 10),
((SELECT $node_id FROM Student WHERE Name = N'�����'), (SELECT $node_id FROM University WHERE Name = N'��������� �����������'), 9),
((SELECT $node_id FROM Student WHERE Name = N'������'), (SELECT $node_id FROM University WHERE Name = N'������ �����������'), 6),
((SELECT $node_id FROM Student WHERE Name = N'����'), (SELECT $node_id FROM University WHERE Name = N'���'), 9),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM University WHERE Name = N'���'), 4),
((SELECT $node_id FROM Student WHERE Name = N'���������'), (SELECT $node_id FROM University WHERE Name = N'����'), 10),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM University WHERE Name = N'���'), 6),
((SELECT $node_id FROM Student WHERE Name = N'�������'), (SELECT $node_id FROM University WHERE Name = N'�����'), 5);


--������� � �������������� Match
--����� ���� ������ ����
SELECT friend.Name AS FriendName
FROM Student AS s, FriendsWith AS fw, Student AS friend
WHERE MATCH(s-(fw)->friend)
  AND s.Name = N'����';

-- ����� ���� ���������� ��������� � �������� �� ������������
SELECT s.Name AS StudentName, u.Name AS University
FROM Student AS s, StudiesAt AS sa, University AS u
WHERE MATCH(s-(sa)->u)
  AND u.Country = N'������';

-- ������� ������ ��������� ���
SELECT student.Name AS MGU_Student, friend.Name AS Friend
FROM Student AS student, StudiesAt AS sa, University AS u,
     FriendsWith AS fw, Student AS friend
WHERE MATCH(student-(sa)->u AND student-(fw)->friend)
  AND u.Name = N'���';

-- ������� ���������� ��������� ����� �� ������
SELECT s.Name AS StudentName, u.Name AS University
FROM Student s, ResidesIn ri, City c, StudiesAt sa, University u
WHERE MATCH(s-(ri)->c AND s-(sa)->u)
  AND c.Name = N'�����'
  AND u.Country = N'������';

-- ������� ��� ��������� ����� ����� ����������
SELECT 
    s1.Name AS Student1,
    s2.Name AS Student2
FROM 
    Student s1,
    FriendsWith fw,
    Student s2
WHERE MATCH(s1-(fw)->s2)
ORDER BY s1.Name, s2.Name;


--������� � �������������� SHORTEST_PATH
--������� ���������� ���� ������ �� ���� �� ������� ������ �� 1 �� 2 �����
WITH FriendshipPaths AS (
    SELECT 
        s1.Name AS StartStudent,
        LAST_VALUE(friend.Name) WITHIN GROUP (GRAPH PATH) AS EndStudent,
        STRING_AGG(friend.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendshipPath,
        COUNT(friend.Name) WITHIN GROUP (GRAPH PATH) AS PathLength
    FROM 
        Student AS s1,
        FriendsWith FOR PATH AS fw,
        Student FOR PATH AS friend
    WHERE MATCH(SHORTEST_PATH(s1(-(fw)->friend){1,2}))
)
SELECT StartStudent, EndStudent, FriendshipPath
FROM FriendshipPaths
WHERE StartStudent = N'����' AND EndStudent = N'�������';


-- ����� ���������� ���� ������ �� ���� �� ���� ������ ���������
SELECT
    s1.Name AS StartStudent, 
    LAST_VALUE(friend.Name) WITHIN GROUP (GRAPH PATH) AS EndStudent, 
    STRING_AGG(friend.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendshipPath,
    COUNT(friend.Name) WITHIN GROUP (GRAPH PATH) AS PathLength
FROM
    Student AS s1, 
    FriendsWith FOR PATH AS fw, 
    Student FOR PATH AS friend 
WHERE MATCH(SHORTEST_PATH(s1(-(fw)->friend)+)) 
  AND s1.Name = N'����'
ORDER BY PathLength, EndStudent;

