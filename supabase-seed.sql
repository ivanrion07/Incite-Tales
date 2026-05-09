-- =============================================================================
-- INCITETALES — SUPABASE SEED DATA
-- Generated from: 8 destination files + 8 insights files
-- Tables: regions, region_meta, places, stays, place_content, insights
-- =============================================================================


-- =============================================================================
-- SECTION 1: regions
-- =============================================================================

INSERT INTO regions (id, state, district, tagline, description, incitetales_angle, hidden_score, verified)
VALUES
  (
    'tawang',
    'Arunachal Pradesh',
    'Tawang',
    'The monastery at the end of the road',
    'Tawang is the highest district in Arunachal Pradesh and one of the most dramatic destinations in India. The Tawang Monastery — the largest Buddhist monastery in India and second largest in the world — sits at 3,048m overlooking a valley that drops into clouds. The road there through Sela Pass (4,170m) is itself an experience.',
    'Everyone knows Tawang monastery. Arrive on a weekday before 9am when the monks are doing morning prayers and the tourists haven''t arrived. That version of Tawang is unforgettable.',
    3,
    true
  ),
  (
    'dibang-valley',
    'Arunachal Pradesh',
    'Lower Dibang Valley / Upper Dibang Valley',
    'The wildest river valley in India',
    'The Dibang Valley is two districts separated by Mayodia Pass. Lower Dibang Valley (headquarters: Roing) is accessible and has real tourist infrastructure. Upper Dibang Valley (headquarters: Anini) is one of the most remote destinations in India — the Idu Mishmi tribe, the Dibang River, and complete wilderness.',
    'Most people who say they have been to Dibang Valley mean Roing. Anini is a completely different category of remote.',
    9,
    true
  ),
  (
    'east-siang-pasighat',
    'Arunachal Pradesh',
    'East Siang',
    'Where the Siang becomes the Brahmaputra',
    'Pasighat is the oldest town in Arunachal Pradesh and sits where the Siang River exits the mountains and becomes the Brahmaputra. The Adi tribe''s homeland. Good base for river activities and for reaching Mechuka.',
    'The Siang at Pasighat, where a mountain river emerges from the gorge into the plains, is one of those sights that changes something in you.',
    5,
    true
  ),
  (
    'changlang',
    'Arunachal Pradesh',
    'Changlang',
    'The jungle war road and one of Asia''s most biodiverse forests',
    'Changlang is the easternmost tourist district of Arunachal Pradesh. It has two draws that are completely different from each other: Namdapha National Park — one of the most biodiverse protected areas in Asia — and the Stilwell Road, the 1,736km WWII supply route built through this jungle in 1942–44.',
    'Namdapha is the most biodiverse national park in India that nobody talks about. Four big cat species in one park.',
    9,
    false
  ),
  (
    'west-kameng',
    'Arunachal Pradesh',
    'West Kameng',
    'Apple orchards, monasteries, and the gateway to Tawang',
    'West Kameng is the first district you enter when driving into Arunachal Pradesh from Assam. The landscape shifts rapidly — from Assam''s flat tea gardens to dense forest to alpine meadows. Bhalukpong is the border checkpost. Shergaon is a secret. Bomdila and Dirang are the classic overnight stops on the Tawang corridor.',
    'Everyone drives through West Kameng to get to Tawang. Almost no one actually stops. Shergaon alone is worth a two-night detour.',
    6,
    true
  ),
  (
    'lower-subansiri',
    'Arunachal Pradesh',
    'Lower Subansiri',
    'Rice fields, Apatani culture, and a music festival at 1,500m',
    'Ziro Valley is a UNESCO World Heritage nominated cultural landscape — a broad, flat valley at 1,500m surrounded by pine-covered hills, filled with Apatani tribal villages and their unique paddy-fish farming system. The Ziro Music Festival (September) draws thousands. The rest of the year it is almost completely empty.',
    'Ziro Music Festival aside, you will have the entire valley to yourself. Walk into an Apatani village on any morning in November and you are the only outsider there.',
    6,
    true
  ),
  (
    'lohit-namsai',
    'Arunachal Pradesh',
    'Lohit / Namsai',
    'Parshuram Kund, the Golden Pagoda, and the Lohit River',
    'The easternmost accessible districts of Arunachal Pradesh. Lohit has Parshuram Kund — a Hindu pilgrimage site on the Lohit River where a January bathing fair draws lakhs of pilgrims. Namsai has the Golden Pagoda — a striking Theravada Buddhist temple built by the Khamti people.',
    'The Golden Pagoda in Namsai is Theravada Buddhist — more Myanmar or Thailand than Tibet. One of the most beautiful monastery complexes in Northeast India.',
    6,
    true
  ),
  (
    'shi-yomi',
    'Arunachal Pradesh',
    'Shi Yomi',
    'The valley the world forgot',
    'Mechuka is one of the most remote and visually spectacular destinations in India — a high-altitude valley at 1,800m near the China border, barely touched by tourism, with the Siyom River running through it and the Himalayas visible on clear days. Getting there is part of the experience.',
    'Mechuka is genuinely difficult to get to. That is exactly why it still looks like this.',
    9,
    true
  );


-- =============================================================================
-- SECTION 2: region_meta
-- =============================================================================

INSERT INTO region_meta (region_id, permit, routes, season)
VALUES
  (
    'tawang',
    '{
      "required": true,
      "type": ["ILP", "PAP"],
      "ilp_notes": "ILP for all non-Arunachal residents. Apply online at arunachalilp.com or at Arunachal House.",
      "pap_notes": "Protected Area Permit required specifically for Tawang district — additional to ILP. Apply simultaneously. Also required for Bumla Pass visit.",
      "cost": "ILP ₹100 per person. PAP ₹100 additional.",
      "processing_time": "1–2 days",
      "bumla_notes": "Bumla Pass requires a separate permit arranged through a registered local operator in Tawang. Minimum group of 2. Indians only — foreigners cannot visit Bumla."
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 500,
        "travel_days": 2,
        "waypoints": ["Tezpur", "Bhalukpong", "Bomdila", "Dirang", "Sela Pass", "Tawang"],
        "nearest_railhead": "Tezpur (280km from Tawang)",
        "nearest_airport": "Tezpur Airport or Guwahati"
      }
    }'::jsonb,
    '{
      "best": ["march", "april", "october", "november"],
      "avoid": ["june", "july", "august"],
      "notes": "March–April: rhododendrons, clear skies. October: best month overall — post monsoon clarity, no crowds, all roads open. Winter: snow possible at Sela Pass, beautiful but cold. Monsoon: Sela Pass frequently closed by landslides."
    }'::jsonb
  ),
  (
    'dibang-valley',
    '{
      "required": true,
      "type": ["ILP"],
      "how_to_apply": "Online at arunachalilp.com or Arunachal House",
      "cost": "₹100",
      "processing_time": "Same day to 1 day",
      "notes": "Anini and Upper Dibang Valley — additional restricted area regulations may apply near border. Check current status with DC office before travel."
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 620,
        "travel_days": 2,
        "waypoints": ["Dholla-Sadiya Bridge", "Sadiya", "Roing", "Mayodia Pass", "Hunli", "Anini"],
        "nearest_railhead": "Tinsukia (120km from Roing via Sadiya)",
        "nearest_airport": "Dibrugarh (160km from Roing)"
      },
      "from_dibrugarh": {
        "total_distance_km": 160,
        "travel_days": 1,
        "waypoints": ["Tinsukia", "Dholla-Sadiya Bridge", "Sadiya", "Roing"],
        "drive_hours": "5–6 hours"
      }
    }'::jsonb,
    '{
      "best": ["october", "november", "december"],
      "also_good": ["march", "april"],
      "avoid": ["june", "july", "august"],
      "notes": "October–December: best overall. Mayodia Pass birdwatching peaks in winter. March–April: rhododendrons at Mayodia. Monsoon: Roing–Anini road frequently blocked."
    }'::jsonb
  ),
  (
    'east-siang-pasighat',
    '{
      "required": true,
      "type": ["ILP"],
      "cost": "₹100"
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 350,
        "travel_days": 1,
        "drive_hours": "9–10 hours",
        "notes": "Long day. Option: fly Guwahati → Pasighat (when IndiGo operates). Pasighat is a gateway for Mechuka."
      }
    }'::jsonb,
    '{
      "best": ["october", "november", "march", "april"],
      "avoid": ["june", "july", "august"]
    }'::jsonb
  ),
  (
    'changlang',
    '{
      "required": true,
      "type": ["ILP"],
      "how_to_apply": "Online at arunachalilp.com or Arunachal House",
      "cost": "₹100",
      "processing_time": "Same day to 1 day",
      "pangsau_pass_notes": "Pangsau Pass crossing requires additional restricted area permit — not routinely issued to tourists. Check with Ministry of Home Affairs."
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 520,
        "travel_days": 2,
        "waypoints": ["Dibrugarh", "Tinsukia", "Margherita", "Ledo", "Miao"],
        "nearest_railhead": "Ledo or Tinsukia",
        "nearest_airport": "Dibrugarh"
      }
    }'::jsonb,
    '{
      "best": ["november", "december", "january", "february", "march"],
      "avoid": ["june", "july", "august", "september"],
      "notes": "Dry season only. Monsoon makes the jungle road and park trails impassable. Winter is excellent — cold nights but clear days."
    }'::jsonb
  ),
  (
    'west-kameng',
    '{
      "required": true,
      "type": ["ILP"],
      "how_to_apply": "Online at arunachalilp.com or at Arunachal House in Guwahati/Kolkata/Delhi",
      "cost": "₹100 per person",
      "processing_time": "Same day to 1 day",
      "notes": "ILP checked at Bhalukpong checkpost — have printed copy ready"
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 300,
        "travel_time": "8–9 hours to Bomdila",
        "waypoints": ["NH27 to Tezpur", "Bhalukpong (ILP check)", "Tipi", "Bomdila"],
        "nearest_railhead": "Tezpur (180km from Bhalukpong)",
        "nearest_airport": "Tezpur Airport (closest) or Guwahati"
      },
      "from_tezpur": {
        "total_distance_km": 175,
        "travel_time": "5–6 hours to Bomdila",
        "waypoints": ["Bhalukpong (ILP check)", "Tipi", "Bomdila"]
      }
    }'::jsonb,
    '{
      "best": ["march", "april", "october", "november"],
      "avoid": ["june", "july", "august"],
      "notes": "March–April: rhododendrons in bloom. October–November: crisp, clear, best views. Winter: cold but possible, Sela Pass may snow. Monsoon: landslides on mountain roads, avoid."
    }'::jsonb
  ),
  (
    'lower-subansiri',
    '{
      "required": true,
      "type": ["ILP"],
      "how_to_apply": "Online at arunachalilp.com or Arunachal House",
      "cost": "₹100",
      "processing_time": "Same day to 1 day"
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 500,
        "travel_days": 2,
        "waypoints": ["Tezpur or North Lakhimpur", "Itanagar / Naharlagun", "Ziro"],
        "nearest_railhead": "North Lakhimpur (100km from Ziro)",
        "nearest_airport": "Lilabari Airport, North Lakhimpur (105km)"
      }
    }'::jsonb,
    '{
      "best": ["september", "october", "november"],
      "also_good": ["march", "april"],
      "avoid": ["june", "july"],
      "notes": "September: music festival + lush green paddy fields at peak. October–November: post harvest, golden fields, clear skies, best for village walks. March–April: rhododendrons in Talley Valley."
    }'::jsonb
  ),
  (
    'lohit-namsai',
    '{
      "required": true,
      "type": ["ILP"],
      "cost": "₹100"
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 560,
        "travel_days": 2,
        "waypoints": ["Dibrugarh", "Tinsukia", "Tezu (Lohit) or Namsai"],
        "notes": "2 days from Guwahati. Dibrugarh is the practical base for this region. Namsai is 50km from Tinsukia — doable as a day trip from Assam."
      },
      "from_dibrugarh": {
        "total_distance_km": 170,
        "travel_days": 1,
        "drive_hours": "4–5 hours to Namsai"
      }
    }'::jsonb,
    '{
      "best": ["october", "november", "december", "january", "february"],
      "avoid": ["june", "july", "august"]
    }'::jsonb
  ),
  (
    'shi-yomi',
    '{
      "required": true,
      "type": ["ILP"],
      "how_to_apply": "Online at arunachalilp.com or Arunachal House",
      "cost": "₹100",
      "processing_time": "Same day to 1 day",
      "notes": "Mechuka is near the China border — additional Inner Line restrictions may apply. Check current status before travel. Military checkposts on the road — have ILP and ID ready."
    }'::jsonb,
    '{
      "from_guwahati": {
        "total_distance_km": 550,
        "travel_days": 2,
        "waypoints": ["Pasighat or North Lakhimpur", "Aalo (Along)", "Tato", "Mechuka"],
        "nearest_railhead": "Murkongselek (for Pasighat), 5km",
        "nearest_airport": "Pasighat Airport (when operational) or Dibrugarh"
      }
    }'::jsonb,
    '{
      "best": ["october", "november"],
      "also_good": ["march", "april", "september"],
      "avoid": ["june", "july", "august"],
      "notes": "October–November: clearest skies, best mountain views, Mechuka Adventure Festival in Nov. March–April: spring, rhododendrons. Monsoon: road frequently blocked by landslides between Aalo and Mechuka."
    }'::jsonb
  );


