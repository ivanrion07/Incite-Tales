-- =============================================================
-- NAGALAND SEED DATA
-- Generated from jsons_file/ (12 district JSON files)
-- Order: regions → region_meta → places → stays → place_content
-- =============================================================


-- =============================================================
-- SECTION 1: regions
-- =============================================================

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'chumoukedima',
  'Nagaland',
  'Chumoukedima',
  'The newest district and the gateway landscape between Assam and Nagaland hills',
  'Chumoukedima is Nagaland''s newest district, carved from Dimapur in 2024. It lies directly adjacent to Dimapur and serves as the transitional zone between Assam''s plains and Nagaland''s hills. The district includes part of the landscape that visitors pass through on the Guwahati-Dimapur-Kohima route. Minimal tourism infrastructure but good location for a quick stop.',
  'Chumoukedima is the edge of Nagaland — where the plains meet the hills. Few tourists think of it as a destination, but it marks the beginning of the state.',
  2,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'dimapur',
  'Nagaland',
  'Dimapur',
  'The gateway of Nagaland',
  'Dimapur is Nagaland''s commercial hub and main entry point. The Nagaland Express train arrives here, the only commercial airport in the state is 7km away, and all major highways converge. The city itself is not a tourist destination, but the entry point to everywhere else.',
  'Most travelers treat Dimapur as a transfer point. It''s the junction where every journey in Nagaland begins.',
  2,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'kiphire',
  'Nagaland',
  'Kiphire',
  'The remote east and the gateway to Mount Saramati',
  'Kiphire is a remote eastern district of Nagaland, home to the Kiphire Nagas. The district borders Myanmar. Mount Saramati (3,826m), Nagaland''s highest peak, is in this region. The district is very sparsely touristed and highly remote.',
  'Mount Saramati is Nagaland''s highest peak. Few trekkers reach it. The landscape is wild and untouched.',
  8,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'kohima',
  'Nagaland',
  'Kohima',
  'The war memorial, Hornbill Festival, and Naga tribal heartland',
  'Kohima is the capital of Nagaland and the cultural heart of the state. Home to the Angami Nagas, the district sits on a ridge at 1,261m. The WWII Kohima War Memorial is one of India''s most significant. The Hornbill Festival (December) draws visitors from across India.',
  'Kohima War Memorial at dawn is among the most moving pilgrimage sites in India. Few Indians know about it.',
  5,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'longleng',
  'Nagaland',
  'Longleng',
  'The remote Chang Naga homeland in North Nagaland',
  'Longleng is one of Nagaland''s most remote districts, in the north. The Chang Nagas inhabit this area. The district is accessible but rarely visited by tourists. The roads are rough, and infrastructure is basic. It is a genuine off-the-beaten-path destination.',
  'Longleng is genuinely remote. Few tourists come here. The Chang Naga villages are deeply traditional, and the landscape is untouched.',
  8,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'mokokchung',
  'Nagaland',
  'Mokokchung',
  'The cultural capital of Nagaland and the Ao Naga heartland',
  'Mokokchung is known as the cultural and fashion capital of Nagaland. It is the heart of the Ao Naga tribe. The town sits at 1,500m surrounded by forested hills. Longkhum, a village 17km away, is famous for rhododendrons and cherry blossoms in spring and is where Ao culture remains deeply rooted.',
  'Longkhum in April is one of the most beautiful villages in Northeast India. Rhododendrons and cherry blossoms combined, and the old Ao saying holds true: ''your soul stays behind and you must return.''',
  6,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'mon',
  'Nagaland',
  'Mon',
  'The Konyak Naga homeland and the legacy of a warrior culture',
  'Mon is Nagaland''s northeasternmost district, home to the Konyak Nagas — historically known as fierce warriors and the last practicing headhunters in India (practice ended in the 1960s). The district is remote but accessible. The Konyaks have a distinct culture, facial tattoos (rare now, seen only in elders), and a warrior tradition that shaped their identity.',
  'The Konyak Nagas are the most distinctive tribal group in Nagaland. Their facial tattoos, warrior history, and isolation created a unique culture. Few tourists visit Mon.',
  7,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'peren',
  'Nagaland',
  'Peren',
  'The new southern district and gateway to Manipur',
  'Peren is one of Nagaland''s newer districts (carved from Kohima). It is in the southern part of the state, sharing a border with Manipur. The district is less touristy than Kohima but still accessible. The Angami Nagas inhabit this region.',
  'Peren is newer and far less visited than Kohima, though it''s quite accessible. The landscape is scenic and tribal culture is strong.',
  4,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'phek',
  'Nagaland',
  'Phek',
  'The Pochury Naga district and the gateway to Manipur',
  'Phek is in southeastern Nagaland, home to the Pochury Nagas. The district is more accessible than the remote northern districts but still relatively sparsely touristed. The landscape is hilly and forested.',
  'Phek is quieter than Kohima but still accessible. The Pochury villages and forest walks offer a glimpse of Naga culture with fewer tourists.',
  5,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'tuensang',
  'Nagaland',
  'Tuensang',
  'The largest district and the wildest — Nagaland''s eastern frontier',
  'Tuensang is Nagaland''s largest district (2,536 sq km), covering 15.3% of the state''s area. It borders Myanmar on the east. The landscape is wild, with dense forests and mountains. The Yimchunger and Konyak Nagas inhabit this region. Tourism infrastructure is minimal. This is genuine wilderness.',
  'Tuensang is Nagaland''s last frontier. Few tourists venture here. The forests are untouched, and the tribal culture is deeply traditional.',
  7,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'wokha',
  'Nagaland',
  'Wokha',
  'The Lotha Naga homeland and the Amur falcon capital',
  'Wokha is the district of the Lotha Nagas. The Doyang Reservoir is known worldwide for the millions of Amur falcons that stop here every October on their migration from Siberia to Africa. The district is also the traditional headhunting homeland — now peaceful, with a rich tribal culture.',
  'Doyang Reservoir in October: millions of Amur falcons fill the sky at dusk. One of the most extraordinary bird spectacles on Earth.',
  7,
  true
);

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified) VALUES
(
  'zunheboto',
  'Nagaland',
  'Zunheboto',
  'The Sumi Naga heartland in the hills',
  'Zunheboto is the district of the Sumi Nagas, located in central Nagaland. The district is more remote than Kohima or Mokokchung, but accessible. Pfutsero, at 2,100m, is one of Nagaland''s highest towns and sits on a ridge with spectacular views. The district has dense forests and traditional Sumi villages.',
  'Pfutsero is the highest town in Nagaland. The views from the ridge are extraordinary. Few tourists venture this far inland.',
  6,
  true
);


