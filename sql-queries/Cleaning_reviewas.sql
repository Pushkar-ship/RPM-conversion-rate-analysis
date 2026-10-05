SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	ReviewText,
	REPLACE(ReviewText, '  ',' ') AS ReviewText
FROM dbo.customer_reviews;