import fs from "fs";
import path from "path";
import { createClient } from "@supabase/supabase-js";

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error("❌ Missing environment variables: SUPABASE_URL and SUPABASE_ANON_KEY must be set.");
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const basePath = "./data/insights/destinations";

async function migrateFile(filePath) {
  const raw = fs.readFileSync(filePath, "utf-8");
  const data = JSON.parse(raw);

  console.log(`\n📦 Migrating: ${data.id}`);

  await supabase.from("regions").upsert({
    id: data.id,
    state: data.state,
    district: data.district,
    tagline: data.tagline,
    description: data.description,
    incitetales_angle: data.incitetales_angle,
    hidden_score: data.hidden_score,
    verified: data.verified,
    last_updated: data.last_updated
  });

  await supabase.from("region_meta").upsert({
    region_id: data.id,
    permit: data.permit,
    routes: data.routes,
    connectivity: data.connectivity,
    season: data.season
  });

  for (const place of data.destinations || []) {

    await supabase.from("places").upsert({
      id: place.id,
      region_id: data.id,
      name: place.name,
      type: place.type,
      altitude_m: place.altitude_m,
      tagline: place.tagline,
      description: place.description,
      hidden_score: place.hidden_score
    });

    console.log(`📍 Place: ${place.name}`);

    const contentMap = [
      ["what_to_do", place.what_is_there],
      ["food", place.local_food],
      ["tips", place.local_tips]
    ];

    for (const [type, items] of contentMap) {
      if (!items) continue;

      for (const item of items) {
        await supabase.from("place_content").upsert({
          place_id: place.id,
          category: type,
          content: item
        });
      }
    }

    for (const stay of place.stays || []) {
      await supabase.from("stays").upsert({
        place_id: place.id,
        name: stay.name,
        type: stay.type,
        price_range: stay.price_range,
        notes: stay.notes
      });
    }
  }
}

async function migrateAll() {
  const states = fs.readdirSync(basePath);

  for (const state of states) {
    const statePath = path.join(basePath, state);

    // skip non-folders
    if (!fs.lstatSync(statePath).isDirectory()) continue;

    console.log(`\n🌍 Processing state: ${state}`);

    const files = fs.readdirSync(statePath);

    for (const file of files) {
      if (!file.endsWith(".json")) continue;

      const filePath = path.join(statePath, file);

      console.log(`➡️ File: ${file}`);

      try {
        await migrateFile(filePath);
      } catch (err) {
        console.error("❌ Error in:", file, err.message);
      }
    }
  }

  console.log("\n🎉 ALL STATES MIGRATED");
}

migrateAll();