-- =============================================================
-- SECTION 2: region_meta
-- =============================================================

-- chumoukedima
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'chumoukedima',
  '{"required": true, "type": ["ILP"], "cost": "₹100", "notes": "Technically requires ILP as part of Nagaland, though very close to Assam-Nagaland border."}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 280, "travel_hours": "8–9 hours", "waypoints": ["Dimapur", "Chumoukedima"], "notes": "Direct route, en route to rest of Nagaland."}, "from_dimapur": {"total_distance_km": 30, "travel_hours": "1 hour", "waypoints": ["Chumoukedima"], "notes": "Very quick from Dimapur — most travelers don''t bother stopping."}}'::jsonb,
  NULL
);

-- dimapur
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'dimapur',
  '{"required": true, "type": ["ILP"], "how_to_apply": "Online at https://ilp.nagaland.gov.in", "cost": "₹100", "processing_time": "1–2 days"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 289, "travel_hours": "9–10 hours by road", "waypoints": ["Tezpur", "Bhalukpong", "Dimapur"], "notes": "By road: NH-27 and NH-39. By train: Nagaland Express (23:30 dep, 05:00 arr next morning) — most comfortable option. By air: IndiGo flights from Guwahati to Dimapur (1.5 hours)."}}'::jsonb,
  NULL
);

-- kiphire
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'kiphire',
  '{"required": true, "type": ["ILP"], "cost": "₹100", "notes": "Kiphire borders Myanmar — may have additional restrictions. Check with DC office before travel."}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 450, "travel_hours": "13–15 hours", "waypoints": ["Dimapur", "Tuensang", "Kiphire"], "notes": "Very long journey — 2+ days. Via Dimapur, then remote mountain roads."}, "from_dimapur": {"total_distance_km": 313, "travel_hours": "10–12 hours", "waypoints": ["Kiphire"], "notes": "Remote mountain roads. Very rough. Allow extra time."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- kohima
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'kohima',
  '{"required": true, "type": ["ILP"], "how_to_apply": "Online at https://ilp.nagaland.gov.in or through Commissioner website", "cost": "₹100", "processing_time": "1–2 days", "notes": "ILP mandatory for all Indian tourists. Apply online (as of Jan 2025). Print or have digital copy."}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 350, "travel_days": 1, "travel_hours": "9–10 hours", "waypoints": ["Tezpur", "Bhalukpong (Assam-Nagaland border)", "Dimapur", "Kohima"], "day_split": {"start": "Guwahati", "end": "Kohima", "distance_km": 350, "drive_hours": "9–10 hours", "stops": ["Tezpur for breakfast (2 hours from Guwahati)", "Bhalukpong border checkpoint", "Dimapur taxi/bus stand (refuel option)"], "notes": "Leave Guwahati by 4–5am. Direct drive via NH-27 and NH-39. Mountain road begins after Dimapur. Reach Kohima by evening."}, "nearest_railhead": "Dimapur (74km from Kohima)", "nearest_airport": "Dimapur Airport (75km from Kohima)"}, "from_dimapur": {"total_distance_km": 74, "travel_hours": "2.5–3 hours", "waypoints": ["Kohima"], "notes": "Shortest route. Taxi or bus from Dimapur railway station/airport. Mountain road but well-maintained."}}'::jsonb,
  '{"best": ["october", "november", "december"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- longleng
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'longleng',
  '{"required": true, "type": ["ILP"], "cost": "₹100"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 420, "travel_hours": "12–14 hours", "waypoints": ["Dimapur", "Mokokchung", "Longleng"], "notes": "Long journey — consider 2 days. Via Golaghat-Mariani route (260km from Dimapur, 11 hours) or via Mokokchung."}, "from_dimapur": {"total_distance_km": 260, "travel_hours": "9–11 hours", "waypoints": ["Longleng"], "notes": "Via Golaghat and Mariani (Assam), then into Nagaland. Rough mountain road. Allow extra time."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- mokokchung
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'mokokchung',
  '{"required": true, "type": ["ILP"], "cost": "₹100", "processing_time": "1–2 days"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 380, "travel_hours": "10–12 hours", "waypoints": ["Dimapur", "Mokokchung"], "notes": "Overnight bus from Guwahati is standard — reaches Mokokchung next morning. Direct buses available, 10–12 hours."}, "from_dimapur": {"total_distance_km": 209, "travel_hours": "5–6 hours", "waypoints": ["Mokokchung"], "notes": "Buses and shared taxis available. Mountain road via NH-61."}}'::jsonb,
  '{"best": ["october", "november", "march", "april"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- mon
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'mon',
  '{"required": true, "type": ["ILP"], "cost": "₹100", "notes": "Mon borders Arunachal Pradesh and Myanmar — may have additional restrictions. Check with DC office."}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 500, "travel_hours": "14–16 hours", "waypoints": ["Dimapur", "Mon"], "notes": "Very long journey — 2+ days. Remote roads."}, "from_dimapur": {"total_distance_km": 283, "travel_hours": "9–11 hours", "waypoints": ["Mon"], "notes": "Mountain roads, remote."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- peren
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'peren',
  '{"required": true, "type": ["ILP"], "cost": "₹100"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 340, "travel_hours": "9–10 hours", "waypoints": ["Dimapur", "Peren"], "notes": "Closer than Kohima from Dimapur."}, "from_dimapur": {"total_distance_km": 85, "travel_hours": "2–3 hours", "waypoints": ["Peren"], "notes": "Shortest distance from Dimapur among southern districts. Quick drive on good road."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- phek
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'phek',
  '{"required": true, "type": ["ILP"], "cost": "₹100"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 380, "travel_hours": "10–12 hours", "waypoints": ["Dimapur", "Kohima", "Phek"], "notes": "Via Dimapur and Kohima. Mountain road scenic."}, "from_dimapur": {"total_distance_km": 219, "travel_hours": "6–7 hours", "waypoints": ["Phek"], "notes": "Direct mountain road, scenic."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- tuensang
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'tuensang',
  '{"required": true, "type": ["ILP"], "cost": "₹100", "notes": "Tuensang borders Myanmar — may have additional restrictions. Check with DC office."}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 480, "travel_hours": "14–16 hours", "waypoints": ["Dimapur", "Tuensang"], "notes": "Very long journey — 2+ days. Remote mountain roads."}, "from_dimapur": {"total_distance_km": 281, "travel_hours": "9–11 hours", "waypoints": ["Tuensang"], "notes": "Mountain roads, rough in places."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- wokha
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'wokha',
  '{"required": true, "type": ["ILP"], "cost": "₹100"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 380, "travel_hours": "10–12 hours", "waypoints": ["Dimapur", "Wokha"], "notes": "Via NH-39 to Dimapur, then mountain road via Merapani route (shorter: 71.7km from Dimapur) or via Kohima route (174km from Dimapur)."}, "from_dimapur": {"total_distance_km": 124, "travel_hours": "3–4 hours", "waypoints": ["Wokha"], "notes": "Two routes: via Kohima (174km, longer) or via Merapani (71.7km, shorter, scenic mountain road)."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);

