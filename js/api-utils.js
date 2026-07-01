/*
 * api-utils.js — Incitetales
 * Shared API/JSON utilities for itinerary-builder and itinerary-result:
 *   - extractJsonBlock(text)
 *   - parseModelJsonResponse(data)
 *   - readWorkerPayload(response)
 *   - SUPABASE_URL, SUPABASE_KEY
 *   - WORKER_API_URL
 *
 * Usage: <script src="/js/api-utils.js"></script>
 * (place before page-specific scripts that call these functions)
 */

var SUPABASE_URL = 'https://zlxmwkfwehpfziyfsdqq.supabase.co';
var SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpseG13a2Z3ZWhwZnppeWZzZHFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQyODU1NTAsImV4cCI6MjA4OTg2MTU1MH0.g1JEQ2eJxKnn472TdsdWocySEC1ED_TwxSMGKjYG7Rk';
var WORKER_API_URL = 'https://incitetales-api.incitetales.workers.dev';

/**
 * Extract a JSON object from a string that may contain markdown fences
 * or surrounding text. Returns the raw JSON string or null.
 */
function extractJsonBlock(text) {
  if (!text || typeof text !== 'string') return null;

  var cleaned = text.replace(/```json|```/gi, '').trim();
  var directStart = cleaned.startsWith('{') ? cleaned.indexOf('{') : -1;
  var directEnd = cleaned.endsWith('}') ? cleaned.lastIndexOf('}') : -1;
  if (directStart === 0 && directEnd === cleaned.length - 1) return cleaned;

  var depth = 0;
  var start = -1;
  var inString = false;
  var escaped = false;

  for (var i = 0; i < cleaned.length; i++) {
    var char = cleaned[i];

    if (inString) {
      if (escaped) {
        escaped = false;
      } else if (char === '\\') {
        escaped = true;
      } else if (char === '"') {
        inString = false;
      }
      continue;
    }

    if (char === '"') {
      inString = true;
      continue;
    }

    if (char === '{') {
      if (depth === 0) start = i;
      depth++;
      continue;
    }

    if (char === '}') {
      if (depth === 0) continue;
      depth--;
      if (depth === 0 && start !== -1) {
        return cleaned.slice(start, i + 1);
      }
    }
  }

  return null;
}

/**
 * Parse a model/API response that may be a direct object, a string,
 * or a wrapper with nested content. Returns the parsed itinerary object.
 */
function parseModelJsonResponse(data) {
  if (data && typeof data === 'object' && !Array.isArray(data)) {
    var hasStructuredItinerary = typeof data.destination === 'string'
      && typeof data.title === 'string'
      && Array.isArray(data.days);

    if (hasStructuredItinerary) {
      return data;
    }
  }

  var text = typeof data === 'string'
    ? data
    : (data && (data.choices && data.choices[0] && data.choices[0].message && data.choices[0].message.content))
      || (data && data.result)
      || (data && data.response)
      || (data && data.content)
      || (data && data.output_text)
      || '';

  if (!text) {
    throw new Error('No model text in response: ' + JSON.stringify(data));
  }

  var jsonBlock = extractJsonBlock(text);
  if (!jsonBlock) {
    throw new Error('Model response did not contain a valid JSON object');
  }

  return JSON.parse(jsonBlock);
}

/**
 * Read the body of a worker fetch response, returning both raw text
 * and parsed JSON (or null if parsing fails).
 */
async function readWorkerPayload(response) {
  var rawText = await response.text();
  var data = null;

  try {
    data = rawText ? JSON.parse(rawText) : null;
  } catch (error) {
    data = null;
  }

  return { rawText: rawText, data: data };
}
