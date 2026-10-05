# RPM Conversion Rate Analysis

An end-to-end analysis of why a client's expensive ad campaigns weren't translating into purchases — built with SQL (data cleaning + insight extraction) and Power BI (interactive dashboard).

## Business Problem

A retail brand selling sports/fitness equipment was running costly ad campaigns but seeing disappointing ROI. Despite strong top-of-funnel traffic, conversion to actual purchases remained low. They brought in a data analyst to find out **where the funnel was leaking and why**.

## Dataset

- Customer journey event log (`View` → `Click` → `Purchase` actions, timestamped, per product)
- Social media engagement metrics (likes, views, clicks by month)
- Customer reviews with star ratings and free-text comments

## Tools & Process

1. **SQL** — cleaned and structured the raw event-log data; wrote aggregation queries to compute monthly/product-level views, clicks, and purchases.
2. **Power BI** — built a 3-page interactive dashboard:
   - `DIVIDE(SUM(Purchases), SUM(Views))` DAX measures for conversion rate (ratio-of-sums, not average-of-ratios — avoids a common accuracy pitfall)
   - Slicers by year, month, and product
   - Sentiment categorization on customer review text

## Dashboard Pages

- **Overview** — top-line KPIs: 9.57% overall conversion rate, 414K likes, 9M views, 1.78M clicks, plus a full funnel breakdown (View → Click → Drop-off → Purchase) by product and month.
- **Social Media Engagement** — likes/views/clicks trend, engagement funnel (Views → Clicks 20% → Likes 5%).
- **Customer Reviews** — sentiment breakdown (840 positive / 226 negative / 196 mixed-negative / 86 mixed-positive / 15 neutral) linked back to product performance.

`![Overview](screenshots/overview.png)`
`![Social Media Engagement](screenshots/social-media-engagement.png)`
`![Customer Reviews](RPM-conversion-rate-analysis/screenshots
/customer-reviews.png
)`
`![Conversion Rate](screenshots/conversion_rate.png)`

## Key Insights

- **Seasonal decline**: January consistently has the highest views, clicks, and likes of the year, but all three metrics decline steadily through to December — engagement isn't being sustained.
- **Funnel leak location**: Of total views, only ~20% convert to clicks and just ~5% convert to likes — the drop-off is concentrated early in the funnel, not at the final purchase step.
- **Business implication**: Ad spend is driving traffic (views) effectively, but the campaigns aren't sustaining engagement past the initial click — meaning the ROI problem is a post-click/engagement issue, not a top-of-funnel traffic issue. Budget is likely better spent on conversion-path optimization than on more impressions.

## Data Limitation Found

While validating the conversion rate measure, I found that a small number of low-traffic product-months (e.g., a product with only ~3–4 views in a given month) showed conversion rates exceeding 100%. Investigation traced this to the event log recording `View` and `Purchase` as independent, non-linked events — a customer who viewed a product in one month can purchase it in a later month without a new `View` event being logged in the purchase month. For high-volume products this averages out, but for low-volume product-months a couple of cross-month purchases is enough to push the ratio past 100%.

**Flag for low-confidence rates**: product-months with fewer than 10 views are excluded/flagged in the dashboard, since the conversion rate is not statistically meaningful at that volume.

**Next step if extended**: rebuild conversion tracking as a customer-linked cohort (View and Purchase tied by `CustomerID`, not just calendar month) rather than independent monthly event counts.

## Author

Pushkar — built as part of a self-directed data analyst portfolio.
