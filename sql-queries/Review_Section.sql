SELECT
	c.CustomerID,
	c.CustomerName,
	c.Email,
	c.Gender,
	c.Age,
	CASE
		WHEN c.Age BETWEEN 18 AND 35 THEN 'Young Adult'
		WHEN c.Age BETWEEN 36 AND 53 THEN 'Middle-aged Adult'
		ELSE 'Senior'
	END AS AgeCategory,
	g.Country,
	g.City
FROM dbo.customers AS c
JOIN dbo.geography AS g
	ON c.GeographyID = g.GeographyID


