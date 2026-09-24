import { createClient } from "@supabase/supabase-js";
import { createHandler } from "./handler.ts";

const url = Deno.env.get("SUPABASE_URL");
const key = Deno.env.get("SUPABASE_ANON_KEY");
if (!url || !key) throw new Error("Missing server public configuration");
function client(token: string) {
  return createClient(url!, key!, {
    global: { headers: { Authorization: `Bearer ${token}` } },
    auth: { persistSession: false, autoRefreshToken: false },
  });
}
Deno.serve(createHandler({
  async verifyUser(token) {
    const { data, error } = await client(token).auth.getUser(token);
    return !error && !!data.user;
  },
  async requestDeletion(token) {
    const { data, error } = await client(token).rpc("request_account_deletion");
    if (error || typeof data !== "string") throw new Error("Deletion request failed");
    return data;
  },
}));