-- zunheboto
INSERT INTO region_meta (region_id, permit, routes, season) VALUES
(
  'zunheboto',
  '{"required": true, "type": ["ILP"], "cost": "₹100"}'::jsonb,
  '{"from_guwahati": {"total_distance_km": 400, "travel_hours": "10–12 hours", "waypoints": ["Dimapur", "Zunheboto"], "notes": "Via Dimapur, then mountain road. Overnight bus or 2-day journey."}, "from_dimapur": {"total_distance_km": 217, "travel_hours": "6–7 hours", "waypoints": ["Zunheboto"], "notes": "Mountain road via NH-61 or alternate routes."}}'::jsonb,
  '{"best": ["october", "november"], "avoid": ["june", "july", "august"]}'::jsonb
);


-- =============================================================
-- SECTION 3: places
-- =============================================================

-- chumoukedima destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'chumoukedima-town',
  'chumoukedima',
  'Chumoukedima',
  'town',
  'The entry town to Nagaland''s hill landscape',
  'Chumoukedima is a growing town, the newest district headquarters. It sits between the plains and the hills. The town is more developed than typical district towns due to its proximity to Dimapur.',
  2
);

-- dimapur destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'dimapur-town',
  'dimapur',
  'Dimapur',
  'transport-hub',
  'Where every Nagaland journey begins',
  'Dimapur is a bustling commercial city on the Dhansiri River. It has good hotels, ATMs, fuel, and all services. Most travelers spend 1–2 hours here transitioning to other districts. The town itself has limited tourist appeal but is well-equipped.',
  2
);

-- kiphire destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'kiphire-town',
  'kiphire',
  'Kiphire',
  'town',
  'The remote eastern outpost',
  'Kiphire is a very small town, the district headquarters. It is remote and has minimal infrastructure. The surrounding region is forested and sparsely populated.',
  7
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'mount-saramati',
  'kiphire',
  'Mount Saramati',
  'mountain-trek',
  'Nagaland''s highest peak and one of the most remote treks in Northeast India',
  'Mount Saramati (3,826m) is Nagaland''s highest peak. It sits on the Nagaland-Myanmar border. The trek to the summit is multi-day and requires serious preparation. Few trekkers attempt it. The peak offers views into Myanmar and across Nagaland.',
  9
);

-- kohima destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'kohima-town',
  'kohima',
  'Kohima',
  'town',
  'Ridge-top capital with a war memorial that changes you',
  'Kohima is built on a ridge with a commanding view of the valley below. The town is the administrative and cultural heart of Nagaland. The Hornbill Festival transforms the entire town in December. Outside the festival, Kohima is quiet and walkable.',
  5
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'kohima-war-memorial',
  'kohima',
  'Kohima War Memorial',
  'historical-memorial',
  'One of WWII''s most significant battle sites, now a place of pilgrimage',
  'The Kohima War Cemetery commemorates the 1944 Battle of Kohima, where Japanese and British forces fought for control of this ridge. British forces held the position. Nearly 1,500 soldiers are buried here. The memorial inscription reads: ''When you go home, tell them of us and say, for your tomorrow, we gave our today.''',
  4
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'khonoma-village',
  'kohima',
  'Khonoma',
  'village',
  'India''s first wildlife sanctuary village',
  'Khonoma was the first village in India to declare itself a wildlife sanctuary. The Angami Nagas here have protected the forest for centuries. The village sits on a ridge with 360° views. Morning or evening walks through the village and forest are excellent.',
  7
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'dzuko-valley',
  'kohima',
  'Dzuko Valley',
  'valley',
  'Alpine meadow, rhododendrons, and one of Nagaland''s most beautiful valleys',
  'Dzuko Valley is a high-altitude alpine meadow straddling the Nagaland-Manipur border. Accessible from Kohima, the trek is a 2-day undertaking. Rhododendrons bloom April-May. The valley floor is open, ringed by cliffs.',
  8
);

-- longleng destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'longleng-town',
  'longleng',
  'Longleng',
  'town',
  'The remote outpost of North Nagaland',
  'Longleng is a small town, the headquarters of the district. It has minimal tourist infrastructure. This is a place for travelers seeking true remoteness, not comfort.',
  7
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'longleng-villages',
  'longleng',
  'Chang Naga Villages',
  'tribal-villages',
  'Deep traditional Chang Naga culture',
  'The Chang Nagas inhabit the villages around Longleng. These are deeply traditional communities with their own language, customs, and way of life. Tourism is rare here, so interactions are genuine.',
  8
);

