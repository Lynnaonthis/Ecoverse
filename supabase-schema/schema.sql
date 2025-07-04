-- Table: ecosystem_zones
CREATE TABLE ecosystem_zones (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  type TEXT NOT NULL, -- e.g. Land, Ocean, Biodiversity
  unlocked BOOLEAN DEFAULT FALSE
);

-- Table: missions
CREATE TABLE missions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  zone_id UUID REFERENCES ecosystem_zones(id),
  action_type TEXT, -- e.g. Clean, Plant, Protect
  reward_points INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: species
CREATE TABLE species (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  category TEXT, -- e.g. Marine, Pollinator, Tree
  zone_id UUID REFERENCES ecosystem_zones(id),
  status TEXT -- e.g. Endangered, Thriving
);

-- Table: users
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username TEXT UNIQUE,
  eco_credits INTEGER DEFAULT 0,
  streak INTEGER DEFAULT 0
);

-- Table: actions
CREATE TABLE actions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  mission_id UUID REFERENCES missions(id),
  zone_id UUID REFERENCES ecosystem_zones(id),
  action_type TEXT,
  completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: badges
CREATE TABLE badges (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  icon_url TEXT
);

-- Table: user_badges
CREATE TABLE user_badges (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  badge_id UUID REFERENCES badges(id),
  earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: impact_stats
CREATE TABLE impact_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  land_restored FLOAT DEFAULT 0,
  ocean_cleaned FLOAT DEFAULT 0,
  species_protected INTEGER DEFAULT 0,
  carbon_offset FLOAT DEFAULT 0
);
