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


-- Создание таблиц узлов
-- Создание таблицы Студенты
CREATE TABLE Student (
    StudentID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
) AS NODE;

-- Создание таблицы Университеты
CREATE TABLE University (
    UniversityID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Country NVARCHAR(50),
) AS NODE;

-- Создание таблицы Города
CREATE TABLE City (
    CityID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
) AS NODE;


-- Создание таблиц ребер
-- Создание таблицы Дружит с
CREATE TABLE FriendsWith AS EDGE;

-- Создание таблицы Проживает в
CREATE TABLE ResidesIn AS EDGE;

-- Создание таблицы Учится в
CREATE TABLE StudiesAt AS EDGE;
ALTER TABLE StudiesAt
ADD Rating INT NOT NULL;


-- Вставка в таблицы узлов
-- Вставка данных в таблицу Student
INSERT INTO Student (Name) VALUES
(N'Иван'), (N'Мария'), (N'Петр'), (N'Елена'), (N'Алексей'),
(N'Ольга'), (N'Сергей'), (N'Анна'), (N'Дмитрий'), (N'Екатерина'),
(N'Николай'), (N'Татьяна');

-- Вставка данных в таблицу University
INSERT INTO University (Name, Country) VALUES
(N'МГУ', N'Россия'), (N'СПбГУ', N'Россия'), (N'НГУ', N'Россия'),
(N'МФТИ', N'Россия'), (N'ВШЭ', N'Россия'), (N'Кембридж', N'Великобритания'),
(N'Сорбонна', N'Франция'), (N'MIT', N'США'), (N'Токийский университет', N'Япония'),
(N'Карлов университет', N'Чехия');

-- Вставка данных в таблицу City
INSERT INTO City (Name) VALUES
(N'Минск'), (N'Гомель'), (N'Могилёв'), (N'Витебск'),
(N'Гродно'), (N'Брест'), (N'Барановичи'), (N'Бобруйск'),
(N'Пинск'), (N'Орша');

-- Вставка данных в таблицу FriendsWith
INSERT INTO FriendsWith ($from_id, $to_id) VALUES
((SELECT $node_id FROM Student WHERE Name = N'Иван'), (SELECT $node_id FROM Student WHERE Name = N'Мария')),
((SELECT $node_id FROM Student WHERE Name = N'Иван'), (SELECT $node_id FROM Student WHERE Name = N'Петр')),
((SELECT $node_id FROM Student WHERE Name = N'Мария'), (SELECT $node_id FROM Student WHERE Name = N'Елена')),
((SELECT $node_id FROM Student WHERE Name = N'Мария'), (SELECT $node_id FROM Student WHERE Name = N'Алексей')),
((SELECT $node_id FROM Student WHERE Name = N'Петр'), (SELECT $node_id FROM Student WHERE Name = N'Сергей')),
((SELECT $node_id FROM Student WHERE Name = N'Петр'), (SELECT $node_id FROM Student WHERE Name = N'Анна')),
((SELECT $node_id FROM Student WHERE Name = N'Алексей'), (SELECT $node_id FROM Student WHERE Name = N'Дмитрий')),
((SELECT $node_id FROM Student WHERE Name = N'Сергей'), (SELECT $node_id FROM Student WHERE Name = N'Екатерина')),
((SELECT $node_id FROM Student WHERE Name = N'Елена'), (SELECT $node_id FROM Student WHERE Name = N'Ольга')),
((SELECT $node_id FROM Student WHERE Name = N'Ольга'), (SELECT $node_id FROM Student WHERE Name = N'Николай')),
((SELECT $node_id FROM Student WHERE Name = N'Дмитрий'), (SELECT $node_id FROM Student WHERE Name = N'Татьяна')),
((SELECT $node_id FROM Student WHERE Name = N'Екатерина'), (SELECT $node_id FROM Student WHERE Name = N'Татьяна')),
((SELECT $node_id FROM Student WHERE Name = N'Иван'), (SELECT $node_id FROM Student WHERE Name = N'Ольга')),
((SELECT $node_id FROM Student WHERE Name = N'Мария'), (SELECT $node_id FROM Student WHERE Name = N'Сергей')),
((SELECT $node_id FROM Student WHERE Name = N'Петр'), (SELECT $node_id FROM Student WHERE Name = N'Дмитрий')),
((SELECT $node_id FROM Student WHERE Name = N'Елена'), (SELECT $node_id FROM Student WHERE Name = N'Анна')),
((SELECT $node_id FROM Student WHERE Name = N'Алексей'), (SELECT $node_id FROM Student WHERE Name = N'Николай')),
((SELECT $node_id FROM Student WHERE Name = N'Сергей'), (SELECT $node_id FROM Student WHERE Name = N'Татьяна')),
((SELECT $node_id FROM Student WHERE Name = N'Анна'), (SELECT $node_id FROM Student WHERE Name = N'Екатерина')),
((SELECT $node_id FROM Student WHERE Name = N'Дмитрий'), (SELECT $node_id FROM Student WHERE Name = N'Николай')),
((SELECT $node_id FROM Student WHERE Name = N'Екатерина'), (SELECT $node_id FROM Student WHERE Name = N'Ольга')),
((SELECT $node_id FROM Student WHERE Name = N'Николай'), (SELECT $node_id FROM Student WHERE Name = N'Татьяна'));