-- mokokchung destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'mokokchung-town',
  'mokokchung',
  'Mokokchung',
  'town',
  'The cultural capital with forested hills on all sides',
  'Mokokchung is a proper town with hotels, ATMs, and services. It is remarkably clean and organized. The town is a base for exploring Ao villages and Longkhum. The town market is known for fashion and textiles — Mokokchung styles are copied across Nagaland.',
  5
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'longkhum',
  'mokokchung',
  'Longkhum',
  'village',
  'Where the soul stays behind: rhododendrons and cherry blossoms in spring',
  'Longkhum is a village 17km from Mokokchung, famous for rhododendrons (March-April) and cherry blossoms (April). The old Ao saying goes: ''A single visit to Longkhum is not enough, for your soul stays behind the first time and you have to return once more to get it back.'' The village is on a ridge with valley views.',
  8
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'ungma-village',
  'mokokchung',
  'Ungma',
  'village',
  'The oldest and largest Ao village, heart of Ao culture',
  'Ungma is 3km from Mokokchung town. It is the oldest and largest Ao village, and the place where Ao tribal history is deepest rooted. The village structure — houses built around a central council ground (morung) — is the traditional Ao settlement pattern.',
  6
);

-- mon destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'mon-town',
  'mon',
  'Mon',
  'town',
  'The Konyak Naga capital',
  'Mon is a small town serving as the district headquarters. It is the base for exploring Konyak villages and culture. The town has basic infrastructure.',
  5
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'konyak-villages',
  'mon',
  'Konyak Villages',
  'tribal-villages',
  'The warrior culture of the Konyak Nagas',
  'Konyak villages around Mon are deeply traditional. The Konyaks were historically headhunters (practice ended in 1960s). Today they are known for their warrior tradition, tattoos (facial and body), distinctive architecture, and unique cultural practices. The older generation bears facial tattoos — a mark of warrior status in pre-colonial times.',
  8
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'konyak-culture-center',
  'mon',
  'Konyak Heritage & Culture',
  'cultural-immersion',
  'Understanding the warrior legacy of the Konyaks',
  'The Konyak Nagas have one of the most distinct cultures in Northeast India. Their facial and body tattoos (now rare), warrior history, and isolation created a unique identity. Understanding Konyak culture means understanding pre-colonial Northeast warrior societies.',
  7
);

-- peren destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'peren-town',
  'peren',
  'Peren',
  'town',
  'The emerging town of southern Nagaland',
  'Peren is a small but growing town, district headquarters. It has basic infrastructure and serves as a base for exploring the region.',
  3
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'peren-villages',
  'peren',
  'Angami Villages in Peren',
  'tribal-villages',
  'Angami Naga settlements with less tourist footprint',
  'Villages in Peren district are settled by Angami Nagas. While the same tribe as those in Kohima, these villages see far fewer tourists and offer a more authentic experience.',
  5
);

-- phek destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'phek-town',
  'phek',
  'Phek',
  'town',
  'The Pochury Naga district capital',
  'Phek is a small town in the hills, serving as the district headquarters. It has basic infrastructure and serves as a base for exploring Pochury villages and the surrounding forest.',
  4
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'pochury-villages',
  'phek',
  'Pochury Villages',
  'tribal-villages',
  'The Pochury Naga homeland',
  'Pochury villages are scattered across Phek district. The Pochury Nagas have their own language, customs, and culture. Tourism is limited here, making interactions genuine.',
  6
);

-- tuensang destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'tuensang-town',
  'tuensang',
  'Tuensang',
  'town',
  'The frontier outpost of eastern Nagaland',
  'Tuensang is the district headquarters of Nagaland''s largest district. It is a small town with basic infrastructure. The surrounding region is forest and mountains.',
  6
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'yimchunger-villages',
  'tuensang',
  'Yimchunger Villages',
  'tribal-villages',
  'The Yimchunger Naga homeland',
  'The Yimchunger Nagas inhabit villages throughout Tuensang district. These are deeply traditional communities with a unique culture and language. Tourism is virtually non-existent here.',
  8
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'longtrok-village',
  'tuensang',
  'Longtrok',
  'village',
  'Home to giant monoliths and Mithun tradition',
  'Longtrok is a village in Tuensang known for its giant monoliths and the Mithun (state animal of Nagaland). The monoliths are erected during festivals and celebrations. Mithun herds roam the surrounding forest.',
  7
);

-- wokha destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'wokha-town',
  'wokha',
  'Wokha',
  'town',
  'The Lotha Naga cultural center',
  'Wokha is a small, pleasant town sitting at the gateway to Doyang Reservoir. It has basic hotels, ATMs, and is the base for visiting the falcon migrations.',
  3
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'doyang-reservoir',
  'wokha',
  'Doyang Reservoir',
  'wetland-birdwatching',
  'Millions of Amur falcons stop here in October — the Falcon capital of the world',
  'Doyang Reservoir is a man-made lake fed by the Doyang River. Every October, millions of Amur falcons descend here for 2–3 weeks on their migration from Siberia to Africa. The birds roost over the water at dusk. The spectacle is extraordinary — the sky turns dark with birds. It is one of the most significant bird migration sites on Earth.',
  9
);

-- zunheboto destinations
INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'zunheboto-town',
  'zunheboto',
  'Zunheboto',
  'town',
  'The gateway to Sumi Naga culture',
  'Zunheboto is a small, quiet town serving as the base for exploring the district. It has basic hotels and serves as the jumping-off point for Pfutsero and surrounding villages.',
  3
);

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score) VALUES
(
  'pfutsero',
  'zunheboto',
  'Pfutsero',
  'hill-station',
  'The highest town in Nagaland with views that stretch to the horizon',
  'Pfutsero sits at 2,100m on a ridge in the Satoi range. It is Nagaland''s highest town. The surrounding forest is dense, and on clear mornings, the views stretch for 100km. The town itself is small but the ridge walks are exceptional. Blyth''s tragopan (Nagaland''s state bird) is sighted in the forests around Pfutsero.',
  7
);


-- =============================================================
-- SECTION 4: stays
-- =============================================================

