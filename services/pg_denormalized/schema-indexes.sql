CREATE INDEX ON tweets_jsonb USING GIN ((data->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb USING GIN ((data->'extended_tweet'->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb USING GIN (
    to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))
);