-- =============================================================================
-- SECTION 3: places
-- =============================================================================

INSERT INTO places (id, region_id, name, type, tagline, description, hidden_score)
VALUES
  -- tawang destinations
  (
    'sela-pass',
    'tawang',
    'Sela Pass',
    'mountain-pass',
    '4,170m. A frozen lake. A shrine. And clouds below you.',
    'Sela Pass is the high point on the Tawang road — a Buddhist shrine, a frozen lake (Paradise Lake), and on clear days, a 360° view of Himalayan peaks. Snow present from November through March. The pass is often clouded over by midday — pass through early.',
    3
  ),
  (
    'tawang-town',
    'tawang',
    'Tawang',
    'town',
    'The monastery at the edge of India',
    'Tawang town is small, cold, and completely dominated by its monastery. The Tawang Chhu valley below, the monastery above, and Bumla Pass (India-China border) 37km further. The town has improved significantly in the last decade — good hotels, decent food, a functioning market.',
    3
  ),
  (
    'nuranang-falls',
    'tawang',
    'Nuranang Falls (Jung Falls)',
    'waterfall',
    '100m of cold water with a war story behind it',
    'Nuranang Falls is a 100m single-drop waterfall about 30km from Tawang on the Bomdila road, near Jung village. The Nuranang River here was the site of a famous last stand by Rifleman Jaswant Singh Rawat during the 1962 war — a small shrine commemorates it near the falls.',
    4
  ),
  (
    'madhuri-lake',
    'tawang',
    'Madhuri Lake (Shonga-tser Lake)',
    'lake',
    'A Himalayan lake that accidentally became famous from a 1997 Bollywood song',
    'Shonga-tser Lake is a high altitude lake 35km from Tawang, near the Bumla road. The Himalayan peaks reflect in the water. It was made famous by a song sequence from the film Koyla (1997) with Madhuri Dixit — locals renamed it. The setting is stunning regardless.',
    4
  ),
  -- dibang-valley destinations
  (
    'roing',
    'dibang-valley',
    'Roing',
    'town',
    'Orchids, rivers, and the gateway to Dibang',
    'Roing is the headquarters of Lower Dibang Valley — a proper town with hotels, ATMs, and supplies. It sits at the confluence of the Roing and Deopani rivers. The surrounding forests are exceptional for orchids and birdwatching. Mehao Wildlife Sanctuary is the main draw.',
    6
  ),
  (
    'mayodia-pass',
    'dibang-valley',
    'Mayodia Pass',
    'mountain-pass',
    'On the road to Anini — where the rhododendrons and snow meet',
    'Mayodia Pass sits on the road between Roing and Anini, at 2,655m. The pass area is known for exceptional birdwatching (including rare species like Ward''s trogon and Blyth''s tragopan), rhododendron forests in spring, and snow in winter. It is NOT a detour — it is on the route.',
    8
  ),
  (
    'anini',
    'dibang-valley',
    'Anini',
    'town',
    'End of the road. Beginning of something else.',
    'Anini is the headquarters of Upper Dibang Valley — one of the least visited districts in India. The Dibang River here is wide, clear, and flanked by mountains. The Idu Mishmi people have their own language, their own religion (Igu — a form of animism), and their own relationship with the forest. There is almost no tourist infrastructure. That is the entire point.',
    10
  ),
  -- east-siang-pasighat destinations
  (
    'pasighat',
    'east-siang-pasighat',
    'Pasighat',
    'town',
    'The Siang emerging from the Himalayan gorge',
    'Pasighat is a proper town with infrastructure — hotels, ATMs, fuel. The Siang River here is powerful. The Adi tribal culture is strong. Used as a base for Mechuka drives or Siang river activities.',
    5
  ),
  -- changlang destinations
  (
    'namdapha',
    'changlang',
    'Namdapha National Park',
    'national-park',
    'Four big cats, one jungle, almost no tourists',
    'Namdapha is India''s third-largest national park and one of its most extraordinary — 1,985 sq km of forest ranging from tropical to alpine, home to tiger, leopard, snow leopard, and clouded leopard (the only park in the world with all four), Hoolock gibbon, red panda, and over 1,000 plant species. The base is Miao town.',
    9
  ),
  (
    'miao',
    'changlang',
    'Miao',
    'town',
    'The base town for Namdapha and Stilwell Road',
    'Miao is a small town on the Noa-Dihing River, the base for Namdapha. It has basic hotels, the park permit office, and is the last town with any services before the park. The Stilwell Road starts properly here.',
    4
  ),
  (
    'stilwell-road',
    'changlang',
    'Stilwell Road',
    'historical-road',
    '1,736km of jungle, monsoon, and will. Most of it swallowed back by forest.',
    'The Stilwell Road (also called Ledo Road) was built by 40,000 Allied troops in 1942–44 to supply Nationalist China after Japan cut the Burma Road. It runs from Ledo in Assam through Changlang district of Arunachal, into Myanmar, and on to Yunnan, China. The Indian portion is driveable in sections. WWII-era bridges, mile markers, and abandoned equipment still exist in the jungle.',
    9
  ),
  -- west-kameng destinations
  (
    'bhalukpong',
    'west-kameng',
    'Bhalukpong',
    'border-town',
    'The gate into Arunachal',
    'Bhalukpong is the checkpost town where you enter Arunachal Pradesh from Assam. The Kameng River runs through it. There''s a small wildlife sanctuary — Pakhui/Pakke — nearby. Most people just stop to show permits and refuel. Worth a short riverside walk.',
    3
  ),
  (
    'shergaon',
    'west-kameng',
    'Shergaon',
    'village',
    'The village nobody stops at. The one everyone should.',
    'A small Sherdukpen tribal village of around 200 families, 13km off the main Bomdila highway. Apple and kiwi orchards, a 16th century monastery (Chug Monastery), quiet forest walks, and Red Berry Homestay — one of the most genuine small stays in the Northeast.',
    9
  ),
  (
    'bomdila',
    'west-kameng',
    'Bomdila',
    'town',
    'The acclimatization town with the best monastery views',
    'Bomdila is the district headquarters of West Kameng, sitting at 2,415m. Most Tawang travellers overnight here to acclimatize. The monastery complex has excellent views of the Kangto and Gorichen peaks on a clear day. The market is good for local woolens, apple products, and supplies.',
    4
  ),
  (
    'dirang',
    'west-kameng',
    'Dirang',
    'town',
    'Hot springs, yaks, and kiwi orchards between Bomdila and Tawang',
    'Dirang sits in a valley at 1,560m, warmer than Bomdila. The Dirang Dzong (old stone fort village) is one of the most atmospheric old settlements in Arunachal. Hot springs, a yak research centre, and extensive kiwi orchards make it worth more than the usual overnight stop.',
    6
  ),
  (
    'sangti-valley',
    'west-kameng',
    'Sangti Valley',
    'valley',
    'Where the black-necked cranes come every winter',
    'A quiet valley 15km from Dirang, completely off the main tourist trail. Sangti River, apple orchards, and most importantly — migratory black-necked cranes (Grus nigricollis) that arrive from Tibet in November and stay through February.',
    8
  ),
  -- lower-subansiri destinations
  (
    'ziro-valley',
    'lower-subansiri',
    'Ziro Valley',
    'valley',
    'Paddy fields, pine forests, and one of India''s most intact tribal cultures',
    'The Ziro Valley is the homeland of the Apatani tribe — known for their unique rice-fish farming method (paddy fields double as fish ponds), their intricate bamboo weaving, and historically for facial tattoos and nose plugs among older women. The valley is flat and walkable, surrounded by pine forests. Hapoli is the main town; the actual Apatani villages are 3–8km away.',
    6
  ),
  -- lohit-namsai destinations
  (
    'parshuram-kund',
    'lohit-namsai',
    'Parshuram Kund',
    'pilgrimage-natural',
    'A Hindu kund where the Lohit cuts through a gorge',
    'Parshuram Kund is where the Lohit River cuts through a narrow gorge and a natural bathing pool forms. Hindu pilgrimage site — according to legend, Parshuram washed away the sin of killing his mother here. January Makar Sankranti mela draws 50,000+ pilgrims. The site itself, outside the festival, is a peaceful gorge.',
    5
  ),
  (
    'golden-pagoda-namsai',
    'lohit-namsai',
    'Golden Pagoda (Kongmu Kham)',
    'religious-site',
    'A Theravada Buddhist temple unlike anything else in India',
    'The Golden Pagoda in Namsai is a Theravada Buddhist monastery complex built by the Khamti people — a Thai-related ethnic group unique to this corner of Arunachal. The architecture is distinctly Southeast Asian — more Myanmar or Thailand than Tibet. Often called the most beautiful monastery in Northeast India.',
    7
  ),
  -- shi-yomi destinations
  (
    'mechuka',
    'shi-yomi',
    'Mechuka',
    'valley',
    'Snow peaks, a turquoise river, and almost no one else',
    'Mechuka is a small Memba tribal town in the Siyom River valley, 29km from the Chinese border. The valley floor has paddy fields and apple orchards. The surrounding peaks exceed 6,000m. There is one road in. There is almost nothing here in terms of tourist infrastructure — which is entirely the point.',
    9
  ),
  (
    'aalo-along',
    'shi-yomi',
    'Aalo (Along)',
    'town',
    'The last proper town before Mechuka',
    'Aalo (officially Along) is the district headquarters of West Siang, 170km from Mechuka. It''s a proper town with ATMs, fuel, hotels, and supplies. Stock up here before heading to Mechuka. The Siang River gorge between Aalo and Yingkiong is dramatic.',
    5
  );


