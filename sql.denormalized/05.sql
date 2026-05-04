/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
 SELECT
    '#' || tag AS tag, count(*) AS count
FROM (
    SELECT DISTINCT id,(jsonb->>'text'::TEXT) AS tag from(
        SELECT
            data->> 'id' AS id,
            jsonb_array_elements(
                COALESCE(data->'extended_tweet'->'entities'->'hashtags',data->'entities'->'hashtags','[]') ) AS jsonb
        FROM tweets_jsonb
        WHERE
        to_tsvector('english',COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english','coronavirus')
        AND
        (data ->> 'lang') = 'en'
    ) AS sub
) AS t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