-- chumoukedima-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('chumoukedima-town', 'Basic hotels', 'hotel', '₹500–1,000', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('chumoukedima-town', 'Circuit House Chumoukedima', 'government', '₹300–600', NULL);

-- dimapur-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('dimapur-town', 'Hotel Mount Elbrus', 'hotel', '₹1,500–2,500', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('dimapur-town', 'Hotel Japfu', 'hotel', '₹800–1,500', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('dimapur-town', 'Circuit House Dimapur', 'government', '₹600–1,200', NULL);

-- kiphire-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('kiphire-town', 'Circuit House Kiphire', 'government', '₹300–500', 'Basic. Book via DC office.');

-- mount-saramati stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('mount-saramati', 'Forest camps / basic shelters', 'camp', 'Minimal to free', 'No established lodging. Trek with guides and camp equipment.');

-- kohima-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('kohima-town', 'HPTDC Hotel Sarai', 'hotel', '₹1,500–2,500', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('kohima-town', 'Circuit House Kohima', 'government', '₹600–1,200', 'Book via DC office');

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('kohima-town', 'Homestays in Kezama or Khonoma', 'homestay', '₹800–1,500 including meals', 'Best authentic experience');

-- kohima-war-memorial stays: empty array in JSON — no rows

-- khonoma-village stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('khonoma-village', 'Homestays in Khonoma', 'homestay', '₹600–1,000 including meals', 'Ask in village, family-run, meals included');

-- dzuko-valley stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('dzuko-valley', 'Rest hut in Dzuko Valley', 'forest-hut', '₹300–500', 'Basic, book via Forest Dept. Limited capacity.');

-- longleng-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('longleng-town', 'Circuit House Longleng', 'government', '₹300–500', 'Basic. Book via DC office.');

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('longleng-town', 'Very basic guesthouses', 'guesthouse', '₹400–600', NULL);

-- longleng-villages stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('longleng-villages', 'Homestays in villages', 'homestay', '₹500–800 including meals', 'Book through DC office or ask in town');

-- mokokchung-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('mokokchung-town', 'Hotel Japfu Heritage', 'hotel', '₹1,200–2,000', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('mokokchung-town', 'Circuit House Mokokchung', 'government', '₹600–1,000', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('mokokchung-town', 'Homestays in nearby Ao villages', 'homestay', '₹700–1,200 including meals', NULL);

-- longkhum stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('longkhum', 'Homestays in Longkhum', 'homestay', '₹600–1,000 including meals', 'Book in advance. Family-run, home-cooked food.');

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('longkhum', 'Circuit House Longkhum', 'government', '₹400–700', 'Basic, book via DC office');

-- ungma-village stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('ungma-village', 'Homestays in Ungma', 'homestay', '₹600–900 including meals', NULL);

-- mon-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('mon-town', 'Circuit House Mon', 'government', '₹300–600', 'Book via DC office');

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('mon-town', 'Basic guesthouses', 'guesthouse', '₹400–700', NULL);

-- konyak-villages stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('konyak-villages', 'Homestays in villages', 'homestay', '₹600–1,000 including meals', 'Book through DC office or ask in Mon town');

-- konyak-culture-center stays: empty array in JSON — no rows

-- peren-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('peren-town', 'Circuit House Peren', 'government', '₹400–700', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('peren-town', 'Basic hotels', 'hotel', '₹600–1,000', NULL);

-- peren-villages stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('peren-villages', 'Homestays if arranged', 'homestay', '₹600–1,000 including meals', NULL);

-- phek-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('phek-town', 'Circuit House Phek', 'government', '₹400–700', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('phek-town', 'Basic guesthouses', 'guesthouse', '₹500–900', NULL);

-- pochury-villages stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('pochury-villages', 'Homestays if arranged', 'homestay', '₹600–1,000 including meals', NULL);

-- tuensang-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('tuensang-town', 'Circuit House Tuensang', 'government', '₹300–500', 'Basic. Book via DC office.');

-- yimchunger-villages stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('yimchunger-villages', 'Homestays if arranged', 'homestay', '₹400–700 including meals', 'Very limited. Ask at Tuensang town office.');

-- longtrok-village stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('longtrok-village', 'Homestays', 'homestay', '₹500–800 including meals', NULL);

-- wokha-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('wokha-town', 'Hotel Wokha', 'hotel', '₹800–1,500', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('wokha-town', 'Circuit House Wokha', 'government', '₹400–700', NULL);

-- doyang-reservoir stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('doyang-reservoir', 'Forest Rest House at Doyang', 'forest-lodge', '₹500–800', 'Book via Forest Dept. Basic but positioned perfectly for viewing.');

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('doyang-reservoir', 'Homestays in nearby villages', 'homestay', '₹600–1,000 including meals', NULL);

-- zunheboto-town stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('zunheboto-town', 'Circuit House Zunheboto', 'government', '₹400–700', NULL);

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('zunheboto-town', 'Basic guesthouses', 'guesthouse', '₹500–900', NULL);

-- pfutsero stays
INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('pfutsero', 'Rest house/guesthouses in Pfutsero', 'guesthouse', '₹400–700', 'Book in advance via District office');

INSERT INTO stays (place_id, name, type, price_range, notes) VALUES
('pfutsero', 'Homestays', 'homestay', '₹600–900 including meals', NULL);


-- =============================================================
-- SECTION 5: place_content
-- =============================================================

-- -------------------------------------------------------
-- chumoukedima-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'what_is_there', 'Transitional landscape — plains to hills');
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'what_is_there', 'Gateway viewpoint into Nagaland hills');
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'what_is_there', 'Market area');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'local_food', 'Mix of Assamese and Naga cuisine');
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'local_food', 'Basic local meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'local_tip', 'Only 20–30km from Dimapur — quick transit stop');
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'local_tip', 'Marks the visual entry into Nagaland''s hill region');
INSERT INTO place_content (place_id, category, content) VALUES ('chumoukedima-town', 'local_tip', 'Minimal tourism — most travelers pass through without stopping');

-- -------------------------------------------------------
-- dimapur-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'what_is_there', 'Railway Station — second busiest in Northeast India, trains to Guwahati');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'what_is_there', 'Dimapur Airport — 7km away, flights to Guwahati and Kolkata');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'what_is_there', 'Dhansiri River — walk the banks, peaceful early morning');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'what_is_there', 'Market area — local goods, Naga handicrafts');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_food', 'Naga cuisine available in local restaurants');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_food', 'Smoked pork, bamboo shoot, apong');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_food', 'Standard Indian, Chinese, continental food in hotels');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_tip', 'Dimapur Railway Station: taxis to Kohima (₹200–300 shared) congregate outside');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_tip', 'Dimapur Airport: 7km northeast of city, taxis available, expensive (₹400–600 to city)');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_tip', 'Old NST Bus Stand: main bus terminal, buses to all districts');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_tip', 'Spend minimal time here unless transferring — go to Kohima or other districts');
INSERT INTO place_content (place_id, category, content) VALUES ('dimapur-town', 'local_tip', 'All banks, ATMs, fuel here — stock up before heading to remote districts');

