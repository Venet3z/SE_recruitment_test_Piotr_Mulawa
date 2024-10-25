-- Query 1: Which brewery produces the strongest beers by abv?
-- This Query shows 10 breweries with highest abv beers and how much it is --
SELECT DISTINCT b.brewery_id, b.brewery_name, MAX(b.beer_abv) AS strongest_beer_abv
FROM beer_reviews b
GROUP BY b.brewery_id, b.brewery_name
ORDER BY strongest_beer_abv DESC
LIMIT 10

-- Query 2: If you had to pick 3 beers to recommend to someone, how would you approach the problem ?
-- If I had to pick 3 beers to recommend to someone, I would need to ask them what are their preferences in beer choice due to high amount of high quality beers. Then I would apply these information in query below
-- For example, this query shows 3 beers that I would recommend to the person that likes American IPA, medium alcohol content (abv between 4.0 and 6.0) and considers as secondary factors: taste -> aroma -> palate -> appearance
SELECT b.beer_beerid, b.beer_name, b.beer_style, b.beer_abv, AVG(b.review_overall) AS average_total_rate, AVG(b.review_taste) AS average_taste_rate, AVG(b.review_aroma) AS average_aroma_rate, AVG(b.review_palate) AS average_palate_rate, AVG(b.review_appearance) AS average_appearance_rate
FROM beer_reviews b
WHERE b.beer_style = "American IPA" AND b.beer_abv >= 4.0 AND b.beer_abv <=6.0
GROUP BY b.beer_beerid, b.beer_name, b.beer_style, b.beer_abv
ORDER BY average_total_rate DESC, average_taste_rate DESC, average_aroma_rate DESC, average_palate_rate DESC, average_appearance_rate DESC
LIMIT 3

-- Query 3: What are the factors that impacts the quality of beer the most ?
-- This query shows correlation between review_overall and other review factors. The higher the correlation, the more that factor impacts the overall rating --
SELECT CORR(review_overall, review_aroma) AS aroma_correlation, CORR(review_overall, review_appearance) AS appearance_correlation, CORR(review_overall, review_palate) AS palate_correlation, CORR(review_overall, review_taste) AS taste_correlation
FROM beer_reviews

-- Query 4: I enjoy a beer which aroma and appearance matches the beer style. What beer should I buy ?
-- This query is similar to second one. It shows all beers with average aroma review and appearace review = 5.0. To indicate best beer to buy there is need to know other factors such as beer style, abv and preference in taste and palate. --
SELECT b.beer_beerid, b.beer_name, b.beer_style, b.beer_abv, AVG(b.review_aroma) AS average_aroma_rate, AVG(b.review_appearance) AS average_appearance_rate, AVG(b.review_overall) AS average_total_rate, AVG(b.review_taste) AS average_taste_rate, AVG(b.review_palate) AS average_palate_rate
FROM beer_reviews b
GROUP BY b.beer_beerid, b.beer_name, b.beer_style, b.beer_abv
HAVING average_aroma_rate = 5.0 AND average_appearance_rate = 5.0
ORDER BY average_aroma_rate DESC, average_appearance_rate DESC, average_total_rate DESC, average_taste_rate DESC, average_palate_rate DESC
