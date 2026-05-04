/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT '#' || tag AS tag, count(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id,
        jsonb->>'text' AS tag
    FROM tweets_jsonb,
    jsonb_array_elements(
        COALESCE(
            data->'extended_tweet'->'entities'->'hashtags',
            data->'entities'->'hashtags',
            '[]'
        )
    ) AS jsonb
    WHERE
        data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
        OR
        data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
) AS t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