-- -------------------------------------------------------
-- kiphire-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'what_is_there', 'Kiphire Naga villages — traditional culture');
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'what_is_there', 'Gateway to Mount Saramati trekking');
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'what_is_there', 'Forest landscape');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'local_food', 'Very basic meals available');
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'local_food', 'Carry supplies from larger towns');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'local_tip', 'Very remote — only for serious off-beat travelers');
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'local_tip', 'Stock up supplies in previous towns');
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'local_tip', 'No ATM — carry cash');
INSERT INTO place_content (place_id, category, content) VALUES ('kiphire-town', 'local_tip', 'Roads are rough');

-- -------------------------------------------------------
-- mount-saramati
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'what_is_there', 'Summit — 360° views on clear days');
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'what_is_there', 'Alpine meadow');
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'what_is_there', 'Forest ecosystem — changes with altitude');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'local_food', 'Carry all food');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'local_tip', 'Requires guide from Kiphire — mandatory');
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'local_tip', '4–5 days round trip from Kiphire town');
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'local_tip', 'Best season: October-November (clear, dry)');
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'local_tip', 'High altitude — altitude sickness possible');
INSERT INTO place_content (place_id, category, content) VALUES ('mount-saramati', 'local_tip', 'Very few trekkers — feels genuine wilderness');

-- -------------------------------------------------------
-- kohima-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'Kohima War Memorial — 1944 WWII site, one of India''s most significant war memorials');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'State Museum — Naga tribal artifacts, history, textiles');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'Kezama Village — traditional Angami Naga settlement, 20km from town');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'Khonoma Village — first Indian village to declare itself a wildlife sanctuary, famous for conservation');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'Hornbill Festival — December, 10-day festival of Naga culture, music, dance, food');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'Naga Heritage Village — reconstructed traditional Naga village with museum');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'what_is_there', 'Ridge viewpoint — walk the ridge at dusk, view valley below');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_food', 'Smoked pork with bamboo shoot — the Naga standard');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_food', 'Naga fish curry — river fish in mustard and chili');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_food', 'Apong — rice beer, served in every home');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_food', 'Axone (fermented soybean) — pungent, addictive, quintessentially Naga');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_food', 'Naga green salad — boiled vegetables with chili');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_food', 'Market food — momos, local breads');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_tip', 'War Memorial: arrive by 6am for dawn ceremony (if available), few crowds');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_tip', 'Hornbill Festival (December): book accommodation 4 months ahead, prices triple');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_tip', 'Khonoma village walk is best in morning — 2-hour loop through forest and fields');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_tip', 'Kezama: ask permission before photographing people or festivals');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-town', 'local_tip', 'English is widely spoken — Kohima is well-accustomed to visitors');

-- -------------------------------------------------------
-- kohima-war-memorial
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'what_is_there', 'War cemetery — rows of graves, each with a name and date');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'what_is_there', 'Memorial stone — inscription, garden, peaceful setting');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'what_is_there', 'Kohima Garrison (historic) — still operational nearby');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'what_is_there', 'Views from the ridge — the valley stretched below');
-- local_food: empty array — no rows
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'local_tip', 'Open sunrise to sunset — arrive early for fewer crowds');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'local_tip', 'Dress respectfully — this is a place of pilgrimage and remembrance');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'local_tip', 'Read the stone inscription slowly — it encapsulates the sacrifice');
INSERT INTO place_content (place_id, category, content) VALUES ('kohima-war-memorial', 'local_tip', 'Spend 30 minutes minimum — sit quietly, read the names');

-- -------------------------------------------------------
-- khonoma-village
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'what_is_there', 'Forest — protected and dense, full of birds and wildlife');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'what_is_there', 'Village walk — traditional stone houses, terraced fields');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'what_is_there', 'Viewpoint — from ridge above village, valley stretches below');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'what_is_there', 'Khonoma museum — small, local history');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'local_food', 'Home-cooked Angami meals at homestays');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'local_food', 'Bamboo shoot curry, smoked pork, apong');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'local_tip', 'Khonoma is 20km from Kohima town — book transport ahead');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'local_tip', 'Walk the forest early morning for birds — bring binoculars');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'local_tip', 'Ask before photographing — locals are welcoming but appreciate consent');
INSERT INTO place_content (place_id, category, content) VALUES ('khonoma-village', 'local_tip', 'Stay overnight if possible — evening in the village is peaceful');

-- -------------------------------------------------------
-- dzuko-valley
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'what_is_there', 'Alpine meadow — open grassland at 2,440m');
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'what_is_there', 'Rhododendron forest — April-May bloom');
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'what_is_there', 'Crystal stream — cold, clear water');
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'what_is_there', 'Sunrise from valley rim — 360° views on clear mornings');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'local_food', 'Carry all food from Kohima');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'local_tip', 'Trek: Kohima → Japfu base → Japfu peak (1 day hike) → Dzuko Valley (2nd day)');
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'local_tip', 'Best season: April-May (rhododendrons), October-November (clear skies)');
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'local_tip', 'Guide strongly recommended — paths are unmarked');
INSERT INTO place_content (place_id, category, content) VALUES ('dzuko-valley', 'local_tip', 'Water available at streams — carry purification tablets');

-- -------------------------------------------------------
-- longleng-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'what_is_there', 'Chang Naga villages — traditional settlements around town');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'what_is_there', 'Forest landscape — dense, untouched');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'what_is_there', 'Gateway to northern Nagaland');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'local_food', 'Basic meals at local dhabas');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'local_food', 'Carry supplies from larger towns');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'local_tip', 'This is a remote destination — only for off-beat travelers');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'local_tip', 'Minimal infrastructure — stock up supplies in Mokokchung or Wokha');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'local_tip', 'Roads are rough — allow extra travel time');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-town', 'local_tip', 'No reliable phone signal');