-- Вставка данных в таблицу ResidesIn
INSERT INTO ResidesIn ($from_id, $to_id) VALUES
((SELECT $node_id FROM Student WHERE Name = N'Иван'), (SELECT $node_id FROM City WHERE Name = N'Минск')),
((SELECT $node_id FROM Student WHERE Name = N'Мария'), (SELECT $node_id FROM City WHERE Name = N'Гомель')),
((SELECT $node_id FROM Student WHERE Name = N'Петр'), (SELECT $node_id FROM City WHERE Name = N'Могилёв')),
((SELECT $node_id FROM Student WHERE Name = N'Елена'), (SELECT $node_id FROM City WHERE Name = N'Витебск')),
((SELECT $node_id FROM Student WHERE Name = N'Алексей'), (SELECT $node_id FROM City WHERE Name = N'Гродно')),
((SELECT $node_id FROM Student WHERE Name = N'Ольга'), (SELECT $node_id FROM City WHERE Name = N'Брест')),
((SELECT $node_id FROM Student WHERE Name = N'Сергей'), (SELECT $node_id FROM City WHERE Name = N'Барановичи')),
((SELECT $node_id FROM Student WHERE Name = N'Анна'), (SELECT $node_id FROM City WHERE Name = N'Бобруйск')),
((SELECT $node_id FROM Student WHERE Name = N'Дмитрий'), (SELECT $node_id FROM City WHERE Name = N'Минск')),
((SELECT $node_id FROM Student WHERE Name = N'Екатерина'), (SELECT $node_id FROM City WHERE Name = N'Гомель')),
((SELECT $node_id FROM Student WHERE Name = N'Николай'), (SELECT $node_id FROM City WHERE Name = N'Могилёв')),
((SELECT $node_id FROM Student WHERE Name = N'Татьяна'), (SELECT $node_id FROM City WHERE Name = N'Витебск'));

-- Вставка данных в таблицу StudiesAt
INSERT INTO StudiesAt ($from_id, $to_id, Rating) VALUES
((SELECT $node_id FROM Student WHERE Name = N'Иван'), (SELECT $node_id FROM University WHERE Name = N'МГУ'), 7),
((SELECT $node_id FROM Student WHERE Name = N'Мария'), (SELECT $node_id FROM University WHERE Name = N'СПбГУ'), 6),
((SELECT $node_id FROM Student WHERE Name = N'Петр'), (SELECT $node_id FROM University WHERE Name = N'Кембридж'), 8),
((SELECT $node_id FROM Student WHERE Name = N'Елена'), (SELECT $node_id FROM University WHERE Name = N'Сорбонна'), 10),
((SELECT $node_id FROM Student WHERE Name = N'Алексей'), (SELECT $node_id FROM University WHERE Name = N'MIT'), 10),
((SELECT $node_id FROM Student WHERE Name = N'Ольга'), (SELECT $node_id FROM University WHERE Name = N'Токийский университет'), 9),
((SELECT $node_id FROM Student WHERE Name = N'Сергей'), (SELECT $node_id FROM University WHERE Name = N'Карлов университет'), 6),
((SELECT $node_id FROM Student WHERE Name = N'Анна'), (SELECT $node_id FROM University WHERE Name = N'ВШЭ'), 9),
((SELECT $node_id FROM Student WHERE Name = N'Дмитрий'), (SELECT $node_id FROM University WHERE Name = N'НГУ'), 4),
((SELECT $node_id FROM Student WHERE Name = N'Екатерина'), (SELECT $node_id FROM University WHERE Name = N'МФТИ'), 10),
((SELECT $node_id FROM Student WHERE Name = N'Николай'), (SELECT $node_id FROM University WHERE Name = N'МГУ'), 6),
((SELECT $node_id FROM Student WHERE Name = N'Татьяна'), (SELECT $node_id FROM University WHERE Name = N'СПбГУ'), 5);


--Запросы с использованием Match
--Найти всех друзей Анны
SELECT friend.Name AS FriendName
FROM Student AS s, FriendsWith AS fw, Student AS friend
WHERE MATCH(s-(fw)->friend)
  AND s.Name = N'Анна';

-- Найти всех российских студентов и выввести их университеты
SELECT s.Name AS StudentName, u.Name AS University
FROM Student AS s, StudiesAt AS sa, University AS u
WHERE MATCH(s-(sa)->u)
  AND u.Country = N'Россия';

-- Вывести друзей студентов МГУ
SELECT student.Name AS MGU_Student, friend.Name AS Friend
FROM Student AS student, StudiesAt AS sa, University AS u,
     FriendsWith AS fw, Student AS friend
WHERE MATCH(student-(sa)->u AND student-(fw)->friend)
  AND u.Name = N'МГУ';

-- Вывести российских студентов родом из Минска
SELECT s.Name AS StudentName, u.Name AS University
FROM Student s, ResidesIn ri, City c, StudiesAt sa, University u
WHERE MATCH(s-(ri)->c AND s-(sa)->u)
  AND c.Name = N'Минск'
  AND u.Country = N'Россия';

-- Вывести все дружеские связи между студентами
SELECT 
    s1.Name AS Student1,
    s2.Name AS Student2
FROM 
    Student s1,
    FriendsWith fw,
    Student s2
WHERE MATCH(s1-(fw)->s2)
ORDER BY s1.Name, s2.Name;


--Запросы с использованием SHORTEST_PATH
--Вывести кратчайший путь дружбы от Анны до Татьяны длиной от 1 до 2 шагов
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
WHERE StartStudent = N'Анна' AND EndStudent = N'Татьяна';


-- Найти кратчайшие пути дружбы от Анна до всех других студентов
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
  AND s1.Name = N'Анна'
ORDER BY PathLength, EndStudent;

