// Shared voting (optional).
// Leave both blank and the site still works, but each visitor only sees their own results.
// Fill these in from Supabase: Project Settings > API. The anon key is meant to be public.
window.TIER_CONFIG = {
  supabaseUrl: "https://rxpkvuakkzgebeyffntd.supabase.co/rest/v1/",       // e.g. "https://abcdefgh.supabase.co"
  supabaseAnonKey: "sb_publishable_h_SXPwwL0XLueoAox6TnJw_S9z1wD7t",   // the "anon public" key
  thumbExt: "webp"       // default thumbnail extension: thumbs/<category>/<id>.webp
};
