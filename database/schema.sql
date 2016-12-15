CREATE TABLE IF NOT EXISTS countdowns (
  id bigserial PRIMARY KEY,
  name text NOT NULL,
  end_date timestamp NOT NULL
);

-- This is just a temporary insert because at the time of presenting, I wasn't
-- able to get the POST endpoint working.
INSERT INTO countdowns (
  id,
  name,
  end_date
) VALUES (
  1,
  'PRESENT AT CHIPY AHHHHH',
  NOW()
);