-- -------------------------------------------------------
-- longleng-villages
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'what_is_there', 'Traditional Chang Naga houses — stone construction, characteristic design');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'what_is_there', 'Village walks — observe daily life');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'what_is_there', 'Traditional festivals — November-December');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'local_food', 'Home-cooked Chang Naga meals at homestays');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'local_tip', 'Ask permission before photographing or entering villages');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'local_tip', 'English proficiency is lower here — basic communication');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'local_tip', 'Festivals (November-December): best time for cultural immersion');
INSERT INTO place_content (place_id, category, content) VALUES ('longleng-villages', 'local_tip', 'Very few tourists — your presence is notable');

-- -------------------------------------------------------
-- mokokchung-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'what_is_there', 'District Museum — Ao tribal artifacts, history, textiles, art');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'what_is_there', 'Town market — fashion, local textiles, Naga handicrafts');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'what_is_there', 'Mokokchung College — on the hill, views of town below');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'what_is_there', 'Forest walks — pine and oak forests surrounding town');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_food', 'Ao Naga cuisine — smoked pork, bamboo shoot, traditional fish');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_food', 'Axone (fermented soybean) — pungent, a staple');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_food', 'Rice beer — apong, served in homes');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_food', 'Market food — momos, breads, street food');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_tip', 'Museum is worth 1–2 hours — excellent collection of Ao artifacts');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_tip', 'Market walk: morning is best, watch local life, buy handicrafts');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_tip', 'English widely spoken — Mokokchung is well-accustomed to visitors');
INSERT INTO place_content (place_id, category, content) VALUES ('mokokchung-town', 'local_tip', 'Ask locals about Ao villages — some families offer homestays');

-- -------------------------------------------------------
-- longkhum
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'what_is_there', 'Rhododendron forest — March-April, entire hillsides covered in pink and white blooms');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'what_is_there', 'Cherry blossom trees — April, line the village streets');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'what_is_there', 'Longkhum village walk — traditional stone houses, peaceful');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'what_is_there', 'Viewpoint — from ridge above village, valley stretches below');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'what_is_there', 'Handlooms — buy directly from weavers, intricate patterns');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_food', 'Home-cooked Ao meals at homestays — best food experience');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_food', 'Smoked pork, bamboo shoot, fresh vegetables');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_food', 'Rice beer — offered in homes');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_tip', 'April is peak — both rhododendrons and cherry blossoms, but crowded on weekends');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_tip', 'March-early April is better — fewer tourists, still in bloom');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_tip', 'Walk early morning — mist clears, light is soft');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_tip', 'Ask homestay to arrange village walk with local guide');
INSERT INTO place_content (place_id, category, content) VALUES ('longkhum', 'local_tip', 'Handlooms: buy directly from weavers — better prices and story');

-- -------------------------------------------------------
-- ungma-village
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'what_is_there', 'Traditional houses — stone construction, thatch roofs');
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'what_is_there', 'Morung (council ground) — central gathering place');
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'what_is_there', 'Village walk — observe daily life');
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'what_is_there', 'Festival activities during Hornbill season (November-December)');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'local_food', 'Home-cooked Ao food at homestays');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'local_tip', 'Only 3km from Mokokchung — easy day trip');
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'local_tip', 'Visit early morning or late afternoon — village life is most active');
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'local_tip', 'Ask permission before photographing — locals appreciate consent');
INSERT INTO place_content (place_id, category, content) VALUES ('ungma-village', 'local_tip', 'Combine with Mokokchung Museum visit for context');

-- -------------------------------------------------------
-- mon-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'what_is_there', 'Konyak tribal settlements around town');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'what_is_there', 'Traditional Konyak houses — distinctive architecture');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'what_is_there', 'Market — local goods');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_food', 'Konyak cuisine — smoked pork, bamboo shoot');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_food', 'Apong rice beer');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_food', 'Local dhabas');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_tip', 'Base for Konyak village exploration');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_tip', 'Tattooed elders are a visual link to history');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_tip', 'Ask permission before photographing');
INSERT INTO place_content (place_id, category, content) VALUES ('mon-town', 'local_tip', 'Festivals (Nov-Dec) show Konyak tradition');

-- -------------------------------------------------------
-- konyak-villages
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'what_is_there', 'Traditional Konyak houses — morungs (men''s houses), intricate woodcarving');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'what_is_there', 'Tattooed elders — living history of Konyak tradition');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'what_is_there', 'Village walks — observe daily life');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'what_is_there', 'Warrior history and artifacts in some villages');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'local_food', 'Home-cooked Konyak meals — traditionally smoked pork and bamboo');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'local_tip', 'Tattooed elders: ask permission before photographing, show respect');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'local_tip', 'Villages are welcoming but private — let them invite you');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'local_tip', 'Festivals (Nov-Dec): best time for cultural immersion');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-villages', 'local_tip', 'Guide recommended — helps with introductions');

-- -------------------------------------------------------
-- konyak-culture-center
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'what_is_there', 'Morung (men''s house) — traditional gathering place, cultural significance');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'what_is_there', 'Tattoo tradition — visual and historical context');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'what_is_there', 'Headhunting history — now purely historical, important to understand context');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'what_is_there', 'Festivals — Konyak New Year and others showcase living tradition');
-- local_food: empty array — no rows
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'local_tip', 'Read about Konyak history before visiting — context is important');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'local_tip', 'Headhunting practice ended in 1960s — it''s historical, not current');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'local_tip', 'Elders who practiced tattoos are living historians');
INSERT INTO place_content (place_id, category, content) VALUES ('konyak-culture-center', 'local_tip', 'Cultural respect is essential — this is not a museum but a living community');

-- -------------------------------------------------------
-- peren-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'what_is_there', 'Angami villages around Peren');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'what_is_there', 'Forest landscape');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'what_is_there', 'Gateway to Manipur border regions');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'local_food', 'Angami Naga cuisine');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'local_food', 'Smoked pork, bamboo shoot');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'local_food', 'Basic local meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'local_tip', 'Only 85km from Dimapur — easily accessible');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'local_tip', 'Fewer tourists than Kohima');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-town', 'local_tip', 'ATM available');