-- =============================================================================
-- SECTION 4: stays
-- =============================================================================

INSERT INTO stays (place_id, name, type, price_range, notes)
VALUES
  -- sela-pass stays (none)
  -- tawang-town stays
  ('tawang-town', 'Hotel Tawang Inn', 'hotel', '₹1,500–3,000', NULL),
  ('tawang-town', 'Hotel Gakyi Khang-zhang', 'hotel', '₹2,000–4,000', 'Best views of the valley'),
  ('tawang-town', 'Monastery Guest House', 'guesthouse', '₹500–1,000', 'Basic, inside monastery complex, advance booking needed'),
  ('tawang-town', 'homestays in Tawang', 'homestay', '₹800–1,500 including meals', NULL),
  -- nuranang-falls stays (none)
  -- madhuri-lake stays (none)
  -- roing stays
  ('roing', 'Hotel Abhinav', 'hotel', '₹800–1,500', NULL),
  ('roing', 'Circuit House Roing', 'government', '₹400–700', 'Book via DC office Lower Dibang Valley'),
  ('roing', 'Mehao Wildlife Sanctuary rest house', 'forest', '₹300–600', 'Book via Forest Dept'),
  -- mayodia-pass stays
  ('mayodia-pass', 'Forest Rest House Mayodia', 'forest', '₹300–500', 'Must book in advance via Forest Dept. Cold — bring sleeping bag.'),
  -- anini stays
  ('anini', 'Circuit House Anini', 'government', '₹400–700', 'Book via DC office Upper Dibang Valley. Best and most reliable option.'),
  ('anini', 'Basic guesthouses', 'guesthouse', '₹300–600', 'Very basic. Carry sleeping bag.'),
  -- pasighat stays
  ('pasighat', 'Hotel Siang', 'hotel', '₹800–2,000', NULL),
  ('pasighat', 'Circuit House Pasighat', 'government', '₹400–700', NULL),
  -- namdapha stays
  ('namdapha', 'Deban Forest Rest House', 'forest', '₹400–800', 'Inside the park, on the Namdapha River bank. Best base. Book via Namdapha Field Director, Miao. Book months ahead.'),
  ('namdapha', 'Hornbill Camp', 'forest-camp', '₹300–500', 'Deeper inside, basic. For serious trekkers.'),
  -- miao stays
  ('miao', 'Circuit House Miao', 'government', '₹400–700', NULL),
  ('miao', 'Basic guesthouses', 'guesthouse', '₹400–800', NULL),
  -- stilwell-road stays
  ('stilwell-road', 'Circuit House Nampong', 'government', '₹300–600', NULL),
  ('stilwell-road', 'Basic accommodation in Changlang town', 'guesthouse', '₹400–800', NULL),
  -- bhalukpong stays
  ('bhalukpong', 'Inspection Bungalow', 'government', '₹500–800', 'Book via DC office West Kameng'),
  ('bhalukpong', 'Private lodges near checkpost', 'basic', '₹600–1,200', NULL),
  -- shergaon stays
  ('shergaon', 'Red Berry Home Stay', 'homestay', '₹800–1,500 per night including meals', 'Family-run, surrounded by apple orchards. Home-cooked Arunachali food. One of the finest small stays in the Northeast. Book weeks ahead.'),
  -- bomdila stays
  ('bomdila', 'Kameng Residency', 'hotel', '₹1,200–2,500', NULL),
  ('bomdila', 'Hotel Bonsai', 'hotel', '₹700–1,500', NULL),
  ('bomdila', 'Inspection Bungalow', 'government', '₹400–800', 'Book in advance via DC office'),
  -- dirang stays
  ('dirang', 'Hotel Pemaling', 'hotel', '₹1,000–2,000', NULL),
  ('dirang', 'Possum Lodge', 'homestay', '₹800–1,500', 'Good birdwatching base'),
  ('dirang', 'Circuit House', 'government', '₹400–700', NULL),
  -- sangti-valley stays
  ('sangti-valley', 'Forest Rest House', 'government', '₹300–500', 'Book through Forest Dept West Kameng'),
  -- ziro-valley stays
  ('ziro-valley', 'Circuit House Ziro', 'government', '₹400–800', 'Best location in Hapoli, book via DC office'),
  ('ziro-valley', 'Blue Pine Resort', 'resort', '₹2,000–4,000', NULL),
  ('ziro-valley', 'Homestays in Apatani villages', 'homestay', '₹600–1,200 including meals', 'Ask in Hong or Hari village — families take in guests informally. Best experience in Ziro.'),
  -- parshuram-kund stays
  ('parshuram-kund', 'PWD Rest House Tezu', 'government', '₹400–700', NULL),
  ('parshuram-kund', 'Temporary camps during January mela', 'camp', '₹200–500', NULL),
  -- golden-pagoda-namsai stays
  ('golden-pagoda-namsai', 'Circuit House Namsai', 'government', '₹400–700', NULL),
  ('golden-pagoda-namsai', 'Monastery guest house', 'guesthouse', '₹300–500', 'Simple, peaceful'),
  -- mechuka stays
  ('mechuka', 'Circuit House Mechuka', 'government', '₹400–700', 'Book through DC Shi Yomi. Best option.'),
  ('mechuka', 'Basic guesthouses in town', 'guesthouse', '₹400–800', 'Very basic. Carry sleeping bag in winter.'),
  ('mechuka', 'Homestays with Memba families', 'homestay', '₹500–1,000 including meals', 'Informal — ask on arrival. Best food in Mechuka.'),
  -- aalo-along stays
  ('aalo-along', 'Hotel Donyi Polo Ashok', 'hotel', '₹1,500–3,000', NULL),
  ('aalo-along', 'Circuit House Along', 'government', '₹400–700', NULL);


-- =============================================================================
-- SECTION 5: place_content
-- =============================================================================

