/*
 * Calculates the languages that use the hashtag #coronavirus
 */
SELECT (data->>'lang') AS lang, count(*) AS count
FROM tweets_jsonb
WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
GROUP BY lang
ORDER BY count DESC, lang;