-- -------------------------------------------------------
-- peren-villages
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'what_is_there', 'Traditional Angami houses');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'what_is_there', 'Village walks');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'what_is_there', 'Angami tribal culture');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'local_food', 'Home-cooked Angami meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'local_tip', 'Far fewer tourists than Kohima area');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'local_tip', 'Ask permission before photographing');
INSERT INTO place_content (place_id, category, content) VALUES ('peren-villages', 'local_tip', 'More authentic experience due to low tourist footfall');

-- -------------------------------------------------------
-- phek-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'what_is_there', 'Pochury tribal villages');
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'what_is_there', 'Forest landscape');
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'what_is_there', 'Gateway to eastern Nagaland');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'local_food', 'Pochury Naga cuisine');
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'local_food', 'Smoked pork, bamboo shoot');
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'local_food', 'Basic local meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'local_tip', 'Base for Pochury village exploration');
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'local_tip', 'ATM available in town');
INSERT INTO place_content (place_id, category, content) VALUES ('phek-town', 'local_tip', 'Mountain road to Phek from Kohima (145km) is scenic');

-- -------------------------------------------------------
-- pochury-villages
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'what_is_there', 'Traditional houses');
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'what_is_there', 'Village walks');
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'what_is_there', 'Pochury tribal culture');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'local_food', 'Home-cooked Pochury meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'local_tip', 'Ask permission before photographing');
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'local_tip', 'Guide recommended');
INSERT INTO place_content (place_id, category, content) VALUES ('pochury-villages', 'local_tip', 'Quieter than Kohima but still accessible');

-- -------------------------------------------------------
-- tuensang-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'what_is_there', 'Yimchunger and Konyak tribal villages');
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'what_is_there', 'Forest walks');
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'what_is_there', 'Gateway to eastern Nagaland wilderness');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'local_food', 'Very basic local meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'local_tip', 'Remote and basic — stock supplies in larger towns');
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'local_tip', 'No ATM — carry cash');
INSERT INTO place_content (place_id, category, content) VALUES ('tuensang-town', 'local_tip', 'Roads are rough and unpredictable');

-- -------------------------------------------------------
-- yimchunger-villages
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'what_is_there', 'Traditional villages');
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'what_is_there', 'Yimchunger tribal culture');
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'what_is_there', 'Forest landscape');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'local_food', 'Home-cooked Yimchunger meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'local_tip', 'Very few tourists — interactions are genuine');
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'local_tip', 'Ask permission before any photography');
INSERT INTO place_content (place_id, category, content) VALUES ('yimchunger-villages', 'local_tip', 'Guide recommended');

-- -------------------------------------------------------
-- longtrok-village
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'what_is_there', 'Giant monoliths — erected during festivals');
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'what_is_there', 'Mithun herds — semi-domesticated gaur');
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'what_is_there', 'Traditional Yimchunger settlement');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'local_food', 'Home-cooked meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'local_tip', 'Mithun are the ritual animal — understand their cultural significance');
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'local_tip', 'Monoliths: best viewed during festivals (Nov-Dec)');
INSERT INTO place_content (place_id, category, content) VALUES ('longtrok-village', 'local_tip', 'Very remote village');

-- -------------------------------------------------------
-- wokha-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'what_is_there', 'Town market — local handicrafts, textiles');
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'what_is_there', 'Lotha tribal culture — villages around town');
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'what_is_there', 'Gateway to Doyang Reservoir');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'local_food', 'Lotha Naga cuisine — smoked pork, bamboo shoot');
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'local_food', 'Apong rice beer');
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'local_food', 'Local market food');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'local_tip', 'Base for visiting Doyang Reservoir');
INSERT INTO place_content (place_id, category, content) VALUES ('wokha-town', 'local_tip', 'Stock up fuel and supplies here');

-- -------------------------------------------------------
-- doyang-reservoir
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'what_is_there', 'Amur falcon migration — October, millions of birds');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'what_is_there', 'Reservoir walk — scenic, birdwatching, morning and dusk');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'what_is_there', 'Migratory waterfowl — November-February, various species');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'what_is_there', 'Fishery — traditional fishing methods on the reservoir');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_food', 'Carry food from Wokha or arrange through Forest Dept');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_food', 'Fresh fish available at the reservoir');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_food', 'Homestays provide home-cooked meals');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_tip', 'Amur falcon peak: October 15–25 — arrive a week before for consistent viewing');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_tip', 'Dusk viewing: 5:30–6:30pm — birds roost over water, turn sky dark');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_tip', 'Bring binoculars and camera with good zoom');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_tip', 'November-February: other migratory species still present, good birdwatching');
INSERT INTO place_content (place_id, category, content) VALUES ('doyang-reservoir', 'local_tip', 'Early morning walks: excellent for other bird species');

-- -------------------------------------------------------
-- zunheboto-town
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'what_is_there', 'Sumi tribal culture — villages around town');
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'what_is_there', 'Gateway to Pfutsero trek');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'local_food', 'Sumi Naga cuisine — smoked pork, bamboo shoot');
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'local_food', 'Apong rice beer');
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'local_food', 'Basic market food');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'local_tip', 'Smaller town than Kohima or Mokokchung — fewer amenities');
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'local_tip', 'ATM available in town');
INSERT INTO place_content (place_id, category, content) VALUES ('zunheboto-town', 'local_tip', 'Base for Pfutsero hike');

-- -------------------------------------------------------
-- pfutsero
-- -------------------------------------------------------
-- what_is_there
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'what_is_there', 'Ridge viewpoint — 360° views on clear mornings, valleys drop on all sides');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'what_is_there', 'Forest walks — dense forest with wildlife, good birdwatching');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'what_is_there', 'Blyth''s tragopan sightings — November-February');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'what_is_there', 'Satoi range — home to several rare bird species');
-- local_food
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'local_food', 'Home-cooked food at homestays');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'local_food', 'Carry supplies from Zunheboto if needed');
-- local_tips
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'local_tip', 'Hike from Zunheboto: 1–2 days depending on fitness and route');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'local_tip', 'Bring warm clothes — cold at 2,100m');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'local_tip', 'Early morning views: wake before dawn for best light');
INSERT INTO place_content (place_id, category, content) VALUES ('pfutsero', 'local_tip', 'Blyth''s tragopan: hire local guide for best sighting chances');