INSERT INTO place_content (place_id, category, content)
VALUES
  -- sela-pass: what_is_there
  ('sela-pass', 'what_is_there', 'Paradise Lake — a small glacial lake, often frozen Nov–Mar'),
  ('sela-pass', 'what_is_there', 'War Memorial — for the 1962 Indo-China war, small but moving'),
  ('sela-pass', 'what_is_there', 'Buddhist shrine and prayer flags'),
  ('sela-pass', 'what_is_there', 'Snow experience in winter — first snow for many Indian tourists'),
  -- sela-pass: local_food
  ('sela-pass', 'local_food', 'Hot tea and Maggi from roadside stalls — the only option'),
  -- sela-pass: local_tip
  ('sela-pass', 'local_tip', 'Cross before 10am — clouds roll in fast after that, you''ll see nothing'),
  ('sela-pass', 'local_tip', 'Carry warm layers even in October — temperature can drop to 0°C at the pass'),
  ('sela-pass', 'local_tip', 'Altitude sickness possible — take it slow, don''t run around'),
  ('sela-pass', 'local_tip', 'The lake is 500m from the road — worth the short walk'),

  -- tawang-town: what_is_there
  ('tawang-town', 'what_is_there', 'Tawang Monastery — 17th century, 450 monks, 400+ year old manuscripts, massive golden Buddha. Arrive for morning prayers.'),
  ('tawang-town', 'what_is_there', 'Urgelling Monastery — birthplace of the 6th Dalai Lama, small, peaceful, 4km from town'),
  ('tawang-town', 'what_is_there', 'Tawang War Memorial — the most significant 1962 war memorial in India. Attending the evening ceremony (5pm) is deeply moving.'),
  ('tawang-town', 'what_is_there', 'Shonga-tser Lake (Madhuri Lake) — 35km from town, high altitude lake with mountain reflections. Named after Madhuri Dixit from a 1997 film shot there.'),
  ('tawang-town', 'what_is_there', 'Nuranang (Jung) Falls — 100m waterfall, 30km from Tawang on the Bomdila road'),
  ('tawang-town', 'what_is_there', 'Bumla Pass — India-China border at 4,700m. Requires special PAP permit. 37km from Tawang on rough road. Book through a local operator.'),
  ('tawang-town', 'what_is_there', 'Pt. 4794 — trekking peak above Tawang, full day climb, guide required'),
  -- tawang-town: local_food
  ('tawang-town', 'local_food', 'Thukpa — noodle soup, the staple here. Order everywhere.'),
  ('tawang-town', 'local_food', 'Butter tea (Po Cha) — salted, yak butter. Acquire the taste.'),
  ('tawang-town', 'local_food', 'Zan — buckwheat porridge, traditional Monpa food'),
  ('tawang-town', 'local_food', 'Khura — buckwheat pancakes with butter and local honey'),
  ('tawang-town', 'local_food', 'Chura Sabji — dried cheese with vegetables'),
  ('tawang-town', 'local_food', 'Local pork and yak meat at small eateries'),
  ('tawang-town', 'local_food', 'Tawang wine — made from local millet, buy from local homes'),
  -- tawang-town: local_tip
  ('tawang-town', 'local_tip', 'Morning prayers at the monastery start around 7am — be there before 8am'),
  ('tawang-town', 'local_tip', 'The War Memorial evening ceremony (retreat) at 5pm is worth rearranging your day for'),
  ('tawang-town', 'local_tip', 'Bumla Pass needs a separate Protected Area Permit — arrange through any local tour operator in Tawang, 1 day advance'),
  ('tawang-town', 'local_tip', 'Madhuri Lake is often windy — go in the morning for calm reflections'),
  ('tawang-town', 'local_tip', 'Buy local honey and buckwheat products from monastery stalls — far better than tourist shops'),
  ('tawang-town', 'local_tip', 'Tawang is expensive vs Bomdila — stock up before arriving'),

  -- nuranang-falls: what_is_there
  ('nuranang-falls', 'what_is_there', '100m waterfall — powerful in summer, partially frozen in winter'),
  ('nuranang-falls', 'what_is_there', 'Jaswant Singh Rawat Memorial — small shrine, worth reading the story'),
  ('nuranang-falls', 'what_is_there', 'Jung village below — Monpa tribal settlement'),
  -- nuranang-falls: local_food
  ('nuranang-falls', 'local_food', 'Nothing at the falls — eat in Tawang or bring food'),
  -- nuranang-falls: local_tip
  ('nuranang-falls', 'local_tip', 'Stop here on the way into or out of Tawang — it''s on the main road'),
  ('nuranang-falls', 'local_tip', 'In January–February part of the falls freezes — extraordinary to see'),
  ('nuranang-falls', 'local_tip', 'The war memorial story is genuinely moving — read before you visit'),

  -- madhuri-lake: what_is_there
  ('madhuri-lake', 'what_is_there', 'High altitude lake with peak reflections on calm mornings'),
  ('madhuri-lake', 'what_is_there', 'Rhododendron forests on the approach road (March–April)'),
  ('madhuri-lake', 'what_is_there', 'YAK — yaks graze around the lake, particularly photogenic'),
  -- madhuri-lake: local_food
  ('madhuri-lake', 'local_food', 'Roadside stalls near the lake — basic tea and snacks only'),
  -- madhuri-lake: local_tip
  ('madhuri-lake', 'local_tip', 'Go in the morning for flat water and peak reflections — afternoons are windy'),
  ('madhuri-lake', 'local_tip', 'The Bumla road passes nearby — combine with a Bumla day if you have the PAP permit'),
  ('madhuri-lake', 'local_tip', 'October is the best month — clear skies, snow on peaks, no crowds'),

  -- roing: what_is_there
  ('roing', 'what_is_there', 'Mehao Wildlife Sanctuary — 281 sq km, tigers, clouded leopards, red pandas, extraordinary birding'),
  ('roing', 'what_is_there', 'Deopani River — walk the banks at dawn, excellent birding'),
  ('roing', 'what_is_there', 'Roing Park — small public garden, good for evening walks'),
  ('roing', 'what_is_there', 'Bhismaknagar Fort — ruined medieval fort 22km from Roing, significant archaeology'),
  ('roing', 'what_is_there', 'Sally Lake — 3km from town, migratory birds'),
  ('roing', 'what_is_there', 'Mayodia Pass — 85km from Roing on the Anini road (see separate entry)'),
  -- roing: local_food
  ('roing', 'local_food', 'Idu Mishmi cuisine — pork, bamboo shoot, wild herbs'),
  ('roing', 'local_food', 'Thupka — Tibetan-influenced noodle soup'),
  ('roing', 'local_food', 'Fresh fish from Deopani and Dibang rivers'),
  ('roing', 'local_food', 'Local rice beer'),
  ('roing', 'local_food', 'Cheap and good Arunachali meals at local dhabas — ₹80–150 per plate'),
  ('roing', 'local_food', 'Local alcohol — significantly cheaper than Assam or Guwahati'),
  -- roing: local_tip
  ('roing', 'local_tip', 'Last ATM before Anini — withdraw enough for 5+ days'),
  ('roing', 'local_tip', 'Last reliable fuel — fill completely before heading to Anini'),
  ('roing', 'local_tip', 'Deopani river walk at 5:30am — exceptional birdwatching, bring binoculars'),
  ('roing', 'local_tip', 'Bhismaknagar fort is understated — one of the most significant medieval ruins in Northeast India'),
  ('roing', 'local_tip', 'Ask locally about current road conditions to Anini before departing'),

  -- mayodia-pass: what_is_there
  ('mayodia-pass', 'what_is_there', 'Exceptional birdwatching — one of the best birding spots in Arunachal Pradesh'),
  ('mayodia-pass', 'what_is_there', 'Rhododendron forest — bloom in March–April'),
  ('mayodia-pass', 'what_is_there', 'Snow — November through February'),
  ('mayodia-pass', 'what_is_there', 'Dibang River valley views from the top'),
  -- mayodia-pass: local_food
  ('mayodia-pass', 'local_food', 'Nothing at pass. Carry food from Roing.'),
  -- mayodia-pass: local_tip
  ('mayodia-pass', 'local_tip', 'This is ON THE ROUTE Roing → Anini, not a detour'),
  ('mayodia-pass', 'local_tip', 'Birders stay at the forest rest house specifically for the pass birds'),
  ('mayodia-pass', 'local_tip', 'In winter the road over the pass can be blocked by snow — check before travel'),
  ('mayodia-pass', 'local_tip', 'Start from Roing by 7am to cross the pass comfortably and reach Anini before dark'),

  -- anini: what_is_there
  ('anini', 'what_is_there', 'Dibang River — walk the banks at any time for views and solitude'),
  ('anini', 'what_is_there', 'Idu Mishmi culture — one of the most isolated and intact tribal cultures in India'),
  ('anini', 'what_is_there', 'Military presence — the China border creates a particular atmosphere'),
  ('anini', 'what_is_there', 'Surrounding mountains — peaks visible on clear mornings'),
  ('anini', 'what_is_there', 'Forest walks — with a local guide, the forests around Anini are extraordinary'),
  ('anini', 'what_is_there', 'Idu Mishmi Cultural and Literary Society — visit if you want to understand the culture'),
  -- anini: local_food
  ('anini', 'local_food', 'Idu Mishmi home cooking — if invited, accept. Pork, wild herbs, bamboo shoot.'),
  ('anini', 'local_food', 'Circuit House cook prepares basic dal-rice-sabji'),
  ('anini', 'local_food', 'Local rice beer — called ''poka'' by Idu Mishmi'),
  ('anini', 'local_food', 'Wild mushrooms and forest greens in season'),
  -- anini: local_tip
  ('anini', 'local_tip', 'No ATM in Anini. Carry all cash from Roing.'),
  ('anini', 'local_tip', 'No reliable phone signal. BSNL occasionally. Inform someone before you leave Roing.'),
  ('anini', 'local_tip', 'Carry all medicines, torch, extra batteries, warm clothes'),
  ('anini', 'local_tip', 'The Dibang River bank at sunrise is among the most beautiful things in this part of India'),
  ('anini', 'local_tip', 'Idu Mishmi families are welcoming but private — let them invite you in rather than approaching uninvited'),
  ('anini', 'local_tip', 'A local guide from Anini is strongly recommended — they know the forest paths and the right people to meet'),

  -- pasighat: what_is_there
  ('pasighat', 'what_is_there', 'Siang River — watch from the banks where the mountain river enters the plains'),
  ('pasighat', 'what_is_there', 'Daying Ering Wildlife Sanctuary — 190 sq km, gangetic dolphins, river birds'),
  ('pasighat', 'what_is_there', 'Pasighat town market — good for Adi handicrafts'),
  ('pasighat', 'what_is_there', 'Kekar Monying waterfall — 5km from town'),
  -- pasighat: local_food
  ('pasighat', 'local_food', 'Adi pork dishes — smoked, bamboo shoot, various preparations'),
  ('pasighat', 'local_food', 'Apong rice beer'),
  ('pasighat', 'local_food', 'Fresh Siang river fish'),
  -- pasighat: local_tip
  ('pasighat', 'local_tip', 'ATM available — withdraw before heading to Mechuka'),
  ('pasighat', 'local_tip', 'Pasighat airport operates occasionally — check IndiGo schedules'),
  ('pasighat', 'local_tip', 'Dawn walk along the Siang bank is excellent — watch the mist clear'),

  -- namdapha: what_is_there
  ('namdapha', 'what_is_there', 'Four big cat species — tiger, leopard, snow leopard, clouded leopard'),
  ('namdapha', 'what_is_there', 'Hoolock gibbons — hear them at dawn from Deban rest house'),
  ('namdapha', 'what_is_there', 'Red panda'),
  ('namdapha', 'what_is_there', 'Namdapha River — crystal clear, runs through the park'),
  ('namdapha', 'what_is_there', 'Jungle walks with forest guides — Deban to Hornbill Camp trail'),
  ('namdapha', 'what_is_there', 'Extensive birding — 500+ species'),
  -- namdapha: local_food
  ('namdapha', 'local_food', 'Cook at Deban prepares basic meals — arrange in advance'),
  ('namdapha', 'local_food', 'Carry packaged food as backup'),
  -- namdapha: local_tip
  ('namdapha', 'local_tip', 'Book Deban rest house at least 2 months ahead — it has very few rooms'),
  ('namdapha', 'local_tip', 'Gibbons are most vocal at dawn — sit outside Deban by 5:30am'),
  ('namdapha', 'local_tip', 'Hire a forest guide through the park office — mandatory and worth every rupee'),
  ('namdapha', 'local_tip', 'Namdapha River is safe to swim in near Deban — clear, cold, beautiful'),
  ('namdapha', 'local_tip', 'The road inside the park is rough — 4WD essential'),

  -- miao: what_is_there
  ('miao', 'what_is_there', 'Namdapha permit office'),
  ('miao', 'what_is_there', 'Noa-Dihing River walk'),
  ('miao', 'what_is_there', 'Stilwell Road Mile 0 marker vicinity'),
  -- miao: local_food
  ('miao', 'local_food', 'Local dhabas — basic Assamese and Arunachali food'),
  ('miao', 'local_food', 'Fresh river fish'),
  -- miao: local_tip
  ('miao', 'local_tip', 'Get Namdapha permits here before entering park'),
  ('miao', 'local_tip', 'Fuel up — last reliable petrol'),

  -- stilwell-road: what_is_there
  ('stilwell-road', 'what_is_there', 'Mile 0 marker at Ledo (Assam) — small monument at the official start'),
  ('stilwell-road', 'what_is_there', 'WWII-era stone bridges — still standing in the jungle sections'),
  ('stilwell-road', 'what_is_there', 'Mile markers — concrete posts with mileage, some still legible'),
  ('stilwell-road', 'what_is_there', 'Pangsau Pass — India-Myanmar border crossing on the Stilwell Road (restricted, special permit needed)'),
  ('stilwell-road', 'what_is_there', 'Nampong town — last Indian town on the road before Myanmar'),
  ('stilwell-road', 'what_is_there', 'Dense jungle — the road disappears into forest in sections, exactly as it looked in 1945'),
  -- stilwell-road: local_food
  ('stilwell-road', 'local_food', 'Local dhabas in Nampong'),
  ('stilwell-road', 'local_food', 'Tangsa and Wancho tribal food if invited'),
  -- stilwell-road: local_tip
  ('stilwell-road', 'local_tip', 'Pangsau Pass crossing requires special permit — not available for regular tourists'),
  ('stilwell-road', 'local_tip', '4WD essential for the jungle sections of the road'),
  ('stilwell-road', 'local_tip', 'Hire a local jeep driver from Miao — they know which sections are driveable'),
  ('stilwell-road', 'local_tip', 'The Digboi WWII cemetery in Assam (nearby) gives essential context before driving the road'),
  ('stilwell-road', 'local_tip', 'Best Oct–Feb — monsoon makes the jungle sections impassable'),

  -- bhalukpong: what_is_there
  ('bhalukpong', 'what_is_there', 'Kameng River — good swimming spot before the mountain roads begin'),
  ('bhalukpong', 'what_is_there', 'Bhalukpong Fort ruins — small, easy walk'),
  ('bhalukpong', 'what_is_there', 'Pakke Tiger Reserve entry point — 5km away'),
  -- bhalukpong: local_food
  ('bhalukpong', 'local_food', 'Assamese-influenced dhabas'),
  ('bhalukpong', 'local_food', 'Fresh river fish'),
  ('bhalukpong', 'local_food', 'Tea from nearby Assam gardens'),
  -- bhalukpong: local_tip
  ('bhalukpong', 'local_tip', 'Fill up fuel here — next reliable petrol pump is Bomdila'),
  ('bhalukpong', 'local_tip', 'Get permits checked and stamped — don''t skip this, checkpost is strict'),
  ('bhalukpong', 'local_tip', 'Kameng riverside in the morning before driving uphill is peaceful'),

  -- shergaon: what_is_there
  ('shergaon', 'what_is_there', 'Chug Monastery — 16th century, small, atmospheric, rarely visited'),
  ('shergaon', 'what_is_there', 'Apple and kiwi orchards — walk through them freely in season (Sept–Nov)'),
  ('shergaon', 'what_is_there', 'Sherdukpen tribal culture — distinct from Tibetan-influenced Tawang'),
  ('shergaon', 'what_is_there', 'Forest walks toward Eaglenest Wildlife Sanctuary boundary'),
  ('shergaon', 'what_is_there', 'Rupa Lake — 4km from village, migratory birds Oct–Feb'),
  -- shergaon: local_food
  ('shergaon', 'local_food', 'Home-cooked Sherdukpen food at Red Berry — don''t eat anywhere else'),
  ('shergaon', 'local_food', 'Local apple juice and fresh apples in season (Sept–Nov)'),
  ('shergaon', 'local_food', 'Thukpa and rice with local vegetables'),
  -- shergaon: local_tip
  ('shergaon', 'local_tip', 'Take the 13km diversion off NH13 — it is fully worth it'),
  ('shergaon', 'local_tip', 'Stay 2 nights minimum — one night is too short'),
  ('shergaon', 'local_tip', 'Ask the homestay family about Chug Monastery — they''ll arrange access'),
  ('shergaon', 'local_tip', 'Eaglenest Wildlife Sanctuary is nearby — one of India''s top birdwatching spots'),

  -- bomdila: what_is_there
  ('bomdila', 'what_is_there', 'Bomdila Monastery (Upper, Middle, Lower) — three levels, Upper has the best views'),
  ('bomdila', 'what_is_there', 'Craft Centre — local weaving, thangkas, Monpa handicrafts'),
  ('bomdila', 'what_is_there', 'Apple Orchard Resort viewpoint'),
  ('bomdila', 'what_is_there', 'Tipi Orchid Research Centre — 45km below on the highway, worth a stop going down'),
  -- bomdila: local_food
  ('bomdila', 'local_food', 'Thukpa and momos — multiple small restaurants in the main market'),
  ('bomdila', 'local_food', 'Local apple products — jams, juice, dried apples from market stalls'),
  ('bomdila', 'local_food', 'Pork dishes — Monpa-style pork with local greens'),
  -- bomdila: local_tip
  ('bomdila', 'local_tip', 'Acclimatize properly — Bomdila is 2,415m, Tawang is 3,048m'),
  ('bomdila', 'local_tip', 'Upper Monastery at sunrise — the Himalayan view is exceptional on clear days'),
  ('bomdila', 'local_tip', 'Stock up on snacks and supplies here — Tawang is more expensive'),
  ('bomdila', 'local_tip', 'Woolens and Monpa shawls from the craft centre are better quality than Tawang market'),

  -- dirang: what_is_there
  ('dirang', 'what_is_there', 'Old Dirang Village (Dirang Dzong) — ancient stone houses, narrow alleys, a small monastery inside'),
  ('dirang', 'what_is_there', 'Hot Springs — natural sulphur springs, 2km from town, free'),
  ('dirang', 'what_is_there', 'National Research Centre on Yak — only one in India, free to visit'),
  ('dirang', 'what_is_there', 'Kiwi orchards — walk through them in season (Oct–Nov)'),
  ('dirang', 'what_is_there', 'Sangti Valley — 15km away, migratory black-necked cranes (Nov–Feb)'),
  -- dirang: local_food
  ('dirang', 'local_food', 'Thukpa and butter tea'),
  ('dirang', 'local_food', 'Kiwi fruit direct from orchards in Oct–Nov'),
  ('dirang', 'local_food', 'Local pork dishes at small dhabas'),
  -- dirang: local_tip
  ('dirang', 'local_tip', 'Old Dirang village is 2km from the highway — most people miss it entirely'),
  ('dirang', 'local_tip', 'Hot springs are basic but the sulphur water is genuine — bring a towel'),
  ('dirang', 'local_tip', 'Sangti Valley cranes: arrive at dawn, November is peak'),
  ('dirang', 'local_tip', 'Dirang to Sela Pass is 3-4 hours — start early to avoid afternoon cloud'),

  -- sangti-valley: what_is_there
  ('sangti-valley', 'what_is_there', 'Black-necked crane sightings — November to February, early morning'),
  ('sangti-valley', 'what_is_there', 'Sangti River — flat, wide, excellent for walks'),
  ('sangti-valley', 'what_is_there', 'Completely empty valley — no tourist infrastructure, almost no visitors'),
  -- sangti-valley: local_food
  ('sangti-valley', 'local_food', 'Carry food from Dirang'),
  -- sangti-valley: local_tip
  ('sangti-valley', 'local_tip', 'Dawn walk along the river is where you''ll spot the cranes — be quiet'),
  ('sangti-valley', 'local_tip', 'No phone signal in the valley'),
  ('sangti-valley', 'local_tip', 'Combine with a Dirang night — Sangti is a half-day from there'),

  -- ziro-valley: what_is_there
  ('ziro-valley', 'what_is_there', 'Apatani villages — Hong, Hari, Hija, Bamin, Dutta, Mudang-Tage, Michi-Bamin. Each has a distinct character.'),
  ('ziro-valley', 'what_is_there', 'Paddy-fish farming — the valley floor is a working agricultural landscape, most striking June–October'),
  ('ziro-valley', 'what_is_there', 'Talley Valley Wildlife Sanctuary — 5km from Ziro, rhododendron and orchid forest'),
  ('ziro-valley', 'what_is_there', 'Kile Pakho viewpoint — hill above Hapoli, sunrise view over the entire valley'),
  ('ziro-valley', 'what_is_there', 'Ziro Music Festival — last weekend of September, outdoor, 3 days, Indian and international indie acts'),
  ('ziro-valley', 'what_is_there', 'Pine Grove — forest walks between villages'),
  ('ziro-valley', 'what_is_there', 'Meghna Cave Temple — small cave temple carved into rock face'),
  -- ziro-valley: local_food
  ('ziro-valley', 'local_food', 'Pila Pila — fermented rice cake, Apatani specialty'),
  ('ziro-valley', 'local_food', 'Bamboo shoot curry — bamboo shoot in every form'),
  ('ziro-valley', 'local_food', 'Apong (rice beer) — offered in every Apatani home'),
  ('ziro-valley', 'local_food', 'Smoked pork with bamboo shoot — the definitive Arunachal dish'),
  ('ziro-valley', 'local_food', 'Marua (millet alcohol) — different from apong, stronger'),
  ('ziro-valley', 'local_food', 'Fresh river fish from the paddy-fish farms'),
  -- ziro-valley: local_tip
  ('ziro-valley', 'local_tip', 'Visit Hong village first — most accessible and welcoming to visitors'),
  ('ziro-valley', 'local_tip', 'The older Apatani women with facial tattoos are in their 70s–80s — this practice ended decades ago. Do not stare or photograph without permission.'),
  ('ziro-valley', 'local_tip', 'Apong offered in homes — accept it. Refusing is considered impolite.'),
  ('ziro-valley', 'local_tip', 'Kile Pakho sunrise: wake at 5am, 30-minute walk up the hill behind Hapoli'),
  ('ziro-valley', 'local_tip', 'Ziro Music Festival: book accommodation 3 months ahead. The valley fills completely.'),
  ('ziro-valley', 'local_tip', 'Walk between villages rather than drive — the paddy field paths are the real Ziro'),

  -- parshuram-kund: what_is_there
  ('parshuram-kund', 'what_is_there', 'The Kund itself — natural pool in a gorge'),
  ('parshuram-kund', 'what_is_there', 'January Mela — one of the largest religious fairs in Northeast India'),
  ('parshuram-kund', 'what_is_there', 'Lohit River gorge — dramatic'),
  ('parshuram-kund', 'what_is_there', 'Brahmapur Fort ruins nearby'),
  -- parshuram-kund: local_food
  ('parshuram-kund', 'local_food', 'Mela food stalls in January'),
  ('parshuram-kund', 'local_food', 'Tezu market for regular meals'),
  -- parshuram-kund: local_tip
  ('parshuram-kund', 'local_tip', 'January Mela: arrive a day early, accommodation books out completely'),
  ('parshuram-kund', 'local_tip', 'Outside January the site is peaceful and nearly empty'),
  ('parshuram-kund', 'local_tip', 'Tezu town (35km) is the base — no accommodation at the Kund'),

  -- golden-pagoda-namsai: what_is_there
  ('golden-pagoda-namsai', 'what_is_there', 'Golden Pagoda — the main temple, gold-covered, reflecting pool'),
  ('golden-pagoda-namsai', 'what_is_there', 'Monks in residence — Theravada tradition, different from the Tibetan Buddhism of Tawang'),
  ('golden-pagoda-namsai', 'what_is_there', 'Khamti village nearby — see traditional weaving'),
  ('golden-pagoda-namsai', 'what_is_there', 'Evening light is the best time — the gold catches the sunset'),
  -- golden-pagoda-namsai: local_food
  ('golden-pagoda-namsai', 'local_food', 'Khamti cuisine — Thai-influenced, rice-based, distinctly different from rest of Arunachal'),
  ('golden-pagoda-namsai', 'local_food', 'Sticky rice preparations'),
  ('golden-pagoda-namsai', 'local_food', 'Fish dishes — Khamti are river people'),
  -- golden-pagoda-namsai: local_tip
  ('golden-pagoda-namsai', 'local_tip', 'Visit in the early morning or evening — midday light is harsh for photos'),
  ('golden-pagoda-namsai', 'local_tip', 'Remove footwear before entering the temple'),
  ('golden-pagoda-namsai', 'local_tip', 'The Khamti weaving is among the most intricate in Arunachal — buy directly from weavers'),

  -- mechuka: what_is_there
  ('mechuka', 'what_is_there', 'Samten Yongcha Monastery — 400-year-old Buddhist monastery, monks in residence'),
  ('mechuka', 'what_is_there', 'Siyom River — turquoise glacial river, excellent for riverside walks'),
  ('mechuka', 'what_is_there', 'Mechuka airstrip — one of the highest airstrips in India, rarely operational (IAF)'),
  ('mechuka', 'what_is_there', 'Apple orchards — walk through freely in season (Oct–Nov)'),
  ('mechuka', 'what_is_there', 'Surrounding peaks — 6,000m+ peaks visible on clear mornings'),
  ('mechuka', 'what_is_there', 'Memba tribal villages — distinct Buddhist tribal culture different from Tawang Monpa'),
  ('mechuka', 'what_is_there', 'Old Mechuka village — 3km from town, traditional wooden houses'),
  ('mechuka', 'what_is_there', 'Border area experience — the Chinese border is 29km away, military presence visible'),
  -- mechuka: local_food
  ('mechuka', 'local_food', 'Thukpa — the staple, available everywhere'),
  ('mechuka', 'local_food', 'Rice with local vegetables and pork — Memba home cooking'),
  ('mechuka', 'local_food', 'Apong (rice beer) — offered in homes'),
  ('mechuka', 'local_food', 'Fresh trout from Siyom River at some guesthouses'),
  ('mechuka', 'local_food', 'Butter tea — strong local style'),
  ('mechuka', 'local_food', 'Local honey — one of the best in Arunachal, buy from families'),
  -- mechuka: local_tip
  ('mechuka', 'local_tip', 'No reliable phone signal in Mechuka. BSNL very occasional. Tell someone your plans before entering.'),
  ('mechuka', 'local_tip', 'Carry all medicines and essentials from Pasighat or Aalo — nothing available in Mechuka'),
  ('mechuka', 'local_tip', 'The best views are from the monastery hill at 6am on a clear day — set your alarm'),
  ('mechuka', 'local_tip', 'Mechuka Adventure Festival (November) — 3-day cultural and adventure sports event, the one time there are crowds'),
  ('mechuka', 'local_tip', 'River crossing to old village requires a log bridge — check condition before crossing'),
  ('mechuka', 'local_tip', 'Carry extra fuel — petrol available in Mechuka but supply is erratic'),

  -- aalo-along: what_is_there
  ('aalo-along', 'what_is_there', 'Siang River — wide, powerful, turquoise'),
  ('aalo-along', 'what_is_there', 'Kaying — 15km from Aalo, traditional Adi village'),
  ('aalo-along', 'what_is_there', 'Poge Orchid Sanctuary'),
  ('aalo-along', 'what_is_there', 'Weekly market — Adi tribal goods, local produce'),
  -- aalo-along: local_food
  ('aalo-along', 'local_food', 'Pork and bamboo shoot — Adi tribal specialty'),
  ('aalo-along', 'local_food', 'Apong rice beer'),
  ('aalo-along', 'local_food', 'Market food stalls — cheap, local, good'),
  -- aalo-along: local_tip
  ('aalo-along', 'local_tip', 'Last ATM before Mechuka — withdraw here'),
  ('aalo-along', 'local_tip', 'Last reliable fuel — fill up completely'),
  ('aalo-along', 'local_tip', 'Mechuka road from Aalo is 6–7 hours — start by 7am');


-- =============================================================================
-- SECTION 6: insights
-- (files from: offbeat/, cultural/, experiences/, hidden-spots/, seasonal/)
-- =============================================================================

INSERT INTO insights (
  geographic_scope,
  verified_facts,
  local_tips,
  warnings,
  stays,
  routes,
  season_notes,
  hidden_score,
  story_slug,
  verified
)
VALUES

  -- -------------------------------------------------------------------------
  -- mising-tribe (cultural)
  -- -------------------------------------------------------------------------
  (
    '["dhemaji", "lakhimpur", "jonai", "mising", "mishing", "subansiri", "north lakhimpur"]'::jsonb,
    '[
      "The Mising (also written Mishing) are the second largest plains tribe of Assam.",
      "They live primarily along the Brahmaputra and its tributaries in stilted bamboo houses (chang ghar).",
      "Known for their weaving tradition, rice beer (apong), and close relationship with the river.",
      "Mising culture is one of the most visually rich and least documented in Northeast India.",
      "Their chang ghars are masterpieces of flood-adaptive architecture.",
      "Chang ghars are built on stilts 4–6 feet off the ground to survive annual floods using traditional bamboo joinery.",
      "Mising women weave on backstrap looms producing fabric (Mibu Gasor / Namsai) with distinctive geometric patterns.",
      "Ali Aye Ligang festival (February/March) — rice sowing festival with traditional dance and apong.",
      "Jonai town in Dhemaji district is the main Mising cultural hub, 4 hours from Dibrugarh.",
      "No formal tourism infrastructure — best accessed through local contacts or Mising Agom Kebang in Dhemaji."
    ]'::jsonb,
    '[
      "Remove footwear before entering a chang ghar (stilted home)",
      "Accept apong (rice beer) when offered — refusing is considered rude",
      "Ask permission before photographing people, especially women weaving",
      "Bring a small gift if visiting a family home — fruit or biscuits are appropriate",
      "Learn 2–3 words of Mising — ''Oi Nitom?'' (how are you?) will delight people",
      "Buy directly from weavers when purchasing Mising textiles — avoid middlemen in Guwahati shops",
      "Do not arrive unannounced at a village during harvest season — people are busy",
      "Do not refer to them as ''Mishing'' — they prefer ''Mising''",
      "Avoid entering the kitchen area unless invited — it has ritual significance in many homes"
    ]'::jsonb,
    '[
      "Do not touch the loom without being invited",
      "Do not photograph religious ceremonies or rituals without explicit permission",
      "Monsoon floods many Mising villages — roads become inaccessible June–August"
    ]'::jsonb,
    '[]'::jsonb,
    '["Jonai town in Dhemaji district is the main Mising cultural hub. 4 hours from Dibrugarh. Ask locally for village homestays — formal tourism infrastructure is minimal."]'::jsonb,
    'Best: November–March. Ali Aye Ligang festival (February/March) is an excellent time to visit. Avoid June–August — monsoon floods many villages and roads become inaccessible.',
    9,
    'mising-tribe',
    true
  ),

  -- -------------------------------------------------------------------------
  -- brahmaputra-river-camp (experience)
  -- -------------------------------------------------------------------------
  (
    '["guwahati", "kamrup", "morigaon", "brahmaputra", "char", "fancy bazar", "tezpur", "central assam"]'::jsonb,
    '[
      "Between November and April, the Brahmaputra''s water level drops to reveal massive sandbars (chars) in the middle of the river.",
      "The Brahmaputra at this point is 10–15km wide.",
      "Migratory birds use the same chars — skimmers, terns, and sometimes bar-headed geese share the sandbar.",
      "Char communities (people who live on sandbars year-round) are one of the most vulnerable populations in Assam.",
      "Dawn is better than sunset — the river turns gold and birds are most active at 5:30am.",
      "Arrange through local boat operators at Fancy Bazar Ghat (Guwahati) or Tezpur riverfront.",
      "Requires advance booking 2–3 days ahead — no walk-in service.",
      "Cost approx ₹1,500–3,000 per person including boat, tent, basic meals.",
      "Arrive at char by 4pm — sunset on the river is the main event.",
      "People fly to the Maldives for ''surrounded by water.'' This is better. And it costs ₹2,000."
    ]'::jsonb,
    '[
      "Arrive at char by 4pm for sunset — the main event",
      "Wake up at 5:30am for dawn — river turns gold and birds are most active",
      "Carry warm layers — river nights are cold even in December",
      "Bring a headlamp",
      "Camera with tripod if possible — Milky Way from a char is exceptional",
      "Carry any personal medication — you are far from help once on the char",
      "Ask specifically for char camping — some operators offer just a boat ride",
      "Verify operators provide proper tents and life jackets"
    ]'::jsonb,
    '[
      "Chars only exist in dry season — by June the entire riverbed is submerged",
      "No formal permit but inform local authorities if camping near border-sensitive areas",
      "Do not treat char communities as a photo opportunity — be respectful",
      "Quality of operators varies — verify equipment before booking"
    ]'::jsonb,
    '[]'::jsonb,
    '["Arrange through local boat operators at Fancy Bazar Ghat (Guwahati) or Tezpur riverfront. Advance booking 2–3 days required."]'::jsonb,
    'Best: December–February (dry season sweet spot). November is early — some chars may still be forming. Avoid June–October — chars submerged during monsoon.',
    7,
    'brahmaputra-river-camp',
    true
  ),

  -- -------------------------------------------------------------------------
  -- maguri-beel (hidden-spot)
  -- -------------------------------------------------------------------------
  (
    '["tinsukia", "guijan", "maguri beel", "dibru saikhowa", "upper assam", "bordoloi nagar"]'::jsonb,
    '[
      "An oxbow lake on the edge of Dibru-Saikhowa biosphere.",
      "One of the few places in India where you can spot Irrawaddy river dolphins, Gangetic dolphins, and migratory birds in the same morning.",
      "Drive to Guijan Ghat from Tinsukia (approx 35km).",
      "Hire a local wooden boat from the ghat — no formal booking system, just show up before 7am.",
      "No signage on the main road — ask locals for ''Guijan Ghat''.",
      "Boat hire approx ₹300–500 for 2 hours. No official entry fee.",
      "Irrawaddy dolphins are most visible between November and February when water levels drop and fish concentrate.",
      "Area is close to Mising tribal villages."
    ]'::jsonb,
    '[
      "Arrive at the ghat before 7am — best wildlife window is 5:30am to 8am",
      "Ask the boatman to take you through the narrow channel on the east side — that''s where dolphins surface most frequently",
      "Most tourists stay near the ghat — the back channel is what most people miss",
      "No formal booking system — just show up early",
      "Ask locals for ''Guijan Ghat'' — no signage on main road",
      "Respectful behaviour expected near Mising tribal villages — do not photograph locals without asking"
    ]'::jsonb,
    '[
      "Floods completely during monsoon — the beel merges with surrounding fields (June–August)",
      "No formal operator or booking — quality of experience depends on the boatman"
    ]'::jsonb,
    '[]'::jsonb,
    '["Drive to Guijan Ghat from Tinsukia (approx 35km). Hire a local wooden boat — no booking, show up before 7am."]'::jsonb,
    'Best: November–February. Shoulder: March, October. Avoid June–August — floods completely during monsoon.',
    8,
    'maguri-beel',
    true
  ),

  -- -------------------------------------------------------------------------
  -- shillong-cherrapunji-offbeat (offbeat)
  -- -------------------------------------------------------------------------
  (
    '["cherrapunji", "sohra", "shillong", "east khasi hills", "sa-i-mika", "nohkalikai", "dainthlen", "wei sawdong", "kyrdemkhla", "meghalaya", "khasi hills", "jaintia hills", "garo hills"]'::jsonb,
    '[
      "Most people drive Shillong to Cherrapunji on NH6 — the Sa-i-Mika road is the offbeat alternative through villages, canyon viewpoints, and waterfalls.",
      "The Sa-i-Mika road is narrow and rough in sections — 4WD recommended. Not suitable for large vehicles.",
      "Distance: 55km via NH6 (fast) / approx 65–70km via Sa-i-Mika road (slow, offbeat).",
      "Kyrdemkhla: a village viewpoint on the Sa-i-Mika road overlooking the Bangladesh plains far below. Almost no tourists stop here.",
      "Nohkalikai Falls: India''s tallest plunge waterfall at 340m. Dramatic in monsoon.",
      "Dainthlen Falls: less visited than Nohkalikai, named after a giant serpent killed here in Khasi legend. Requires a short walk.",
      "Wei Sawdong Falls: three-tier waterfall you can swim in. Requires a steep 30–45 minute descent. Almost no one goes here.",
      "Cherrapunji is the Khasi name Sohra — locals prefer Sohra.",
      "The Khasi matrilineal system means family names pass through the mother.",
      "Airtel/Jio available in Shillong and Cherrapunji town. Sa-i-Mika road has dead zones."
    ]'::jsonb,
    '[
      "Take Sa-i-Mika road one way (Shillong → Cherrapunji); return on NH6 if pressed for time",
      "Wei Sawdong Falls requires effort — steep descent, no railings, can be slippery. Worth it.",
      "Cherrapunji is best in monsoon — counterintuitive but correct. Waterfalls at full force.",
      "Bring good rain gear for monsoon visits — embrace the rain",
      "Call it Sohra when talking to locals — they prefer it to Cherrapunji",
      "Ask locals about the Khasi matrilineal system — people are proud of it"
    ]'::jsonb,
    '[
      "Sa-i-Mika road has dead zones — BSNL most reliable",
      "January–February is dry season — waterfalls shrink to trickles, less worth the detour",
      "Wei Sawdong descent can be slippery — proper footwear essential, not sandals"
    ]'::jsonb,
    '[
      "Sa-i-Mika Resort — resort — ₹2,000–4,000 — On the Sa-i-Mika road itself. Good base. Views of the Bangladesh plains.",
      "Ri-Sohra Resort — resort — ₹3,000–6,000 — Cliff-edge property with canyon views. Good for couples.",
      "Lawanba Home Stay — homestay — ₹800–1,500 including meals — Local family-run. Home-cooked Khasi food. Most authentic experience."
    ]'::jsonb,
    '["Shillong to Cherrapunji: 55km via NH6 (fast) or 65–70km via Sa-i-Mika road (recommended, slow, offbeat). 4WD recommended for the Sa-i-Mika road."]'::jsonb,
    'Best: June–September (monsoon — waterfalls at full force, most dramatic). Also good: October–November. Avoid: January–February (dry, waterfalls shrink).',
    7,
    'shillong-cherrapunji-offbeat',
    true
  ),

  -- -------------------------------------------------------------------------
  -- shillong-dawki-shnongpedeng (offbeat)
  -- -------------------------------------------------------------------------
  (
    '["dawki", "shnongpedeng", "umngot", "mawlynnong", "west jaintia hills", "pynursla", "umkhoi", "kolington", "double decker bridge", "nongriat", "south meghalaya", "meghalaya", "khasi hills", "jaintia hills", "garo hills"]'::jsonb,
    '[
      "The Umngot River at Dawki/Shnongpedeng is famous for being so clear that boats appear to float on air.",
      "Crystal clarity only exists in dry season — monsoon floods the Umngot and turns it brown.",
      "Shnongpedeng is 3km upstream from Dawki — same water, completely different atmosphere. Riverside camping available.",
      "Umkhoi Canyon: a narrow limestone canyon with a river running through it. Almost zero tourist infrastructure. Requires a local guide.",
      "Kolington Lake: a hidden lake off the main route, serene, often completely empty.",
      "Mawlynnong — Cleanest Village in Asia: community takes cleanliness seriously as a cultural practice.",
      "Double Decker Living Root Bridge: two levels of ancient Ficus elastica roots woven into a bridge. Near Nongriat village. Requires a 3,000-step descent.",
      "Kayaking and coracle (round boat) rides available at Shnongpedeng and Dawki (₹200–500 per ride).",
      "The Khasi people are matrilineal — property and family names pass through the mother.",
      "Dawki is a border town — India-Bangladesh border crossing is here.",
      "Signal weakens past Pynursla — download offline maps before leaving Shillong."
    ]'::jsonb,
    '[
      "Do not rush this as a day trip from Shillong — staying overnight at Shnongpedeng changes the entire experience",
      "Umkhoi Canyon is 2 hours from the main route and has almost no visitors — worth it with an extra day",
      "Ask locals for the best swimming spots at Shnongpedeng — not the same location as the tourist coracle area",
      "Mawlynnong gets crowded on weekends — go on a weekday morning",
      "Double Decker Root Bridge: proper shoes essential, not sandals — steep 3,000-step descent",
      "Peak clarity at Umngot: December–February",
      "Book Brightstar Camp 1–2 weeks ahead in December–February",
      "Download offline maps before leaving Shillong — signal weakens past Pynursla"
    ]'::jsonb,
    '[
      "Monsoon floods the Umngot and turns it brown — crystal clarity only in dry season",
      "Shnongpedeng camping only possible in dry season",
      "Signal limited near border areas — inform someone of plans",
      "Umkhoi Canyon requires a local guide — do not attempt without one"
    ]'::jsonb,
    '[
      "Brightstar Camp — riverside camp — ₹1,000–2,000 per tent — Tents right on the Umngot riverbank. Best way to experience Shnongpedeng. Gets fully booked in peak season.",
      "Betelnut Resort — resort — ₹2,000–3,500 — More comfortable option with proper rooms near the river. Local food on-site."
    ]'::jsonb,
    '["Shillong to Shnongpedeng/Dawki: 95–100km. Good tarmac till Dawki. Side roads to offbeat stops require care. Recommended: 2 days."]'::jsonb,
    'Best: October–March (crystal clarity in dry season, peak December–February). Avoid: June–August (river floods and turns brown).',
    7,
    'shillong-dawki-shnongpedeng',
    true
  ),

  -- -------------------------------------------------------------------------
  -- stilwell-road (offbeat)
  -- -------------------------------------------------------------------------
  (
    '["changlang", "miao", "stilwell road", "ledo", "nampong", "namdapha", "eastern arunachal"]'::jsonb,
    '[
      "A 1,736km road built by the Allied forces in 1942–1945 connecting Ledo in Assam through Arunachal Pradesh, Myanmar, and into Yunnan, China.",
      "Built to supply Nationalist China after Japan cut the Burma Road. General Joseph Stilwell commanded its construction.",
      "Built by US Army Corps of Engineers and Indian Labour Corps with 40,000 men (1942–1945). Casualties: thousands from malaria, accidents, Japanese attacks.",
      "Most of the road has been reclaimed by jungle. The Indian portion through Changlang district is driveable (barely).",
      "WWII-era bridges, abandoned equipment, and mile markers still standing in the jungle.",
      "Mile 0 marker at Ledo — small monument at the official start, almost no one visits.",
      "Pangsau Pass: India-Myanmar border crossing on the Stilwell Road — restricted, special permit needed.",
      "Namdapha National Park entrance is en route — one of the most biodiverse parks in Asia.",
      "Base at Miao town in Changlang district. From Dibrugarh: approx 6–7 hours.",
      "4WD mandatory beyond Miao. Minimum 3 days to do justice to the area.",
      "Changlang district is home to Tangsa, Tutsa, and Nocte tribes."
    ]'::jsonb,
    '[
      "Hire a local jeep driver from Miao — they know which sections are driveable",
      "Start early — roads are difficult and distances are long",
      "Visit the Digboi WWII cemetery before driving the road — gives essential context",
      "Inform someone of your route before departing Miao",
      "Best October–February — road becomes completely impassable in monsoon",
      "Do not attempt to cross into Myanmar — area near border is sensitive"
    ]'::jsonb,
    '[
      "Inner Line Permit (ILP) mandatory for all non-Arunachal residents — ₹100, 1–2 days processing",
      "Changlang district has restricted areas — check current status before visiting",
      "Pangsau Pass crossing requires additional restricted area permit — not available for regular tourists",
      "Road completely impassable in monsoon (June–September)",
      "4WD essential — do not attempt in a regular vehicle"
    ]'::jsonb,
    '[
      "Circuit House Nampong — government — ₹300–600 — Basic government rest house",
      "Basic accommodation in Changlang town — guesthouse — ₹400–800 — Very basic"
    ]'::jsonb,
    '["Base at Miao town in Changlang district. From Dibrugarh: cross into Arunachal at Tinsukia–Margherita, then onward to Miao (approx 6–7 hours). 4WD mandatory beyond Miao."]'::jsonb,
    'Best: November–March. Road completely impassable in monsoon (June–September). The jungle closes in fast.',
    9,
    'stilwell-road',
    false
  ),

  -- -------------------------------------------------------------------------
  -- tawang-corridor (offbeat / route)
  -- -------------------------------------------------------------------------
  (
    '["tawang", "bomdila", "dirang", "shergaon", "sela", "bhalukpong", "west kameng", "tawang district", "kameng", "rupa", "tenga"]'::jsonb,
    '[
      "The classic overland route to Tawang — one of the most dramatic drives in India. Total distance: 540km from Guwahati / 320km from Tezpur.",
      "Sela Pass (4,170m) is the high point — frozen lake, Buddhist shrine, often snow-covered.",
      "Shergaon: tiny village, apple orchards, 16th century monastery (Chug Monastery), completely off the tourist radar.",
      "Red Berry Home Stay in Shergaon: family-run, apple orchards, home-cooked Arunachali food. One of the best small stays in the Northeast.",
      "Bomdila is at 2,415m — proper acclimatization stop before Tawang (3,048m).",
      "Dirang: hot springs, kiwi orchards, old Dirang village (Dirang Dzong). Often skipped — shouldn''t be.",
      "BSNL works best throughout. Expect no signal for stretches of 1–2 hours while driving.",
      "Mix of good highway and mountain road. 4WD recommended but not mandatory in dry season.",
      "Recommended stops: Bhalukpong, Shergaon, Bomdila, Dirang, Sela Pass, Tawang. Recommended 4 days.",
      "ILP mandatory + PAP for Tawang — apply simultaneously. ₹100 each."
    ]'::jsonb,
    '[
      "Shergaon is 13km off the main road — ninety percent of tourists miss it. Take the diversion.",
      "Cross Sela Pass before 10am — clouds roll in fast after that",
      "Drive through early to avoid afternoon cloud at Sela Pass",
      "Red Berry Home Stay: advance booking essential — only a few rooms",
      "Buy local apple products in Bomdila — Tawang is more expensive",
      "Old Dirang village is 2km from the highway — most people miss it entirely",
      "Inform someone of your route — signal is patchy for long stretches"
    ]'::jsonb,
    '[
      "January–February: Sela Pass often snowed shut — check road status",
      "Monsoon brings landslides on this route — check road status daily June–August",
      "ILP + PAP required — have printed copies ready at checkposts",
      "ATM in Bomdila — carry cash after that"
    ]'::jsonb,
    '[
      "Red Berry Home Stay — homestay — ₹800–1,500 per night including meals — Shergaon village. Family-run. Apple orchards. Home-cooked Arunachali food. Best small stay in the Northeast.",
      "Kameng Residency — hotel — ₹1,200–2,500 per night — Bomdila town. Clean, reliable. Decent restaurant.",
      "Hotel Bonsai — hotel — ₹700–1,500 per night — Bomdila town. Budget-friendly. Clean rooms, central location."
    ]'::jsonb,
    '["Guwahati to Tawang: 540km / 4 days recommended. Key stops: Bhalukpong (ILP check), Shergaon (13km detour, worth it), Bomdila (acclimatization), Dirang (hot springs, old village), Sela Pass (4,170m, cross before 10am), Tawang."]'::jsonb,
    'Best: March–May, October–November. Avoid: January–February (Sela Pass may be snowed shut). Monsoon (June–August): landslides, check road status daily.',
    6,
    'tawang-corridor',
    true
  ),

  -- -------------------------------------------------------------------------
  -- dzukou-valley (seasonal)
  -- -------------------------------------------------------------------------
  (
    '["dzukou", "kohima", "viswema", "japfu", "nagaland", "dzukou valley", "naga hills"]'::jsonb,
    '[
      "A high-altitude valley at 2,438m straddling Nagaland and Manipur.",
      "Famous for the Dzukou lily (Lilium mackliniae) which blankets the valley floor every monsoon.",
      "Accessible by two routes — from Nagaland side (Viswema village, 5km trek) or Manipur side (Mao — longer but less steep).",
      "Trek from Viswema is 5km uphill, approximately 3–4 hours. Base camp is Viswema village, 20km from Kohima.",
      "ILP required for non-Nagaland residents — get at Kohima DC office or online at nagaland.gov.in. Free of cost.",
      "Entry fee: ₹100 per person (Nagaland side). Additional ₹50 camera fee.",
      "Basic guesthouse at valley top — book ahead in July.",
      "No mobile network inside the valley — last signal at Viswema village base.",
      "Food at valley camp is ₹200–350 per meal — everything carried up.",
      "Viswema is an Angami Naga village — community manages the trek.",
      "The ridge walk on day 2 toward Japfu Peak offers a 360° view of both Nagaland and Manipur."
    ]'::jsonb,
    '[
      "Start trek by 6am to reach valley before afternoon cloud cover",
      "1 night minimum recommended — day trek possible but not ideal",
      "Do the ridge walk toward Japfu Peak on day 2 — most people miss this",
      "Buy supplies from local shops at Viswema — directly supports the community",
      "Do not litter — the Nagas take this extremely seriously",
      "Book guesthouse at valley top in advance if visiting in July",
      "Inform someone before going in — no mobile network inside the valley",
      "Hire a local guide at Viswema — recommended for first-timers"
    ]'::jsonb,
    '[
      "No mobile network inside the valley — inform someone before you go",
      "April–May is dry and brown — nothing to see, not recommended",
      "December–January: -5°C nights — very cold, demanding",
      "July peak season: medium crowds for Nagaland standards — guesthouse books out"
    ]'::jsonb,
    '[]'::jsonb,
    '["Base camp: Viswema village, 20km from Kohima. Trek is 5km uphill, 3–4 hours. Alternatively from Manipur side via Mao Gate (longer, less steep)."]'::jsonb,
    'Best: June–August (Dzukou lily season — valley floor turns white and pink). Also good: December–January (snow, no crowds, very cold). Avoid: April–May (dry, parched, nothing to see).',
    5,
    'dzukou-valley',
    true
  );
